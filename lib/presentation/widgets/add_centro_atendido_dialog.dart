import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projecto_base_laboratorio/data/models/course.dart';


class AddCentroAtendidoDialog extends StatelessWidget {
  final Function(CentroAtendido) onAdd;

  AddCentroAtendidoDialog({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final _nombreCentroController = TextEditingController();
    final _idCentroController = TextEditingController();

    return AlertDialog(
      title: Text('Agregar Centro Atendido', style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDialogTextField(_nombreCentroController, 'Nombre del Centro', TextInputType.text),
          _buildDialogTextField(_idCentroController, 'ID del Centro', TextInputType.number),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar', style: GoogleFonts.montserrat(fontSize: 14)),
        ),
        TextButton(
          onPressed: () {
            if (_nombreCentroController.text.isNotEmpty && _idCentroController.text.isNotEmpty) {
              onAdd(CentroAtendido(
                centroAtender: int.parse(_idCentroController.text),
                nombreCentroAtendido: _nombreCentroController.text,
              ));
              Navigator.of(context).pop();
            }
          },
          child: Text('Agregar', style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildDialogTextField(TextEditingController controller, String labelText, TextInputType keyboardType) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}
