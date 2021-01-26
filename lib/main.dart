import 'package:flutter/material.dart';
import 'package:page_multas/model/config.dart';
import 'package:page_multas/pages/consulta.dart';
import 'package:page_multas/pages/login.dart';
import 'package:page_multas/pages/cadastro.dart';
import 'package:page_multas/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/DadosVeiculo.dart';

SalveData myData = new SalveData();
main() {
  //_sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

_isLogin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (prefs.getString("_token") != '' || prefs.getString("_email") != '')
    myData.setLogin();
  else
    myData.setLogout();

  //int counter = (prefs.getInt('counter') ?? 0) + 1;
  //print('Pressed $counter times.');
  //await prefs.setInt('counter', counter);
}

class _MyAppState extends State<MyApp> {
  String rotaInicial = 'login';

  @override
  Widget build(BuildContext context) {
    //print(myData.getisLogado());

    if (myData.getIsLogado()) {
      rotaInicial = '';
    }
    //print(rotaInicial);

    return MaterialApp(
      title: 'Pague Multas',
      debugShowCheckedModeBanner: false,
      initialRoute: rotaInicial,
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
