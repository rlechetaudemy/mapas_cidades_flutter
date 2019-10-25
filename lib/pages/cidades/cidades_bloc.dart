import 'package:cidade_mapas/imports.dart';

class CidadesBloc extends SimpleBloc<List<Cidade>> {
  Future<List<Cidade>> fetch() async {
    try {

      List<Cidade> cidades = await CidadesApi.getCidades();

      add(cidades);

      return cidades;
    } catch (e) {
      addError(e);
    }

    return [];
  }
}
