import 'package:flutter/material.dart';
import 'package:projecto_base_laboratorio/data/models/course.dart';

import 'package:google_fonts/google_fonts.dart';


class CourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Function(BuildContext, Function(CentroAtendido)) onAddCentroAtendido;

  CourseCard({
    required this.course,
    required this.onEdit,
    required this.onDelete,
    required this.onAddCentroAtendido,
  });

  @override
  Widget build(BuildContext context) {
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
                  _buildCentrosAtendidosTab(context),
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
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: onEdit,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCentrosAtendidosTab(BuildContext context) {
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
                    onDeleted: () {
                      course.atiende.remove(centro);
                    },
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
                course.atiende.add(centro);
              }),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
