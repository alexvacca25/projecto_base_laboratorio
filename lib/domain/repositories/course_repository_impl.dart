

import 'package:projecto_base_laboratorio/data/models/course.dart';
import 'package:projecto_base_laboratorio/data/providers/api_provider.dart';
import 'package:projecto_base_laboratorio/domain/entities/course.dart';

class CourseRepositoryImpl implements CourseRepository {
  final ApiProvider apiProvider;

  CourseRepositoryImpl({required this.apiProvider});

  @override
  Future<List<Course>> getCourses() async {
    return await apiProvider.fetchCourses();
  }
}
