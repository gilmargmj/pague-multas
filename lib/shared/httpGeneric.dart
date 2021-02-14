import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:page_multas/model/config.dart';

class HttpGeneric {
  Dio dio = new Dio(options);
  Object data;
  String textSucesso;

  postData() async {
    Response resp = await dio.post('/account/signup', data: data);
    return resp;
  }
}
