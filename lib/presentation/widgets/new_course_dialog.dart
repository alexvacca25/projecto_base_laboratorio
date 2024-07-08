import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projecto_base_laboratorio/data/models/course.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class NewCourseDialog extends StatefulWidget {
  final Function(Course) onAdd;

  NewCourseDialog({required this.onAdd});

  @override
  _NewCourseDialogState createState() => _NewCourseDialogState();
}

class _NewCourseDialogState extends State<NewCourseDialog> {
  final TextEditingController _idCursoController = TextEditingController();
  final TextEditingController _descripcionCursoController = TextEditingController();
  final TextEditingController _idCentroController = TextEditingController();
  final TextEditingController _nombreCentroController = TextEditingController();
  final TextEditingController _estudiantesController = TextEditingController();
  final TextEditingController _horasController = TextEditingController();
  final TextEditingController _idCentroAtendidoController = TextEditingController();
  final TextEditingController _nombreCentroAtendidoController = TextEditingController();
  final List<CentroAtendido> _centrosAtendidos = [];

  Future<void> _fetchData(String id, String type) async {
    final token = "123"; // Token por defecto
    String url = '';
    if (type == 'curso') {
      url = 'http://localhost:8000/curso?id=$id&token=$token';
    } else if (type == 'centro') {
      url = 'http://localhost:8000/centro?id=$id&token=$token';
    } else if (type == 'centroa') {
      url = 'http://localhost:8000/centro?id=$id&token=$token';
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        if (type == 'curso') {
          _descripcionCursoController.text = data['descripcion'];
        } else if (type == 'centro') {
          _nombreCentroController.text = data['descripcion'];
        } else if (type == 'centroa') {
          _nombreCentroAtendidoController.text = data['descripcion'];
        }
      });
    } else {
      print('Error fetching $type: ${response.statusCode}');
    }
  }

  void _addCentroAtendido() {
    if (_idCentroAtendidoController.text.isNotEmpty && _nombreCentroAtendidoController.text.isNotEmpty) {
      setState(() {
        _centrosAtendidos.add(CentroAtendido(
          centroAtender: int.parse(_idCentroAtendidoController.text),
          nombreCentroAtendido: _nombreCentroAtendidoController.text,
        ));
        _idCentroAtendidoController.clear();
        _nombreCentroAtendidoController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Nuevo Curso', style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDialogTextField(_idCursoController, 'ID del Curso', TextInputType.number, true, 'curso'),
            _buildDialogTextField(_descripcionCursoController, 'Descripción del Curso', TextInputType.text, false, null),
            _buildDialogTextField(_idCentroController, 'ID del Centro Principal', TextInputType.number, true, 'centro'),
            _buildDialogTextField(_nombreCentroController, 'Nombre del Centro Principal', TextInputType.text, false, null),
            _buildDialogTextField(_estudiantesController, 'Número de Estudiantes', TextInputType.number, true, null),
            _buildDialogTextField(_horasController, 'Horas del Curso', TextInputType.number, true, null),
            SizedBox(height: 8.0),
            _buildDialogTextField(_idCentroAtendidoController, 'ID del Centro Atendido', TextInputType.number, true, 'centroa'),
            _buildDialogTextField(_nombreCentroAtendidoController, 'Nombre del Centro Atendido', TextInputType.text, false, null),
            TextButton(
              onPressed: _addCentroAtendido,
              child: Text('Agregar Centro Atendido', style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.bold)),
            ),
            ..._centrosAtendidos.map((centro) => ListTile(
              title: Text(centro.nombreCentroAtendido),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    _centrosAtendidos.remove(centro);
                  });
                },
              ),
            )),
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
                _descripcionCursoController.text.isNotEmpty &&
                _idCentroController.text.isNotEmpty &&
                _nombreCentroController.text.isNotEmpty &&
                _estudiantesController.text.isNotEmpty &&
                _horasController.text.isNotEmpty &&
                _centrosAtendidos.isNotEmpty) {
              widget.onAdd(Course(
                id: DateTime.now().millisecondsSinceEpoch, // ID generado automáticamente
                curso: int.parse(_idCursoController.text),
                descripcion: _descripcionCursoController.text,
                centro: int.parse(_idCentroController.text),
                nombreCentroPrincipal: _nombreCentroController.text,
                estudiantes: int.parse(_estudiantesController.text),
                horas: int.parse(_horasController.text),
                atiende: _centrosAtendidos,
              ));
              Navigator.of(context).pop();
            } else {
              // Muestra un mensaje de error si falta algún campo obligatorio
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Todos los campos son obligatorios y debe haber al menos un centro atendido.')));
            }
          },
          child: Text('Agregar', style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildDialogTextField(TextEditingController controller, String labelText, TextInputType keyboardType,
      bool isNumeric, String? type) {
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
          if (type != null) {
            _fetchData(value, type); // Validar y obtener datos del curso o centro
          }
        },
      ),
    );
  }
}
