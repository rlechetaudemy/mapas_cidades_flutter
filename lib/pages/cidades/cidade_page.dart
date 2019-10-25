import 'package:cidade_mapas/imports.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CidadePage extends StatefulWidget {
  final Cidade cidade;

  CidadePage(this.cidade);

  @override
  _CidadePageState createState() => _CidadePageState();
}

class _CidadePageState extends State<CidadePage> {
  Completer<GoogleMapController> _controller = Completer();

  Cidade get cidade => widget.cidade;
  LatLng latLng;

  var _markers = Set<Marker>();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    super.initState();
    latLng = cidade.latlng;
    _loadMarkers();
  }

  _loadMarkers() async {

    _markers.clear();

    final list = Set<Marker>();

    print("init markers: ${cidade.pontosTuristicos}");

    for (int i = 0; i < cidade.pontosTuristicos.length; i++) {
      final p = cidade.pontosTuristicos[i];

      print(p.nome);

      list.add(
        Marker(
          markerId: MarkerId("$i"),
          position: LatLng(p.lat, p.lng),
          infoWindow: InfoWindow(title: p.nome),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueBlue,
          ),
        ),
      );
    }

    setState(() {
      this._markers = list;
    });
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
          target: latLng,
          zoom: 11.0,
        ),
        mapType: MapType.normal,
        markers: _markers,
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
}
