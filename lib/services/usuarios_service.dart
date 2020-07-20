import 'dart:convert';
import 'package:control_tareas_app/models/usuario_for_listing.dart';
import 'package:control_tareas_app/models/api_response.dart';
import 'package:http/http.dart' as http;

class UsuarioService {

  static const API = 'http://3.128.29.238:8001/api/usuario/'; //AWS
  static const headers = {
      'Content-Type': 'application/json'
  };

  
  // Recibe Listado GET
  Future<APIResponse<List<UsuarioForListing>>> getUsuariosList() {
    return http.get(API + 'lista', headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final usuario = <UsuarioForListing>[];
        for (var item in jsonData) {
          usuario.add(UsuarioForListing.fromJson(item));
        }
        return APIResponse<List<UsuarioForListing>>(data: usuario);
      }
      return APIResponse<List<UsuarioForListing>>(error: true, errorMessage: 'Ha ocurrido un error');
    })
    .catchError((_) => APIResponse<List<UsuarioForListing>>(error: true, errorMessage: 'Ha ocurrido un error'));
  }


}