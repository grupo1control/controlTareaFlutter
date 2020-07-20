class FkUnidadInterna{
  int codigo;
  String nombre;
  String descripcion;
  String integrantes;
  String procesos;
  DateTime creada;
  DateTime modificada;

  FkUnidadInterna({this.codigo, this.nombre, this.descripcion, this.integrantes, this.procesos,
   this.creada, this.modificada});

  factory FkUnidadInterna.fromJson(Map<String, dynamic> item){
    return FkUnidadInterna(
      codigo: item['codigo'],
      nombre: item['nombre'],
      descripcion: item['descripcion'],
      integrantes: item['integrantes'],
      procesos: item['procesos'],
      creada: item['creada'] != null
          ? DateTime.parse(item['creada'])
          : null,
      modificada: item['modificada'] != null
          ? DateTime.parse(item['modificada'])
          : null,
    );
  } 
}
class FkPersona {
  String rut;
  String nombre;
  String apellido;
  DateTime natalicio;
  String contratos;
  String usuarios;
  DateTime creada;
  DateTime modificada;

  FkPersona({this.rut, this.nombre, this.apellido, this.natalicio, this.contratos,
   this.usuarios, this.creada, this.modificada});

  factory FkPersona.fromJson(Map<String, dynamic> item){
    return FkPersona(
      rut: item['rut'],
      nombre: item['nombre'],
      apellido: item['apellido'],
      natalicio: item['natalicio'] != null
        ? DateTime.parse(item['natalicio'])
        :null,
      contratos: item['contratos'],
      usuarios: item['usuarios'],
      creada: item['creada'] != null
        ? DateTime.parse(item['creada'])
        :null,
      modificada: item['modificada'] != null
        ? DateTime.parse(item['modificada'])
        :null,    
    );
  }
}
class FkUsuario{
  int id;
  String nombre;
  String correo;
  String clave;
  String administrador;
  String disennador;
  String funcionario;
  String integrantes;
  FkPersona fkPersona;
  DateTime creado;
  DateTime modificado;

  FkUsuario({this.id, this.nombre, this.correo, this.clave, this.administrador, this.disennador, 
  this.funcionario, this.integrantes, this.fkPersona, this.creado, this.modificado});

  factory FkUsuario.fromJson(Map<String, dynamic> item){
    return FkUsuario(
      id: item['id'],
      nombre: item['nombre'],
      correo: item['item'],
      clave: item['clave'],
      administrador: item['administrador'],
      disennador: item['disennador'],
      funcionario: item['funcionario'],
      integrantes: item['integrantes'],
      fkPersona: FkPersona.fromJson(item['fkPersona']),
      creado: item['creado']!= null
          ? DateTime.parse(item['creado'])
          : null,
      modificado: item['modificado'] != null
        ? DateTime.parse(item['modificado'])
        :null,    
    );
  }
}

class PkIntegrante {
  FkUsuario fkUsuario;
  FkUnidadInterna fkUnidadInterna;

  PkIntegrante ({this.fkUsuario, this.fkUnidadInterna});

  factory PkIntegrante.fromJson(Map<String, dynamic> item){
    return PkIntegrante(
      fkUsuario: FkUsuario.fromJson(item['fkUsuario']),
      fkUnidadInterna: FkUnidadInterna.fromJson(item['fkUnidadInterna']),
    );
  }
}

class FkIntegrante {
  PkIntegrante pkIntegrante;
  String asignaciones;
  DateTime creado;

  FkIntegrante({this.pkIntegrante, this.asignaciones, this.creado});

  factory FkIntegrante.fromJson(Map<String, dynamic> item){
    return FkIntegrante(
      pkIntegrante: PkIntegrante.fromJson(item['pkIntegrante']),
      asignaciones: item['asignaciones'],
      creado: item['creado'] != null
          ? DateTime.parse(item['creado'])
          : null,
    );
  }
}
class FkTarea {
  int codigo;
  String nombre;
  String descripcion;
  String estado;
  String asignaciones;
  String flujosTarea;
  String plazos;
  DateTime creada;
  DateTime modificada;

  FkTarea ({this.codigo, this.nombre, this.descripcion, this.estado, this.asignaciones, 
  this.flujosTarea, this.plazos, this.creada, this.modificada});

  factory FkTarea.fromJson(Map<String, dynamic> item){
    return FkTarea(
      codigo: item['codigo'],
      nombre: item['nombre'],
      descripcion: item['descripcion'],
      estado: item['estado'],
      asignaciones: item['asignaciones'],
      flujosTarea: item['flujosTarea'],
      plazos: item['plazos'],
      creada: item['creada'] != null
          ? DateTime.parse(item['creada'])
          : null,
      modificada: item['modificada'] != null
        ? DateTime.parse(item['modificada'])
        :null,    
    );
  }  
}

class PkAsignacion{
  FkTarea fkTarea;
  FkIntegrante fkIntegrante;

  PkAsignacion({this.fkTarea, this.fkIntegrante});

  factory PkAsignacion.fromJson(Map<String, dynamic> item){
    return PkAsignacion(
      fkTarea: FkTarea.fromJson(item['fkTarea']),
      fkIntegrante: FkIntegrante.fromJson(item['fkIntegrante']),
    );
  }  
}

class AsignacionForListing {
  String rol;
  String estado;
  String nota;
  PkAsignacion pkAsignacion;
  DateTime creada;
  DateTime modificada;

  AsignacionForListing({this.rol, this.estado, this.nota, this.pkAsignacion, this.creada, 
  this.modificada});
  
 factory AsignacionForListing.fromJson(Map<String, dynamic> item) {
    return AsignacionForListing(
      rol: item['rol'],
      estado: item['estado'],
      nota: item['nota'],
      pkAsignacion: PkAsignacion.fromJson(item['pkAsignacion']),
      creada: item['creada'] != null
          ? DateTime.parse(item['creada'])
          : null,
      modificada: item['modificada'] != null
        ? DateTime.parse(item['modificada'])
        :null, 
    );
  }
}