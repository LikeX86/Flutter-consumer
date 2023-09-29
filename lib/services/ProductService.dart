import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:apif/models/Product.dart';

class ProductService {
  final String baseUrl =
      'http://192.168.1.38:8080/product'; // Substitua pela URL correta da sua API de produtos

  Future<List<Product>> fetchProducts(String authToken) async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {'Authorization': 'Bearer $authToken'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      final List<Product> products =
          jsonList.map((json) => Product.fromJson(json)).toList();
      return products;
    } else {
      throw Exception(
          'Falha ao buscar a lista de produtos'); // Trate os erros adequadamente
    }
  }
}
