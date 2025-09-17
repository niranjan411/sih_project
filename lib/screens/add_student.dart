import 'package:flutter/material.dart';

class AddStudentScreen extends StatelessWidget {
  const AddStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Student')),
    body: Padding(
  padding: const EdgeInsets.all(16),
  child: Column(
    children: [
      TextField(
        decoration: const InputDecoration(labelText: 'Name'),
      ),
      const SizedBox(height: 12),
      TextField(
        decoration: const InputDecoration(labelText: 'Roll No'),
        keyboardType: TextInputType.number,
      ),
      const SizedBox(height: 20),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.save),
          label: const Text('Save'),
        ),
      ),
    ],
  ),
),
    );
  }
}
