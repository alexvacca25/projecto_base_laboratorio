class Laboratorio {
  final double id;
  final double idCurso;
  final String cursoDescripcion;
  final String escuela;
  final int centro;
  final String nombreCead;
  final String nombreZona;
  final int estudiantesGrupo;
  final double horasGrupo;
  final String? tipoLaboratorio;
  final String? ubicacion;
  final String? recurso;
  String tipo;  // Removed final keyword
  final String token;

  Laboratorio({
    required this.id,
    required this.idCurso,
    required this.cursoDescripcion,
    required this.escuela,
    required this.centro,
    required this.nombreCead,
    required this.nombreZona,
    required this.estudiantesGrupo,
    required this.horasGrupo,
    this.tipoLaboratorio,
    this.ubicacion,
    this.recurso,
    required this.tipo,
    required this.token,
  });

  factory Laboratorio.fromJson(Map<String, dynamic> json) {
    return Laboratorio(
      id: json['id'],
      idCurso: json['id_curso'],
      cursoDescripcion: json['descripcion'],
      escuela: json['mat.descripcion'],
      centro: json['centro'],
      nombreCead: json['nombrecead'],
      nombreZona: json['nombre_zona'],
      estudiantesGrupo: json['estudiantes_grupo'],
      horasGrupo: json['horas_grupo'],
      tipoLaboratorio: json['tipo_laboratorio'],
      ubicacion: json['ubicacion'],
      recurso: json['recurso'],
      tipo: json['tipo'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_curso': idCurso,
      'descripcion': cursoDescripcion,
      'mat.descripcion': escuela,
      'centro': centro,
      'nombrecead': nombreCead,
      'nombre_zona': nombreZona,
      'estudiantes_grupo': estudiantesGrupo,
      'horas_grupo': horasGrupo,
      'tipo_laboratorio': tipoLaboratorio,
      'ubicacion': ubicacion,
      'recurso': recurso,
      'tipo': tipo,
      'token': token,
    };
  }
}
