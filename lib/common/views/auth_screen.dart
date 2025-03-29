import 'package:flutter/material.dart';
import 'login_tab.dart';
import 'register_tab.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Authentification")),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: "Connexion"),
                Tab(text: "Inscription"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  LoginTab(),
                  RegisterTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
