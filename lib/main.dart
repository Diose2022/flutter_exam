
import 'package:examen_flutter/common/constants_colors.dart';
import 'package:examen_flutter/common/views/add_member_screen.dart';
import 'package:examen_flutter/common/views/admin_dashboard.dart';
import 'package:examen_flutter/common/views/auth_screen.dart';
import 'package:examen_flutter/common/views/create_project_screen.dart';
import 'package:examen_flutter/common/views/kanban_screen.dart';
import 'package:examen_flutter/common/views/main_screen.dart';
import 'package:examen_flutter/common/views/project_statistic.dart';
import 'package:examen_flutter/common/views/task_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // ou Provider

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // Remplace par MaterialApp si tu utilises Provider
      debugShowCheckedModeBanner: false,
      title: 'exam flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.light(
          secondary: Colors.blue
        )
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.dark(
          secondary: Colors.blue
        )
      ),

      themeMode: ThemeMode.system,
      home: AdminDashboardScreen()
    );
  }
}
