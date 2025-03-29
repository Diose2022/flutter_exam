import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '/common/views/admin_screen.dart';
import '/common/views/chef_projet_screen.dart';
import '/common/views/membre_screen.dart';
import '/common/views/verify_email_screen.dart';
import 'package:lottie/lottie.dart';


class LoginTab extends StatefulWidget {
  @override
  _LoginTabState createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      User? user = userCredential.user;

      if (!user!.emailVerified) {
        Get.to(() => VerifyEmailScreen());
        return;
      }

      String uid = user.uid;
      DocumentSnapshot userDoc = await _firestore.collection("users").doc(uid).get();
      String role = userDoc["role"];

      if (role == "Admin") {
        Get.offAll(() => AdminScreen());
      } else if (role == "Chef de projet") {
        Get.offAll(() => ChefProjetScreen());
      } else {
        Get.offAll(() => MembreScreen());
      }

      Get.snackbar("Connexion réussie ✅", "Bienvenue ${user.email} !", snackPosition: SnackPosition.BOTTOM);

    } catch (e) {
      Get.snackbar("Erreur", e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/animations/login.json', height: 150), // Animation de connexion
          Text(
            "Connectez-vous 🔑",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueAccent),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: "Mot de passe",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            obscureText: true,
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _login,
            icon: Icon(Icons.login),
            label: Text("Se connecter"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () {
              Get.toNamed('/forgot-password'); // Rediriger vers la récupération de mot de passe
            },
            child: Text(
              "Mot de passe oublié ?",
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }
}
