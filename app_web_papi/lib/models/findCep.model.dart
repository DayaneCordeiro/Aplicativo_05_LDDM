import 'dart:convert';

class FindCep {
  String cep;
  String logradouro;
  String complemento;
  String bairro;
  String localidade;
  String uf;

  /// @brief constructs a FindCep object
  FindCep(
      {this.cep,
      this.logradouro,
      this.complemento,
      this.bairro,
      this.localidade,
      this.uf});

  factory FindCep.fromJson(String result) =>
      FindCep.fromMap(json.decode(result));

  String toJson() => json.encode(toMap());

  factory FindCep.fromMap(Map<String, dynamic> json) => FindCep(
        cep: json["cep"],
        logradouro: json["logradouro"],
        complemento: json["complemento"],
        bairro: json["bairro"],
        localidade: json["localidade"],
        uf: json["uf"],
      );

  Map<String, dynamic> toMap() => {
        "cep": cep,
        "logradouro": logradouro,
        "complemento": complemento,
        "bairro": bairro,
        "localidade": localidade,
        "uf": uf,
      };
}
