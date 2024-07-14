import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projecto_base_laboratorio/data/models/laboratorio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewLaboratorioDialog extends StatefulWidget {
  final Function(Laboratorio) onAdd;

  NewLaboratorioDialog({required this.onAdd});

  @override
  _NewLaboratorioDialogState createState() => _NewLaboratorioDialogState();
}

class _NewLaboratorioDialogState extends State<NewLaboratorioDialog> {
  final TextEditingController _idCursoController = TextEditingController();
  final TextEditingController _nombreCursoController = TextEditingController();
  final TextEditingController _idCentroController = TextEditingController();
  final TextEditingController _nombreCentroController = TextEditingController();
  final TextEditingController _idPeriodoController = TextEditingController();
  final TextEditingController _nombrePeriodoController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _ubicacionController = TextEditingController();
  final TextEditingController _recursoController = TextEditingController();
  final TextEditingController _estudiantesGrupoController = TextEditingController();
  final TextEditingController _horasGrupoController = TextEditingController();
  final TextEditingController _tipoLaboratorioController = TextEditingController(); // Nuevo campo


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
    }
  });

  if (type == 'curso') {
    url = 'http://localhost:8000/curso?id=$id&token=$token';
  } else if (type == 'centro') {
    url = 'http://localhost:8000/centro?id=$id&token=$token';
  } else if (type == 'periodo') {
    url = 'http://localhost:8000/periodo?id=$id&token=$token';
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
      title: Text('Nuevo Laboratorio', style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDialogTextField(_idCursoController, 'ID del Curso', TextInputType.number, true, 'curso'),
            _buildDialogTextField(_nombreCursoController, 'Nombre del Curso', TextInputType.text, false, null,escribir: true),
            _buildDialogTextField(_idCentroController, 'ID del Centro', TextInputType.number, true, 'centro'),
            _buildDialogTextField(_nombreCentroController, 'Nombre del Centro', TextInputType.text, false, null, escribir: true),
            _buildDialogTextField(_idPeriodoController, 'ID del Periodo', TextInputType.number, true, 'periodo'),
            _buildDialogTextField(_nombrePeriodoController, 'Nombre del Periodo', TextInputType.text, false, null, escribir: true),
            _buildDialogTextField(_estudiantesGrupoController, 'Número de Estudiantes', TextInputType.number, true, null),
            _buildDialogTextField(_horasGrupoController, 'Horas del Grupo', TextInputType.number, true, null),
          /*   _buildDialogTextField(_tipoLaboratorioController, 'Tipo de Laboratorio', TextInputType.text, false, null),  */// Nuevo campo
            _buildDialogTextField(_tipoController, 'Tipo (Opcional)', TextInputType.text, false, null),
            _buildDialogTextField(_ubicacionController, 'Ubicación (Opcional)', TextInputType.text, false, null),
            _buildDialogTextField(_recursoController, 'Recurso (Opcional)', TextInputType.text, false, null),
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
                _estudiantesGrupoController.text.isNotEmpty &&
                _horasGrupoController.text.isNotEmpty) {
              widget.onAdd(Laboratorio(
                id: DateTime.now().millisecondsSinceEpoch.toDouble(), // ID generado automáticamente
                idCurso: double.parse(_idCursoController.text),
                cursoDescripcion: _nombreCursoController.text,
                escuela: '', // No se incluye en la creación
                centro: int.parse(_idCentroController.text),
                nombreCead: _nombreCentroController.text,
                nombreZona: '', // No se incluye en la creación
                estudiantesGrupo: int.parse(_estudiantesGrupoController.text),
                horasGrupo: double.parse(_horasGrupoController.text),
                tipoLaboratorio: '', // Nuevo campo
                tipo: _tipoController.text,
                ubicacion: _ubicacionController.text,
                recurso: _recursoController.text,
                token: '123', // Token por defecto
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
          enabled: escribir,
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
