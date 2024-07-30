import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projecto_base_laboratorio/data/models/laboratorio.dart';
import 'package:projecto_base_laboratorio/presentation/controllers/laboratorio_controller.dart';

class EditarLaboratorioDialog extends StatelessWidget {
  final Laboratorio laboratorio;

  EditarLaboratorioDialog({required this.laboratorio});

  final TextEditingController estudiantesController = TextEditingController();
  final TextEditingController horasController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    estudiantesController.text = laboratorio.estudiantesGrupo.toString();
    horasController.text = laboratorio.horasGrupo.toString();

    return AlertDialog(
      title: Text('Editar Laboratorio', style: GoogleFonts.montserrat()),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: estudiantesController,
            decoration: InputDecoration(
              labelText: 'Estudiantes',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          SizedBox(height: 8),
          TextField(
            controller: horasController,
            decoration: InputDecoration(
              labelText: 'Horas',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancelar', style: GoogleFonts.montserrat()),
        ),
        TextButton(
          onPressed: () {
            int estudiantes = int.parse(estudiantesController.text);
            int horas = int.parse(horasController.text);
            _showConfirmationDialog(context, 'Confirmar cambios',
                '¿Está seguro que desea cambiar los valores?', () {
              Get.find<LaboratorioController>().updateLaboratorio(
                  laboratorio.id.toInt(), estudiantes, horas);
              Navigator.of(context).pop();
            });
          },
          child: Text('Guardar', style: GoogleFonts.montserrat()),
        ),
      ],
    );
  }

  void _showConfirmationDialog(BuildContext context, String title,
      String content, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: GoogleFonts.montserrat()),
          content: Text(content, style: GoogleFonts.montserrat()),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar', style: GoogleFonts.montserrat()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirmar', style: GoogleFonts.montserrat()),
              onPressed: () {
                onConfirm();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
