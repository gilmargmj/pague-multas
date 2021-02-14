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
  //final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  _isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString("_token") != '' || prefs.getString("_email") != '') {
    } else
      userDate.setLogout();
  }

  _isGetPaca() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString("_placa").isNotEmpty) {
      _cPlaca.text = prefs.getString("_placa");
      _cRenavan.text = prefs.getString("_renavan");
    }
    setState(() {
      this.isLoading = false;
    });
  }

  _setPlacaRenavan(String placa, String renavan) async {
    //print(placa);
    //print(renavan);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("_placa", placa);
    prefs.setString("_renavan", renavan);
  }

  @override
  Widget build(BuildContext context) {
    //_isGetPaca();
    return (this.isLoading)
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
                    child: Text("Carregando dados..."),
                  ),
                )
              ],
            ),
          )
        : Scaffold(
            /*appBar: new AppBar(
        title: new Text('Pague Multas'),
      ),*/
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.symmetric(horizontal: 20),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(height: 20),
                    _logo(),
                    Text('Pague Multas'),

                    _ComboBoxDetran(),
                    Column(
                      children: <Widget>[
                        _entryFieldPlaca("Placa", 'Placa', _cPlaca),
                        _entryField("Renavan", 'Renavan', _cRenavan)
                      ],
                    ),
                    //Expanded(child: SizedBox(height: 10)),
                    //_submitButton(),
                    _ConultaGratis(context),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
  }
}

Widget _ConultaGratis(BuildContext context) {
  return new InkWell(
    onTap: () {
      //if (_formKey.currentState.validate()) {
      //_setPlacaRenavan(_cPlaca.text, _cRenavan.text);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Consulta(new DadosVeiculo(
                idDetran: '1',
                placa: '', //Widget._cPlaca.text,
                renavan: '', //_cRenavan.text,
                ufDetran: 'GO'))),
      );
      //}
    },
    child: new Container(
      width: MediaQuery.of(context).size.width - 150,
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
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    ),
  );
}

Widget _ComboBoxDetran() {
  void popupButtonSelected(String value) {}
  return new Container(
    margin: const EdgeInsets.fromLTRB(100, 5, 120, 0),
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
  );
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
  return InkWell(
    onTap: () {
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
        style: TextStyle(fontSize: 20, color: Colors.white),
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value.isEmpty || value.length < 10) {
                return 'Informe RENAVAN com 10 caracteres';
              }
              return null;
            },
            controller: controler,
            obscureText: isPassword,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54, width: 5.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54, width: 5.0),
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
          style: TextStyle(fontSize: 15.0),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value.isEmpty || value.length < 7) {
              return 'Informe placa com 7 caracteres';
            }
            return null;
          },
          obscureText: isPassword,
          controller: controler,
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Color(0xfff3f3f4),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black54, width: 5.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black54, width: 5.0),
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
