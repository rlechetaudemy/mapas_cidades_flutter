import 'package:cidade_mapas/imports.dart';
import 'package:cidade_mapas/utils/http_helper.dart' as http;
import 'dart:convert' as convert;

class CidadesApi {

  static Future<List<Cidade>> getCidades() async {
    String url = "http://www.mocky.io/v2/5db3321a3500000f15f55455";

    print("GET > $url");

    final response = await http.get(url);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    String json = response.body;

    List list = convert.json.decode(json);

    List<Cidade> cidades = list.map<Cidade>((map) => Cidade.fromMap(map)).toList();

    return cidades;
  }
}
