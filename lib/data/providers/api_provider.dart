import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:projecto_base_laboratorio/data/models/course.dart';
import 'package:projecto_base_laboratorio/data/models/laboratorio.dart';


class ApiProvider extends GetConnect {
  Future<List<Course>> fetchCourses() async {
    final response = await http.get(Uri.parse('http://localhost:8000/labnodos?id=1701&token=123'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Course.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }

  Future<List<Laboratorio>> fetchLaboratorios() async {
    final response = await http.get(Uri.parse('http://localhost:8000/laboratorios?id=1701&token=123'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Laboratorio.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }
}
