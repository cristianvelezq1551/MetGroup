import '../../../data/models/user_model.dart';

abstract class AuthStates {}

///The initial state of the authentication screen.
class AuthInitialStates extends AuthStates {}

///Loading state of the authentication screen.
class AuthLoadingState extends AuthStates {}

///The state of the authentication screen when the user is logged in.
class AuthLoggedInState extends AuthStates {
  final UserModel user;

  AuthLoggedInState({required this.user});
}

///The state of the authentication screen when the user is logged out.
class AuthLoggedOutState extends AuthStates {}

///The error state of the authentication screen.
class AuthErrorState extends AuthStates {
  final String message;

  AuthErrorState({required this.message});
}
