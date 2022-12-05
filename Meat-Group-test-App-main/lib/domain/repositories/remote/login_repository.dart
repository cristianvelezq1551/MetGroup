import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meat_group/data/services/remote/login_services.dart';

class LoginRepository {
  ///Data source
  final LoginServices _loginServices;

  LoginRepository(this._loginServices);

  ///Sign with email and password.
  Future<String> signInWithEmailAndPassword(
          {required String email, required String password}) =>
      _loginServices.signInWithEmailAndPassword(
          email: email, password: password);
}

final loginRepositoryProvider = Provider.autoDispose<LoginRepository>(
    (ref) => LoginRepository(ref.read(loginServicesProvider)));
