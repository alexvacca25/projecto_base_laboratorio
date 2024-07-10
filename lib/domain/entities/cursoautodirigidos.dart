import 'package:projecto_base_laboratorio/data/models/cursoauto.dart';

abstract class CursoAutodirigidoRepository {
  Future<List<CursoAutodirigido>> getCursosAutodirigidos(int periodoId);
}
