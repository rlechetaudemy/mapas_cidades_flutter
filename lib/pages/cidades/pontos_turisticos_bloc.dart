import 'package:cidade_mapas/imports.dart';
import 'package:cidade_mapas/pages/cidades/ponto_turistico.dart';

class PontosTuristicosBloc extends SimpleBloc<List<PontoTuristico>> {
  Future<List<PontoTuristico>> fetch() async {
    try {
      List<PontoTuristico> pontosTuristicos;

      add(pontosTuristicos);

      return pontosTuristicos;
    } catch (e) {
      addError(e);
    }

    return [];
  }
}
