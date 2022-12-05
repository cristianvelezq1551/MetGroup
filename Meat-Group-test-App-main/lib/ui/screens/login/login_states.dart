import '../../../data/models/user_model.dart';

abstract class LoginStates {}

///The initial state of the login screen.
class LoginInitialStates extends LoginStates {}

///Loading state of the login screen.
class LoginLoadingState extends LoginStates {}

///LoginSuccessState of the login screen.
class LoginSuccessState extends LoginStates {
  ///The user.
  final UserModel user;

  LoginSuccessState({required this.user});
}

///The error state of the login screen.
class LoginErrorState extends LoginStates {
  final String message;

  LoginErrorState({required this.message});
}
