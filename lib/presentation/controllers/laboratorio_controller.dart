import 'package:get/get.dart';
import 'package:projecto_base_laboratorio/data/models/laboratorio.dart';
import 'package:projecto_base_laboratorio/domain/usecases/get_laboratorios.dart';

class LaboratorioController extends GetxController {
  final GetLaboratorio getLaboratorios;

  LaboratorioController({required this.getLaboratorios});

  var laboratorios = <Laboratorio>[].obs;
  var filteredLaboratorios = <Laboratorio>[].obs;
  var isLoading = true.obs;
  var selectedCentro = 'Todos'.obs;
  var selectedCurso = 'Todos'.obs;

  @override
  void onInit() {
    fetchLaboratorios();
    super.onInit();
  }

  void fetchLaboratorios() async {
    isLoading.value = true;
    try {
      var result = await getLaboratorios();
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
}
