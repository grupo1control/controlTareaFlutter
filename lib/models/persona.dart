class Persona {
  String rut;
  String nombre;
  String apellido;
  DateTime natalicio;
  String contratos;
  String usuarios;
  DateTime creada;
  DateTime modificada;

  Persona({this.rut, this.nombre, this.apellido, this.natalicio, this.contratos, this.usuarios, this.creada, this.modificada});
  

  factory Persona.fromJson(Map<String, dynamic> item) {
    return Persona(
      rut: item['rut'],
      nombre: item['nombre'],
      apellido: item['apellido'],
      natalicio: DateTime.parse(item['natalicio']),
      contratos: item['contratos'],
      usuarios: item['usuarios'],
      creada: DateTime.parse(item['creada']),
      modificada: item['modificada'] != null
          ? DateTime.parse(item['modificada'])
          : null,
    );
  }
}