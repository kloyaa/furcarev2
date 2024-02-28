import 'package:flutter/material.dart';
import 'package:furcarev2/screens/admin/screen_staff_management.dart';
import 'package:furcarev2/screens/auth/screen_admin_login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Furcare v2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const ScreenAdminLogin(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/a/management/staff': (context) => const AdminStaffManagement(),
      },
    );
  }
}
