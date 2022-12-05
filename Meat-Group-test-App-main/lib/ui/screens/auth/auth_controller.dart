import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/models/user_model.dart';
import '../../../domain/repositories/local/auth_repository.dart';
import 'auth_states.dart';

class AuthController extends StateNotifier<AuthStates> {
  AuthController(this._authRepository) : super(AuthInitialStates()) {
    getUser();
  }

  ///The repository of the authentication screen.
  final AuthRepository _authRepository;

  ///change the state of the authentication screen
  void changeState(AuthStates state) => this.state = state;

  ///?Get state of the authentication screen
  AuthStates get getState => state;

  ///Save the user in the local storage.
  Future<void> saveUser(UserModel user) => _authRepository.saveUser(user);

  ///Gets the user from the local storage.
  Future<void> getUser() async {
    try {
      ///change the state of the authentication screen to loading.
      changeState(AuthLoadingState());

      ///get the user from the local storage.
      final UserModel? user = await _authRepository.getUser();

      if (user != null) {
        ///change the state of the authentication screen to logged in.
        changeState(AuthLoggedInState(user: user));
      } else {
        ///change the state of the authentication screen to logged out.
        changeState(AuthInitialStates());
      }
    } catch (e) {
      ///Error to get the user from the local storage.
      changeState(AuthErrorState(message: e.toString()));
    }
  }

  ///Signs out.
  Future<void> signOut() async {
    try {
      ///change the state of the authentication screen to loading.
      changeState(AuthLoadingState());

      ///sign out.
      await _authRepository.signOut();

      ///change the state of the authentication screen to logged out.
      changeState(AuthLoggedOutState());
    } catch (e) {
      ///Error to sign out.
      changeState(AuthErrorState(message: e.toString()));
    }
  }
}

final authControllerProvider =
    StateNotifierProvider.autoDispose<AuthController, AuthStates>(
  (ref) => AuthController(
    ref.read(authRepositoryProvider),
  ),
);
