import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projecto_base_laboratorio/data/models/actividades.dart';
import 'package:projecto_base_laboratorio/presentation/controllers/referencia_controller.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_search/dropdown_search.dart';

class ParametrosReferenciasPage extends StatelessWidget {
  final ReferenciaController controller = Get.find<ReferenciaController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Parámetros de Referencias"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() {
              return DropdownSearch<String>(
                items: controller.referencias.map((Referencia referencia) {
                  return referencia.descripcion;
                }).toList(),
                selectedItem: controller.selectedDescripcion.value.isEmpty
                    ? null
                    : controller.selectedDescripcion.value,
                onChanged: (value) {
                  controller.filterReferencias(value ?? '');
                },
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: 'Buscar y Seleccionar Descripción',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                      labelText: 'Buscar',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  itemBuilder: _customPopupItemBuilderExample,
                ),
              );
            }),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.isTrue) {
                return Center(child: CircularProgressIndicator());
              } else if (controller.filteredReferencias.isEmpty) {
                return Center(
                    child: Text(
                        'Seleccione una descripción para ver las referencias.'));
              } else {
                return GridView.builder(
                  padding: EdgeInsets.all(8.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Número de columnas en la grilla
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio:
                        0.75, // Relación de aspecto de las tarjetas
                  ),
                  itemCount: controller.filteredReferencias.length,
                  itemBuilder: (context, index) {
                    var referencia = controller.filteredReferencias[index];
                    return Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Card(
                            elevation: 4,
                            margin: EdgeInsets.all(8),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      referencia.descripcion,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    buildEditableField(
                                      'Valor',
                                      referencia.valor.toString(),
                                      (value) {
                                        referencia.valor = int.parse(value);
                                      },
                                    ),
                                    buildEditableField(
                                      'Máximo',
                                      referencia.maximo.toString(),
                                      (value) {
                                        referencia.maximo = int.parse(value);
                                      },
                                    ),
                                    buildEditableField(
                                      'Mínimo',
                                      referencia.minimo.toString(),
                                      (value) {
                                        referencia.minimo = int.parse(value);
                                      },
                                    ),
                                    buildEditableField(
                                      'Referenciado',
                                      referencia.referenciado.toString(),
                                      (value) {
                                        referencia.referenciado =
                                            int.parse(value);
                                      },
                                    ),
                                    buildEditableField(
                                      'Estado',
                                      referencia.estado.toString(),
                                      (value) {
                                        referencia.estado = int.parse(value);
                                      },
                                    ),
                                    buildEditableField(
                                      'Actividad Tipo',
                                      referencia.actividadTipo.toString(),
                                      (value) {
                                        referencia.actividadTipo =
                                            int.parse(value);
                                      },
                                    ),
                                    buildEditableField(
                                      'Investigación',
                                      referencia.investigacion.toString(),
                                      (value) {
                                        referencia.investigacion =
                                            int.parse(value);
                                      },
                                    ),
                                    buildEditableField(
                                      'Liderazgo',
                                      referencia.liderazgo.toString(),
                                      (value) {
                                        referencia.liderazgo = int.parse(value);
                                      },
                                    ),
                                    buildEditableField(
                                      'Estudiantes',
                                      referencia.estudiantes.toString(),
                                      (value) {
                                        referencia.estudiantes =
                                            int.parse(value);
                                      },
                                    ),
                                    buildEditableField(
                                      'DOFE',
                                      referencia.dofe.toString(),
                                      (value) {
                                        referencia.dofe = int.parse(value);
                                      },
                                    ),
                                    buildEditableField(
                                      'Valida Estudiantes',
                                      referencia.validaEstudiantes.toString(),
                                      (value) {
                                        referencia.validaEstudiantes =
                                            int.parse(value);
                                      },
                                    ),
                                    buildEditableField(
                                      'Categoría',
                                      referencia.categoria.toString(),
                                      (value) {
                                        referencia.categoria = int.parse(value);
                                      },
                                    ),
                                    buildEditableField(
                                      'Registros',
                                      referencia.registros.toString(),
                                      (value) {
                                        referencia.registros = int.parse(value);
                                      },
                                    ),
                                    buildEditableField(
                                      'Registros UA',
                                      referencia.registrosUa.toString(),
                                      (value) {
                                        referencia.registrosUa =
                                            int.parse(value);
                                      },
                                    ),
                                    buildEditableField(
                                      'Registros Zona',
                                      referencia.registrosZona.toString(),
                                      (value) {
                                        referencia.registrosZona =
                                            int.parse(value);
                                      },
                                    ),
                                    buildEditableField(
                                      'Registros Centro',
                                      referencia.registrosCentro.toString(),
                                      (value) {
                                        referencia.registrosCentro =
                                            int.parse(value);
                                      },
                                    ),
                                    buildEditableField(
                                      'Estudiantes Max',
                                      referencia.estudiantesMax.toString(),
                                      (value) {
                                        referencia.estudiantesMax =
                                            int.parse(value);
                                      },
                                    ),
                                    buildEditableField(
                                      'Cantidad',
                                      referencia.cantidad.toString(),
                                      (value) {
                                        referencia.cantidad = int.parse(value);
                                      },
                                    ),
                                    buildEditableField(
                                      'Producto',
                                      referencia.producto.toString(),
                                      (value) {
                                        referencia.producto = int.parse(value);
                                      },
                                    ),
                                    buildEditableField(
                                      'Carrera',
                                      referencia.carrera.toString(),
                                      (value) {
                                        referencia.carrera = int.parse(value);
                                      },
                                    ),
                                    buildEditableField(
                                      'Items',
                                      referencia.items.toString(),
                                      (value) {
                                        referencia.items = int.parse(value);
                                      },
                                    ),
                                    buildEditableField(
                                      'DOFE Estudiantes Max',
                                      referencia.dofeEstudiantesMax.toString(),
                                      (value) {
                                        referencia.dofeEstudiantesMax =
                                            int.parse(value);
                                      },
                                    ),
                                    buildEditableField(
                                      'DOFE Estudiantes Min',
                                      referencia.dofeEstudiantesMin.toString(),
                                      (value) {
                                        referencia.dofeEstudiantesMin =
                                            int.parse(value);
                                      },
                                    ),
                                    buildEditableField(
                                      'Referenciar',
                                      referencia.referenciar.toString(),
                                      (value) {
                                        referencia.referenciar =
                                            int.parse(value);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Card(
                            elevation: 4,
                            margin: EdgeInsets.all(8),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Funciones:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    Text(referencia.funciones),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _customDropDownExample(BuildContext context, String? item) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      child: Text(
        item ?? "Seleccionar Descripción",
        style: TextStyle(fontSize: 14.0),
      ),
    );
  }

  Widget _customPopupItemBuilderExample(
      BuildContext context, String item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.white,
      ),
      child: ListTile(
        title: Text(item),
      ),
    );
  }

  Widget buildEditableField(
      String label, String initialValue, ValueChanged<String> onChanged) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14.0),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: TextFormField(
              initialValue: initialValue,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 8.0),
              ),
              onChanged: (value) {
                if (value.isNotEmpty && int.tryParse(value) != null) {
                  onChanged(value);
                }
              },
              textAlign: TextAlign.right,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ], // Solo permite dígitos
            ),
          ),
        ],
      ),
    );
  }
}
