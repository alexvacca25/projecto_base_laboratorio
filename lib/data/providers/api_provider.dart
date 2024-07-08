import 'dart:convert';
import 'package:get/get_connect.dart';
import 'package:http/http.dart' as http;
import 'package:projecto_base_laboratorio/data/models/course.dart';
import 'package:projecto_base_laboratorio/data/models/laboratorio.dart';

class ApiProvider extends GetConnect {
  Future<List<Course>> fetchCourses(int periodoId) async {
    print(periodoId);
    final response = await http.get(Uri.parse('http://localhost:8000/labnodos?id=$periodoId&token=123'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Course.fromJson(item)).toList();
    } else {
      throw Exception('No hay Cursos');
    }
  }

  Future<List<Laboratorio>> fetchLaboratorios(int periodoId) async {
    print(periodoId);
    final response = await http.get(Uri.parse('http://localhost:8000/laboratorios?id=$periodoId&token=123'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Laboratorio.fromJson(item)).toList();
    } else {
      throw Exception('No hay Laboratorios');
    }
  }

  Future<List<dynamic>> fetchPeriodos() async {
    final response = await http.get(Uri.parse('http://localhost:8000/periodosall?token=123'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load periodos');
    }
  }
}
