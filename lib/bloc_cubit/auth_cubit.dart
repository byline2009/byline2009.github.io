import 'package:bloc/bloc.dart';
import 'package:bloc_login/services/authentication_service.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthDefault());
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FacebookAuth _facebookAuth = FacebookAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
//the main logic
//login
  Future<void> login(String email, String password) async {
    emit(AuthLoginLoading());
    try {
      User? user = (await _firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user != null) {
        emit(AuthLoginSuccess(user: user));
      }
    } on FirebaseException catch (e) {
      emit(AuthLoginError(error: e.message!));
    }
  }

  // signup method
  Future signUp(String name, String password, String email) async {
    emit(const AuthSignUpLoading());
    try {
      User? user = (await _firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;

      // if the user is not null
      if (user != null) {
        user.updateDisplayName(name);
        emit(const AuthSignUpSuccess());
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthSignUpError(e.message));
    }
  }

  // forgot password method
  Future forgotPassword(String email) async {
    emit(const AuthForgotPasswordLoading());
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      emit(const AuthForgotPasswordSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthForgotPasswordError(e.message));
    }
  }
  // google auth

  Future googleAuth() async {
    emit(const AuthGoogleLoading());
    try {
      final GoogleSignInAccount? _googleUser = await _googleSignIn.signIn();
      if (_googleUser != null) {
        emit(AuthDefault());
      } else {
        final GoogleSignInAuthentication googleAuth =
            await _googleUser!.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );
        User? user =
            (await _firebaseAuth.signInWithCredential(credential)).user;
        if (user != null) {
          emit(AuthGoogleSuccess(user: user));
        }
      }
    } catch (e) {
      emit(AuthGoogleError(error: e.toString()));
    }
  }

  Future googleLogout() async {
    await _googleSignIn.signOut();
    emit(const AuthLogout());
  }

  // facebook auth
  Future facebookAuthentication() async {
    emit(const AuthFBLoading());
    try {
      final LoginResult loginResult = await _facebookAuth.login();
      final OAuthCredential oAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      User? user =
          (await _firebaseAuth.signInWithCredential(oAuthCredential)).user;
      if (user != null) {
        emit(AuthFbSuccess(user: user));
      }
    } catch (e) {
      emit(AUthFBError(error: e.toString()));
    }
  }

  Future facebookLogout() async {
    await _facebookAuth.logOut();
    emit(const AuthLogout());
  }

  // auth logout
  Future logout() async {
    await _firebaseAuth.signOut();
    emit(const AuthLogout());
  }
}
