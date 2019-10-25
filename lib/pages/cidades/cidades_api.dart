import 'package:cidade_mapas/imports.dart';
import 'package:cidade_mapas/utils/http_helper.dart' as http;
import 'dart:convert' as convert;

class CidadesApi {

  static Future<List<Cidade>> getCidades() async {
    String url = "http://www.mocky.io/v2/5db35c0b3000007c0057b621";

    print("GET > $url");

    final response = await http.get(url);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body.substring(0,20)}');

    String sUtf8 = convert.utf8.decode(response.bodyBytes);
    List list = convert.jsonDecode(sUtf8);

    List<Cidade> cidades = list.map<Cidade>((map) => Cidade.fromMap(map)).toList();

    return cidades;
  }
}
