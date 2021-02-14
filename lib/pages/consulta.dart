import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:page_multas/model/DadosVeiculo.dart';
import 'package:page_multas/model/DadosVeiculoIn.dart';
import 'package:page_multas/pages/cadastro.dart';
import 'package:page_multas/pages/login.dart';
import 'package:page_multas/pages/home.dart';
import 'package:page_multas/model/config.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import 'custom_dialog_box.dart';

DadosVeiculo dados;

SalveData myData = new SalveData();

class Consulta extends StatefulWidget {
  const Consulta(dados);
  //print(dados.toString());

  @override
  _ConsultaState createState() => _ConsultaState();
}

class _ConsultaState extends State<Consulta> {
  bool isLoading = true;
  DadosVeiculoIn dadosVeiculo;
  double valorIPVA = 0;
  double valorMULTA = 0;
  double valorLICENCIAMENTO = 0;
  ProgressDialog pr;
  String placa;
  String renavan;

  final formatCurrency = new NumberFormat.simpleCurrency();
  //List<Ipva> checkBoxListTileModel;

  @override
  void initState() {
    _getDataLogin().then((value) {
      setState(() {
        valorMULTA = 0;
        for (var i = 0; i < dadosVeiculo.multa.length; i++) {
          valorMULTA = valorMULTA + dadosVeiculo.multa[i].valor;
        }

        for (var i = 0; i < dadosVeiculo.licenciamento.length; i++) {
          valorLICENCIAMENTO =
              valorLICENCIAMENTO + dadosVeiculo.licenciamento[i].valor;
        }

        for (var i = 0; i < dadosVeiculo.ipva.length; i++) {
          valorIPVA = valorIPVA + dadosVeiculo.ipva[i].valor;
        }

        this.isLoading = false;
      });
    });

    super.initState();
  }

