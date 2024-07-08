import 'package:get/get.dart';

enum MenuItem {
  laboratorios,
  nodo_centro,
  laboratorio_curso,
}

class MenuOpController extends GetxController {
  var selectedItem = MenuItem.laboratorios.obs;

  String get selectedItemName {
    switch (selectedItem.value) {
      case MenuItem.laboratorios:
        return 'Laboratorios';
      case MenuItem.nodo_centro:
        return 'Nodo Centro';
      case MenuItem.laboratorio_curso:
        return 'Laboratorio Curso';
      default:
        return '';
    }
  }
}
