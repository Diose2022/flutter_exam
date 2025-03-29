import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mon Profil")),
      body: Center(child: Text("Bienvenue sur votre profil !", style: TextStyle(fontSize: 18))),
    );
  }
}
