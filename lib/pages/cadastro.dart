import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:page_multas/model/config.dart';
import 'package:page_multas/model/usuario.dart';
import 'package:page_multas/pages/consulta.dart';
//import 'package:page_multas/shared/progesso.dart';

import 'custom_dialog_box.dart';

class Cadastro extends StatefulWidget {
  Cadastro({Key key}) : super(key: key);

  @override
  _Cadastro createState() {
    return _Cadastro();
  }
}

class _Cadastro extends State<Cadastro> {
  //ProgressoState progress = new ProgressoState();
  final TextEditingController _cNome = TextEditingController();
  final TextEditingController _cTelefone = TextEditingController();
  final TextEditingController _cEmail = TextEditingController();
  final TextEditingController _cSenha = TextEditingController();
  final TextEditingController _cCpf = TextEditingController();

  Future<Usuario> _futureUsuario;

  Widget _logo() {
    return Image(
      image: AssetImage(
        'assets/images/icone.png',
      ),
      fit: BoxFit.cover,
      width: 100,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: new AppBar(
        title: new Text('Pague Multas - Cadastro'),
        backgroundColor: Color(0xFF151026),
      ),*/
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _logo(),
            SizedBox(height: 40.0),
            //InputField Widget from the widgets folder
            InputField(label: "Name", content: "Name", controler: this._cNome),

            SizedBox(height: 10.0),

            SizedBox(height: 10.0),

            //InputField Widget from the widgets folder
            InputField(
                label: "CPF.",
                content: "999.999.999-99",
                controler: this._cCpf),

            SizedBox(height: 10.0),

            //InputField Widget from the widgets folder
            InputField(
                label: "Email",
                content: "seu@email.com",
                controler: this._cEmail),

            SizedBox(height: 10.0),

            InputField(
                label: "Senha",
                content: "*************",
                controler: this._cSenha),

            SizedBox(height: 10.0),

            //InputField Widget from the widgets folder
            InputField(
                label: "Telefone",
                content: "+22994684468",
                controler: this._cTelefone),

            SizedBox(
              height: 40.0,
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  color: Colors.grey[200],
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Consulta(dados)),
                    );
                  },
                  child: Text("Cancel"),
                ),
                SizedBox(
                  width: 20.0,
                ),
                InkWell(
                  onTap: () {
                    //print(Widget.userDate.getIsLogado());
                    setState(() {
                      _futureUsuario = createUsuario(
                              context,
                              _cCpf.text,
                              _cEmail.text,
                              _cNome.text,
                              _cTelefone.text,
                              _cSenha.text)
                          .then((value) {});
                    });
                  },
                  child: new Container(
                    width: MediaQuery.of(context).size.width / 3,
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
                      'Salvar',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<Usuario> createUsuario(BuildContext context, String cpf, String email,
    String nome, String telefone, String senha) async {
  Dio dio = new Dio(options);
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(child: CircularProgressIndicator());
      });
  try {
    Response resp = await dio.post('/account/signup',
        data: jsonEncode(<String, String>{
          'cpf': cpf,
          'email': email,
          'nome': nome,
          'password': senha,
          'telefone': telefone,
          'username': email,
        }));

    if (resp.statusCode == 201) {
      Navigator.of(context).pop();
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "Pague Multas Informa",
              descriptions:
                  "Cadastro foi realizado, um email lhe foi enviado confirme para finalizar cadastro",
              text: "Continuar",
            );
          });
    }
  } on DioError catch (err) {
    Navigator.of(context).pop();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: "Pague Multas Informa",
            descriptions: "Algo deu errado " + err.message,
            text: "Fechar",
          );
        });
  }

  /*
  final http.Response response = await http.post(
    urlBase + '/account/signup',
    //port: 8080,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
      <String, String>{
        'cpf': cpf,
        'email': email,
        'nome': nome,
        'password': senha,
        'telefone': telefone,
        'username': email,
      },
    ),
  );

  if (response.statusCode == 201) {
    //console.log(Usuario.fromJson(jsonDecode(response.body)));
    //log(message)
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: "Pague Multas Informa",
            descriptions: "Sucesso",
            text: "Continuar",
          );
        });
    return Usuario.fromJson(jsonDecode(response.body));
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: "Pague Multas Informa",
            descriptions: "Algo deu errado ",
            text: "Fechar",
          );
        });
    throw Exception('Failed: ' + response.body);
  }
  */
}

class InputField extends StatelessWidget {
  final String label;
  final String content;
  final TextEditingController controler;

  InputField({this.label, this.content, this.controler});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 70.0,
              child: Text(
                "$label",
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              width: 40.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 150,
              //color: Colors.cyan[200],
              child: TextField(
                style: TextStyle(
                  fontSize: 15.0,
                ),
                controller: controler,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue[50],
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue[50],
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: "$content",
                  fillColor: Colors.blue[50],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
