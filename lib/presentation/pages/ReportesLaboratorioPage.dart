import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projecto_base_laboratorio/config.dart';
import 'package:projecto_base_laboratorio/presentation/controllers/reportes_ontroller.dart';

class ReportesLaboratorioPage extends StatelessWidget {
  final ReportesController controller = Get.put(ReportesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reportes de Laboratorio', style: GoogleFonts.montserrat()),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircleAvatar(
              radius: 30,
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = constraints.maxWidth < 600
                    ? 1
                    : constraints.maxWidth < 900
                        ? 2
                        : 4;
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return _buildReportCard(
                          context,
                          icon: Icons.person,
                          label: 'Docentes con Grupos',
                          onTap: () => controller.downloadReport(
                              '${Config.baseUrl}/reportescomponente?token=123&consulta=consulta1',
                              'docentes_grupo.xlsx'),
                        );
                      case 1:
                        return _buildReportCard(
                          context,
                          icon: Icons.analytics,
                          label: 'Estadísticas Cursos',
                          onTap: () => controller.downloadReport(
                              '${Config.baseUrl}/reportescomponente?token=123&consulta=consulta2',
                              'estadisticas_curso1.xlsx'),
                        );
                      case 2:
                        return _buildReportCard(
                          context,
                          icon: Icons.analytics_outlined,
                          label: 'Análisis Cursos',
                          onTap: () => controller.downloadReport(
                              '${Config.baseUrl}/reportescomponente?token=123&consulta=consulta3',
                              'estadisticas_curso2.xlsx'),
                        );
                      case 3:
                        return _buildReportCard(
                          context,
                          icon: Icons.person_remove_alt_1,
                          label: 'Candidatos Sin Asignación',
                          onTap: () => controller.downloadReport(
                              '${Config.baseUrl}/reportescomponente?token=123&consulta=consulta4',
                              'candidatos_sin_asignacion.xlsx'),
                        );
                      case 4:
                        return _buildReportCard(
                          context,
                          icon: Icons.co_present_outlined,
                          label: 'Asignacion Componente Practico',
                          onTap: () => controller.downloadReport(
                              '${Config.baseUrl}/reportescomponente?token=123&consulta=consulta5',
                              'CP.xlsx'),
                        );
                      case 5:
                        return _buildReportCard(
                          context,
                          icon: Icons.present_to_all_outlined,
                          label: 'Componente Practico y Acompañamiento',
                          onTap: () => controller.downloadReport(
                              '${Config.baseUrl}/reportescomponente?token=123&consulta=consulta6',
                              'CP_AC.xlsx'),
                        );
                      default:
                        return SizedBox.shrink();
                    }
                  },
                );
              },
            ),
          );
        }
      }),
    );
  }

  Widget _buildReportCard(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48.0, color: Colors.blue),
            SizedBox(height: 8.0),
            Text(label,
                style: GoogleFonts.montserrat(
                    fontSize: 12.0, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
