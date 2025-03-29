import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddMemberScreen extends StatefulWidget {
  final String projectId;

  const AddMemberScreen({Key? key, required this.projectId}) : super(key: key);

  @override
  _AddMemberScreenState createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _message = "";

  Future<void> _addMember() async {
    String email = _emailController.text.trim();
    if (email.isEmpty) return;

    try {
      // 🔍 Recherche de l'utilisateur dans Firestore
      QuerySnapshot userQuery = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (userQuery.docs.isEmpty) {
        setState(() => _message = "Utilisateur non trouvé !");
        return;
      }

      // 🔄 Récupération de l'UID
      String userId = userQuery.docs.first.id;

      // 🔍 Vérification si l'utilisateur est déjà membre
      DocumentSnapshot projectDoc = await _firestore
          .collection('projects')
          .doc(widget.projectId)
          .get();

      List<dynamic> members = (projectDoc.data() as Map<String, dynamic>)["members"] ?? [];

      if (members.contains(userId)) {
        setState(() => _message = "L'utilisateur est déjà membre !");
        return;
      }

      // 📝 Ajout de l'utilisateur dans la liste des membres
      await _firestore.collection('projects').doc(widget.projectId).update({
        "members": FieldValue.arrayUnion([userId])
      });

      setState(() => _message = "Membre ajouté avec succès !");
      _emailController.clear();
    } catch (e) {
      setState(() => _message = "Erreur: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ajouter un membre")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email du membre"),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: _addMember,
              child: Text("Ajouter"),
            ),
            SizedBox(height: 12),
            Text(_message, style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
