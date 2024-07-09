import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projecto_base_laboratorio/data/models/course.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projecto_base_laboratorio/presentation/controllers/course_controller.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback onDelete;
  final Function(BuildContext, Function(CentroAtendido)) onAddCentroAtendido;

  CourseCard({
    required this.course,
    required this.onDelete,
    required this.onAddCentroAtendido,
  });

  void _confirmDeleteCentroAtendido(BuildContext context, CentroAtendido centro, CourseController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Eliminación', style: GoogleFonts.montserrat()),
          content: Text('¿Estás seguro de que deseas eliminar este centro atendido?', style: GoogleFonts.montserrat()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar', style: GoogleFonts.montserrat()),
            ),
            TextButton(
              onPressed: () {
                controller.removeCentroAtendido(course, centro);
                Navigator.of(context).pop();
              },
              child: Text('Eliminar', style: GoogleFonts.montserrat()),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final CourseController controller = Get.find<CourseController>();

    return Card(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: 'Detalles'),
                Tab(text: 'Centros Atendidos'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildDetailsTab(context),
                  _buildCentrosAtendidosTab(context, controller),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsTab(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            course.descripcion,
            style: GoogleFonts.montserrat(fontSize: 14),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          SizedBox(height: 8.0),
          Text(
            'Centro: ${course.nombreCentroPrincipal}',
            style: GoogleFonts.montserrat(fontSize: 14),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              Text(
                'Estudiantes: ${course.estudiantes}',
                style: GoogleFonts.montserrat(fontSize: 14),
              ),
              SizedBox(width: 16),
              Text(
                'Horas: ${course.horas}',
                style: GoogleFonts.montserrat(fontSize: 14),
              ),
            ],
          ),
          Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCentrosAtendidosTab(BuildContext context, CourseController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
         
         Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 4.0,
                  runSpacing: 2.0,
                  children: course.atiende.map((centro) {
                    return Chip(
                      label: Text(centro.nombreCentroAtendido, style: GoogleFonts.montserrat(fontSize: 12)),
                      deleteIcon: Icon(Icons.close, size: 16),
                      onDeleted: () => _confirmDeleteCentroAtendido(context, centro, controller),
                    );
                  }).toList(),
                ),
              ],
            ),
         
          Positioned(
            bottom: 0,
            right: 0,
            child: FloatingActionButton(
              mini: true,
              onPressed: () => onAddCentroAtendido(context, (centro) {
                controller.addCentroAtendido(course, centro);
              }),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
