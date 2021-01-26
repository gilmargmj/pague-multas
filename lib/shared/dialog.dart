import 'package:flutter/material.dart';
import 'package:page_multas/pages/custom_dialog_box.dart';

class Dialogs extends StatefulWidget {
  @override
  _DialogsState createState() => _DialogsState();
}

class _DialogsState extends State<Dialogs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pague Multas Informa"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Center(
          child: RaisedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomDialogBox(
                      title: "Pague Multas Informa",
                      descriptions: "Aqui meu alerta....",
                      text: "Confirmar",
                    );
                  });
            },
            child: Text("Custom Dialog"),
          ),
        ),
      ),
    );
  }
}
