
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/cidades/cidades_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
//        Provider<EventBus>(
//          builder: (context) => EventBus(),
//          dispose: (context, bus) => bus.dispose(),
//        ),
//        ChangeNotifierProvider<FavoritosModel>(
//          builder: (context) => FavoritosModel(),
//        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.white
        ),
        home: CidadesPage(),
      ),
    );
  }
}