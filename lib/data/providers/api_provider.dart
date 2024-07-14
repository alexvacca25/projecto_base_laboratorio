import 'dart:convert';
import 'package:get/get_connect.dart';
import 'package:http/http.dart' as http;
import 'package:projecto_base_laboratorio/data/models/course.dart';
import 'package:projecto_base_laboratorio/data/models/cursoauto.dart';
import 'package:projecto_base_laboratorio/data/models/laboratorio.dart';
import 'package:projecto_base_laboratorio/data/models/mensajes.dart';

class ApiProvider extends GetConnect {
  Future<List<Course>> fetchCourses(int periodoId) async {
    print(periodoId);
    final response = await http.get(Uri.parse('http://localhost:8000/labnodos?id=$periodoId&token=123'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Course.fromJson(item)).toList();
    } else {
      throw Exception('Cargando...');
    }
  }

  Future<List<Laboratorio>> fetchLaboratorios(int periodoId) async {
    print(periodoId);
    final response = await http.get(Uri.parse('http://localhost:8000/laboratorios?id=$periodoId&token=123'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Laboratorio.fromJson(item)).toList();
    } else {
      throw Exception('Cargando...');
    }
  }

  Future<List<dynamic>> fetchPeriodos() async {
    final response = await http.get(Uri.parse('http://localhost:8000/periodosall?token=123'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Cargando...');
    }
  }

    Future<List<CursoAutodirigido>> fetchCursosAutodirigidos(int periodoId) async {
    final response = await http.get(Uri.parse('http://localhost:8000/cursosauto?id=$periodoId&token=123'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((curso) => CursoAutodirigido.fromJson(curso)).toList();
    } else {
      throw Exception('Cargando...');
    }
  }


Future<DeleteResponse> deleteGeneral(int id) async {
    final response = await http.get(Uri.parse('http://localhost:8000/quitar?id=$id&token=123'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return DeleteResponse.fromJson(jsonResponse);
    } else {
      throw Exception('Error Quitando Cursos....');
    }
  }

}
