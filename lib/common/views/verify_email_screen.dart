import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class VerifyEmailScreen extends StatefulWidget {
  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _emailSent = false;

  void _resendVerificationEmail() async {
    try {
      User? user = _auth.currentUser;
      await user!.sendEmailVerification();
      setState(() {
        _emailSent = true;
      });
      Get.snackbar("Email envoyé ✅", "Vérifiez votre boîte mail 📩",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Erreur", e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void _logout() async {
    await _auth.signOut();
    Get.offAllNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Vérification d'Email"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/animations/email_verification.json', height: 200), // Animation
            SizedBox(height: 20),
            Text(
              "Vérifiez votre boîte mail 📩",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
            ),
            SizedBox(height: 10),
            Text(
              "Un email de confirmation a été envoyé. Cliquez sur le lien pour activer votre compte.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 20),

            _emailSent
                ? Text(
              "Email renvoyé ! Vérifiez votre boîte mail.",
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            )
                : ElevatedButton.icon(
              onPressed: _resendVerificationEmail,
              icon: Icon(Icons.refresh),
              label: Text("Renvoyer l'email"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
              ),
            ),

            SizedBox(height: 20),
            TextButton(
              onPressed: _logout,
              child: Text(
                "Se déconnecter",
                style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
