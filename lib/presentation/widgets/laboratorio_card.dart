import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projecto_base_laboratorio/data/models/laboratorio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projecto_base_laboratorio/presentation/controllers/laboratorio_controller.dart';
import 'package:projecto_base_laboratorio/presentation/widgets/editar_laboratorio_dialog.dart';

class LaboratorioCard extends StatelessWidget {
  final Laboratorio laboratorio;
  final VoidCallback onDelete;

  LaboratorioCard({
    required this.laboratorio,
    required this.onDelete,
  });

  void _toggleTipo(LaboratorioController controller, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Cambio', style: GoogleFonts.montserrat()),
          content: Text('¿Estás seguro de que deseas cambiar la modalidad de este laboratorio?', style: GoogleFonts.montserrat()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar', style: GoogleFonts.montserrat()),
            ),
            TextButton(
              onPressed: () {
                controller.updateTipo(laboratorio, laboratorio.tipo == 'virtual' ? 'presencial' : 'virtual');
                Navigator.of(context).pop();
              },
              child: Text('Cambiar', style: GoogleFonts.montserrat()),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final LaboratorioController controller = Get.find<LaboratorioController>();

    return Card(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: 'Detalles'),
                Tab(text: 'Otros'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildDetailsTab(context, controller),
                  _buildOtrosTab(context, controller),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsTab(BuildContext context, LaboratorioController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            laboratorio.cursoDescripcion,
            style: GoogleFonts.montserrat(fontSize: 14),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          SizedBox(height: 8.0),
          Text(
            'Centro: ${laboratorio.nombreCead}',
            style: GoogleFonts.montserrat(fontSize: 14),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              Text(
                'Estudiantes: ${laboratorio.estudiantesGrupo}',
                style: GoogleFonts.montserrat(fontSize: 14),
              ),
              SizedBox(width: 16),
              Text(
                'Horas: ${laboratorio.horasGrupo}',
                style: GoogleFonts.montserrat(fontSize: 14),
              ),
            ],
          ),
          Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return EditarLaboratorioDialog(laboratorio: laboratorio);
                      },
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: onDelete,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtrosTab(BuildContext context, LaboratorioController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Tipo: ${laboratorio.tipo}', style: GoogleFonts.montserrat(fontSize: 14)),
              IconButton(
                icon: Icon(Icons.swap_horiz),
                onPressed: () => _toggleTipo(controller, context),
                tooltip: 'Cambiar entre virtual y presencial',
              ),
            ],
          ),
          Text('Ubicación: ${laboratorio.ubicacion ?? 'N/A'}', style: GoogleFonts.montserrat(fontSize: 14)),
          Text('Recurso: ${laboratorio.recurso ?? 'N/A'}', style: GoogleFonts.montserrat(fontSize: 14)),
        ],
      ),
    );
  }
}
