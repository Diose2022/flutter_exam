import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Se connecter")),
      body: Center(child: Text("Page de connexion", style: TextStyle(fontSize: 18))),
    );
  }
}
