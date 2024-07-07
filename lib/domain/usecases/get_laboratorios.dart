

import 'package:projecto_base_laboratorio/data/models/laboratorio.dart';
import 'package:projecto_base_laboratorio/domain/entities/laboratorio.dart';


class GetLaboratorio {
  final LaboratorioRepository repository;

  GetLaboratorio({required this.repository});

  Future<List<Laboratorio>> call() async {
    return await repository.getLaboratorios();
  }
}
