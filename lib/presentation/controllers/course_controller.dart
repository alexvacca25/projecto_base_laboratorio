import 'package:get/get.dart';
import 'package:projecto_base_laboratorio/data/models/course.dart';
import 'package:projecto_base_laboratorio/domain/usecases/get_courses.dart';
import 'package:projecto_base_laboratorio/presentation/controllers/periodo_controller.dart';

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

  void addCentroAtendido(int courseIndex, CentroAtendido centroAtendido) {
    courses[courseIndex].atiende.add(centroAtendido);
    filterCourses();
  }


  void addCourse(Course course) {
    courses.add(course);
    filterCourses();
  }
}
