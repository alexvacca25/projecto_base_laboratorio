
import 'package:projecto_base_laboratorio/data/models/laboratorio.dart';
import 'package:universal_html/html.dart' as html;
import 'package:excel/excel.dart';
import 'package:projecto_base_laboratorio/data/models/course.dart';


void downloadCourseExcel(List<Course> courses) {
  var excel = Excel.createExcel();
  Sheet sheetObject = excel['Courses'];
  sheetObject.appendRow([
    'ID',
    'Curso',
    'Descripción',
    'Centro',
    'Nombre del Centro Principal',
    'Estudiantes',
    'Horas',
    'Centros Atendidos'
  ]);

  for (var course in courses) {
    sheetObject.appendRow([
      course.id,
      course.curso,
      course.descripcion,
      course.centro,
      course.nombreCentroPrincipal,
      course.estudiantes,
      course.horas,
      course.atiende.map((e) => e.nombreCentroAtendido).join(', '),
    ]);
  }

  var fileBytes = excel.encode();
  final blob = html.Blob([fileBytes], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: url)
    ..setAttribute('download', 'Nodos.xlsx')
    ..click();
  html.Url.revokeObjectUrl(url);
}

void downloadLaboratorioExcel(List<Laboratorio> laboratorios) {
  var excel = Excel.createExcel();
  Sheet sheetObject = excel['Laboratorios'];
  sheetObject.appendRow([
    'ID',
    'ID Curso',
    'Curso Descripción',
    'Centro',
    'Nombre CEAD',
    'Estudiantes Grupo',
    'Horas Grupo',
    'Tipo Laboratorio',
    'Ubicación',
    'Recurso'
  ]);

  for (var laboratorio in laboratorios) {
    sheetObject.appendRow([
      laboratorio.id,
      laboratorio.idCurso,
      laboratorio.cursoDescripcion,
      laboratorio.centro,
      laboratorio.nombreCead,
      laboratorio.estudiantesGrupo,
      laboratorio.horasGrupo,
      laboratorio.tipoLaboratorio ?? '',
      laboratorio.ubicacion ?? '',
      laboratorio.recurso ?? '',
    ]);
  }

  var fileBytes = excel.encode();
  final blob = html.Blob([fileBytes], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: url)
    ..setAttribute('download', 'laboratorios.xlsx')
    ..click();
  html.Url.revokeObjectUrl(url);
}
