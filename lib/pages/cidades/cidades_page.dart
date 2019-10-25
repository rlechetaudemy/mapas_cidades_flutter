import 'package:cidade_mapas/imports.dart';

class CidadesPage extends StatefulWidget {
  @override
  _CidadesPageState createState() => _CidadesPageState();
}

class _CidadesPageState extends State<CidadesPage> {

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
      body: CidadesListView(),
    );
  }

  logout(BuildContext context) {
    print("TODO logout!");
  }

}
