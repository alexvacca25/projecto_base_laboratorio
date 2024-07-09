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
    if (centro == 'Todos' && curso == 'Todos') {
      filteredCourses.value = courses;
    } else {
      filteredCourses.value = courses.where((course) {
        final matchCentro = centro == 'Todos' || course.nombreCentroPrincipal == centro;
        final matchCurso = curso == 'Todos' || course.descripcion == curso;
        return matchCentro && matchCurso;
      }).toList();
    }
  }

  void setSelectedCentro(String centro) {
    selectedCentro.value = centro;
    filterCourses();
  }

  void setSelectedCurso(String curso) {
    selectedCurso.value = curso;
    filterCourses();
  }

  void addCentroAtendido(Course course, CentroAtendido centroAtendido) {
    course.atiende.add(centroAtendido);
    courses.refresh();
  }

  void removeCentroAtendido(Course course, CentroAtendido centroAtendido) {
    course.atiende.remove(centroAtendido);
    courses.refresh();
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
    downloadCourseExcel(courses);
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
