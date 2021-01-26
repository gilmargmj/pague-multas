import 'dart:io';

import 'package:flutter/material.dart';
import 'package:page_multas/pages/custom_dialog_box.dart';

_isInternet(BuildContext context) async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "Paguem Multas Informa",
              descriptions: "Voce esta conectado",
              text: "Fechar",
            );
          });
    }
  } on SocketException catch (_) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: "Paguem Multas Informa",
            descriptions: "Nescessario estar conectado com a internet",
            text: "Fechar",
          );
        });
  }
}
