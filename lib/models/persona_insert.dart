import 'package:flutter/foundation.dart';

class PersonaInsert {
  String apellido;
  DateTime natalicio;
  String nombre;
  String rut;

  PersonaInsert(
    {
      @required this.apellido,
      @required this.natalicio,
      @required this.nombre,
      @required this.rut
    }
  );

  Map<String, dynamic> toJson() {
    return {
      "apellido": apellido,
      "natalicio": natalicio,
      "nombre": nombre,
      "rut": rut
    };
  }
}