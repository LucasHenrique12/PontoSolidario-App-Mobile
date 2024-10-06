import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:mobile_app/services/auth_service.dart';

class HomePage extends StatelessWidget {
  final AuthService _authService = AuthService();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Center(
        child: Text('Bem-vindo à Home Page!'),
      ),
    );
  }

  void _logout(BuildContext context) async {
    // Limpa os dados do usuário, se necessário
    await _authService.logout(); // Implemente o método logout no AuthService

    // Redireciona para a página de login
    Navigator.pushReplacementNamed(context, '/');
  }
}
