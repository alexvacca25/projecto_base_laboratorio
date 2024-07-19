import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:projecto_base_laboratorio/presentation/controllers/periodo_controller.dart';
import 'package:projecto_base_laboratorio/utils/excel_util.dart';

class ReportesController extends GetxController {
  var isLoading = false.obs;
  final PeriodoController periodoController = Get.find();

  void downloadReport(String url, String fileName) async {
    isLoading.value = true;
    try {
      final periodoId = periodoController.selectedPeriodoId.value;
      
      final completeUrl = '$url&origen=$periodoId';

      final response = await http.get(Uri.parse(completeUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Llamar a la función que descarga el Excel
        downloadExcel(data, fileName);
      } else {
        Get.snackbar('Error', 'No se pudo descargar el reporte. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'No se pudo descargar el reporte');
    } finally {
      isLoading.value = false;
    }
  }
}
