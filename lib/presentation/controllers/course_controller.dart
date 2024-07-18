import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:projecto_base_laboratorio/config.dart';
import 'package:projecto_base_laboratorio/data/models/course.dart';

import 'package:projecto_base_laboratorio/domain/usecases/get_courses.dart';
import 'package:projecto_base_laboratorio/presentation/controllers/periodo_controller.dart';
import 'package:projecto_base_laboratorio/utils/excel_util.dart';

class CourseController extends GetxController {
  final GetCourses getCourses;
  final PeriodoController periodoController;

  CourseController({required this.getCourses, required this.periodoController});

  var courses = <Course>[].obs;
  var filteredCourses = <Course>[].obs;
  var isLoading = true.obs;
  var selectedCentro = 'Todos'.obs;
  var selectedCurso = 'Todos'.obs;
  var selectedZona = 'Todos'.obs;
  var selectedEscuela = 'Todos'.obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    fetchCourses();
    super.onInit();
    periodoController.selectedPeriodoId.listen((_) => fetchCourses());
  }

  void fetchCourses() async {
    isLoading.value = true;
    courses.clear();
    try {
      var result = await getCourses(periodoController.selectedPeriodoId.value);
      courses.value = result;
      filterCourses(); // Filtrar después de obtener los datos
    } catch (e) {
      // Handle error
      Get.snackbar('Error', 'Failed to load courses');
    } finally {
      isLoading.value = false;
    }
  }

  void filterCourses() {
    var centro = selectedCentro.value;
    var curso = selectedCurso.value;
    var zona = selectedZona.value;
    var escuela = selectedEscuela.value;
    var query = searchQuery.value.toLowerCase();

    filteredCourses.value = courses.where((course) {
      final matchCentro = centro == 'Todos' || course.nombreCentroPrincipal == centro;
      final matchCurso = curso == 'Todos' || course.descripcion == curso;
      final matchZona = zona == 'Todos' || course.zona == zona;
      final matchEscuela = escuela == 'Todos' || course.escuela == escuela;
      final matchQuery = course.descripcion.toLowerCase().contains(query) ||
                         course.nombreCentroPrincipal.toLowerCase().contains(query) ||
                         course.zona.toLowerCase().contains(query) ||
                         course.escuela.toLowerCase().contains(query);
      return matchCentro && matchCurso && matchZona && matchEscuela && matchQuery;
    }).toList();
  }

  void setSelectedCentro(String centro) {
    selectedCentro.value = centro;
    filterCourses();
  }

  void setSelectedCurso(String curso) {
    selectedCurso.value = curso;
    filterCourses();
  }

  void setSelectedZona(String zona) {
    selectedZona.value = zona;
    filterCourses();
  }

  void setSelectedEscuela(String escuela) {
    selectedEscuela.value = escuela;
    filterCourses();
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
    filterCourses();
  }

  void addCentroAtendido(Course course, CentroAtendido centroAtendido) {
    course.atiende.clear();
    course.atiende.add(centroAtendido);
    addCourse(course);
    courses.refresh();
    filterCourses();
  }

  void removeCentroAtendido(Course course, CentroAtendido centroAtendido) async {
   /*  course.atiende.remove(centroAtendido);
    courses.refresh();
    filterCourses(); */

     final token = "123";
    final url = '${Config.baseUrl}/quitar?origen=soca2015.laboratorios_cursos_nocentro&id=${centroAtendido.idCentroAtender}&token=$token';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final registrosAfectados = data['registrosAfectados'];
         Get.snackbar(
          'Centro Atendio',
          'Se Retiro: $registrosAfectados registros.',
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 5), // Duración del Snackbar
          
          
        );
        fetchCourses(); // Actualizar los datos después de la clonación
      } else {
        Get.snackbar('Error', 'No se pudo Quitar el CEntro. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'No se pudo Quitar el Centro');
    }
    filterCourses();
  }

  void addCourse(Course course) async {
    /* courses.add(course);
    filterCourses(); */
      /* laboratorios.add(laboratorio);
    filterLaboratorios(); */
  final token = "123";
  final url = '${Config.baseUrl}/addnodo';

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
    "curso": course.curso,
    "centro": course.centro,
    "centro_atender": course.atiende[0].centroAtender,
    "estudiantes": course.estudiantes,
    "horas": course.horas,
    "periodo": periodoController.selectedPeriodoId.value,
            
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final registrosAfectados = data['registrosAfectados'];
      Get.snackbar(
        'Nodos Atendidos en Centro',
        'Se Registraron: $registrosAfectados registros.',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 5), // Duración del Snackbar
      );
      fetchCourses(); // Actualizar los datos después de la eliminación
    } else {
      Get.snackbar(
        'Error',
        'No se pudo Agregar el Centro. Código de estado: ${response.statusCode}',
      );
    }
  } catch (e) {
    Get.snackbar(
      'Error',
      'No se pudo Agregar el Centro',
    );
  }
  filterCourses();
  }

  void removeCourse(Course course) {
    courses.remove(course);
    filterCourses();
  }

  void downloadExcel() {
    downloadCourseExcel(filteredCourses);
  }

  
 void clonePeriodo(int origenId, int destinoId) async {
    final token = "123";
    final url = '${Config.baseUrl}/clonarnodo?token=$token&origen=$origenId&destino=$destinoId';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final registrosAfectados = data['registrosAfectados'];
         Get.snackbar(
          'Éxito',
          'Se clonaron $registrosAfectados registros.',
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 5), // Duración del Snackbar
          
          
        );
        fetchCourses(); // Actualizar los datos después de la clonación
      } else {
        Get.snackbar('Error', 'No se pudo clonar el período. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'No se pudo clonar el período');
    }
  }
}
