import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projecto_base_laboratorio/data/models/laboratorio.dart';
import 'package:projecto_base_laboratorio/presentation/controllers/laboratorio_controller.dart';
import 'package:projecto_base_laboratorio/presentation/widgets/clone_periodo_dialog.dart';
import 'package:projecto_base_laboratorio/presentation/widgets/new_laboratorio_dialog.dart';
import '../widgets/laboratorio_card.dart';

class LaboratorioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LaboratorioController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text('Laboratorio', style: GoogleFonts.montserrat()),
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
                          Text('Centro:', style: GoogleFonts.montserrat(fontSize: 12)),
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
                                List<String> centros = ['Todos'];
                                centros.addAll(controller.laboratorios.map((laboratorio) => laboratorio.nombreCead).toSet().toList());
                                return DropdownButton<String>(
                                  isExpanded: true,
                                  value: controller.selectedCentro.value,
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      controller.setSelectedCentro(newValue);
                                    }
                                  },
                                  items: centros.map<DropdownMenuItem<String>>((String value) {
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
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Curso:', style: GoogleFonts.montserrat(fontSize: 12)),
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
                                List<String> cursos = ['Todos'];
                                cursos.addAll(controller.laboratorios.map((laboratorio) => laboratorio.cursoDescripcion).toSet().toList());
                                return DropdownButton<String>(
                                  isExpanded: true,
                                  value: controller.selectedCurso.value,
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      controller.setSelectedCurso(newValue);
                                    }
                                  },
                                  items: cursos.map<DropdownMenuItem<String>>((String value) {
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
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Zona:', style: GoogleFonts.montserrat(fontSize: 12)),
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
                                List<String> zonas = ['Todos'];
                                zonas.addAll(controller.laboratorios.map((laboratorio) => laboratorio.nombreZona).toSet().toList());
                                return DropdownButton<String>(
                                  isExpanded: true,
                                  value: controller.selectedZona.value,
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      controller.setSelectedZona(newValue);
                                    }
                                  },
                                  items: zonas.map<DropdownMenuItem<String>>((String value) {
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
                    SizedBox(width: 8),
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
                                escuelas.addAll(controller.laboratorios.map((laboratorio) => laboratorio.escuela).toSet().toList());
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
              } else if (controller.filteredLaboratorios.isEmpty) {
                return Center(child: Text('No hay laboratorios que coincidan con los filtros.', style: GoogleFonts.montserrat()));
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
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 3 / 2,
                      ),
                      itemCount: controller.filteredLaboratorios.length,
                      itemBuilder: (context, index) {
                        return LaboratorioCard(
                          laboratorio: controller.filteredLaboratorios[index],
                          onDelete: () {
                            _confirmDeleteLaboratorio(context, controller.filteredLaboratorios[index], controller);
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
                  return NewLaboratorioDialog(
                    onAdd: (laboratorio) {
                      controller.addLaboratorio(laboratorio);
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

  void _confirmDeleteLaboratorio(BuildContext context, Laboratorio laboratorio, LaboratorioController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Eliminación', style: GoogleFonts.montserrat()),
          content: Text('¿Estás seguro de que deseas eliminar este laboratorio?', style: GoogleFonts.montserrat()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar', style: GoogleFonts.montserrat()),
            ),
            TextButton(
              onPressed: () {
                controller.removeLaboratorio(laboratorio);
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