import 'package:app_web_papi/models/findCep.model.dart';
import 'package:http/http.dart' as http;

class FindcepRepository {
  static Future<FindCep> fetchCep({String cep}) async {
    final response = await http.get('https://viacep.com.br/ws/$cep/json/');
    if (response.statusCode == 200) {
      return FindCep.fromJson(response.body);
    } else {
      throw Exception('Request failed!');
    }
  }
}
