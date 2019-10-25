import 'package:cidade_mapas/imports.dart';
import 'package:cidade_mapas/pages/cidades/cidade_page.dart';

class CidadesPage extends StatefulWidget {
  @override
  _CidadesPageState createState() => _CidadesPageState();
}

class _CidadesPageState extends State<CidadesPage> {
  final _bloc = CidadesBloc();

  List<Cidade> cidades;

  @override
  void initState() {
    super.initState();

    _bloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cidades"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh,) ,
            onPressed: (){
              setState(() {

              });
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => logout(context),
          )
        ],
      ),
      body: _listView(),
    );
  }


  _listView() {
    return StreamBuilder(
      stream: _bloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return TextError("Não foi possível buscar os cidades");
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Cidade> cidades = snapshot.data;

        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: _grid(cidades),
        );
      },
    );
  }


  int _columns(constraints) {
    int columns = constraints.maxWidth > 800 ? 3 : 2;
    if (constraints.maxWidth <= 500) {
      columns = 1;
    }
    return columns;
  }

  _grid(List<Cidade> cidades) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int columns = _columns(constraints);

        return Container(
          padding: EdgeInsets.all(16),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              childAspectRatio: 1.8,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
            ),
            itemCount: cidades.length,
            itemBuilder: (context, index) {
              Cidade c = cidades[index];

              return InkWell(
                child: _cardCidade(c),
                onTap: () => _onClickCidade(c),
              );
            },
          ),
        );
      },
    );
  }

  _cardCidade(Cidade c) {
    return LayoutBuilder(
      builder: (context, constraints) {

        return Card(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 240,
                      maxHeight: 120,
                    ),
                    child: c.urlFoto != null
                        ? Image.network(
                      c.urlFoto,
                      fit: BoxFit.cover,
                    )
                        : FlutterLogo(
                      size: 100,
                    ),
                  ),
                ),
                Center(
                  child: text(
                    "${c.nome}",
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _onClickCidade(Cidade c) {
    push(context, CidadePage(c));
//    push(context, CidadePageMap(c));
  }

  Future<void> _onRefresh() {
    return _bloc.fetch();
  }

  logout(BuildContext context) {
    print("TODO logout!");
  }


  @override
  void dispose() {
    super.dispose();

    _bloc.dispose();
  }
}
