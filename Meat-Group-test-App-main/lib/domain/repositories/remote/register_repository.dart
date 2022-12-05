import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meat_group/data/services/remote/register_services.dart';

class RegisterRepository {
  ///Data source
  final RegisterServices _registerServices;

  RegisterRepository(this._registerServices);

  ///Register with email and password.
  Future<void> registerWithEmailAndPassword(
          {required String email, required String password}) =>
      _registerServices.registerWithEmailAndPassword(
          email: email, password: password);
}

final registerRepositoryProvider = Provider.autoDispose<RegisterRepository>(
    (ref) => RegisterRepository(ref.read(registerServicesProvider)));
