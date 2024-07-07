
import 'package:projecto_base_laboratorio/data/models/laboratorio.dart';
import 'package:projecto_base_laboratorio/data/providers/api_provider.dart';
import 'package:projecto_base_laboratorio/domain/entities/laboratorio.dart';



class LaboratorioRepositoyImp implements LaboratorioRepository {
   final ApiProvider apiProvider;

  LaboratorioRepositoyImp({required this.apiProvider});

  @override
  Future<List<Laboratorio>> getLaboratorios() async {
    return await apiProvider.fetchLaboratorios();
  }
}
