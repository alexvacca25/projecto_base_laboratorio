import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'package:projecto_base_laboratorio/config.dart';
import 'dart:convert';

import 'package:projecto_base_laboratorio/data/models/cursoauto.dart';

class NewCursoAutodirigidoDialog extends StatefulWidget {
  final Function(CursoAutodirigido) onAdd;

  NewCursoAutodirigidoDialog({required this.onAdd});

  @override
  _NewCursoAutodirigidoDialogState createState() => _NewCursoAutodirigidoDialogState();
}

class _NewCursoAutodirigidoDialogState extends State<NewCursoAutodirigidoDialog> {
  final TextEditingController _idCursoController = TextEditingController();
  final TextEditingController _nombreCursoController = TextEditingController();
  final TextEditingController _idPeriodoController = TextEditingController();
  final TextEditingController _nombrePeriodoController = TextEditingController();

  Future<void> _fetchData(String id, String type) async {
    final token = "123"; // Token por defecto
    String url = '';
    if (type == 'curso') {
      url = '${Config.baseUrl}/curso?id=$id&token=$token';
    } else if (type == 'periodo') {
      url = '${Config.baseUrl}/periodo?id=$id&token=$token';
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        if (type == 'curso') {
          _nombreCursoController.text = data['descripcion'] ?? 'Descripción no disponible';
        } else if (type == 'periodo') {
          _nombrePeriodoController.text = data['descripcion'] ?? 'Descripción no disponible';
        }
      });
    } else {
      print('Error fetching $type: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Nuevo Curso Autodirigido', style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDialogTextField(_idCursoController, 'Código del Curso', TextInputType.number, true, 'curso'),
            _buildDialogTextField(_nombreCursoController, 'Descripción del Curso', TextInputType.text, false, null),
            _buildDialogTextField(_idPeriodoController, 'ID del Periodo', TextInputType.number, true, 'periodo'),
            _buildDialogTextField(_nombrePeriodoController, 'Descripción del Periodo', TextInputType.text, false, null),
          ],
        ),
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
            if (_idCursoController.text.isNotEmpty &&
                _idPeriodoController.text.isNotEmpty) {
              widget.onAdd(CursoAutodirigido(
                id: 100, // ID generado automáticamente
                periodo: int.parse(_idPeriodoController.text),
                curso: int.parse(_idCursoController.text),
                consecutivo: int.parse(_idCursoController.text),
                matDescripcion: _nombreCursoController.text,
                escuelaDescripcion: '', // Añadir la descripción de la escuela si es necesario
              ));
              Navigator.of(context).pop();
            }
          },
          child: Text('Agregar', style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildDialogTextField(TextEditingController controller, String labelText, TextInputType keyboardType,
      bool fetchOnEnter, String? type) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        inputFormatters: type == 'curso' || type == 'periodo' ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly] : null,
        enabled: true,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        keyboardType: keyboardType,
        onFieldSubmitted: fetchOnEnter ? (value) => _fetchData(value, type!) : null,
      ),
    );
  }
}
