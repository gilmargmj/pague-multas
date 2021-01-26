import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_multas/model/config.dart';
import 'package:page_multas/model/usuario.dart';

import 'package:http/http.dart' as http;

import 'custom_dialog_box.dart';

class Cadastro extends StatefulWidget {
  Cadastro({Key key}) : super(key: key);

  @override
  _Cadastro createState() {
    return _Cadastro();
  }
}

class _Cadastro extends State<Cadastro> {
  final TextEditingController _cNome = TextEditingController();
  final TextEditingController _cTelefone = TextEditingController();
  final TextEditingController _cEmail = TextEditingController();
  final TextEditingController _cSenha = TextEditingController();
  final TextEditingController _cCpf = TextEditingController();

  Future<Usuario> _futureUsuario;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Pague Multas - Cadastro'),
        backgroundColor: Color(0xFF151026),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 40.0),
          //InputField Widget from the widgets folder
          InputField(label: "Name", content: "Name", controler: this._cNome),

          SizedBox(height: 10.0),

          SizedBox(height: 10.0),

          //InputField Widget from the widgets folder
          InputField(
              label: "CPF.", content: "999.999.999-99", controler: this._cCpf),

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
            children: <Widget>[
              FlatButton(
                color: Colors.grey[200],
                onPressed: () {},
                child: Text("Cancel"),
              ),
              SizedBox(
                width: 20.0,
              ),
              FlatButton(
                color: Colors.greenAccent,
                onPressed: () {
                  setState(() {
                    _futureUsuario = createUsuario(
                        context,
                        _cCpf.text,
                        _cEmail.text,
                        _cNome.text,
                        _cTelefone.text,
                        _cSenha.text);
                  });
                },
                child: Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Future<Usuario> createUsuario(BuildContext context, String cpf, String email,
    String nome, String telefone, String senha) async {
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
            title: "Paguem Multas Informa",
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
            title: "Paguem Multas Informa",
            descriptions: "Algo deu errado ",
            text: "Fechar",
          );
        });
    throw Exception('Failed: ' + response.body);
  }
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
          children: <Widget>[
            Container(
              width: 50.0,
              child: Text(
                "$label",
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              width: 40.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 100,
              color: Colors.cyan[200],
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
