import 'dart:convert';
import 'package:control_tareas_app/models/usuario.dart';
import 'package:control_tareas_app/models/api_response.dart';
import 'package:http/http.dart' as http;

class UsuarioService {

  static const API = 'http://3.128.29.238:8001/api/usuario/'; //AWS
  static const headers = {
      'Content-Type': 'application/json'
  };

  
  // Recibe Listado GET
  Future<APIResponse<List<Usuario>>> getUsuariosList() {
    return http.get(API + 'lista', headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final usuario = <Usuario>[];
        for (var item in jsonData) {
          usuario.add(Usuario.fromJson(item));
        }
        return APIResponse<List<Usuario>>(data: usuario);
      }
      return APIResponse<List<Usuario>>(error: true, errorMessage: 'Ha ocurrido un error');
    })
    .catchError((_) => APIResponse<List<Usuario>>(error: true, errorMessage: 'Ha ocurrido un error'));
  }


}