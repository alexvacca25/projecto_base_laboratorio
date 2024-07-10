class CursoAutodirigido {
  final int id;
  final int periodo;
  final int curso;
  final int consecutivo;
  final String matDescripcion;
  final String? escuelaDescripcion;

  CursoAutodirigido({
    required this.id,
    required this.periodo,
    required this.curso,
    required this.consecutivo,
    required this.matDescripcion,
    this.escuelaDescripcion,
  });

  factory CursoAutodirigido.fromJson(Map<String, dynamic> json) {
    return CursoAutodirigido(
      id: json['id'],
      periodo: json['periodo'],
      curso: json['curso'],
      consecutivo: json['consecutivo'],
      matDescripcion: json['mat_descripcion'],
      escuelaDescripcion: json['escuela_descripcion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'periodo': periodo,
      'curso': curso,
      'consecutivo': consecutivo,
      'mat_descripcion': matDescripcion,
      'escuela_descripcion': escuelaDescripcion,
    };
  }
}
