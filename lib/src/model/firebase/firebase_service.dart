import 'package:ayuuto_savings_app/src/view/controller/user_Id_Controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../view/controller/usercreatecontroller/create_user_controller.dart';



class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CreateController _createController = Get.put(CreateController());
  final UserIdController _userIdController = Get.put(UserIdController());

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

        _userIdController.setUid(user.uid);

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

  //======================== SignIn =========================
  Future<bool> signInUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null && user.emailVerified) {
        return true;
      } else {
        print('Email not verified.');
        return false;
      }
    } on FirebaseAuthException catch (e) {
      print('Sign In Error: ${e.message}');
      return false;
    } catch (e) {
      print('Unexpected Error during Sign In: $e');
      return false;
    }
  }

  //======================== Logout =========================
  Future<bool> logOutUser() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      print('Logout Error: $e');
      return false;
    }
  }

  //======================== Send Email Verification =========================
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

  //======================== Change Password =========================
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      User? user = _auth.currentUser;

      if (user == null) {
        await _auth.authStateChanges().first;
        user = _auth.currentUser;
      }

      if (user != null) {
        await user.reload();
        user = _auth.currentUser;

        AuthCredential credential = EmailAuthProvider.credential(
          email: user!.email!,
          password: currentPassword,
        );

        await user.reauthenticateWithCredential(credential);
        await user.updatePassword(newPassword);

        print('Password updated successfully.');
        return true;
      } else {
        print("User is null, cannot change password");
        return false;
      }
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException during password change: ${e.message}');
      return false;
    } catch (e) {
      print('Unexpected error during password change: $e');
      return false;
    }
  }
}
