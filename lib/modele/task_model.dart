class TaskModel {
  String id;
  String title;
  String description;
  String status; // "À faire", "En cours", "Terminé"
  String assignedTo; // UID du membre assigné
  String priority; // "Basse", "Moyenne", "Haute", "Urgente"
  DateTime dueDate; // Date limite
  double progress; // Pourcentage d'avancement (0.0 à 100.0)

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.assignedTo,
    required this.priority,
    required this.dueDate,
    required this.progress,
  });

  // Convertir en Map pour Firestore
  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "status": status,
      "assignedTo": assignedTo,
      "priority": priority,
      "dueDate": dueDate.toIso8601String(),
      "progress": progress,
    };
  }

  // Construire un objet depuis Firestore
  factory TaskModel.fromMap(String id, Map<String, dynamic> map) {
    return TaskModel(
      id: id,
      title: map["title"] ?? "Sans titre",
      description: map["description"] ?? "Aucune description",
      status: map["status"] ?? "À faire",
      assignedTo: map["assignedTo"] ?? "",
      priority: map["priority"] ?? "Basse",
      dueDate: DateTime.parse(map["dueDate"] ?? DateTime.now().toIso8601String()),
      progress: (map["progress"] ?? 0.0).toDouble(),
    );
  }
}
