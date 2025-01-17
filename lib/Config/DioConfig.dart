import 'package:dio/dio.dart';

class DioConfig {
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl:'https://api.aguasanta.store/', // Reemplaza con tu URL base
        connectTimeout: Duration(seconds: 5), // 5 segundos
        receiveTimeout: Duration(seconds: 3), // 3 segundos
        headers: {
          'Content-Type': 'application/json',
        },
        validateStatus: (status) {
          return status! < 500; // Permite códigos de estado menores a 500
        },
      ),
    );

    // Interceptores para logs y errores
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print('Solicitud a: ${options.uri}');
        return handler.next(options); // Continúa con la solicitud
      },
      onResponse: (response, handler) {
        print('Respuesta recibida: ${response.data}');
        return handler.next(response); // Continúa con la respuesta
      },
      onError: (DioException e, handler) {
        print('Error ocurrido: ${e.message}');
        if (e.response != null) {
          // Maneja errores específicos basados en el código de estado
          switch (e.response!.statusCode) {
            case 400:
              print('Error 400: Solicitud incorrecta');
              break;
            case 401:
              print('Error 401: No autorizado');
              break;
            case 403:
              print('Error 403: Prohibido');
              break;
            case 404:
              print('Error 404: No encontrado');
              break;
            default:
              print('Error ${e.response!.statusCode}: ${e.response!.statusMessage}');
          }
        }
        return handler.next(e); // Continúa con el error
      },
    ));

    return dio;
  }
}