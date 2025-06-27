import 'package:flutter/foundation.dart' show immutable;
 @immutable

abstract class AuthEvent{}

class AuthEventSignIn extends AuthEvent{
   final String password;
   final String email;

  AuthEventSignIn({required this.password, required this.email});
 }

@immutable
class AuthEventSignUp extends AuthEvent{
  final String password;
  final String email;

  AuthEventSignUp({required this.password, required this.email});
}

@immutable
class AuthEventGoToSignIn extends AuthEvent{}

@immutable
class AuthEventGoToSignUp extends AuthEvent{}
