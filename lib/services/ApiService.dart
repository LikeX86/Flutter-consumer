import 'dart:convert';
import 'package:apif/models/User.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl = 'http://192.168.1.38:8080';

  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  Future<http.Response> _sendRequest(
    String endpoint, {
    String method = 'GET',
    Map<String, dynamic>? body,
  }) async {
    final token = await getAuthToken();
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final uri = Uri.parse('$baseUrl/$endpoint');

    try {
      if (method == 'GET') {
        return await http.get(uri, headers: headers);
      } else if (method == 'POST') {
        return await http.post(uri, headers: headers, body: jsonEncode(body));
      }
      // Adicione suporte para outros métodos (PUT, DELETE, etc.) conforme necessário.
      throw Exception('Método HTTP não suportado: $method');
    } catch (e) {
      // Trate os erros de rede ou de solicitação aqui
      print('Erro na solicitação: $e');
      throw e;
    }
  }

  Future<http.Response> registerUser(User user) async {
    return await _sendRequest('auth/register',
        method: 'POST', body: user.toJson());
  }

  Future<http.Response> loginUser(User user) async {
    return await _sendRequest('auth/login',
        method: 'POST', body: user.toJson());
  }

  // Implemente outros métodos de requisição conforme necessário para os produtos.
}
