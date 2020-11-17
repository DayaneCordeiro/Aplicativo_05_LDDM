class Pessoa {
  int id;
  String nome;
  String cep;
  String logradouro;
  String complemento;
  String bairro;
  String localidade;
  String uf;

  Pessoa( {this.id, this.nome, this.cep, this.logradouro,
           this.complemento, this.bairro, this.localidade, this.uf});

  Pessoa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    cep = json['cep'];
    logradouro = json['logradouro'];
    complemento = json['complemento'];
    bairro = json['bairro'];
    localidade = json['localidade'];
    uf = json['uf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['cep'] = this.cep;
    data['logradouro'] = this.logradouro;
    data['complemento'] = this.complemento;
    data['bairro'] = this.bairro;
    data['localidade'] = this.localidade;
    data['uf'] = this.uf;
    return data;
  }
}