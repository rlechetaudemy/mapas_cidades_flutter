import 'package:carousel_slider/carousel_slider.dart';
import 'package:cidade_mapas/imports.dart';
import 'package:cidade_mapas/pages/cidades/ponto_turistico.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  double _zoom = 11.0;

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
    return Stack(
      children: <Widget>[
        _map(),
        _zoomButton(Icons.zoom_out, Alignment.topLeft, -1),
        _zoomButton(Icons.zoom_in, Alignment.topRight, 1),
        _listPontosTuristicos()
      ],
    );
  }

  _listPontosTuristicos() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: _carrousel(),
      ),
    );
  }

  _carrousel() {
    return CarouselSlider(
      height: 400.0,
      items: cidade.pontosTuristicos.map<Widget>((p) {
        return _card(p);
      }).toList(),
    );
  }

  _pageView() {
    return PageView.builder(
//          scrollDirection: Axis.horizontal,
      itemCount: cidade.pontosTuristicos.length,
      itemBuilder: (context, idx) {
        PontoTuristico p = cidade.pontosTuristicos[idx];

        return _card(p);
      },
    );
  }

  _card(PontoTuristico p) {
    return InkWell(
      onTap: () {
        _goToLocation(p.latlng);
      },
      child: Container(
        child: FittedBox(
          child: Material(
            color: Colors.white,
            elevation: 12.0,
            borderRadius: BorderRadius.circular(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 200,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: new BorderRadius.circular(24.0),
                    child: Image(
                      fit: BoxFit.fill,
                      image: NetworkImage(p.urlFoto),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: _cardDados(p.nome),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _cardDados(String _name) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            _name,
            style: TextStyle(
                color: Colors.indigo,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        SizedBox(height: 5.0),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Text(
                  "5.0",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18.0,
                  ),
                ),
              ),
              _star(),
              _star(),
              _star(),
              _star(),
              _star(),
            ],
          ),
        ),
        SizedBox(height: 5.0),
        Container(
          child: Text(
            "Fechado \u00B7 Abre 9:00",
            style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  _star() {
    return Container(
      child: Icon(
        FontAwesomeIcons.solidStar,
        color: Colors.amber,
        size: 15.0,
      ),
    );
  }

  Future<void> _goToLocation(LatLng latLng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: latLng,
          zoom: 15,
          tilt: 50.0,
          bearing: 45.0,
        ),
      ),
    );
  }

  _map() {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: latLng,
        zoom: _zoom,
      ),
      mapType: MapType.normal,
      markers: _markers,
    );
  }

  _zoomButton(IconData icon, AlignmentGeometry alignment, int value) {
    return Align(
      alignment: alignment,
      child: IconButton(
        icon: Icon(Icons.zoom_in, color: Color(0xff6200ee)),
        onPressed: () async {
          // Incrementa
          _zoom += value;

          print("Zoom $_zoom");

          // Atualiza
          final GoogleMapController controller = await _controller.future;
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: latLng,
                zoom: _zoom,
              ),
            ),
          );
        },
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
