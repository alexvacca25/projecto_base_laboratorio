import 'package:get/get.dart';
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
    course.atiende.add(centroAtendido);
    courses.refresh();
    filterCourses();
  }

  void removeCentroAtendido(Course course, CentroAtendido centroAtendido) {
    course.atiende.remove(centroAtendido);
    courses.refresh();
    filterCourses();
  }

  void addCourse(Course course) {
    courses.add(course);
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
    // Implementa la lógica de clonación aquí
    try {
      // Aquí puedes implementar la llamada a la API para clonar el período
      // Ejemplo:
      // final response = await apiProvider.clonePeriodo(origenId, destinoId);
      // if (response.isSuccessful) {
      //   Get.snackbar('Success', 'Periodo clonado con éxito');
      //   fetchCourses(); // Actualizar los datos después de la clonación
      // } else {
      //   Get.snackbar('Error', 'No se pudo clonar el período');
      // }
    } catch (e) {
      Get.snackbar('Error', 'No se pudo clonar el período');
    }
  }
}
