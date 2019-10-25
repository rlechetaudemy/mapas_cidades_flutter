import 'package:cidade_mapas/imports.dart';
import 'package:cidade_mapas/pages/cidades/ponto_turistico.dart';
import 'package:cidade_mapas/pages/cidades/pontos_turisticos_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CidadePage extends StatefulWidget {
  final Cidade cidade;

  CidadePage(this.cidade);

  @override
  _CidadePageState createState() => _CidadePageState();
}

class _CidadePageState extends State<CidadePage> {
  Completer<GoogleMapController> _controller = Completer();

  final _bloc = PontosTuristicosBloc();

  List<PontoTuristico> pontos = [];

  @protected
  final markers = Set<Marker>();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    super.initState();

    _markers();
  }

  _markers() async {
    pontos = await _bloc.fetch();
    print("Revendas qtde: ${pontos.length}");
    _initMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(widget.cidade.nome),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.place),
            onPressed: () => _onClickMapa(context),
          ),
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Center(
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
        mapType: MapType.normal,
      ),
    );
  }

  void _onClickMapa(context) {
    print(widget.cidade);
    if (widget.cidade.lat != null && widget.cidade.lng != null) {
      launch(
          "https://www.google.com/maps/@${widget.cidade.lat},${widget.cidade.lng},11z");
    } else {
      alert(context, "Este cidade não possui Lat/Lng.");
    }
  }

  void _initMarkers() {
    markers.clear();

    for (int i = 0; i < pontos.length; i++) {
      final p = pontos[i];

      final latLng = LatLng(p.lat, p.lng);

      markers.add(
        Marker(
          markerId: MarkerId("$i"),
          position: latLng,
        ),
      );
    }

    if (markers.isEmpty) {
      Future.delayed(Duration(seconds: 1), () {
        print("Nenhuma revenda encontrada");
      });
    }
  }
}
