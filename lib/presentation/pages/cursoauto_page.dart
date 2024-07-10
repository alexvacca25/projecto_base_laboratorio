import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projecto_base_laboratorio/data/models/cursoauto.dart';

import 'package:projecto_base_laboratorio/presentation/controllers/cursoauto_controller.dart';
import 'package:projecto_base_laboratorio/presentation/widgets/clone_periodo_dialog.dart';
import 'package:projecto_base_laboratorio/presentation/widgets/cursoauto_card.dart';

import 'package:projecto_base_laboratorio/presentation/widgets/new_cursoauto_dialog.dart';

class CursoAutodirigidoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CursoAutodirigidoController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text('Cursos Autodirigidos', style: GoogleFonts.montserrat()),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => controller.setSearchQuery(value),
              decoration: InputDecoration(
                labelText: 'Buscar',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              ),
              style: GoogleFonts.montserrat(fontSize: 12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Escuela:', style: GoogleFonts.montserrat(fontSize: 12)),
                          Container(
                            height: 35,
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: Obx(() {
                                List<String> escuelas = ['Todos'];
                                escuelas.addAll(controller.cursosAutodirigidos.map((curso) => curso.escuelaDescripcion ?? 'No disponible').toSet().toList());
                                return DropdownButton<String>(
                                  isExpanded: true,
                                  value: controller.selectedEscuela.value,
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      controller.setSelectedEscuela(newValue);
                                    }
                                  },
                                  items: escuelas.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value, style: GoogleFonts.montserrat(fontSize: 12)),
                                    );
                                  }).toList(),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (controller.filteredCursosAutodirigidos.isEmpty) {
                return Center(child: Text('No hay cursos autodirigidos que coincidan con los filtros.', style: GoogleFonts.montserrat()));
              } else {
                return LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = constraints.maxWidth < 600
                        ? 1
                        : constraints.maxWidth < 900
                            ? 2
                            : 4;

                    return GridView.builder(
                      padding: EdgeInsets.all(16.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16.0,
                        
                        childAspectRatio: 3 / 2,
                      ),
                      itemCount: controller.filteredCursosAutodirigidos.length,
                      itemBuilder: (context, index) {
                        return CursoAutodirigidoCard(
                          cursoAutodirigido: controller.filteredCursosAutodirigidos[index],
                          onDelete: () {
                            _confirmDeleteCursoAutodirigido(context, controller.filteredCursosAutodirigidos[index], controller);
                          },
                        );
                      },
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.blue,
        children: [
          SpeedDialChild(
            child: Icon(Icons.file_copy),
            label: 'Clonar Periodo',
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ClonePeriodoDialog(
                    onClone: (origenId, destinoId) {
                      controller.clonePeriodo(origenId, destinoId);
                    },
                  );
                },
              );
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.add),
            label: 'Nuevo Curso',
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return NewCursoAutodirigidoDialog(
                    onAdd: (curso) {
                      controller.addCursoAutodirigido(curso);
                    },
                  );
                },
              );
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.download),
            label: 'Descargar Excel',
            onTap: () {
              controller.downloadExcel();
            },
          ),
        ],
      ),
    );
  }

  void _confirmDeleteCursoAutodirigido(BuildContext context, CursoAutodirigido curso, CursoAutodirigidoController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Eliminación', style: GoogleFonts.montserrat()),
          content: Text('¿Estás seguro de que deseas eliminar este curso autodirigido?', style: GoogleFonts.montserrat()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar', style: GoogleFonts.montserrat()),
            ),
            TextButton(
              onPressed: () {
                controller.removeCursoAutodirigido(curso);
                Navigator.of(context).pop();
              },
              child: Text('Eliminar', style: GoogleFonts.montserrat()),
            ),
          ],
        );
      },
    );
  }
}
