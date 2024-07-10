import 'package:projecto_base_laboratorio/data/models/cursoauto.dart';
import 'package:projecto_base_laboratorio/domain/entities/cursoautodirigidos.dart';

class GetCursosAutodirigidos {
  final CursoAutodirigidoRepository repository;

  GetCursosAutodirigidos({required this.repository});

  Future<List<CursoAutodirigido>> call(int periodoId) async {
    return await repository.getCursosAutodirigidos(periodoId);
  }
}
