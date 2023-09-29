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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        // Adicione provedores adicionais aqui, como ProductProvider
      ],
      child: MaterialApp(
        title: 'Your App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/login', // Defina sua tela de login como inicial
        routes: {
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/home': (context) =>
              HomeScreen(), // Adicione a rota para a tela Home
          // Adicione rotas adicionais aqui para outras telas do aplicativo
        },
      ),
    );
  }
}
