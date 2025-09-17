import 'package:flutter/material.dart';

class MarkAttendanceScreen extends StatefulWidget {
  const MarkAttendanceScreen({super.key});

  @override
  State<MarkAttendanceScreen> createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends State<MarkAttendanceScreen> {
  String? selectedClass;
  final List<String> classes = ["Class 1", "Class 2", "Class 3"];

  // Example student list
  final List<Map<String, dynamic>> students = [
    {"name": "Aarav Sharma", "present": false},
    {"name": "Ishita Verma", "present": false},
    {"name": "Rohan Mehta", "present": false},
    {"name": "Sneha Patil", "present": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mark Attendance")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdown for class selection
         DropdownButtonFormField<String>(
  initialValue: selectedClass,
  hint: const Text("Select Class"),
  items: classes.map((cls) => DropdownMenuItem(
        value: cls,
        child: Text(cls),
      )).toList(),
  onChanged: (val) {
    setState(() {
      selectedClass = val;
    });
  },
  decoration: const InputDecoration(
    border: OutlineInputBorder(),
    labelText: "Class",
  ),
),
            const SizedBox(height: 20),

            // Student list with checkboxes
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(students[index]["name"]),
                    value: students[index]["present"],
                    onChanged: (val) {
                      setState(() {
                        students[index]["present"] = val!;
                      });
                    },
                  );
                },
              ),
            ),

            // Save button
            ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text("Save Attendance"),
              onPressed: () {
                // For now, just show a snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Attendance Saved")),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

