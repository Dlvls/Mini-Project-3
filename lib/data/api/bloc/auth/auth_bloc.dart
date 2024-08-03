import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthBloc() : super(const AuthState()) {
    on<AuthRegister>((event, emit) async {
      emit(const AuthState(isLoading: true));

      try {
        final res = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        emit(AuthState(userData: res.user));
      } catch (e) {
        emit(AuthState(errorMessage: e.toString()));
      }
    });

    on<AuthSignInWithGoogle>((event, emit) async {
      emit(const AuthState(isLoading: true, isGoogleSignIn: true));

      try {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        if (googleUser == null) {
          emit(const AuthState(errorMessage: 'Google sign in was cancelled'));
          return;
        }
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          emit(AuthState(userData: user));
        } else {
          emit(const AuthState(errorMessage: 'Sign in failed'));
        }
      } catch (e) {
        emit(AuthState(errorMessage: 'Sign in failed: $e'));
      }
    });
    on<AuthLogin>((event, emit) async {
      emit(const AuthState(isLoading: true));

      try {
        final res = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        emit(AuthState(userData: res.user));
      } catch (e) {
        emit(AuthState(errorMessage: e.toString()));
      }
    });

    on<AuthUpdated>((event, emit) async {
      emit(AuthState(userData: event.userData));
    });

    // Monitor authentication state changes
    monitorAuthState();
  }

  void monitorAuthState() {
    _auth.authStateChanges().listen((user) {
      add(AuthUpdated(userData: user));
    });
  }
}
