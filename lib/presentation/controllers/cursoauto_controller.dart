import 'package:get/get.dart';

import 'package:projecto_base_laboratorio/data/models/cursoauto.dart';
import 'package:projecto_base_laboratorio/domain/usecases/get_cursoauto.dart';

import 'package:projecto_base_laboratorio/presentation/controllers/periodo_controller.dart';
import 'package:projecto_base_laboratorio/utils/excel_util.dart';

class CursoAutodirigidoController extends GetxController {
  final GetCursosAutodirigidos getCursosAutodirigidos;
  final PeriodoController periodoController;

  CursoAutodirigidoController({
    required this.getCursosAutodirigidos,
    required this.periodoController,
  });

  var cursosAutodirigidos = <CursoAutodirigido>[].obs;
  var filteredCursosAutodirigidos = <CursoAutodirigido>[].obs;
  var isLoading = true.obs;
  var selectedEscuela = 'Todos'.obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    fetchCursosAutodirigidos();
    super.onInit();
    periodoController.selectedPeriodoId.listen((_) => fetchCursosAutodirigidos());
  }

  void fetchCursosAutodirigidos() async {
    isLoading.value = true;
    cursosAutodirigidos.clear();
    try {
      var result = await getCursosAutodirigidos(periodoController.selectedPeriodoId.value);
      cursosAutodirigidos.value = result;
      filterCursosAutodirigidos();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load cursos autodirigidos');
    } finally {
      isLoading.value = false;
    }
  }

  void filterCursosAutodirigidos() {
    var escuela = selectedEscuela.value;
    var query = searchQuery.value.toLowerCase();
    if (escuela == 'Todos' && query.isEmpty) {
      filteredCursosAutodirigidos.value = cursosAutodirigidos;
    } else {
      filteredCursosAutodirigidos.value = cursosAutodirigidos.where((curso) {
        final matchEscuela = escuela == 'Todos' || curso.escuelaDescripcion?.toLowerCase() == escuela.toLowerCase();
        final matchQuery = query.isEmpty || curso.matDescripcion.toLowerCase().contains(query);
        return matchEscuela && matchQuery;
      }).toList();
    }
  }

  void setSelectedEscuela(String escuela) {
    selectedEscuela.value = escuela;
    filterCursosAutodirigidos();
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
    filterCursosAutodirigidos();
  }

  void addCursoAutodirigido(CursoAutodirigido curso) {
    cursosAutodirigidos.add(curso);
    filterCursosAutodirigidos();
  }

  void removeCursoAutodirigido(CursoAutodirigido curso) {
    cursosAutodirigidos.remove(curso);
    filterCursosAutodirigidos();
  }

  void downloadExcel() {
    downloadCursoAutodirigidoExcel(cursosAutodirigidos);
  }

  void clonePeriodo(int origenId, int destinoId) async {
    // Implementa la lógica de clonación aquí
    try {
      // Aquí puedes implementar la llamada a la API para clonar el período
      // Ejemplo:
      // final response = await apiProvider.clonePeriodo(origenId, destinoId);
      // if (response.isSuccessful) {
      //   Get.snackbar('Success', 'Periodo clonado con éxito');
      //   fetchCursosAutodirigidos(); // Actualizar los datos después de la clonación
      // } else {
      //   Get.snackbar('Error', 'No se pudo clonar el período');
      // }
    } catch (e) {
      Get.snackbar('Error', 'No se pudo clonar el período');
    }
  }
}
