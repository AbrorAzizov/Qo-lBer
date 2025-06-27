import 'package:flutter/foundation.dart' show immutable;
import 'package:firebase_auth/firebase_auth.dart';

import '../auth_error.dart';
@immutable
abstract class AuthState {
  final bool isLoading;
  final AuthError? authError;

  const AuthState({required this.isLoading, this.authError});
}

class AuthStateLoggedOut extends AuthState{
  const AuthStateLoggedOut({required super.isLoading,super.authError});
}

class AuthStateLoggedIn extends AuthState{
  final User user;


  const AuthStateLoggedIn({required super.isLoading,required this.user,super.authError});
}

class AuthStateRegistering extends AuthState {
  const AuthStateRegistering({required super.isLoading, super.authError});
}

