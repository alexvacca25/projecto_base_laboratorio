

import 'package:projecto_base_laboratorio/data/models/course.dart';



abstract class CourseRepository {
  Future<List<Course>> getCourses();
}
