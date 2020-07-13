import 'dart:convert';
import 'package:control_tareas_app/models/api_response.dart';
import 'package:control_tareas_app/models/persona.dart';
import 'package:control_tareas_app/models/persona_insert.dart';
import 'package:control_tareas_app/models/persona_for_listing.dart';
import 'package:http/http.dart' as http;

class PersonasService {
  // static const API = 'http://192.168.1.108:8080/api/persona/'; // Local
  static const API = 'http://3.128.29.238:8001/api/persona/'; //AWS
  static const headers = {
      'Content-Type': 'application/json'
    };
  // Recibe Listado GET
  Future<APIResponse<List<PersonaForListing>>> getPersonasList() {
    return http.get(API + 'lista', headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final persona = <PersonaForListing>[];
        for (var item in jsonData) {
          persona.add(PersonaForListing.fromJson(item));
        }
        return APIResponse<List<PersonaForListing>>(data: persona);
      }
      return APIResponse<List<PersonaForListing>>(error: true, errorMessage: 'Ha ocurrido un error');
    })
    .catchError((_) => APIResponse<List<PersonaForListing>>(error: true, errorMessage: 'Ha ocurrido un error'));
  }
    //Recibe una persona GET
    Future<APIResponse<Persona>> getPersona(String rut) {
    return http.get(API + rut, headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<Persona>(data: Persona.fromJson(jsonData[0]));
      }
      return APIResponse<Persona>(error: true, errorMessage: 'Ha ocurrido un error');
    })
    .catchError((_) => APIResponse<Persona>(error: true, errorMessage: 'Ha ocurrido un error'));
  }
    // Crear Persona POST
    Future<APIResponse<bool>> createPersona(PersonaInsert item) {
    return http.post(API + 'ingresar?'+'apellido='+item.apellido
                                      +'&natalicio='+item.natalicio.toString().substring(0,10)
                                      +'&nombre='+item.nombre
                                      +'&rut='+item.rut,
                                      headers: headers ).then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'Ha ocurrido un error');
    })
    .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'Ha ocurrido un error'));
  }
  //Update PUT
  Future<APIResponse<bool>> updatePersona(String rut, PersonaInsert item) {
    return http.put(API + 'actualizar/' + rut +'?apellido='+item.apellido
                                              +'&natalicio='+item.natalicio.toString().substring(0,10)
                                              +'&nombre='+item.nombre,
                                              headers: headers ).then((data) {
      if (data.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'Ha ocurrido un error');
    })
    .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'Ha ocurrido un error'));
  }
  // Delete Persona
  Future<APIResponse<bool>> deletePersona(String rut) {
    print(API + 'eliminar/' + rut);
    return http.delete(API + 'eliminar/' + rut, headers: headers).then((data) {
      if (data.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'Ha ocurrido un error');
    })
    .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'Ha ocurrido un error'));
  }
}



