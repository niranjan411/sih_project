import 'package:flutter/material.dart';

class SchoolApprovePendingScreen extends StatelessWidget {
  const SchoolApprovePendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Approval Pending")),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Your school registration request has been submitted.\n"
            "Please wait while the admin reviews and approves it.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
