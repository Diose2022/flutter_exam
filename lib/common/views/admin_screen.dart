import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Espace Administrateur")),
      body: Center(child: Text("Bienvenue, Administrateur !")),
    );
  }
}
