import 'package:cidade_mapas/imports.dart';

class CidadePage extends StatelessWidget {
  final Cidade cidade;

  CidadePage(this.cidade);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(cidade.nome),
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
      child: Image.network(
        cidade.urlFoto,
        fit: BoxFit.cover,
      ),
    );
  }

  void _onClickMapa(context) {
    print(cidade);
    if (cidade.lat != null && cidade.lng != null) {
      launch(
          "https://www.google.com/maps/@${cidade.lat},${cidade.lng},11z");
    } else {
      alert(context, "Este cidade não possui Lat/Lng.");
    }
  }
}
