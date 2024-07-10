import 'package:flutter/material.dart';
import 'package:projecto_base_laboratorio/data/models/laboratorio.dart';
import 'package:google_fonts/google_fonts.dart';

class LaboratorioCard extends StatelessWidget {
  final Laboratorio laboratorio;
  final VoidCallback onDelete;

  LaboratorioCard({required this.laboratorio, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    labelColor: Theme.of(context).primaryColor,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(text: 'Detalles'),
                      Tab(text: 'Otros'),
                    ],
                  ),
                  Container(
                    height: 100,
                    child: TabBarView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${laboratorio.cursoDescripcion}',
                              style:  GoogleFonts.montserrat(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              
                            ),
                            Text(
                              'Centro: ${laboratorio.nombreCead}',
                              style:  GoogleFonts.montserrat(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text('Estudiantes: ${laboratorio.estudiantesGrupo}',
                              style:  GoogleFonts.montserrat(),),
                            Text('Horas: ${laboratorio.horasGrupo}',
                              style:  GoogleFonts.montserrat(),),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Tipo: ${laboratorio.tipoLaboratorio ?? 'N/A'}',
                              style:  GoogleFonts.montserrat(),),
                            Text('Ubicación: ${laboratorio.ubicacion ?? 'N/A'}',
                              style:  GoogleFonts.montserrat(),),
                            Text('Recurso: ${laboratorio.recurso ?? 'N/A'}',
                              style:  GoogleFonts.montserrat(),),
                                Text('Modalidad: ${laboratorio.tipo}',
                              style:  GoogleFonts.montserrat(),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
