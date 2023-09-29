import 'package:apif/services/AuthService.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController roleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
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
              TextField(
                controller: roleController,
                decoration: InputDecoration(labelText: 'Papel (ADMIN ou USER)'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final login = loginController.text;
                  final password = passwordController.text;
                  final role = roleController.text;

                  final registered =
                      await authService.register(login, password, role);

                  if (registered) {
                    // Registro bem-sucedido, navegue para a próxima tela
                    Navigator.pushReplacementNamed(context, '/home');
                  } else {
                    // Tratamento para registro falho
                    // Por exemplo, exiba uma mensagem de erro ao usuário
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Falha no registro. Verifique os dados e tente novamente.'),
                      ),
                    );
                  }
                },
                child: Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
