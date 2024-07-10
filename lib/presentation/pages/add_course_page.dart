import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projecto_base_laboratorio/data/models/course.dart';

class AddCoursePage extends StatefulWidget {
  final Function(Course) onAdd;

  AddCoursePage({required this.onAdd});

  @override
  _AddCoursePageState createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  final _formKey = GlobalKey<FormState>();
  final _cursoController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _centroController = TextEditingController();
  final _nombreCentroPrincipalController = TextEditingController();
  final _estudiantesController = TextEditingController();
  final _horasController = TextEditingController();
  final _idPeriodoController = TextEditingController();
  final List<CentroAtendido> _centrosAtendidos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Nuevo Curso', style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField(_cursoController, 'Curso ID', TextInputType.number),
                _buildTextField(_descripcionController, 'Descripción', TextInputType.text),
                _buildTextField(_centroController, 'Centro ID', TextInputType.number),
                _buildTextField(_nombreCentroPrincipalController, 'Nombre del Centro Principal', TextInputType.text),
                _buildTextField(_idPeriodoController, 'ID del Periodo', TextInputType.number),
                Row(
                  children: [
                    Expanded(child: _buildTextField(_estudiantesController, 'Estudiantes', TextInputType.number)),
                    SizedBox(width: 16),
                    Expanded(child: _buildTextField(_horasController, 'Horas', TextInputType.number)),
                  ],
                ),
                SizedBox(height: 16.0),
                Text('Centros Atendidos', style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold)),
                _buildCentrosAtendidos(),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Agregar Curso', style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText, TextInputType keyboardType) {
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
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, ingrese $labelText';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildCentrosAtendidos() {
    return Column(
      children: [
        Wrap(
          spacing: 4.0,
          runSpacing: 2.0,
          children: _centrosAtendidos.map((centro) {
            return Chip(
              label: Text(centro.nombreCentroAtendido, style: GoogleFonts.montserrat(fontSize: 12)),
              deleteIcon: Icon(Icons.close, size: 16),
              onDeleted: () {
                setState(() {
                  _centrosAtendidos.remove(centro);
                });
              },
            );
          }).toList(),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: _addCentroAtendido,
        ),
      ],
    );
  }

  void _addCentroAtendido() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
                  setState(() {
                    _centrosAtendidos.add(CentroAtendido(
                      centroAtender: int.parse(_idCentroController.text),
                      nombreCentroAtendido: _nombreCentroController.text,
                    ));
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Agregar', style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newCourse = Course(
        id: DateTime.now().millisecondsSinceEpoch,  // Generar un ID único temporal
        curso: int.parse(_cursoController.text),
        descripcion: _descripcionController.text,
        centro: int.parse(_centroController.text),
        nombreCentroPrincipal: _nombreCentroPrincipalController.text,
        estudiantes: int.parse(_estudiantesController.text),
        horas: int.parse(_horasController.text),
        periodo: int.parse(_idPeriodoController.text),
        atiende: _centrosAtendidos,
        zona: '', // No se incluye en la creación
        escuela: '', // No se incluye en la creación
        tipo: '', // No se incluye en la creación
      );
      widget.onAdd(newCourse);
      Navigator.of(context).pop();
    }
  }
}
