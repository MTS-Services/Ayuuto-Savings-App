import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //======================== SignUp =========================

  Future<bool> signUpUser({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return await sendEmailVerification();
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
    required String email,
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
