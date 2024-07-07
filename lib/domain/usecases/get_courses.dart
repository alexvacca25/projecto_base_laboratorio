import 'package:projecto_base_laboratorio/data/models/course.dart';
import 'package:projecto_base_laboratorio/domain/entities/course.dart';


class GetCourses {
  final CourseRepository repository;

  GetCourses({required this.repository});

  Future<List<Course>> call() async {
    return await repository.getCourses();
  }
}
