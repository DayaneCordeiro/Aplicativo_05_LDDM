import 'dart:convert';
import 'package:app_web_papi/models/pessoa.model.dart';
import 'package:http/http.dart' as http;

class PessoaRepository{

  var url = 'http://klebersouza.pro.br/api/pessoas';

  Future<List<Pessoa>> getAll() async{

    final response = await http.get(url);

    if(response.statusCode == 200){

      List<Pessoa> data = (json.decode(response.body) as List)
          .map((i) => Pessoa.fromJson(i)).toList();

      return data;
    }else{
      throw Exception("Erro de conexão com o servidor!");
    }
  }

  Future<bool> create(Pessoa pessoa) async{

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:  jsonEncode(pessoa.toJson()),
    );

    if(response.statusCode == 201){
      return true;
    }else{
      return false;
    }
  }

  Future<bool> edit(Pessoa professor) async{

    final response = await http.put(
      url + "/${professor.id}",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(professor.toJson()),
    );

    if(response.statusCode == 204){
      return true;
    }else{
      return false;
    }
  }

  Future<bool> delete(int id) async{

    final response = await http.delete( url + "/${id}");

    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }

}