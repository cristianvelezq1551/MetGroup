import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';

///The service that handles the authentication.
class AuthService {
  ///Save the user in the local storage.
  Future<void> saveUser(UserModel user) async {
    ///Get the instance of the local storage.
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    ///Convert the user to json.
    final String userEncode = jsonEncode(user.toJson());

    ///Save the user in the local storage.
    await prefs.setString('user', userEncode);
  }

  ///Gets the user from the local storage.
  Future<UserModel?> getUser() async {
    ///Get the instance of the local storage.
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    ///Get the user from the local storage.
    final String? userEncode = prefs.getString('user');

    ///If the user is null, return null.
    if (userEncode != null) {
      final Map<String, dynamic> userDecode = jsonDecode(userEncode);

      final UserModel user = UserModel.fromJson(userDecode);

      return user;
    }

    return null;
  }

  ///Signs out.
  Future<void> signOut() async {
    ///Get the instance of the local storage.
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    ///Remove the user from the local storage.
    await prefs.remove('user');
  }
}

final authServiceProvider = Provider.autoDispose((ref) => AuthService());
