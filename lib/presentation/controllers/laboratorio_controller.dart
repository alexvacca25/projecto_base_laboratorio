import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:projecto_base_laboratorio/config.dart';
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
      Get.snackbar('Laboratorios', 'Cargando Datos...');
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
      final matchQuery = query.isEmpty || laboratorio.cursoDescripcion.toLowerCase().contains(query);

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

  void addLaboratorio(Laboratorio laboratorio) async {
    /* laboratorios.add(laboratorio);
    filterLaboratorios(); */
  final token = "123";
  final url = '${Config.baseUrl}/addlab';

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
    "curso": laboratorio.idCurso,
    "centro": laboratorio.centro,
    "estudiantes_grupo": laboratorio.estudiantesGrupo,
    "horas_grupo": laboratorio.horasGrupo,
    "tipo_laboratorio": null,
    "ubicacion": null,
    "recurso": null,
    "periodo": periodoController.selectedPeriodoId.value,
    "estado": 0,
	  "token":"123"
        
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final registrosAfectados = data['registrosAfectados'];
      Get.snackbar(
        'Cursos Laboratorio',
        'Se Registraron: $registrosAfectados registros.',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 5), // Duración del Snackbar
      );
      fetchLaboratorios(); // Actualizar los datos después de la eliminación
    } else {
      Get.snackbar(
        'Error',
        'No se pudo Agregar el Centro. Código de estado: ${response.statusCode}',
      );
    }
  } catch (e) {
    Get.snackbar(
      'Error',
      'No se pudo Agregar el Centro',
    );
  }
  }

  void removeLaboratorio(Laboratorio laboratorio) async {
    /* laboratorios.remove(laboratorio);
    filterLaboratorios(); */
    final token = "123";
    final url = '${Config.baseUrl}/quitar?origen=soca2015.laboratorios_cursos_centro&id=${laboratorio.id}&token=$token';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final registrosAfectados = data['registrosAfectados'];
         Get.snackbar(
          'Cursos Laboratorio ',
          'Se Retiro: $registrosAfectados registros.',
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 5), // Duración del Snackbar
          
          
        );
        fetchLaboratorios(); // Actualizar los datos después de la clonación
      } else {
        Get.snackbar('Error', 'No se pudo Quitar el CEntro. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'No se pudo Quitar el Centro');
    }
    filterLaboratorios();
  }

  void updateTipo(Laboratorio laboratorio, String nuevoTipo) {
    laboratorio.tipo = nuevoTipo;
    laboratorios.refresh();
    filterLaboratorios();
  }

  void downloadExcel() {
    downloadLaboratorioExcel(filteredLaboratorios);
  }

 void clonePeriodo(int origenId, int destinoId) async {
    final token = "123";
    final url = '${Config.baseUrl}/clonarlab?token=$token&origen=$origenId&destino=$destinoId';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final registrosAfectados = data['registrosAfectados'];
         Get.snackbar(
          'Éxito',
          'Se clonaron $registrosAfectados registros.',
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 5), // Duración del Snackbar
          
          
        );
        fetchLaboratorios(); // Actualizar los datos después de la clonación
      } else {
        Get.snackbar('Error', 'No se pudo clonar el período. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'No se pudo clonar el período');
    }
  }
}
