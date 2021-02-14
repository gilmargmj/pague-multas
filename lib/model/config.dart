import 'package:dio/dio.dart';

const String urlBase = "http://systs:8080/";

// or new Dio with a BaseOptions instance.
BaseOptions options = new BaseOptions(
  baseUrl: "http://192.168.43.118:8080/",
  connectTimeout: 5000,
  receiveTimeout: 3000,
);

class SalveData {
  bool isLogado = false;
  String email = "";
  String nome = "";
  String token = "";

  setLogin(String token, String email, String nome) {
    this.isLogado = true;
    this.nome = nome;
    this.email = email;
    this.token = token;
  }

  setLogout() {
    this.isLogado = false;
  }

  bool getIsLogado() {
    return this.isLogado;
  }

  setIsLogado() {
    this.isLogado = true;
  }
  //SharedPreferences prefs = null;
  /*
  setsToken(String token) async {
    if (this.prefs == null) this.prefs = await SharedPreferences.getInstance();
    this.prefs.setString(this._sToken, token);
  }

  

  getsEmail() async {
    if (this.prefs == null) this.prefs = await SharedPreferences.getInstance();
    return this.prefs.getString(this._sEmail);
  }

  setsEmail(String email) async {
    if (this.prefs == null) this.prefs = await SharedPreferences.getInstance();
    this.prefs.setString(this._sEmail, email);
  }
  */

}
