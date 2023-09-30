import 'package:apif/client/UserProvider.dart';
import 'package:apif/pages/Home_page.dart';
import 'package:apif/pages/Register_page.dart';
import 'package:apif/pages/Login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha Loja',
      theme: ThemeData(
        primarySwatch: Colors.green, // Cor principal do aplicativo
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(), // Substitua pelo nome da sua tela de login
    );
  }
}
