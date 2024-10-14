import 'package:flutter/material.dart';
import 'package:mobile_app/views/DonationPlaceDetails.dart';
import 'package:mobile_app/views/login_page.dart';
import 'package:mobile_app/services/auth_service.dart';
import 'package:mobile_app/views/profile_page.dart';
import 'package:mobile_app/views/register_page.dart';
import 'package:mobile_app/views/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ponto Solidário',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => FutureBuilder<bool>(
          future: _authService.isLoggedIn(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasData && snapshot.data!) {
              return HomePage();
            } else {
              return LoginPage();
            }
          },
        ),
        '/home': (context) => HomePage(),
        '/register':(context) => RegisterPage(),
        '/profile':(context) => ProfilePage(),

      },
    );
  }
}


