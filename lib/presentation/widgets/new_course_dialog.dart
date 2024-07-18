import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projecto_base_laboratorio/config.dart';
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
  final TextEditingController _nombreCursoController = TextEditingController();
  final TextEditingController _idCentroController = TextEditingController();
  final TextEditingController _nombreCentroController = TextEditingController();
  final TextEditingController _idPeriodoController = TextEditingController();
  final TextEditingController _nombrePeriodoController = TextEditingController();
  final TextEditingController _estudiantesController = TextEditingController();
  final TextEditingController _horasController = TextEditingController();
  final TextEditingController _centroAtendidoController = TextEditingController();
  final TextEditingController _nombreCaController = TextEditingController();

Future<void> _fetchData(String id, String type) async {
  final token = "123"; // Token por defecto
  String url = '';

  // Limpiar los controladores de texto antes de la solicitud HTTP
  setState(() {
    if (type == 'curso') {
      _nombreCursoController.clear();
    } else if (type == 'centro') {
      _nombreCentroController.clear();
    } else if (type == 'periodo') {
      _nombrePeriodoController.clear();
    } else if (type == 'centroa') {
      _nombreCaController.clear();
    }
  });

  if (type == 'curso') {
    url = '${Config.baseUrl}/curso?id=$id&token=$token';
  } else if (type == 'centro') {
    url = '${Config.baseUrl}/centro?id=$id&token=$token';
  } else if (type == 'periodo') {
    url = '${Config.baseUrl}/periodo?id=$id&token=$token';
  }else if (type == 'centroa') {
    url = '${Config.baseUrl}/centro?id=$id&token=$token';
  }
  

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        if (type == 'curso') {
          _nombreCursoController.text = data['descripcion'];
        } else if (type == 'centro') {
          _nombreCentroController.text = data['descripcion'];
        } else if (type == 'periodo') {
          _nombrePeriodoController.text = data['descripcion'];
        }else if (type == 'centroa') {
          _nombreCaController.text = data['descripcion'];
        }
      });
    } else {
      print('Error fetching $type: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching $type: $e');
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
            _buildDialogTextField(_nombreCursoController, 'Nombre del Curso', TextInputType.text, false, null,escribir: true),
            _buildDialogTextField(_idCentroController, 'ID del Centro', TextInputType.number, true, 'centro'),
            _buildDialogTextField(_nombreCentroController, 'Nombre del Centro', TextInputType.text, false, null,escribir: true),
            _buildDialogTextField(_idPeriodoController, 'ID del Periodo', TextInputType.number, true, 'periodo'),
            _buildDialogTextField(_nombrePeriodoController, 'Nombre del Periodo', TextInputType.text, false, null, escribir: true),
            _buildDialogTextField(_estudiantesController, 'Número de Estudiantes', TextInputType.number, true, null),
            _buildDialogTextField(_horasController, 'Horas del Grupo', TextInputType.number, true, null),
             _buildDialogTextField(_centroAtendidoController, 'ID del Centro Atendido', TextInputType.number, true, 'centroa'),
            _buildDialogTextField(_nombreCaController, 'Nombre del Centro', TextInputType.text, false, null,escribir: true),
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
                _idCentroController.text.isNotEmpty &&
                _idPeriodoController.text.isNotEmpty &&
                _estudiantesController.text.isNotEmpty &&
                _horasController.text.isNotEmpty) {
              widget.onAdd(Course(
                id: DateTime.now().millisecondsSinceEpoch, // ID generado automáticamente
                curso: int.parse(_idCursoController.text),
                descripcion: _nombreCursoController.text,
                centro: int.parse(_idCentroController.text),
                nombreCentroPrincipal: _nombreCentroController.text,
                estudiantes: int.parse(_estudiantesController.text),
                horas: int.parse(_horasController.text),
                periodo: int.parse(_idPeriodoController.text),
                atiende: [ CentroAtendido(idCentroAtender: int.parse(_centroAtendidoController.text), centroAtender:int.parse(_centroAtendidoController.text) , nombreCentroAtendido: _nombreCaController.text)
                 
                ], // Lista vacía al crear nuevo curso
                zona: '', // No se incluye en la creación
                escuela: '', // No se incluye en la creación
                tipo: '', // No se incluye en la creación
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
      bool isNumeric, String? type,{bool escribir=false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        readOnly: escribir,
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
        onChanged: (value) {
          if (type != null) {
            _fetchData(value, type); // Validar y obtener datos del curso, centro o periodo
          }
        },
      ),
    );
  }
}
