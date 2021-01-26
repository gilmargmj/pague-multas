class Usuario {
  String cpf;
  String email;
  String nome;
  String password;
  String telefone;
  String username;

  Usuario(
      {this.cpf,
      this.email,
      this.nome,
      this.password,
      this.telefone,
      this.username});

  Usuario.fromJson(Map<String, dynamic> json) {
    cpf = json['cpf'];
    email = json['email'];
    nome = json['nome'];
    password = json['password'];
    telefone = json['telefone'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cpf'] = this.cpf;
    data['email'] = this.email;
    data['nome'] = this.nome;
    data['password'] = this.password;
    data['telefone'] = this.telefone;
    data['username'] = this.username;
    return data;
  }
}
