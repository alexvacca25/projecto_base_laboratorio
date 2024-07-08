import 'package:get/get.dart';
import 'package:projecto_base_laboratorio/data/providers/api_provider.dart';

class PeriodoController extends GetxController {
  final ApiProvider apiProvider;

  PeriodoController({required this.apiProvider});

  var periodos = <dynamic>[].obs;
  var selectedPeriodoId = 0.obs; // Valor por defecto

  @override
  void onInit() {
    fetchPeriodos();
    super.onInit();
  }

  void fetchPeriodos() async {
    try {
      var result = await apiProvider.fetchPeriodos();
      if (result.isNotEmpty) {
        // Remover duplicados
        periodos.value = result.toSet().toList();
        selectedPeriodoId.value = result.first['id']; // Seleccionar el primer período por defecto
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load periodos');
    }
  }

  String get selectedPeriodoDescription {
    return periodos.firstWhere((periodo) => periodo['id'] == selectedPeriodoId.value, orElse: () => {'descripcion': ''})['descripcion'];
  }

  void setSelectedPeriodoId(int id) {
    if (periodos.any((periodo) => periodo['id'] == id)) {
      selectedPeriodoId.value = id;
    }
  }
}
