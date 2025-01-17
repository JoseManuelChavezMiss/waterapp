import 'package:dio/dio.dart';
import 'package:waterapp/Models/AuthModels/loginUser.dart';

import '../../Config/DioConfig.dart';

class AuthRepository {
  final Dio _dio = DioConfig.createDio();

  Future<Map<String, dynamic>?> loginUser(LoginUser user) async {
    try {
      final response = await _dio.post(
        'auth/login',
        data: {
          'nombreUsuario': user.nombreUsuario,
          'password': user.password,
        },
      );
      return response.data;
    } catch (e) {
      print('Error en el registro: $e');
      return null;
    }
  }
}