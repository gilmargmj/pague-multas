class Seguro {
  int ano;
  double valor;

  Seguro({this.ano, this.valor});

  Seguro.fromJson(Map<String, dynamic> json) {
    ano = json['ano'];
    valor = json['valor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ano'] = this.ano;
    data['valor'] = this.valor;
    return data;
  }
}
