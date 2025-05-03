import 'package:ayuuto_savings_app/src/view/controller/usercreatecontroller/create_user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  final CreateController _createController = Get.put(CreateController());


  // === Getters ===
  FirebaseAuth get auth => _auth;
  FirebaseFirestore get firestore => _firestore;

  //======================== SignUp =========================
  Future<bool> signUpUser({
    required String name,
    required String email,
    required String dateOfBirth,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        await user.sendEmailVerification();
        _createController.createUser(
          uid: user.uid,
          name: name,
          email: email,
          dateOfBirth: dateOfBirth,
          password: password,
          context: context,
        );

        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      print('Sign Up Error: ${e.message}');
      return false;
    } catch (e) {
      print('Unexpected Error during Sign Up: $e');
      return false;
    }
  }

  // ======================== SignIn =========================
  Future<bool> signInUser({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      print('Sign In Error: ${e.message}');
      return false;
    } catch (e) {
      print('Unexpected Error during Sign In: $e');
      return false;
    }
  }

  // ======================== Logout =========================
  Future<bool> logOutUser() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      print('Logout Error: $e');
      return false;
    }
  }

  // ======================== Email Verification =========================
  Future<bool> sendEmailVerification() async {
    try {
      User? user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        return true;
      }
      return false;
    } catch (e) {
      print('Error sending email verification: $e');
      return false;
    }
  }

  // ======================== Change Password =========================
  Future<bool> changePassword({
  required String currentPassword,
  required String newPassword,
}) async {
  try {
    // Get the current user
    User? firebaseUser = _auth.currentUser;

    // Wait for auth state if null
    if (firebaseUser == null) {
      firebaseUser = await _auth.authStateChanges().first;
    }

    // If still null or email is null, return false
    if (firebaseUser == null || firebaseUser.email == null) {
      print("User or email is null, cannot change password");
      return false;
    }

    // Reload and get updated user
    await firebaseUser.reload();
    firebaseUser = _auth.currentUser;

    // Recheck for null
    if (firebaseUser == null || firebaseUser.email == null) {
      print("User or email is null after reload, cannot change password");
      return false;
    }

    // Create credentials
    final credential = EmailAuthProvider.credential(
      email: firebaseUser.email!,
      password: currentPassword,
    );

    // Re-authenticate and update password
    await firebaseUser.reauthenticateWithCredential(credential);
    await firebaseUser.updatePassword(newPassword);

    print('Password updated successfully.');
    return true;
  } on FirebaseAuthException catch (e) {
    print('FirebaseAuthException during password change: ${e.message}');
    return false;
  } catch (e) {
    print('Unexpected error during password change: $e');
    return false;
  }
}

}