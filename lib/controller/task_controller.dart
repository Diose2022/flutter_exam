import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../modele/task_model.dart';

class TaskController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var tasks = <TaskModel>[].obs; // Liste des tâches en temps réel

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  // Récupérer les tâches depuis Firestore
  void fetchTasks() {
    firestore.collection("tasks").snapshots().listen((snapshot) {
      tasks.value = snapshot.docs.map((doc) => TaskModel.fromMap(doc.id, doc.data())).toList();
    });
  }

  // Ajouter une tâche
  Future<void> addTask(TaskModel task) async {
    await firestore.collection("tasks").add(task.toMap());
  }

  // Mettre à jour une tâche (ex: progression ou statut)
  Future<void> updateTask(String taskId, Map<String, dynamic> updates) async {
    await firestore.collection("tasks").doc(taskId).update(updates);
  }

  // Supprimer une tâche
  Future<void> deleteTask(String taskId) async {
    await firestore.collection("tasks").doc(taskId).delete();
  }
}
