import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meat_group/ui/screens/register/register_state.dart';

import '../../../domain/repositories/remote/register_repository.dart';

class RegisterController extends StateNotifier<RegisterStates> {
  RegisterController(this._registerRepository) : super(RegisterInitialState());

  ///Repository of register controller.
  final RegisterRepository _registerRepository;

  ///Change the state of the register controller.
  void changeState(RegisterStates state) => this.state = state;

  ///Register with email and password.
  void registerWithEmailAndPassword(
      {required String email, required String password}) async {
    ///Change the state of the register controller to loading.
    changeState(RegisterLoadingState());

    try {
      ///Register with email and password.
      await _registerRepository.registerWithEmailAndPassword(
          email: email, password: password);

      ///Change the state of the register controller to success.
      changeState(RegisterSuccessState());
    } catch (e) {
      log(e.toString());

      ///Change the state of the register controller to error.
      changeState(RegisterErrorState(message: e.toString()));
    }
  }
}

final registerControllerProvider =
    StateNotifierProvider.autoDispose<RegisterController, RegisterStates>(
        (ref) => RegisterController(
              ref.read(registerRepositoryProvider),
            ));
