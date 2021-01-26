import 'package:flutter/material.dart';
import 'package:page_multas/model/config.dart';
import 'package:page_multas/pages/consulta.dart';
import 'package:page_multas/model/DadosVeiculo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _cPlaca = TextEditingController();
  final TextEditingController _cRenavan = TextEditingController();
  final SalveData userDate = new SalveData();

  _isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString("_token") != '' || prefs.getString("_email") != '') {
      print(prefs.getString("_token") + " - " + prefs.getString("_email"));
      userDate.setLogin();
    } else
      userDate.setLogout();

    //int counter = (prefs.getInt('counter') ?? 0) + 1;
    //print('Pressed $counter times.');
    //await prefs.setInt('counter', counter);
  }

  @override
  Widget build(BuildContext context) {
    _isLogin();
    ;
    return new Scaffold(
      /*appBar: new AppBar(
        title: new Text('Pague Multas'),
      ),*/
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.1),
              BlendMode.dstATop,
            ),
            image: AssetImage("assets/images/placa.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 100),
            _logo(),
            Text('Pague Multas'),
            SizedBox(height: 60),
            new Container(
              margin: const EdgeInsets.fromLTRB(120, 5, 120, 0),
              child: new DropdownButtonFormField<String>(
                onChanged: popupButtonSelected,
                decoration: new InputDecoration(
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                value: "1",
                style: new TextStyle(
                  fontSize: 15.0,
                  color: const Color(0xFF202020),
                  fontWeight: FontWeight.w200,
                  fontFamily: "Roboto",
                ),
                items: [
                  DropdownMenuItem(
                    value: "1",
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        //Icon(Icons.build),
                        SizedBox(width: 10),
                        Text(
                          "DETRAN-GO",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: <Widget>[
                _entryFieldPlaca("Placa", 'Informe Placa do veiculo', _cPlaca),
                _entryField("Renavan", 'Informe Renavan', _cRenavan),
              ],
            ),
            SizedBox(height: 10),
            //_submitButton(),
            InkWell(
              onTap: () {
                print(userDate.getIsLogado());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Consulta(new DadosVeiculo(
                          idDetran: '1',
                          placa: _cPlaca.text,
                          renavan: _cRenavan.text,
                          ufDetran: 'GO'))),
                );
              },
              child: new Container(
                width: MediaQuery.of(context).size.width - 100,
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
                  'Consulta Gratis',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
            /* _submitButton(
                context,
                new DadosVeiculo(
                    idDetran: '1',
                    placa: _cPlaca.text,
                    renavan: _cRenavan.text,
                    ufDetran: 'GO')),*/
          ],
        ),
      ),
    );
  }

  void popupButtonSelected(String value) {}
}

Widget _logo() {
  return Image(
    image: AssetImage(
      'assets/images/icone.png',
    ),
    fit: BoxFit.cover,
    width: 100,
  );
}

Widget _submitButton(BuildContext context, DadosVeiculo dados) {
  //print(dados.getPlaca());
  return InkWell(
    onTap: () {
      //print(Widget.userDate.getIsLogado());
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Consulta(dados)),
      );
    },
    child: new Container(
      width: MediaQuery.of(context).size.width - 100,
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
        'Consulta Gratis',
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
    ),
  );
}

Widget _entryField(String title, String hint, TextEditingController controler,
    {bool isPassword = false}) {
  return new Container(
    margin: const EdgeInsets.fromLTRB(50, 1, 50, 0),
    height: 120,
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
        TextFormField(
            validator: (value) {
              if (value.isEmpty || value.length < 10) {
                return 'Informe a RENAVAN do veiculo com 10 caracteres';
              }
              return null;
            },
            controller: controler,
            obscureText: isPassword,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 5.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 5.0),
                ),
                hintText: hint,
                filled: true))
      ],
    ),
  );
}

Widget _entryFieldPlaca(
    String title, String hint, TextEditingController controler,
    {bool isPassword = false}) {
  return new Container(
    margin: const EdgeInsets.fromLTRB(50, 1, 50, 0),
    height: 120,
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
        TextFormField(
          style: TextStyle(fontSize: 35.0),
          validator: (value) {
            if (value.isEmpty || value.length < 7) {
              return 'Informe a placa do veiculo completa';
            }
            return null;
          },
          obscureText: isPassword,
          controller: controler,
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Color(0xfff3f3f4),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 5.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 5.0),
            ),
            hintText: hint,
            filled: true,
          ),
        ),
      ],
    ),
  );
}

/*
Widget _submitButton() {
  return InkWell(
    onTap: () {},
    child: new Container(
      //width: MediaQuery.of(context).size.width,
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
        'Consulta Gratis',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    ),
  );
  
}

*/
