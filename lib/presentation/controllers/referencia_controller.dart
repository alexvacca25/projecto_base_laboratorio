import 'package:get/get.dart';
import 'package:projecto_base_laboratorio/data/models/actividades.dart';
import 'package:projecto_base_laboratorio/data/providers/api_provider.dart';

class ReferenciaController extends GetxController {
  var referencias = <Referencia>[].obs;
  var isLoading = false.obs;
  var filteredReferencias = <Referencia>[].obs;
  var selectedDescripcion = ''.obs;

  final ApiProvider apiProvider;

  ReferenciaController({required this.apiProvider});

  @override
  void onInit() {
    super.onInit();
    fetchReferencias();
  }

  void fetchReferencias() async {
    try {
      isLoading(true);
      var fetchedReferencias = await apiProvider.fetchReferencias();
      referencias.assignAll(fetchedReferencias);
      // Ordenar alfabéticamente por descripción
      referencias.sort((a, b) => a.descripcion.compareTo(b.descripcion));
    } catch (e) {
      Get.snackbar('Error', 'No se pudieron cargar las referencias: $e');
    } finally {
      isLoading(false);
    }
  }

  void filterReferencias(String descripcion) {
    selectedDescripcion.value = descripcion;
    if (descripcion.isEmpty) {
      filteredReferencias.clear();
    } else {
      filteredReferencias.assignAll(
        referencias.where((ref) => ref.descripcion == descripcion).toList(),
      );
    }
  }
}
