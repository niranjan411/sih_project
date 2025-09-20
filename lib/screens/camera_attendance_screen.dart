import 'package:flutter/material.dart';
import '../widgets/app_header.dart';
import '../widgets/report_chart_placeholder.dart';

class CameraAttendanceScreen extends StatefulWidget {
  @override
  _CameraAttendanceScreenState createState() => _CameraAttendanceScreenState();
}

class _CameraAttendanceScreenState extends State<CameraAttendanceScreen> {
  String className = "Class 6";
  String division = "A";
  List<String> present = ["Aarav", "Riya"]; // mock list captured by face recognition

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>?;
    if (args != null) {
      className = args['class'] ?? className;
      division = args['division'] ?? division;
    }
  }

  _saveAttendance() {
    final total = 47; // example total students
    final recorded = present.length;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Saved'),
        content: Text('Attendance recorded for $recorded/$total students'),
        actions: [TextButton(onPressed: ()=> Navigator.pop(ctx), child: Text('OK'))],
      )
    );
    Navigator.pop(context); // go back after save
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(title: "Attendance – $className $division", showSchoolName: true, schoolName: "Sunrise High School"),
      body: Column(
        children: [
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:16.0),
            child: Text("Attendance Class: $className $division", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 12),

          // Camera area placeholder (in real app embed camera preview)
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
              child: Center(child: Text('Camera preview area\n(attach camera plugin here)', textAlign: TextAlign.center)),
            ),
          ),

          // Present list
          Container(
            height: 140,
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Marked Present:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Expanded(
                  child: ListView(
                    children: present.map((p) => ListTile(leading: Icon(Icons.person), title: Text(p))).toList(),
                  ),
                )
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveAttendance,
                child: Text('Save Attendance'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
