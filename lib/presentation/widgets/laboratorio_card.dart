import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projecto_base_laboratorio/data/models/laboratorio.dart';


class LaboratorioCard extends StatelessWidget {
  final Laboratorio laboratorio;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const LaboratorioCard({super.key, 
    required this.laboratorio,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          _buildDetailsTab(context),
        ],
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
            laboratorio.cursoDescripcion,
            style: GoogleFonts.montserrat(fontSize: 14),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          SizedBox(height: 8.0),
          Text(
            'Centro: ${laboratorio.nombreCead}',
            style: GoogleFonts.montserrat(fontSize: 14),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              Text(
                'Estudiantes: ${laboratorio.estudiantesGrupo}',
                style: GoogleFonts.montserrat(fontSize: 14),
              ),
              SizedBox(width: 16),
              Text(
                'Horas: ${laboratorio.horasGrupo}',
                style: GoogleFonts.montserrat(fontSize: 14),
              ),
            ],
          ),
          if (laboratorio.tipoLaboratorio != null) ...[
            SizedBox(height: 8.0),
            Text(
              'Tipo de Laboratorio: ${laboratorio.tipoLaboratorio}',
              style: GoogleFonts.montserrat(fontSize: 14),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
          if (laboratorio.ubicacion != null) ...[
            SizedBox(height: 8.0),
            Text(
              'Ubicación: ${laboratorio.ubicacion}',
              style: GoogleFonts.montserrat(fontSize: 14),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
          if (laboratorio.recurso != null) ...[
            SizedBox(height: 8.0),
            Text(
              'Recurso: ${laboratorio.recurso}',
              style: GoogleFonts.montserrat(fontSize: 14),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
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
}
