import 'package:flutter/material.dart';

class StudentListScreen extends StatelessWidget {
  const StudentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student List')),
     body: ListView.separated(
  padding: const EdgeInsets.all(16),
  itemBuilder: (_, i) => Card(
    child: ListTile(
      leading: CircleAvatar(child: Text('${i+1}')),
      title: Text(['Asha Sharma','Ravi Kumar','Priya Patil'][i]),
      subtitle: Text('Roll: ${i+1}'),
    ),
  ),
  separatorBuilder: (_, __) => const SizedBox(height: 8),
  itemCount: 3,
),
    );
  }
}
