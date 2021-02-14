import 'dart:convert';

import 'Licenciamento.dart';
import 'Seguro.dart';

class DadosVeiculoIn {
  int ano;
  String chassi;
  List<Ipva> ipva;
  List<Licenciamento> licenciamento;
  int modelo;
  List<Multa> multa;
  String placa;
  String renavam;
  List<Seguro> seguro;

  DadosVeiculoIn(
      {this.ano,
      this.chassi,
      this.ipva,
      this.licenciamento,
      this.modelo,
      this.multa,
      this.placa,
      this.renavam,
      this.seguro});

  List<Ipva> getIpva() {
    return this.ipva;
  }

  DadosVeiculoIn.fromJson(Map<String, dynamic> json) {
    ano = json['ano'];
    chassi = json['chassi'];
    if (json['ipva'] != null) {
      //Map<String, dynamic> data = jsonDecode(json['ipva'].toString());
      //print(data);
      //(data['ipva'] as List<dynamic>).forEach((item) => item["isCheck"] = true);
      ipva = new List<Ipva>();
      (json["ipva"] as List<dynamic>).forEach((item) {
        item["isCheck"] = true;
      });
      //print(json["ipva"]);
      json['ipva'].forEach((v) {
        //var jsonData = '{ "nome" : "Paulo", "email" : "paulo@hotmail.com"  }';
        //var parsedJson = json.decode(jsonData);
        //ipvaVal
        //json.encoder.convert(ipvaVal);
        //print("->>>>>>>>>>>" + v.toString());
        ipva.add(new Ipva.fromJson(v));
      });
      // (ipva['ipva'] as List<dynamic>).forEach((item) => item["favorite"] = true);
    }
    if (json['licenciamento'] != null) {
      (json["licenciamento"] as List<dynamic>).forEach((item) {
        item["isCheck"] = true;
      });
      //add apena um --momo
      //(data["licenciamento"] as List<dynamic>)[position]['isCheck'] = true;
      licenciamento = new List<Licenciamento>();
      json['licenciamento'].forEach((v) {
        licenciamento.add(new Licenciamento.fromJson(v));
      });
    }
    modelo = json['modelo'];

    if (json['multa'] != null) {
      multa = new List<Multa>();
      (json["multa"] as List<dynamic>).forEach((item) {
        item["isCheck"] = true;
      });
      json['multa'].forEach((v) {
        multa.add(new Multa.fromJson(v));
      });
    }
    placa = json['placa'];
    renavam = json['renavam'];
    if (json['seguro'] != null) {
      seguro = new List<Seguro>();
      json['seguro'].forEach((v) {
        seguro.add(new Seguro.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ano'] = this.ano;
    data['chassi'] = this.chassi;
    if (this.ipva != null) {
      data['ipva'] = this.ipva.map((v) => v.toJson()).toList();
    }
    if (this.licenciamento != null) {
      data['licenciamento'] =
          this.licenciamento.map((v) => v.toJson()).toList();
    }
    data['modelo'] = this.modelo;
    if (this.multa != null) {
      data['multa'] = this.multa.map((v) => v.toJson()).toList();
    }
    data['placa'] = this.placa;
    data['renavam'] = this.renavam;
    if (this.seguro != null) {
      data['seguro'] = this.seguro.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ipva {
  int ano;
  double valor;
  bool isCheck;

  Ipva({this.ano, this.valor, this.isCheck});

  getAno() {
    return ano;
  }

  getValor() {
    return valor;
  }

  setIsCheck(bool isChecked) {
    this.isCheck = isChecked;
  }

  Ipva.fromJson(Map<String, dynamic> json) {
    ano = json['ano'];
    valor = json['valor'];
    isCheck = json['isCheck'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ano'] = this.ano;
    data['valor'] = this.valor;
    data['isCheck'] = this.isCheck;
    return data;
  }
}

class Multa {
  String dataVencimento;
  String descricaoInfracao;
  String gravidade;
  double valor;
  bool isCheck;

  Multa(
      {this.dataVencimento,
      this.descricaoInfracao,
      this.gravidade,
      this.valor,
      this.isCheck});

  Multa.fromJson(Map<String, dynamic> json) {
    dataVencimento = json['dataVencimento'];
    descricaoInfracao = json['descricaoInfracao'];
    gravidade = json['gravidade'];
    valor = json['valor'];
    isCheck = json['isCheck'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dataVencimento'] = this.dataVencimento;
    data['descricaoInfracao'] = this.descricaoInfracao;
    data['gravidade'] = this.gravidade;
    data['valor'] = this.valor;
    data['isCheck'] = this.isCheck;
    return data;
  }
}
