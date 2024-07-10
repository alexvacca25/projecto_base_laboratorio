import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:projecto_base_laboratorio/data/models/cursoauto.dart';

import 'package:projecto_base_laboratorio/presentation/controllers/cursoauto_controller.dart';

class CursoAutodirigidoCard extends StatelessWidget {
  final CursoAutodirigido cursoAutodirigido;
  final VoidCallback onDelete;

  CursoAutodirigidoCard({
    required this.cursoAutodirigido,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final CursoAutodirigidoController controller = Get.find<CursoAutodirigidoController>();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cursoAutodirigido.matDescripcion,
              style: GoogleFonts.montserrat(fontSize: 14),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            SizedBox(height: 8.0),
            Text(
              'Escuela: ${cursoAutodirigido.escuelaDescripcion ?? 'No disponible'}',
              style: GoogleFonts.montserrat(fontSize: 12),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Spacer(),
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
