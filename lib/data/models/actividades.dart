class Referencia {
  final int id;
  String descripcion;
  int valor;
  int maximo;
  int minimo;
  int referenciado;
  int estado;
  int actividadTipo;
  String funciones;
  String funcionesWeb;
  int investigacion;
  int liderazgo;
  int estudiantes;
  int dofe;
  int validaEstudiantes;
  int categoria;
  int registros;
  int registrosUa;
  int registrosZona;
  int registrosCentro;
  int estudiantesMax;
  int cantidad;
  int producto;
  String? variableDescribe;
  int carrera;
  int items;
  int dofeEstudiantesMax;
  int dofeEstudiantesMin;
  int referenciar;

  Referencia({
    required this.id,
    required this.descripcion,
    required this.valor,
    required this.maximo,
    required this.minimo,
    required this.referenciado,
    required this.estado,
    required this.actividadTipo,
    required this.funciones,
    required this.funcionesWeb,
    required this.investigacion,
    required this.liderazgo,
    required this.estudiantes,
    required this.dofe,
    required this.validaEstudiantes,
    required this.categoria,
    required this.registros,
    required this.registrosUa,
    required this.registrosZona,
    required this.registrosCentro,
    required this.estudiantesMax,
    required this.cantidad,
    required this.producto,
    this.variableDescribe,
    required this.carrera,
    required this.items,
    required this.dofeEstudiantesMax,
    required this.dofeEstudiantesMin,
    required this.referenciar,
  });

  factory Referencia.fromJson(Map<String, dynamic> json) {
    return Referencia(
      id: json['id'],
      descripcion: json['descripcion'],
      valor: json['valor'],
      maximo: json['maximo'],
      minimo: json['minimo'],
      referenciado: json['referenciado'],
      estado: json['estado'],
      actividadTipo: json['actividad_tipo'],
      funciones: json['funciones'] ?? '',
      funcionesWeb: json['funciones_web'] ?? '',
      investigacion: json['investigacion'],
      liderazgo: json['liderazgo'],
      estudiantes: json['estudiantes'],
      dofe: json['dofe'],
      validaEstudiantes: json['valida_estudiantes'],
      categoria: json['categoria'],
      registros: json['registros'],
      registrosUa: json['registros_ua'],
      registrosZona: json['registros_zona'],
      registrosCentro: json['registros_centro'],
      estudiantesMax: json['estudiantes_max'],
      cantidad: json['cantidad'],
      producto: json['producto'],
      variableDescribe: json['variable_describe'] ?? '',
      carrera: json['carrera'],
      items: json['items'],
      dofeEstudiantesMax: json['dofe_estudiantes_max'],
      dofeEstudiantesMin: json['dofe_estudiantes_min'],
      referenciar: json['referenciar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descripcion': descripcion,
      'valor': valor,
      'maximo': maximo,
      'minimo': minimo,
      'referenciado': referenciado,
      'estado': estado,
      'actividad_tipo': actividadTipo,
      'funciones': funciones,
      'funciones_web': funcionesWeb,
      'investigacion': investigacion,
      'liderazgo': liderazgo,
      'estudiantes': estudiantes,
      'dofe': dofe,
      'valida_estudiantes': validaEstudiantes,
      'categoria': categoria,
      'registros': registros,
      'registros_ua': registrosUa,
      'registros_zona': registrosZona,
      'registros_centro': registrosCentro,
      'estudiantes_max': estudiantesMax,
      'cantidad': cantidad,
      'producto': producto,
      'variable_describe': variableDescribe,
      'carrera': carrera,
      'items': items,
      'dofe_estudiantes_max': dofeEstudiantesMax,
      'dofe_estudiantes_min': dofeEstudiantesMin,
      'referenciar': referenciar,
    };
  }
}
