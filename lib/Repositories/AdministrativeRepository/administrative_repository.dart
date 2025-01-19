
import 'package:dio/dio.dart';
import 'package:waterapp/Config/DioConfig.dart';

class AdministrativeRepository {

  final Dio _dio = DioConfig.createDio();

  //metodo para obtener los datos de los usuarios
  Future<List<Map<String, dynamic>>?> listUsersByRole() async {
  try {
    final response = await _dio.get('usuario/listarUsuariosPorRol');
    if (response.statusCode == 200) {
      // Asegúrate de que la respuesta sea una lista de mapas
      if (response.data is List) {
        return List<Map<String, dynamic>>.from(response.data);
      } else {
        print('Error: La respuesta no es una lista');
        return null;
      }
    } else {
      print('Error: Código de estado ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error en el registro: $e');
    return null;
  }
}
}