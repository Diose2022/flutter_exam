import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RegisterTab extends StatefulWidget {
  @override
  _RegisterTabState createState() => _RegisterTabState();
}

class _RegisterTabState extends State<RegisterTab> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _selectedRole = "Membre"; // Rôle par défaut

  void _register() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Envoyer l'email de vérification
      await userCredential.user!.sendEmailVerification();

      // Ajouter l'utilisateur dans Firestore avec le rôle sélectionné
      await _firestore.collection("users").doc(userCredential.user!.uid).set({
        "email": _emailController.text.trim(),
        "role": _selectedRole,
        "emailVerified": false, // Indiquer que l'email n'est pas encore vérifié
      });

      Get.snackbar(
        "Vérification requise",
        "Un email de confirmation a été envoyé. Veuillez vérifier votre boîte mail.",
      );

      // Déconnecter l'utilisateur après l'inscription pour éviter qu'il accède sans vérifier son email
      await _auth.signOut();

    } catch (e) {
      Get.snackbar("Erreur", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: "Email"),
          ),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: "Mot de passe"),
            obscureText: true,
          ),
          SizedBox(height: 20),

          // Dropdown pour choisir le rôle
          DropdownButtonFormField<String>(
            value: _selectedRole,
            onChanged: (value) {
              setState(() {
                _selectedRole = value!;
              });
            },
            items: ["Admin", "Chef de projet", "Membre"]
                .map((role) => DropdownMenuItem(
              value: role,
              child: Text(role),
            ))
                .toList(),
            decoration: InputDecoration(labelText: "Sélectionnez un rôle"),
          ),

          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _register,
            child: Text("S'inscrire"),
          ),
        ],
      ),
    );
  }
}