  Future _setLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("_token", null);
    prefs.setString("_email", null);
    prefs.setString("_Usuario", null);
    //Widget.b
    //int counter = (prefs.getInt('counter') ?? 0) + 1;
    //print('Pressed $counter times.');
    //await prefs.setInt('counter', counter);
  }

  Future _getDataLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("_token") != null) {
      if (prefs.getString("_token").isNotEmpty) {
        myData.setIsLogado();
        //print("prefs not empty ->" + prefs.getString("_email"));
      }
    }

    if (prefs.getString("_placa") != null) {
      placa = prefs.getString("_placa");
      renavan = prefs.getString("_renavan");
    }

    Dio dio = new Dio(options);
    //print("Placa" + dados.getPlaca());
    try {
      Response resp = await dio.post('/debito/public/consulta',
          data: jsonEncode(<String, String>{
            'estado': 'GO', //dados.getUf(),
            'placa': placa,
            'renavam': renavan,
          }));

      if (resp.statusCode == 200) {
        //print(resp.data);
        dadosVeiculo = DadosVeiculoIn.fromJson(resp.data);
        //print(dadosVeiculo.toJson().toString());
        //checkBoxListTileModel = dadosVeiculo.getIpva();
        //print(dadosVeiculo.ipva.length);
      }
    } on DioError catch (err) {
      print("Erro: " + err.message);
      //Navigator.of(context).pop();
    }
  }

  Widget build(BuildContext context) {
    //_isInternet(context);
    pr = new ProgressDialog(context);
    pr.style(
        message: 'Aguarde...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
    //print(dados.getPlaca());
    return (isLoading)
        ? new Scaffold(
            body: new Stack(
              children: [
                new Opacity(
                  opacity: 0.3,
                  child: ModalBarrier(dismissible: false, color: Colors.grey),
                ),
                new Center(
                  child: new CircularProgressIndicator(),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(left: 7),
                    child: Text("Consultando dados junto ao Detran..."),
                  ),
                )
              ],
            ),
          )
        : new Scaffold(
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
                        child: _boxInfortationIPVA('IPVA',
                            formatCurrency.format(valorIPVA).toString()),
                      ),
                    ),
                    Expanded(
                      flex: 2, // 20%
                      child: Container(
                        height: 100,
                        child: _boxInfortationMulta('MULTA',
                            formatCurrency.format(valorMULTA).toString()),
                      ),
                    ),
                    Expanded(
                      flex: 2, // 20%
                      child: Container(
                        height: 100,
                        child: _boxInfortationSeguro(
                            'SEGURO',
                            formatCurrency
                                .format(valorLICENCIAMENTO)
                                .toString()),
                      ),
                    ),
                    Expanded(
                      flex: 2, // 20%
                      child: Container(
                        height: 100,
                        child: _boxInfortationOrcamento(
                            'ORC',
                            formatCurrency
                                .format(
                                    valorLICENCIAMENTO + valorMULTA + valorIPVA)
                                .toString()),
                      ),
                    ),
                  ],
                ),
                (myData.isLogado) ? isLogin() : notLogin()
              ]));
  }

  Widget isLogin() {
    return Expanded(
      child: Column(
        children: <Widget>[
          (dadosVeiculo.ipva.length == 0)
              ? Card(child: Text('Nao consta ipva pendente'))
              : Text(
                  "IPVA",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
          Expanded(
            flex: 2,
            child: ListView.builder(
                itemCount: dadosVeiculo.ipva.length,
                itemBuilder: (BuildContext context, int index) {
                  return new Column(
                    children: <Widget>[
                      new CheckboxListTile(
                          activeColor: Colors.green,
                          dense: true,
                          title: new Text(
                            'Ano: ' +
                                dadosVeiculo.ipva[index].getAno().toString() +
                                ' R' +
                                formatCurrency
                                    .format(dadosVeiculo.ipva[index].getValor())
                                    .toString(),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5),
                          ),
                          value: dadosVeiculo.ipva[index].isCheck,
                          /*secondary: Container(
                                height: 50,
                                width: 50,
                                child: Image.asset(
                                  dadosVeiculo.ipva[index].getAno(),
                                  fit: BoxFit.cover,
                                ),
                              ),*/
                          onChanged: (bool val) {
                            itemChange(val, index);
                          })
                    ],
                  );
                }),
          ),
          (dadosVeiculo.licenciamento.length == 0)
              ? Card(child: Text('Nao consta licenciamento pendente'))
              : Text(
                  "Licenciamento",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
          Expanded(
            flex: 2,
            child: ListView.builder(
                itemCount: dadosVeiculo.licenciamento.length,
                itemBuilder: (BuildContext context, int index) {
                  return new Column(
                    children: <Widget>[
                      new CheckboxListTile(
                          activeColor: Colors.green,
                          dense: true,
                          title: new Text(
                            'Ano: ' +
                                dadosVeiculo.licenciamento[index]
                                    .getAno()
                                    .toString() +
                                ' R' +
                                formatCurrency
                                    .format(dadosVeiculo.licenciamento[index]
                                        .getValor())
                                    .toString(),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5),
                          ),
                          value: dadosVeiculo.licenciamento[index].isCheck,
                          /*secondary: Container(
                                height: 50,
                                width: 50,
                                child: Image.asset(
                                  dadosVeiculo.ipva[index].getAno(),
                                  fit: BoxFit.cover,
                                ),
                              ),*/
                          onChanged: (bool val) {
                            itemChangeLicenciamento(val, index);
                          })
                    ],
                  );
                }),
          ),
          (dadosVeiculo.multa.length == 0)
              ? Card(child: Text('Nao consta multas'))
              : Text(
                  "Multa(s)",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
          Expanded(
            flex: 6,
            child: ListView.builder(
                itemCount: dadosVeiculo.multa.length,
                itemBuilder: (BuildContext context, int index) {
                  return new Column(
                    children: <Widget>[
                      new CheckboxListTile(
                          activeColor: Colors.green,
                          dense: true,
                          subtitle: Text(dadosVeiculo.multa[index].gravidade +
                              ' ' +
                              dadosVeiculo.multa[index].descricaoInfracao
                                  .toString()),
                          title: new Text(
                            'Venc. ' +
                                dadosVeiculo.multa[index].dataVencimento
                                    .toString() +
                                ' R' +
                                formatCurrency
                                    .format(dadosVeiculo.multa[index].valor)
                                    .toString(),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5),
                          ),
                          value: dadosVeiculo.multa[index].isCheck,
                          /*secondary: Container(
                                height: 50,
                                width: 50,
                                child: Image.asset(
                                  dadosVeiculo.multa[index].getAno(),
                                  fit: BoxFit.cover,
                                ),
                              ),*/
                          onChanged: (bool val) {
                            itemChangeMulta(val, index);
                          })
                    ],
                  );
                }),
          ),
          orcamento()
        ],
      ),
    );
  }

  Widget orcamento() {
    return new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: 25),
          new InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomDialogBox(
                      title: "Pague Multas Informa",
                      descriptions:
                          "Enviaremos a documentacao por e-mail, nosso correspondente bancario ira entrar em contato",
                      text: "Fechar",
                    );
                  });
            },
            child: new Container(
              width: MediaQuery.of(context).size.width / 2 - 50,
              padding: EdgeInsets.symmetric(vertical: 15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
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
                      colors: [Color(0xff00cc44), Color(0xff009933)])),
              child: Text(
                'Solicitar Orcamento',
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
          ),
          SizedBox(width: 25),
          new InkWell(
            onTap: () {
              _setLogout();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: new Container(
              width: MediaQuery.of(context).size.width / 2 - 50,
              padding: EdgeInsets.symmetric(vertical: 15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
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
                      colors: [Color(0xff00cc44), Color(0xff009933)])),
              child: Text(
                'Logout',
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
          ),
        ]);
  }

  Widget notLogin() {
    return new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Container(
              child: Text(
                  "Informacoes importante\n\n Para conhecer os detalhes do debito e regulariza-lo \njunta ou DETRAN, e nescessario que crie \nou acesse uma conta Pague Multas \n\n Ao criar uma conta, lembre-se de informar \ncorretamente os seu dados, assim podemos\n prestar um atendimento mais agil.")),
          new Container(
            width: 40,
            padding: EdgeInsets.symmetric(vertical: 15),
          ),
          new InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Cadastro()),
              );
            },
            child: new Container(
              width: MediaQuery.of(context).size.width - 50,
              padding: EdgeInsets.symmetric(vertical: 15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
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
                      colors: [Color(0xff00cc44), Color(0xff009933)])),
              child: Text(
                'Criar uma conta',
                style: TextStyle(fontSize: 10, color: Colors.white),
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
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: new Container(
              width: MediaQuery.of(context).size.width - 50,
              padding: EdgeInsets.symmetric(vertical: 15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
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
                      colors: [Color(0xff00cc44), Color(0xff009933)])),
              child: Text(
                'Ja Tenho Conta',
                style: TextStyle(fontSize: 10, color: Colors.white),
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
              width: MediaQuery.of(context).size.width - 50,
              padding: EdgeInsets.symmetric(vertical: 15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
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
                      colors: [Color(0xff00cc44), Color(0xff009933)])),
              child: Text(
                'Nova Consulta',
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
          ),
        ]);
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

  void itemChange(bool val, int index) {
    setState(() {
      dadosVeiculo.ipva[index].isCheck = val;

      double total = 0;
      for (var i = 0; i < dadosVeiculo.ipva.length; i++) {
        if (dadosVeiculo.ipva[i].isCheck)
          total = total + dadosVeiculo.ipva[i].valor;
      }
      valorIPVA = total;
    });
  }

  void itemChangeMulta(bool val, int index) {
    setState(() {
      dadosVeiculo.multa[index].isCheck = val;

      double total = 0;
      for (var i = 0; i < dadosVeiculo.multa.length; i++) {
        if (dadosVeiculo.multa[i].isCheck)
          total = total + dadosVeiculo.multa[i].valor;
      }
      valorMULTA = total;
    });
  }

  void itemChangeLicenciamento(bool val, int index) {
    setState(() {
      dadosVeiculo.licenciamento[index].isCheck = val;

      double total = 0;
      for (var i = 0; i < dadosVeiculo.licenciamento.length; i++) {
        if (dadosVeiculo.licenciamento[i].isCheck)
          total = total + dadosVeiculo.licenciamento[i].valor;
      }
      valorLICENCIAMENTO = total;
    });
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
            title: "Pague Multas Informa",
            descriptions:
                "Nescessario estar conectado a internet, o aplicativo sera fechado.",
            text: "Fechar",
          );
        });
    Future.delayed(const Duration(milliseconds: 7000), () {
      exit(0);
    });
  }
}
