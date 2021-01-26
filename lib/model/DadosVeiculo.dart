class DadosVeiculo {
  String idDetran;
  String ufDetran;
  String placa;
  String renavan;

  DadosVeiculo({this.idDetran, this.ufDetran, this.placa, this.renavan});

  DadosVeiculo.fromJson(Map<String, dynamic> json) {
    idDetran = json['idDetran'];
    ufDetran = json['ufDetran'];
    placa = json['placa'];
    renavan = json['renavan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idDetran'] = this.idDetran;
    data['ufDetran'] = this.ufDetran;
    data['placa'] = this.placa;
    data['renavan'] = this.renavan;
    return data;
  }

  String getPlaca() {
    return this.placa;
  }
}
