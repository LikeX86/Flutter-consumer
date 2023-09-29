import 'package:apif/pages/ProductList_page.dart';
import 'package:apif/services/AuthService.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

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
                      final productList = await authService
                          .fetchProducts(); // Buscar a lista de produtos
                      final context = Navigator.of(
                          context); // Captura o BuildContext fora do bloco assíncrono
                      context.pushReplacement(
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductListScreen(products: productList),
                        ),
                      );
                    } catch (e) {
                      // Tratar erros ao buscar a lista de produtos, se necessário
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
