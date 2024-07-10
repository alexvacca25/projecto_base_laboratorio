import 'package:get/get.dart';
import 'package:projecto_base_laboratorio/data/models/laboratorio.dart';
import 'package:projecto_base_laboratorio/domain/usecases/get_laboratorios.dart';
import 'package:projecto_base_laboratorio/presentation/controllers/periodo_controller.dart';
import 'package:projecto_base_laboratorio/utils/excel_util.dart';

class LaboratorioController extends GetxController {
  final GetLaboratorio getLaboratorios;
  final PeriodoController periodoController;

  LaboratorioController({required this.getLaboratorios, required this.periodoController});

  var laboratorios = <Laboratorio>[].obs;
  var filteredLaboratorios = <Laboratorio>[].obs;
  var isLoading = true.obs;
  var selectedCentro = 'Todos'.obs;
  var selectedCurso = 'Todos'.obs;
  var selectedZona = 'Todos'.obs;
  var selectedEscuela = 'Todos'.obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    fetchLaboratorios();
    super.onInit();
    periodoController.selectedPeriodoId.listen((_) => fetchLaboratorios());
  }

  void fetchLaboratorios() async {
    isLoading.value = true;
    laboratorios.clear();
    try {
      var result = await getLaboratorios(periodoController.selectedPeriodoId.value);
      laboratorios.value = result;
      filterLaboratorios();
    } catch (e) {
      Get.snackbar('Laboratorios', 'Cargando...');
    } finally {
      isLoading.value = false;
    }
  }

  void filterLaboratorios() {
    var centro = selectedCentro.value;
    var curso = selectedCurso.value;
    var zona = selectedZona.value;
    var escuela = selectedEscuela.value;
    var query = searchQuery.value.toLowerCase();

    filteredLaboratorios.value = laboratorios.where((laboratorio) {
      final matchCentro = centro == 'Todos' || laboratorio.nombreCead == centro;
      final matchCurso = curso == 'Todos' || laboratorio.cursoDescripcion == curso;
      final matchZona = zona == 'Todos' || laboratorio.nombreZona == zona;
      final matchEscuela = escuela == 'Todos' || laboratorio.escuela == escuela;
      final matchQuery = query.isEmpty || laboratorio.cursoDescripcion.toLowerCase().contains(query) ||
          laboratorio.nombreCead.toLowerCase().contains(query);

      return matchCentro && matchCurso && matchZona && matchEscuela && matchQuery;
    }).toList();
  }

  void setSelectedCentro(String centro) {
    selectedCentro.value = centro;
    filterLaboratorios();
  }

  void setSelectedCurso(String curso) {
    selectedCurso.value = curso;
    filterLaboratorios();
  }

  void setSelectedZona(String zona) {
    selectedZona.value = zona;
    filterLaboratorios();
  }

  void setSelectedEscuela(String escuela) {
    selectedEscuela.value = escuela;
    filterLaboratorios();
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
    filterLaboratorios();
  }

  void addLaboratorio(Laboratorio laboratorio) {
    laboratorios.add(laboratorio);
    filterLaboratorios();
  }

  void removeLaboratorio(Laboratorio laboratorio) {
    laboratorios.remove(laboratorio);
    filterLaboratorios();
  }

  void downloadExcel() {
    downloadLaboratorioExcel(filteredLaboratorios);
  }

  void clonePeriodo(int origenId, int destinoId) async {
    // Implementa la lógica de clonación aquí
    try {
      // Aquí puedes implementar la llamada a la API para clonar el período
      // Ejemplo:
      // final response = await apiProvider.clonePeriodo(origenId, destinoId);
      // if (response.isSuccessful) {
      //   Get.snackbar('Success', 'Periodo clonado con éxito');
      //   fetchLaboratorios(); // Actualizar los datos después de la clonación
      // } else {
      //   Get.snackbar('Error', 'No se pudo clonar el período');
      // }
    } catch (e) {
      Get.snackbar('Error', 'No se pudo clonar el período');
    }
  }
}
