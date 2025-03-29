class Project {
  String id;
  String title;
  String description;
  DateTime startDate;
  DateTime endDate;
  String priority;  // Ex: "Haute", "Moyenne", "Basse"
  String status;  // Ex: "En attente", "En cours", "Terminé", "Annulé"
  List<String> members;  // Liste des emails des membres

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.priority,
    required this.status,
    required this.members,
  });

  // Convertir en map pour Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'priority': priority,
      'status': status,
      'members': members,
    };
  }

  // Convertir de Firestore à un projet
  static Project fromMap(Map<String, dynamic> map, String id) {
    return Project(
      id: id,
      title: map['title'],
      description: map['description'],
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
      priority: map['priority'],
      status: map['status'],
      members: List<String>.from(map['members']),
    );
  }
}
