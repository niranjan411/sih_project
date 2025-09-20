import 'package:flutter/material.dart';
import '../widgets/app_header.dart';
import '../widgets/app_footer.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String schoolName = "Sunrise High School"; // in real app get from profile
  String teacherName = "Mrs. Sharma";
  String? selectedClass;
  String? selectedDivision;

  final List<String> classes = ["Class 6", "Class 7", "Class 8", "Class 9"];
  final List<String> divisions = ["A", "B", "C"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(title: "Welcome", showSchoolName: true, schoolName: schoolName),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome, $teacherName", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text("Select class & division to continue", style: TextStyle(color: Colors.black54)),
            SizedBox(height: 10),
            Row(children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Class'),
                  value: selectedClass,
                  items: classes.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                  onChanged: (v) => setState(()=>selectedClass=v),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Division'),
                  value: selectedDivision,
                  items: divisions.map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
                  onChanged: (v) => setState(()=>selectedDivision=v),
                ),
              ),
            ]),
            SizedBox(height: 18),
            Row(children: [
              ElevatedButton.icon(
                icon: Icon(Icons.list),
                label: Text('Open Students'),
                onPressed: (selectedClass!=null && selectedDivision!=null) ? () {
                  Navigator.pushNamed(context, '/students', arguments: {'class': selectedClass, 'division': selectedDivision});
                } : null,
              ),
              SizedBox(width: 12),
              ElevatedButton.icon(
                icon: Icon(Icons.bar_chart),
                label: Text('Reports'),
                onPressed: (selectedClass!=null && selectedDivision!=null) ? () {
                  Navigator.pushNamed(context, '/reports', arguments: {'class': selectedClass, 'division': selectedDivision});
                } : null,
              ),
            ]),
            Spacer(),
            AppFooter(),
          ],
        ),
      ),
    );
  }
}
