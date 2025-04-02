import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/common/views/Add_member_Screen.dart';

class KanbanBoardScreen extends StatelessWidget {
  const KanbanBoardScreen({Key? key}) : super(key: key);

  Stream<List<Map<String, dynamic>>> _loadProjects(String status) {
    return FirebaseFirestore.instance
        .collection('projects')
        .where('status', isEqualTo: status)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
      final data = doc.data();
      return {
        "id": doc.id,
        "title": data["title"] ?? "Titre inconnu",
        "description": data["description"] ?? "Pas de description",
        "status": data["status"] ?? "En attente",
      };
    }).toList());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Nombre d'onglets
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tableau Kanban"),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          bottom: TabBar(
            tabs: [
              Tab(text: "En attente"),
              Tab(text: "En cours"),
              Tab(text: "Terminé"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildProjectListView(context, "En attente", Colors.orangeAccent),
            _buildProjectListView(context, "En cours", Colors.blue),
            _buildProjectListView(context, "Terminé", Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectListView(BuildContext context, String status, Color color) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _loadProjects(status),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("Aucun projet"));
        }

        return ListView(
          padding: EdgeInsets.all(8),
          children: snapshot.data!.map((project) {
            return Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(12),
                title: Text(
                  project["title"],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(project["description"]),
                trailing: IconButton(
                  icon: Icon(Icons.person_add, color: Colors.blue),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddMemberScreen(projectId: project["id"]),
                      ),
                    );
                  },
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
