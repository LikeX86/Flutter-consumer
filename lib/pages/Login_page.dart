import 'package:apif/pages/ProductList_page.dart';
import 'package:apif/services/AuthService.dart';
import 'package:apif/services/ProductService.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService =
      AuthService(); // Crie uma instância de AuthService
  final ProductService productService =
      ProductService(); // Crie uma instância de ProductService

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: loginController,
                decoration: InputDecoration(labelText: 'Login'),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: () async {
                  final login = loginController.text;
                  final password = passwordController.text;

                  final loggedIn = await authService.login(login, password);

                  if (loggedIn) {
                    try {
                      final token = await authService.getAuthToken();
                      final productList =
                          await productService.fetchProducts(token!);

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ProductListScreen(products: productList),
                        ),
                      );
                    } catch (e) {
                      // Trate os erros adequadamente
                      print('Erro ao buscar a lista de produtos: $e');
                    }
                  } else {
                    // Trate os erros de login aqui
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Falha no login. Verifique os dados e tente novamente.'),
                      ),
                    );
                  }
                },
                child: Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text('Não tem uma conta? Crie uma aqui.'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
