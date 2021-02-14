import 'dart:wasm';

class Licenciamento {
  int ano;
  double valor;
  bool isCheck;

  Licenciamento({this.ano, this.valor, this.isCheck});

  Licenciamento.fromJson(Map<String, dynamic> json) {
    ano = json['ano'];
    valor = json['valor'];
    isCheck = json['isCheck'];
  }

  getAno() {
    return ano;
  }

  getValor() {
    return valor;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ano'] = this.ano;
    data['valor'] = this.valor;
    data['isCheck'] = this.isCheck;
    return data;
  }
}
