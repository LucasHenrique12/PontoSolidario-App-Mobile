import 'package:flutter/material.dart';
import 'package:mobile_app/services/auth_service.dart';
import 'package:mobile_app/views/register_page.dart';

class LoginPage extends StatefulWidget {
const LoginPage({super.key});

@override
_LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
final _emailController = TextEditingController();
final _passwordController = TextEditingController();
final AuthService _authService = AuthService();
bool _isPasswordVisible = false;

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text('Login', style: TextStyle(fontSize: 24)),
backgroundColor: Colors.teal,
),
body: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Icon(Icons.login, size: 64, color: Colors.teal),
SizedBox(height: 20),
TextField(
controller: _emailController,
decoration: InputDecoration(
labelText: 'Email',
prefixIcon: Icon(Icons.email),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(10),
),
),
),
SizedBox(height: 16),
TextField(
controller: _passwordController,
decoration: InputDecoration(
labelText: 'Password',
prefixIcon: Icon(Icons.lock),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(10),
),
suffixIcon: IconButton(
icon: Icon(
_isPasswordVisible ? Icons.visibility : Icons.visibility_off,
),
onPressed: () {
setState(() {
_isPasswordVisible = !_isPasswordVisible;
});
},
),
),
obscureText: !_isPasswordVisible,
),
SizedBox(height: 20),
ElevatedButton(
onPressed: _login,
style: ElevatedButton.styleFrom(
backgroundColor: Colors.teal,
padding: EdgeInsets.symmetric(vertical: 15),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(10),
),
),
child: Text('Login', style: TextStyle(fontSize: 18)),
),
SizedBox(height: 10),
ElevatedButton(
onPressed: _navigateToRegister,
style: ElevatedButton.styleFrom(
foregroundColor: Colors.black, backgroundColor: Colors.grey[300],
padding: EdgeInsets.symmetric(vertical: 15),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(10),
),
),
child: Text('Registrar', style: TextStyle(fontSize: 18)),
),
SizedBox(height: 10),
TextButton(
onPressed: _resetPassword,
child: Text(
'Esqueceu a senha?',
style: TextStyle(color: Colors.teal),
),
),
],
),
),
);
}

void _login() async {
final email = _emailController.text;
final password = _passwordController.text;

final success = await _authService.login(email, password);
if (success) {
Navigator.pushReplacementNamed(context, '/home');
} else {
ScaffoldMessenger.of(context).showSnackBar(SnackBar(
content: Text('Falha no login. Verifique suas credenciais.'),
));
}
}

void _navigateToRegister() {
Navigator.push(
context,
MaterialPageRoute(builder: (context) => RegisterPage()),
);
}

void _resetPassword() {

ScaffoldMessenger.of(context).showSnackBar(SnackBar(
content: Text('Função de redefinir senha não implementada.'),
));
}
}