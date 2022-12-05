import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meat_group/app/constants/resource.dart';

///The class that connects to the API and returns the data to the repository for Login.
class LoginServices {
  ///The connection to the API.
  final _dio = Dio(
    BaseOptions(
      baseUrl: Resource.API_ENDPOINT,
      contentType: 'application/json',
    ),
  );

  ///Sign with email and password.
  Future<String> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    ///Call the API for sign in with email and password.
    final response = await _dio
        .post('/auth', data: {'username': email, 'password': password});

    ///Print the response of the API.
    log(response.data.toString());

    return response.data['access_token'];
  }
}

final loginServicesProvider =
    Provider.autoDispose<LoginServices>((ref) => LoginServices());
