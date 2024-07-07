import 'package:get/get.dart';
import 'package:projecto_base_laboratorio/data/models/course.dart';
import 'package:projecto_base_laboratorio/domain/usecases/get_courses.dart';


class CourseController extends GetxController {
  final GetCourses getCourses;

  CourseController({required this.getCourses});

  var courses = <Course>[].obs;
  var filteredCourses = <Course>[].obs;
  var isLoading = true.obs;
  var selectedCentro = 'Todos'.obs;
  var selectedCurso = 'Todos'.obs;

  @override
  void onInit() {
    fetchCourses();
    super.onInit();
  }

  void fetchCourses() async {
    isLoading.value = true;
    try {
      var result = await getCourses();
      courses.value = result;
      filteredCourses.value = result;
    } catch (e) {
      // Handle error
    } finally {
      isLoading.value = false;
    }
  }

  void filterCourses() {
    var centro = selectedCentro.value;
    var curso = selectedCurso.value;
    filteredCourses.value = courses.where((course) {
      final matchCentro = centro == 'Todos' || course.nombreCentroPrincipal == centro;
      final matchCurso = curso == 'Todos' || course.descripcion == curso;
      return matchCentro && matchCurso;
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
}
