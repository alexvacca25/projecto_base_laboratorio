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
      print(result);
      filterLaboratorios(); // Filtrar después de obtener los datos
    } catch (e) {
      // Handle error
      Get.snackbar('Error', 'Failed to load laboratorios');
    } finally {
      isLoading.value = false;
    }
  }

  void filterLaboratorios() {
    var centro = selectedCentro.value;
    var curso = selectedCurso.value;
    if (centro == 'Todos' && curso == 'Todos') {
      filteredLaboratorios.value = laboratorios;
    } else {
      filteredLaboratorios.value = laboratorios.where((laboratorio) {
        final matchCentro = centro == 'Todos' || laboratorio.nombreCead == centro;
        final matchCurso = curso == 'Todos' || laboratorio.cursoDescripcion == curso;
        return matchCentro && matchCurso;
      }).toList();
    }
  }

  void setSelectedCentro(String centro) {
    selectedCentro.value = centro;
    filterLaboratorios();
  }

  void setSelectedCurso(String curso) {
    selectedCurso.value = curso;
    filterLaboratorios();
  }

    void addLaboratorio(Laboratorio laboratorio) {
    laboratorios.add(laboratorio);
    filterLaboratorios();
  }

  void downloadExcel() {
    downloadLaboratorioExcel(laboratorios);
  }

  void clonePeriodo(int origenId, int destinoId) async {
    // Implementa la lógica de clonación aquí
    // Por ejemplo, podrías llamar a una API que haga la clonación
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
