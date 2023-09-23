import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getApi(String cityName) async {
  try {
    var url = Uri.parse('https://weather.contrateumdev.com.br/api/weather/city/?city=$cityName');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data; // Retorna os dados completos da API
    } else {
      // Em caso de erro, retorna um mapa vazio
      return {};
    }
  } catch (e) {
    print('Erro ao acessar a API: $e');
    // Em caso de exceção, retorna um mapa vazio
    return {};
  }
}
