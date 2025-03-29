import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controller/task_controller.dart';
import '/modele/task_model.dart';

class TaskScreen extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gestion des Tâches")),
      body: Obx(() => ListView.builder(
        itemCount: taskController.tasks.length,
        itemBuilder: (context, index) {
          var task = taskController.tasks[index];
          return ListTile(
            title: Text(task.title),
            subtitle: Text("Priorité: ${task.priority} - Progression: ${task.progress}%"),
            trailing: PopupMenuButton(
              onSelected: (value) {
                if (value == "update") {
                  taskController.updateTask(task.id, {"progress": task.progress + 10});
                } else if (value == "delete") {
                  taskController.deleteTask(task.id);
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(value: "update", child: Text("Augmenter Progression")),
                PopupMenuItem(value: "delete", child: Text("Supprimer")),
              ],
            ),
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    String selectedPriority = "Basse";
    String selectedStatus = "À faire";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Ajouter une tâche"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: InputDecoration(labelText: "Titre")),
            TextField(controller: descriptionController, decoration: InputDecoration(labelText: "Description")),
            DropdownButton<String>(
              value: selectedPriority,
              onChanged: (value) => selectedPriority = value!,
              items: ["Basse", "Moyenne", "Haute", "Urgente"]
                  .map((priority) => DropdownMenuItem(value: priority, child: Text(priority)))
                  .toList(),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Annuler"),
          ),
          TextButton(
            onPressed: () {
              TaskModel newTask = TaskModel(
                id: "",
                title: titleController.text,
                description: descriptionController.text,
                status: selectedStatus,
                assignedTo: "",
                priority: selectedPriority,
                dueDate: DateTime.now().add(Duration(days: 7)), // Date limite par défaut
                progress: 0.0,
              );
              taskController.addTask(newTask);
              Navigator.pop(context);
            },
            child: Text("Ajouter"),
          ),
        ],
      ),
    );
  }
}
