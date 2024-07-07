class Laboratorio {
  final double id;
  final double idCurso;
  final String cursoDescripcion;
  final int centro;
  final String nombreCead;
  final int estudiantesGrupo;
  final double horasGrupo;
  final String? tipoLaboratorio;
  final String? ubicacion;
  final String? recurso;
  final String token;

  Laboratorio({
    required this.id,
    required this.idCurso,
    required this.cursoDescripcion,
    required this.centro,
    required this.nombreCead,
    required this.estudiantesGrupo,
    required this.horasGrupo,
    this.tipoLaboratorio,
    this.ubicacion,
    this.recurso,
    required this.token,
  });

  factory Laboratorio.fromJson(Map<String, dynamic> json) {
    return Laboratorio(
      id: json['id'],
      idCurso: json['id_curso'],
      cursoDescripcion: json['curso_descripcion'],
      centro: json['centro'],
      nombreCead: json['nombrecead'],
      estudiantesGrupo: json['estudiantes_grupo'],
      horasGrupo: json['horas_grupo'],
      tipoLaboratorio: json['tipo_laboratorio'],
      ubicacion: json['ubicacion'],
      recurso: json['recurso'],
      token: json['token'],
    );
  }
}
