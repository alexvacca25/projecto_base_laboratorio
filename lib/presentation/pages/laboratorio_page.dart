import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projecto_base_laboratorio/presentation/widgets/new_laboratorio_dialog.dart';
import '../controllers/laboratorio_controller.dart';
import '../widgets/laboratorio_card.dart';

class LaboratorioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LaboratorioController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text('Laboratorio Nodo Centro', style: GoogleFonts.montserrat()),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
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
                              child: Text(value, style: GoogleFonts.montserrat(fontSize: 14)),
                            );
                          }).toList(),
                        );
                      }),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 50,
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
                              child: Text(value, style: GoogleFonts.montserrat(fontSize: 14)),
                            );
                          }).toList(),
                        );
                      }),
                    ),
                  ),
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
                          onEdit: () {
                            // Implementar lógica de edición
                            print('Edit laboratorio: ${controller.filteredLaboratorios[index].cursoDescripcion}');
                          },
                          onDelete: () {
                            // Implementar lógica de eliminación
                            print('Delete laboratorio: ${controller.filteredLaboratorios[index].cursoDescripcion}');
                            controller.filteredLaboratorios.removeAt(index);
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
              // Acción para clonar periodo
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
                      // Implementar lógica para agregar el nuevo laboratorio
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
              // Acción para descargar excel
            },
          ),
        ],
      ),
    );
  }
}
