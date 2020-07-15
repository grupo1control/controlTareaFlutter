//import 'package:control_tareas_app/models/persona.dart';

class Usuario {
  int id;
  String nombre;
  String correo;
  String clave;
  String administrador;
  String disennador;
  String funcionario;
  String integrantes;
  dynamic fkPersona;
  DateTime creado;
  DateTime modificado;

  Usuario({this.id, this.nombre, this.correo, this.clave, this.administrador, this.disennador, this.funcionario, 
  this.integrantes, this.fkPersona, this.creado, this.modificado});

  factory Usuario.fromJson(Map<String, dynamic> item){

    return Usuario(
      id: item['id'] as int,
      nombre: item['nombre'],
      correo: item['correo'],
      clave: item['clave'],
      administrador: item['administrador'],
      disennador: item['disennador'],
      funcionario: item['funcionario'],
      integrantes: item['integrantes'],
      fkPersona: item['fkPersona'],
      creado: DateTime.parse(item['creado']),
      modificado: item['modificado'] != null
          ? DateTime.parse(item['modificado'])
          : null,
    );

  }
}