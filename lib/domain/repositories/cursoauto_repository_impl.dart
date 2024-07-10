import 'package:projecto_base_laboratorio/data/models/cursoauto.dart';
import 'package:projecto_base_laboratorio/data/providers/api_provider.dart';
import 'package:projecto_base_laboratorio/domain/entities/cursoautodirigidos.dart';

class CursoAutodirigidoRepositoryImpl implements CursoAutodirigidoRepository {
  final ApiProvider apiProvider;

  CursoAutodirigidoRepositoryImpl({required this.apiProvider});

  @override
  Future<List<CursoAutodirigido>> getCursosAutodirigidos(int periodoId) async {
    return await apiProvider.fetchCursosAutodirigidos(periodoId);
  }
}
