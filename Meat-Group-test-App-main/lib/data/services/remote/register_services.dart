import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/constants/resource.dart';

class RegisterServices {
  ///The connection to the API.
  final _dio = Dio(
    BaseOptions(
      baseUrl: Resource.API_ENDPOINT,
      contentType: 'application/json',
    ),
  );

  ///Register with email and password.
  Future<void> registerWithEmailAndPassword(
      {required String email, required String password}) async {
    ///Call the API for register with email and password.
    final response = await _dio
        .post('/register', data: {'username': email, 'password': password});

    ///Print the response of the API.
    log(response.data.toString());
  }
}

final registerServicesProvider =
    Provider.autoDispose<RegisterServices>((ref) => RegisterServices());
