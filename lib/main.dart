import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projecto_base_laboratorio/presentation/pages/course_page.dart';
import 'package:projecto_base_laboratorio/presentation/pages/laboratorio_page.dart';
import 'presentation/widgets/side_menu.dart';

import 'presentation/controllers/menu_controller.dart';
import 'presentation/bindings/course_binding.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(MenuController());
        CourseBinding().dependencies();
      }),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MenuOpController menuController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
      ),
      drawer: SideMenu(),
      body: Obx(() {
        switch (menuController.selectedItem.value) {
          case MenuItem.laboratorios:
            return LaboratorioPage();
          case MenuItem.nodo_centro:
            return CoursePage();
          case MenuItem.laboratorio_curso:
            return CoursePage();
          default:
            return Center(child: Text('Selecciona una opción del menú'));
        }
      }),
    );
  }
}
