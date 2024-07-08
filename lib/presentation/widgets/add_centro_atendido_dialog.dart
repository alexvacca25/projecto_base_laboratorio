import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projecto_base_laboratorio/data/models/course.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddCentroAtendidoDialog extends StatefulWidget {
  final Function(CentroAtendido) onAdd;

  AddCentroAtendidoDialog({required this.onAdd});

  @override
  _AddCentroAtendidoDialogState createState() => _AddCentroAtendidoDialogState();
}

class _AddCentroAtendidoDialogState extends State<AddCentroAtendidoDialog> {
  final TextEditingController _nombreCentroController = TextEditingController();
  final TextEditingController _idCentroController = TextEditingController();

  Future<void> _fetchCentro(String id) async {
    final token = "123"; // Token por defecto
    final response = await http.get(Uri.parse('http://localhost:8000/centro?id=$id&token=$token'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _nombreCentroController.text = data['descripcion'];
      });
    } else {
      print('Error fetching centro: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Agregar Centro Atendido', style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDialogTextField(_idCentroController, 'ID del Centro', TextInputType.number, true),
          _buildDialogTextField(_nombreCentroController, 'Nombre del Centro', TextInputType.text, false),
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
              widget.onAdd(CentroAtendido(
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

  Widget _buildDialogTextField(TextEditingController controller, String labelText, TextInputType keyboardType, bool isNumeric) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        inputFormatters: isNumeric ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly] : null,
        enabled: true,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        keyboardType: keyboardType,
        onFieldSubmitted: (value) {
          if (labelText == 'ID del Centro') {
            _fetchCentro(value); // Se envía solo el id, el token es por defecto "123"
          }
        },
      ),
    );
  }
}
