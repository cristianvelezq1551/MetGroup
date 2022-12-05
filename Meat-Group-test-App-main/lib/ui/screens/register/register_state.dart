abstract class RegisterStates {}

///The initial state of the register screen.
class RegisterInitialState extends RegisterStates {}

///?State of the register screen when the user is loading.
class RegisterLoadingState extends RegisterStates {}

///?State of the register screen when the user is logged in.
class RegisterSuccessState extends RegisterStates {}

///?State of the register screen when something went wrong.
class RegisterErrorState extends RegisterStates {
  ///The error message.
  final String message;

  RegisterErrorState({required this.message});
}
