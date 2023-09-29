import 'package:apif/client/UserProvider.dart';
import 'package:apif/models/User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Coloque seus campos de login aqui
            ElevatedButton(
              onPressed: () {
                final user =
                    User(login: 'example', password: 'password', role: 'USER');
                userProvider.loginUser(user);
              },
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                final user =
                    User(login: 'example', password: 'password', role: 'USER');
                userProvider.registerUser(user);
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
