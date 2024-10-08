import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AuthEvent{
  const AuthEvent();
}

class AuthEventInitialize extends AuthEvent {
  const AuthEventInitialize();
}

class AuthEventLogin extends AuthEvent{
  final String email;
  final String password;

  const AuthEventLogin(this.email, this.password);
}

class AuthEventLogout extends AuthEvent {
  const AuthEventLogout();
}

class AuthEventSendEmailVerification extends AuthEvent {
  const AuthEventSendEmailVerification();
}

class AuthEventRegister extends AuthEvent {

   final String email;
  final String password;
  
  const AuthEventRegister(this.email, this.password);
  
}

class AuthEventForgotPassowrd extends AuthEvent {
 final String? email;
 const AuthEventForgotPassowrd({this.email});
}

class AuthEventShouldRegister extends AuthEvent {
 const AuthEventShouldRegister();
}

