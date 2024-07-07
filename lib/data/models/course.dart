class Course {
  int id;
  int curso;
  String descripcion;
  int centro;
  String nombreCentroPrincipal;
  int estudiantes;
  int horas;
  List<CentroAtendido> atiende;

  Course({
    required this.id,
    required this.curso,
    required this.descripcion,
    required this.centro,
    required this.nombreCentroPrincipal,
    required this.estudiantes,
    required this.horas,
    required this.atiende,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    var list = json['atiende'] as List;
    List<CentroAtendido> atiendeList = list.map((i) => CentroAtendido.fromJson(i)).toList();

    return Course(
      id: json['id'],
      curso: json['curso'],
      descripcion: json['descripcion'],
      centro: json['centro'],
      nombreCentroPrincipal: json['nombre_centro_principal'],
      estudiantes: json['estudiantes'],
      horas: json['horas'],
      atiende: atiendeList,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> atiendeList = this.atiende.map((i) => i.toJson()).toList();

    return {
      'id': id,
      'curso': curso,
      'descripcion': descripcion,
      'centro': centro,
      'nombre_centro_principal': nombreCentroPrincipal,
      'estudiantes': estudiantes,
      'horas': horas,
      'atiende': atiendeList,
    };
  }
}

class CentroAtendido {
  int centroAtender;
  String nombreCentroAtendido;

  CentroAtendido({
    required this.centroAtender,
    required this.nombreCentroAtendido,
  });

  factory CentroAtendido.fromJson(Map<String, dynamic> json) {
    return CentroAtendido(
      centroAtender: json['centro_atender'],
      nombreCentroAtendido: json['nombre_centro_atendido'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'centro_atender': centroAtender,
      'nombre_centro_atendido': nombreCentroAtendido,
    };
  }
}
