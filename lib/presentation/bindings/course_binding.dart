import 'package:get/get.dart';
import 'package:projecto_base_laboratorio/data/providers/api_provider.dart';
import 'package:projecto_base_laboratorio/domain/entities/course.dart';
import 'package:projecto_base_laboratorio/domain/entities/cursoautodirigidos.dart';
import 'package:projecto_base_laboratorio/domain/entities/laboratorio.dart';
import 'package:projecto_base_laboratorio/domain/repositories/course_repository_impl.dart';
import 'package:projecto_base_laboratorio/domain/repositories/cursoauto_repository_impl.dart';
import 'package:projecto_base_laboratorio/domain/repositories/laboratorio_repositoy_imp.dart';
import 'package:projecto_base_laboratorio/domain/usecases/get_courses.dart';
import 'package:projecto_base_laboratorio/domain/usecases/get_cursoauto.dart';
import 'package:projecto_base_laboratorio/domain/usecases/get_laboratorios.dart';
import 'package:projecto_base_laboratorio/presentation/controllers/course_controller.dart';
import 'package:projecto_base_laboratorio/presentation/controllers/cursoauto_controller.dart';
import 'package:projecto_base_laboratorio/presentation/controllers/laboratorio_controller.dart';
import 'package:projecto_base_laboratorio/presentation/controllers/menu_controller.dart';
import 'package:projecto_base_laboratorio/presentation/controllers/periodo_controller.dart';


class CourseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiProvider>(() => ApiProvider());

    Get.lazyPut<PeriodoController>(() => PeriodoController(apiProvider: Get.find()));

    Get.lazyPut<CourseRepository>(() => CourseRepositoryImpl(apiProvider: Get.find()));
    Get.lazyPut<GetCourses>(() => GetCourses(repository: Get.find(),));
    Get.lazyPut<CourseController>(() => CourseController(getCourses: Get.find(), periodoController: Get.find()));
    
    Get.lazyPut<MenuOpController>(() => MenuOpController());
    
    Get.lazyPut<LaboratorioRepository>(() => LaboratorioRepositoyImp(apiProvider: Get.find()));
    Get.lazyPut<GetLaboratorio>(() => GetLaboratorio(repository: Get.find()));
    Get.lazyPut<LaboratorioController>(() => LaboratorioController(getLaboratorios: Get.find(), periodoController: Get.find()));
  
    Get.lazyPut<CursoAutodirigidoRepository>(() => CursoAutodirigidoRepositoryImpl(apiProvider: Get.find()));
    Get.lazyPut<GetCursosAutodirigidos>(() => GetCursosAutodirigidos(repository: Get.find()));
    Get.lazyPut<CursoAutodirigidoController>(() => CursoAutodirigidoController(periodoController: Get.find(), getCursosAutodirigidos: Get.find()),);
  
  }
}
