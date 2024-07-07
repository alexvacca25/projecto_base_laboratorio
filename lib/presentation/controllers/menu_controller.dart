import 'package:get/get.dart';

enum MenuItem {
  laboratorios,
  nodo_centro,
  laboratorio_curso,
}

class MenuOpController extends GetxController {
  var selectedItem = MenuItem.laboratorios.obs;

  void selectItem(MenuItem item) {
    selectedItem.value = item;
  }
}
