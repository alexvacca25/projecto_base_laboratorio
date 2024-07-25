import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projecto_base_laboratorio/presentation/pages/ReportesLaboratorioPage.dart';
import 'package:projecto_base_laboratorio/presentation/pages/actividades_page.dart';
import 'package:projecto_base_laboratorio/presentation/pages/course_page.dart';
import 'package:projecto_base_laboratorio/presentation/pages/cursoauto_page.dart';
import 'package:projecto_base_laboratorio/presentation/pages/laboratorio_page.dart';
import 'package:projecto_base_laboratorio/utils/token_validator.dart';
import 'presentation/widgets/side_menu.dart';
import 'presentation/controllers/menu_controller.dart';
import 'presentation/controllers/periodo_controller.dart';
import 'presentation/bindings/course_binding.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Parametros Cursos',
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

class TokenValidationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: TokenValidator.validateToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError || !TokenValidator.isTokenValid) {
          return Scaffold(
            body: Center(
              child: Text(
                'Error: Token no válido. Por favor, inicie sesión de nuevo.',
                style: TextStyle(fontSize: 18),
              ),
            ),
          );
        } else {
          return MyHomePage();
        }
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final MenuOpController menuController = Get.find();
    final PeriodoController periodoController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return Text(
              '${menuController.selectedItemName} - ${periodoController.selectedPeriodoDescription}');
        }),
      ),
      drawer: SideMenu(),
      body: Obx(() {
        switch (menuController.selectedItem.value) {
          case MenuItem.laboratorios:
            return LaboratorioPage();
          case MenuItem.nodo_centro:
            return CoursePage();
          case MenuItem.reportes_componente:
            return ReportesLaboratorioPage();
          case MenuItem.parametros_referencias:
            return ParametrosReferenciasPage();
          case MenuItem.curso_autodiridos:
            return CursoAutodirigidoPage();
          default:
            return Center(child: Text('Selecciona una opción del menú'));
        }
      }),
    );
  }
}
