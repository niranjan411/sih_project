import 'package:flutter/material.dart';
import 'routes.dart';

void main() {
  runApp(SmartAttendanceApp());
}

class SmartAttendanceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Attendance',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      initialRoute: Routes.login,
      routes: Routes.getRoutes(),
    );
  }
}
