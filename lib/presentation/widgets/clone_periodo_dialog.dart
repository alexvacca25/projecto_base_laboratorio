import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projecto_base_laboratorio/presentation/controllers/periodo_controller.dart';

class ClonePeriodoDialog extends StatefulWidget {
  final Function(int, int) onClone;

  ClonePeriodoDialog({required this.onClone});

  @override
  _ClonePeriodoDialogState createState() => _ClonePeriodoDialogState();
}

class _ClonePeriodoDialogState extends State<ClonePeriodoDialog> {
  int? selectedOrigen;
  int? selectedDestino;

  @override
  Widget build(BuildContext context) {
    final PeriodoController periodoController = Get.find();

    return AlertDialog(
      title: Text('Clonar Período', style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() {
            return DropdownButton<int>(
              hint: Text('Seleccione el período de origen'),
              value: selectedOrigen,
              onChanged: (int? newValue) {
                setState(() {
                  selectedOrigen = newValue;
                  if (selectedDestino == selectedOrigen) {
                    selectedDestino = null; // Reset destino if it's equal to origen
                  }
                });
              },
              items: periodoController.periodos.map<DropdownMenuItem<int>>((periodo) {
                return DropdownMenuItem<int>(
                  value: periodo['id'],
                  child: Text(periodo['descripcion'], style: GoogleFonts.montserrat(fontSize: 14)),
                );
              }).toList(),
            );
          }),
          SizedBox(height: 16),
          Obx(() {
            return DropdownButton<int>(
              hint: Text('Seleccione el período de destino'),
              value: selectedDestino,
              onChanged: (int? newValue) {
                setState(() {
                  if (newValue != selectedOrigen) {
                    selectedDestino = newValue;
                  }
                });
              },
              items: periodoController.periodos.where((periodo) => periodo['id'] != selectedOrigen).map<DropdownMenuItem<int>>((periodo) {
                return DropdownMenuItem<int>(
                  value: periodo['id'],
                  child: Text(periodo['descripcion'], style: GoogleFonts.montserrat(fontSize: 14)),
                );
              }).toList(),
            );
          }),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar', style: GoogleFonts.montserrat(fontSize: 14)),
        ),
        TextButton(
          onPressed: () {
            if (selectedOrigen != null && selectedDestino != null) {
              widget.onClone(selectedOrigen!, selectedDestino!);
              Navigator.of(context).pop();
            }
          },
          child: Text('Clonar', style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
