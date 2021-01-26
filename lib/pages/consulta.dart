import 'dart:io';

import 'package:flutter/material.dart';
import 'package:page_multas/model/DadosVeiculo.dart';
import 'package:page_multas/pages/cadastro.dart';
import 'package:page_multas/pages/login.dart';
import 'package:page_multas/pages/home.dart';

import 'custom_dialog_box.dart';

class Consulta extends StatefulWidget {
  final DadosVeiculo dados;
  const Consulta(this.dados);

  @override
  _ConsultaState createState() => _ConsultaState();
}

class _ConsultaState extends State<Consulta> {
  Widget build(BuildContext context) {
    //print(">>>>>>>");
    //print(widget.dados.getPlaca());
    _isInternet(context);

    //print(dados.getPlaca());
    return new Scaffold(
      /*appBar: new AppBar(
        title: new Text('Pague Multas - Consulta'),
        backgroundColor: Color(0xFF151026),
      ),*/
      body: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 38),
            new Row(
              children: <Widget>[
                Expanded(
                  flex: 2, // 20%
                  child: Container(
                    height: 100,
                    child: _boxInfortationIPVA('IPVA', '20.000,00'),
                  ),
                ),
                Expanded(
                  flex: 2, // 20%
                  child: Container(
                    height: 100,
                    child: _boxInfortationMulta('MULTA', '20.000,00'),
                  ),
                ),
                Expanded(
                  flex: 2, // 20%
                  child: Container(
                    height: 100,
                    child: _boxInfortationSeguro('SEGURO', '20.000,00'),
                  ),
                ),
                Expanded(
                  flex: 2, // 20%
                  child: Container(
                    height: 100,
                    child: _boxInfortationOrcamento('ORC', '20.000,00'),
                  ),
                ),
                /*Expanded(
                  flex: 2, // 60%
                  child: Container(
                      color: Colors.teal,
                      child: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new Text(
                              "MULTA",
                              style: new TextStyle(
                                  fontSize: 20.0,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w200,
                                  fontFamily: "Roboto"),
                            ),
                            new Text(
                              "R 200,00",
                              style: new TextStyle(
                                  fontSize: 15.0,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w200,
                                  fontFamily: "Roboto"),
                            )
                          ])),
                ),
                Expanded(
                  flex: 2, // 20%
                  child: Container(
                    color: Colors.blue,
                    child: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Text(
                            "SEGURO",
                            style: new TextStyle(
                                fontSize: 20.0,
                                color: const Color(0xFF000000),
                                fontWeight: FontWeight.w200,
                                fontFamily: "Roboto"),
                          ),
                          new Text(
                            "R 300,00",
                            style: new TextStyle(
                                fontSize: 15.0,
                                color: const Color(0xFF000000),
                                fontWeight: FontWeight.w200,
                                fontFamily: "Roboto"),
                          )
                        ]),
                  ),
                ),
                Expanded(
                  flex: 2, // 20%
                  child: Container(
                    color: Colors.pink,
                    child: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Text(
                            "ORCA.",
                            style: new TextStyle(
                                fontSize: 20.0,
                                color: const Color(0xFF000000),
                                fontWeight: FontWeight.w200,
                                fontFamily: "Roboto"),
                          ),
                          new Text(
                            "R 200000,00",
                            style: new TextStyle(
                                fontSize: 15.0,
                                color: const Color(0xFF000000),
                                fontWeight: FontWeight.w200,
                                fontFamily: "Roboto"),
                          )
                        ]),
                  ),
                )*/
              ],
            ),
            new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    height: 250.0,
                    child: Card(
                      child: Text(
                          "Informacoes importante\n\n Para conhecer os detalhes \ndo debito e regulariza-lo \njunta ou DETRAN, e\n nescessario que crie \nou acesse uma conta \nPague Multas \n\n Ao criar uma conta, \nlembre-se de informar \ncorretamente os seus\ndados, assim podemos\n prestar um atendimento \nmais agil."),
                    ),
                  ),
                  new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Cadastro()),
                            );
                          },
                          child: new Container(
                            width: MediaQuery.of(context).size.width / 3,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.grey.shade200,
                                      offset: Offset(2, 4),
                                      blurRadius: 5,
                                      spreadRadius: 2)
                                ],
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xfffbb448),
                                      Color(0xfff7892b)
                                    ])),
                            child: Text(
                              'Criar uma conta',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          ),
                        ),
                        new Container(
                          width: 40,
                          padding: EdgeInsets.symmetric(vertical: 15),
                        ),
                        new InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                          child: new Container(
                            width: MediaQuery.of(context).size.width / 3,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.grey.shade200,
                                      offset: Offset(2, 4),
                                      blurRadius: 5,
                                      spreadRadius: 2)
                                ],
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xfffbb448),
                                      Color(0xfff7892b)
                                    ])),
                            child: Text(
                              'Ja Tenho Conta',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          ),
                        ),
                        new Container(
                          width: 40,
                          padding: EdgeInsets.symmetric(vertical: 15),
                        ),
                        new InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                            );
                          },
                          child: new Container(
                            width: MediaQuery.of(context).size.width / 3,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.grey.shade200,
                                      offset: Offset(2, 4),
                                      blurRadius: 5,
                                      spreadRadius: 2)
                                ],
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xfffbb448),
                                      Color(0xfff7892b)
                                    ])),
                            child: Text(
                              'Nova Consulta',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          ),
                        ),
                      ])
                ])
          ]),
    );
  }

  void buttonPressed() {}

  Widget _boxInfortationIPVA(String titulo, String valor) {
    return new InkWell(
      onTap: () {},
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFF1a75ff),
              /*borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
              ),*/
              /*boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],*/
              /*
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xfffbb448), Color(0xfff7892b)]),
                  */
            ),
            child: Text(
              titulo,
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
          new Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFFcce6ff),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              /*boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0x4ffbb448), Color(0x6ff7892b)]),
                  */
            ),
            child: Text(
              valor,
              style: TextStyle(fontSize: 10, color: Colors.black),
            ),
          )
        ],
      ),
    );
  }

  Widget _boxInfortationSeguro(String titulo, String valor) {
    return new InkWell(
      onTap: () {},
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFF33cc33),
              /*borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
              ),*/
              /*boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],*/
              /*
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xfffbb448), Color(0xfff7892b)]),
                  */
            ),
            child: Text(
              titulo,
              style: TextStyle(fontSize: 15, color: Color(0xFFd6f5d6)),
            ),
          ),
          new Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFFd6f5d6),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              /*boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0x4ffbb448), Color(0x6ff7892b)]),
                  */
            ),
            child: Text(
              valor,
              style: TextStyle(fontSize: 10, color: Colors.black),
            ),
          )
        ],
      ),
    );
  }

  Widget _boxInfortationMulta(String titulo, String valor) {
    return new InkWell(
      onTap: () {},
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.teal,
              /*borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
              ),*/
              /*boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],*/
              /*
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xfffbb448), Color(0xfff7892b)]),
                  */
            ),
            child: Text(
              titulo,
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
          new Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0XFF5cd6d6),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              /*boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0x4ffbb448), Color(0x6ff7892b)]),
                  */
            ),
            child: Text(
              valor,
              style: TextStyle(fontSize: 10, color: Colors.black),
            ),
          )
        ],
      ),
    );
  }

  Widget _boxInfortationOrcamento(String titulo, String valor) {
    return new InkWell(
      onTap: () {},
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0XFFffd633),
              /*borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
              ),*/
              /*boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],*/
              /*
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xfffbb448), Color(0xfff7892b)]),
                  */
            ),
            child: Text(
              titulo,
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
          new Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFFfff5cc),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              /*boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0x4ffbb448), Color(0x6ff7892b)]),
                  */
            ),
            child: Text(
              valor,
              style: TextStyle(
                fontSize: 10,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}

_isInternet(BuildContext context) async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {}
  } on SocketException catch (_) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: "Paguem Multas Informa",
            descriptions: "Nescessario estar conectado a internet",
            text: "Fechar",
          );
        });
    Future.delayed(const Duration(milliseconds: 7000), () {
      exit(0);
    });
  }
}
