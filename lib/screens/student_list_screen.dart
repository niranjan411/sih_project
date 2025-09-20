import 'package:flutter/material.dart';
import '../models/student.dart';
import '../widgets/student_list_item.dart';
import '../widgets/app_header.dart';

class StudentListScreen extends StatefulWidget {
  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  List<Student> students = [
    Student(name: "Aarav", roll: 1),
    Student(name: "Ishita", roll: 2),
    Student(name: "Kunal", roll: 3),
    Student(name: "Pooja", roll: 4),
    Student(name: "Riya", roll: 5),
    Student(name: "Sanjay", roll: 6),
  ];

  String className = "Class 6";
  String division = "A";

  @override
  void initState() {
    super.initState();
    students.sort((a,b) => a.name.compareTo(b.name));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>?;
    if (args != null) {
      className = args['class'] ?? className;
      division = args['division'] ?? division;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(title: "$className $division", showSchoolName: true, schoolName: "Sunrise High School"),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (ctx, i) {
                final s = students[i];
                return StudentListItem(
                  name: s.name,
                  roll: s.roll,
                  present: s.present,
                  onChanged: (val) => setState(()=> s.present = val),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:16.0, vertical: 8),
            child: Row(
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.camera_alt),
                  label: Text('Take Attendance'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/camera', arguments: {'class': className, 'division': division});
                  },
                ),
                SizedBox(width: 12),
                ElevatedButton.icon(
                  icon: Icon(Icons.analytics),
                  label: Text('Generate Reports'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/reports', arguments: {'class': className, 'division': division});
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
