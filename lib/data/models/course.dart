class Course {
  final int id;
  final int curso;
  final String descripcion;
  final int centro;
  final String nombreCentroPrincipal;
  final int estudiantes;
  final int horas;
  final int periodo;
  final List<CentroAtendido> atiende;
  final String zona;
  final String escuela;
  final String tipo;

  Course({
    required this.id,
    required this.curso,
    required this.descripcion,
    required this.centro,
    required this.nombreCentroPrincipal,
    required this.estudiantes,
    required this.horas,
    required this.periodo,
    required this.atiende,
    required this.zona,
    required this.escuela,
    required this.tipo,
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
      periodo: json['periodo'],
      atiende: atiendeList,
      zona: json['zona'],
      escuela: json['escuela'],
      tipo: json['tipo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'curso': curso,
      'descripcion': descripcion,
      'centro': centro,
      'nombre_centro_principal': nombreCentroPrincipal,
      'estudiantes': estudiantes,
      'horas': horas,
      'periodo': periodo,
      'atiende': atiende.map((e) => e.toJson()).toList(),
      'zona': zona,
      'escuela': escuela,
      'tipo': tipo,
    };
  }
}

class CentroAtendido {
  final int centroAtender;
  final String nombreCentroAtendido;

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
