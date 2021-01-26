import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_multas/model/WebServiceJson.dart';
import 'package:page_multas/model/config.dart';
import 'package:page_multas/model/usuario.dart';
import 'package:page_multas/pages/cadastro.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

import 'custom_dialog_box.dart';

final facebookLogin = FacebookLogin();

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

Future<Usuario> LogarUsuario(
    BuildContext context, String email, String senha) async {
  final http.Response response = await http.post(
    urlBase + 'account/signin',
    //port: 8080,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
      <String, String>{
        'username': email,
        'password': senha,
      },
    ),
  );

  if (response.statusCode == 200) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: "Pague Multas",
            descriptions: "Login efetuado com sucesso ",
            text: "Continuar",
          );
        });
    print(response.body.toString());
    return Usuario.fromJson(jsonDecode(response.body));
  } else {
    var dados = WebServiceJson.fromJson(jsonDecode(response.body));
    /*
    var decoded = jsonDecode(response.body);
    List<WebServiceJson> dados = decoded.map<WebServiceJson>((dados) {
      return WebServiceJson.fromJson(dados);
    }).toList();
    */

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: "Pague Multas Informa",
            descriptions: "Algo deu errado: " + dados.message,
            text: "Fechar",
          );
        });
    throw Exception('Failed: ' + response.body);
  }
}

class _LoginPageState extends State<LoginPage> {
  bool isLoggedIn = false;
  final TextEditingController _cEmail = TextEditingController();
  final TextEditingController _cSenha = TextEditingController();
  Future<Usuario> _futureLogin;

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Voltar',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  void onLoginStatusChanged(bool isLoggedIn) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
    });
  }

  void initiateFacebookLogin() async {
    var facebookLogin = FacebookLogin();
    var result = await facebookLogin.logIn(['email']);

    print("*****->" +
        result.toString() +
        " -**- " +
        FacebookLoginStatus.loggedIn.toString());
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${result.accessToken.token}');

        var profile = JSON.jsonDecode(graphResponse.body);

        //print(profile.toString());
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialogBox(
                title: "Paguem Multas Informa",
                descriptions: "Muito bem," +
                    profile.toString() +
                    " login efetuado no facebook " +
                    result.accessToken.token,
                text: "Fechar",
              );
            });
        break;
      case FacebookLoginStatus.cancelledByUser:
        //_showCancelledMessage();
        break;
      case FacebookLoginStatus.error:
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialogBox(
                title: "Paguem Multas Informa",
                descriptions: "Erro ao efetuar login com facebook ",
                text: "Fechar",
              );
            });
        break;
    }

/*
    switch (result.status) {
      case FacebookLoginStatus.error:
        print("Error");
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        print("LoggedIn");
        onLoginStatusChanged(true);
        break;
    }
    */
  }

  Widget _entryField(String title, TextEditingController controler,
      {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              obscureText: isPassword,
              controller: controler,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        _futureLogin = LogarUsuario(context, _cEmail.text, _cSenha.text);
      },
      child: new Container(
        width: MediaQuery.of(context).size.width,
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
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _facebookButton() {
    return InkWell(
      onTap: () => initiateFacebookLogin(),
      child: new Container(
        height: 50,
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff1959a9),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      topLeft: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: Text('f',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w400)),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff2872ba),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(5),
                      topRight: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: Text('Login no Facebook',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _googleButton() {
    return new GestureDetector(
      onTap: () {
        //print("Container clicked");
      },
      child: new Container(
        height: 50,
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      topLeft: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: Text('G',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w400)),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(5),
                      topRight: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: Text('Login no Google',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Cadastro()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'nao tem conta?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Registre-se',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    Tab(
      icon: Container(
        child: Image(
          image: AssetImage(
            'assets/images/icone.png',
          ),
          fit: BoxFit.cover,
        ),
        height: 100,
        width: 100,
      ),
    );

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(text: '',
          /*style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),*/
          children: [
            TextSpan(
              text: 'Pague',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'Multas',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Email", _cEmail),
        _entryField("Password", _cSenha, isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          /*Positioned(
            top: -height * .15,
            right: -MediaQuery.of(context).size.width,
            child: null,
            // child: BezierContainer(),
          ),*/
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .1),
                  _title(),
                  SizedBox(height: 20),
                  _emailPasswordWidget(),
                  SizedBox(height: 10),
                  _submitButton(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerRight,
                  ),
                  _divider(),
                  _facebookButton(),
                  _googleButton(),
                  _createAccountLabel(),
                ],
              ),
            ),
          ),
          Positioned(top: 40, left: 0, child: _backButton()),
        ],
      ),
    ));
  }
}
