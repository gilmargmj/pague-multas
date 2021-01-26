const String urlBase = "http://192.168.0.105:8080/";

class SalveData {
  bool isLogado = false;
  String email = "";
  String nome = "";
  String token = "";
  setLogin() {
    this.isLogado = true;
  }

  setLogout() {
    this.isLogado = false;
  }

  bool getIsLogado() {
    return this.isLogado;
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
