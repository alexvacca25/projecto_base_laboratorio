import 'package:get/get.dart';

enum MenuItem {
  laboratorios,
  nodo_centro,
  laboratorio_curso,
  curso_autodiridos,
}

class MenuOpController extends GetxController {
  var selectedItem = MenuItem.laboratorios.obs;

  String get selectedItemName {
    switch (selectedItem.value) {
      case MenuItem.laboratorios:
        return 'Laboratorios';
      case MenuItem.nodo_centro:
        return 'Nodo Atendido Centro';
      case MenuItem.laboratorio_curso:
        return 'Laboratorio Curso';

      case MenuItem.curso_autodiridos:
        return 'Cursos Autodirigidos';
      default:
        return '';
    }
  }
}
