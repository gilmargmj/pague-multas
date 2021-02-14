import 'package:flutter/material.dart';
import 'package:page_multas/model/config.dart';
import 'package:page_multas/pages/consulta.dart';
import 'package:page_multas/pages/login.dart';
import 'package:page_multas/pages/cadastro.dart';
import 'package:page_multas/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/DadosVeiculo.dart';

main() {
  //_sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //String rotaInicial = '/home';
  Future _SetLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("_token", null);
    prefs.setString("_email", null);
    prefs.setString("_Usuario", null);

    //int counter = (prefs.getInt('counter') ?? 0) + 1;
    //print('Pressed $counter times.');
    //await prefs.setInt('counter', counter);
  }

  @override
  void initState() {
    //_SetLogout().then((value) {
    //  print('LOGOUT Efetuado');
    // });
    //_getDadosVeiculo().then((value) {
    //  print('Terminei Busca de Dados do Veiculo');
    //});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print(myData.getIsLogado());

    //if (myData.getIsLogado()) {
    //  rotaInicial = '/home';
    //}
    //print(rotaInicial);

    return MaterialApp(
      title: 'Pague Multas',
      debugShowCheckedModeBanner: false,
      initialRoute: "/home",
      routes: {
        '/': (context) => Consulta(new DadosVeiculo()),
        '/login': (context) => LoginPage(),
        '/cadastro': (BuildContext context) => new Cadastro(),
        '/home': (context) => Home(),
      },

      //home: MyHomePage(title: 'Pague Multas'),
    );
  }
}
