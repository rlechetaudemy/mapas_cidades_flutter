import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert' as convert;

class PontoTuristico {
  String nome;
  String urlFoto;
  double lat;
  double lng;

  get latlng => LatLng(lat, lng);

  PontoTuristico({this.nome, this.urlFoto, this.lat, this.lng});

  PontoTuristico.fromMap(Map<String, dynamic> map) {
    nome = map['nome'];
    urlFoto = map['urlFoto'];
    lat = map["lat"];
    lng = map['lng'];
  }

  Map<String, dynamic> toMap() {
    final data = new Map<String, dynamic>();

    data['nome'] = this.nome;
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
    return 'Cidade{nome: $nome, urlFoto: $urlFoto, latitude: $lat, longitude: $lng}';
  }
}
