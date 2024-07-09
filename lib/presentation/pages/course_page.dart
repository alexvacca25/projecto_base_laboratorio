import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projecto_base_laboratorio/presentation/controllers/course_controller.dart';
import 'package:projecto_base_laboratorio/presentation/widgets/add_centro_atendido_dialog.dart';
import 'package:projecto_base_laboratorio/presentation/widgets/clone_periodo_dialog.dart';
import 'package:projecto_base_laboratorio/presentation/widgets/course_card.dart';
import 'package:projecto_base_laboratorio/data/models/course.dart';
import 'package:projecto_base_laboratorio/presentation/widgets/new_course_dialog.dart';

class CoursePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CourseController controller = Get.find();

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
                        centros.addAll(controller.courses.map((course) => course.nombreCentroPrincipal).toSet().toList());
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
                        cursos.addAll(controller.courses.map((course) => course.descripcion).toSet().toList());
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
              } else if (controller.filteredCourses.isEmpty) {
                return Center(child: Text('No hay cursos que coincidan con los filtros.', style: GoogleFonts.montserrat()));
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
                      itemCount: controller.filteredCourses.length,
                      itemBuilder: (context, index) {
                        return CourseCard(
                          course: controller.filteredCourses[index],
                          onEdit: () {
                            // Implementar lógica de edición
                            print('Edit course: ${controller.filteredCourses[index].descripcion}');
                          },
                          onDelete: () {
                            // Implementar lógica de eliminación
                            print('Delete course: ${controller.filteredCourses[index].descripcion}');
                            controller.filteredCourses.removeAt(index);
                          },
                          onAddCentroAtendido: (context, onAdd) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AddCentroAtendidoDialog(onAdd: (centroAtendido) {
                                  controller.addCentroAtendido(index, centroAtendido); // Agregar el centro atendido al curso
                                });
                              },
                            );
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
                  return NewCourseDialog(
                    onAdd: (course) {
                      // Implementar lógica para agregar el nuevo curso
                      controller.addCourse(course);
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
}
