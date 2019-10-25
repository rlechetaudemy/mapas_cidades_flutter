import 'dart:convert' as convert;

import 'package:cidade_mapas/pages/cidades/ponto_turistico.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Cidade {
  String nome;
  String descricao;
  String urlFoto;
  double lat;
  double lng;
  List<PontoTuristico> pontosTuristicos;

  get latlng => LatLng(lat, lng);

  Cidade({this.nome, this.descricao, this.urlFoto, this.lat, this.lng});

  Cidade.fromMap(Map<String, dynamic> map) {
    nome = map['nome'];
    descricao = map['descricao'];
    urlFoto = map['urlFoto'];
    lat = map["lat"];
    lng = map['lng'];
    pontosTuristicos = map['pontosTuristicos'] != null
        ? map['pontosTuristicos']
            .map<PontoTuristico>((map) => PontoTuristico.fromMap(map))
            .toList()
        : [];
  }

  Map<String, dynamic> toMap() {
    final data = new Map<String, dynamic>();

    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    data['urlFoto'] = this.urlFoto;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }

  @override
  String toString() {
    return 'Cidade{nome: $nome, descricao: $descricao, urlFoto: $urlFoto, latitude: $lat, longitude: $lng, pontosTuristicos: $pontosTuristicos}';
  }
}
