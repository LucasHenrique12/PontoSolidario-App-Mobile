import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import '../components/drawer_custom.dart';


class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu Perfil'),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Text('Conteúdo da Página de Perfil'),
      ),
    );
  }
}
