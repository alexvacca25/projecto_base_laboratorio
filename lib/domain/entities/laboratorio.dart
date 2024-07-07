
import 'package:projecto_base_laboratorio/data/models/laboratorio.dart';

abstract class LaboratorioRepository {
  Future<List<Laboratorio>> getLaboratorios();
}
