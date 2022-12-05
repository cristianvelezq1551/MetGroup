import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/models/user_model.dart';
import '../../../data/services/local/auth_services.dart';

///The repository of the authentication.
class AuthRepository {
  ///?The service that handles the authentication.
  final AuthService _authService;

  AuthRepository(this._authService);

  //?Save the user in the local storage.
  Future<void> saveUser(UserModel user) async {
    await _authService.saveUser(user);
  }

  ///Gets the user from the local storage.
  Future<UserModel?> getUser() async {
    final UserModel? user = await _authService.getUser();

    return user;
  }

  ///Signs out.
  Future<void> signOut() async {
    await _authService.signOut();
  }
}

final authRepositoryProvider = Provider.autoDispose(
  (ref) => AuthRepository(
    ref.read(authServiceProvider),
  ),
);
