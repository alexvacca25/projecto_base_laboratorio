import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projecto_base_laboratorio/presentation/controllers/menu_controller.dart';
import 'package:projecto_base_laboratorio/presentation/controllers/periodo_controller.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PeriodoController periodoController = Get.find();
    final MenuOpController menuController = Get.find();

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text('Menú', style: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() {
              final periodos = periodoController.periodos.toSet().toList(); // Remover duplicados
              return DropdownButton<int>(
                value: periodos.any((p) => p['id'] == periodoController.selectedPeriodoId.value)
                    ? periodoController.selectedPeriodoId.value
                    : null,
                onChanged: (int? newValue) {
                  if (newValue != null) {
                    periodoController.setSelectedPeriodoId(newValue);
                  }
                },
                items: periodos.map<DropdownMenuItem<int>>((periodo) {
                  return DropdownMenuItem<int>(
                    value: periodo['id'],
                    child: Text(periodo['descripcion'], style: GoogleFonts.montserrat(fontSize: 14)),
                  );
                }).toList(),
              );
            }),
          ),
          ListTile(
            leading: Icon(Icons.science),
            title: Text('Laboratorios', style: GoogleFonts.montserrat()),
            onTap: () {
              menuController.selectedItem.value = MenuItem.laboratorios;
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: Icon(Icons.school),
            title: Text('Nodo Atendido Centro', style: GoogleFonts.montserrat()),
            onTap: () {
              menuController.selectedItem.value = MenuItem.nodo_centro;
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('Primera Matricula', style: GoogleFonts.montserrat()),
            onTap: () {
              menuController.selectedItem.value = MenuItem.laboratorio_curso;
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
