import 'package:flutter/material.dart';
import 'package:projecto_base_laboratorio/data/models/laboratorio.dart';

class LaboratorioCard extends StatelessWidget {
  final Laboratorio laboratorio;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  LaboratorioCard({required this.laboratorio, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultTabController(
              length: 2, // Número de pestañas
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
                    height: 100, // Ajusta la altura según sea necesario
                    child: TabBarView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${laboratorio.cursoDescripcion} ',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text('Centro: ${laboratorio.nombreCead}',  
                            maxLines: 1,
                              overflow: TextOverflow.ellipsis,),
                            Text('Estudiantes: ${laboratorio.estudiantesGrupo}'),
                            Text('Horas: ${laboratorio.horasGrupo}'),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Tipo: ${laboratorio.tipoLaboratorio ?? 'N/A'}'),
                               Text('Ubicación: ${laboratorio.ubicacion ?? 'N/A'}'),
                            Text('Recurso: ${laboratorio.recurso ?? 'N/A'}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(icon: Icon(Icons.edit), onPressed: onEdit),
                IconButton(icon: Icon(Icons.delete), onPressed: onDelete),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
