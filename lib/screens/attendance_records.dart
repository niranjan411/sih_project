import 'package:flutter/material.dart';

class AttendanceRecordsScreen extends StatelessWidget {
  const AttendanceRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Example dummy data
    final List<Map<String, dynamic>> records = [
      {
        "date": "2025-09-15",
        "class": "Class 1",
        "present": 20,
        "absent": 5,
      },
      {
        "date": "2025-09-14",
        "class": "Class 2",
        "present": 18,
        "absent": 7,
      },
      {
        "date": "2025-09-13",
        "class": "Class 3",
        "present": 22,
        "absent": 3,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Attendance Records")),
      body: ListView.builder(
        itemCount: records.length,
        itemBuilder: (context, index) {
          final record = records[index];
          return Card(
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            child: ListTile(
              leading: const Icon(Icons.calendar_today, color: Colors.blue),
              title: Text("Date: ${record["date"]}"),
              subtitle: Text("Class: ${record["class"]}"),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("✅ ${record["present"]}"),
                  Text("❌ ${record["absent"]}"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
