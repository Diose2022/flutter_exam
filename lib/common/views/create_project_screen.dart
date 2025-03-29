import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // Pour formater les dates
import 'kanban_screen.dart'; // Import de la page Kanban

class CreateProjectScreen extends StatefulWidget {
  @override
  _CreateProjectScreenState createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  String _priority = "Moyenne"; // Priorité par défaut

  // Fonction pour choisir une date
  Future<void> _pickDate(BuildContext context, bool isStart) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      setState(() {
        if (isStart) {
          _startDate = pickedDate;
        } else {
          _endDate = pickedDate;
        }
      });
    }
  }


  // Fonction pour enregistrer un projet dans Firestore
  Future<void> _createProject() async {
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty || _startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Veuillez remplir tous les champs")),
      );
      return;
    }

    await FirebaseFirestore.instance.collection('projects').add({
      'title': _titleController.text,
      'description': _descriptionController.text,
      'startDate': _startDate!.toIso8601String(),
      'endDate': _endDate!.toIso8601String(),
      'priority': _priority,
      'status': 'En attente', // Projet commence toujours en attente
      'createdAt': Timestamp.now(),
    });

    // Redirige vers KanbanScreen après la création
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => KanbanBoardScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Créer un Projet"), backgroundColor: Colors.blueAccent),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField("Titre", _titleController),
            SizedBox(height: 10),
            _buildTextField("Description", _descriptionController, maxLines: 3),
            SizedBox(height: 10),
            _buildDatePicker("Date de début", _startDate, true),
            _buildDatePicker("Date de fin", _endDate, false),
            SizedBox(height: 10),
            _buildPriorityDropdown(),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _createProject,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text("Créer le Projet", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Champ de texte stylé
  Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }

  // Sélecteur de date
  Widget _buildDatePicker(String label, DateTime? date, bool isStart) {
    return ListTile(
      title: Text(label),
      subtitle: Text(date == null ? "Sélectionner une date" : DateFormat('dd/MM/yyyy').format(date)),
      trailing: Icon(Icons.calendar_today),
      onTap: () => _pickDate(context, isStart),
    );
  }

  // Sélecteur de priorité
  Widget _buildPriorityDropdown() {
    return DropdownButtonFormField<String>(
      value: _priority,
      items: ["Basse", "Moyenne", "Haute"].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _priority = newValue!;
        });
      },
      decoration: InputDecoration(
        labelText: "Priorité",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
