import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthState extends Equatable {
  final User? userData;
  final bool isLoading;
  final String errorMessage;
  final bool isGoogleSignIn;

  const AuthState(
      {this.userData,
      this.isLoading = false,
      this.errorMessage = '',
      this.isGoogleSignIn = false});

  @override
  List<Object?> get props =>
      [userData, isLoading, errorMessage, isGoogleSignIn];
}
