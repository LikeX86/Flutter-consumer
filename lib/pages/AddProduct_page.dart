import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:apif/services/AuthService.dart';

class AddProductScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final AuthService authService = AuthService();
  final Function updateProductList;
  final BuildContext context; // Adicione o argumento BuildContext

  AddProductScreen(
      {required this.updateProductList,
      required this.context}); // Atualize o construtor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nome do Produto'),
            ),
            TextFormField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Preço do Produto'),
              keyboardType: TextInputType.number, // Teclado numérico
            ),
            ElevatedButton(
              onPressed: () async {
                final name = nameController.text;
                final price = double.tryParse(priceController.text);
                final token = await authService.getAuthToken();

                if (name.isNotEmpty && price != null && token != null) {
                  final success = await sendProductToAPI(name, price, token);

                  if (success) {
                    // Após adicionar o produto com sucesso, retorne true
                    Navigator.of(context).pop(true);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Erro ao adicionar o produto.'),
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Preencha todos os campos.'),
                    ),
                  );
                }
              },
              child: Text('Adicionar Produto'),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> sendProductToAPI(String name, double price, String token) async {
    final String baseUrl = 'http://192.168.1.38:8080/product';

    final Map<String, dynamic> data = {
      'name': name,
      'price': price,
    };

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      // Produto adicionado com sucesso
      updateProductList();
      Navigator.of(context).pop(); // Fecha a tela de adição de produto
      return true;
    } else if (response.statusCode == 401) {
      // Token de autorização inválido ou expirado
      print('Erro 401: Token de autorização inválido ou expirado.');
      return false;
    } else {
      // Trate outros códigos de erro da API aqui
      final responseBody = response.body;

      // Verifique se a resposta não está vazia antes de tentar analisá-la
      if (responseBody.isNotEmpty) {
        final parsedResponse = json.decode(responseBody);

        // Se a resposta contiver um campo 'error', você pode imprimir ou tratar o erro
        if (parsedResponse.containsKey('error')) {
          final errorMessage = parsedResponse['error'];
          print('Erro da API: $errorMessage');
        }
      }

      return false;
    }
  }
}
