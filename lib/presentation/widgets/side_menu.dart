import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projecto_base_laboratorio/presentation/controllers/menu_controller.dart';


class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MenuOpController menuController = Get.find();

    return Drawer(
      child: Column(
        children: <Widget>[
         const  UserAccountsDrawerHeader(
            accountName: Text('Gestion de Recursos'),
            accountEmail: Text('usuario@ejemplo.com'),
            currentAccountPicture: CircleAvatar(
             child: Icon(Icons.settings, size: 50,),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
             
            ),
          ),
          ListTile(
            leading: Icon(Icons.science),
            title: Text('Laboratorios'),
            onTap: () {
              menuController.selectItem(MenuItem.laboratorios);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.center_focus_strong),
            title: Text('Nodo Centro'),
            onTap: () {
              menuController.selectItem(MenuItem.nodo_centro);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.school),
            title: Text('Laboratorio Curso'),
            onTap: () {
              menuController.selectItem(MenuItem.laboratorio_curso);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
