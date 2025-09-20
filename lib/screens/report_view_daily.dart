import 'package:flutter/material.dart';
import '../widgets/app_header.dart';
import '../widgets/report_chart_placeholder.dart';

class DailyReportView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>?;
    final DateTime date = args!=null && args['date'] != null ? args['date'] as DateTime : DateTime.now();
    final String formatted = "${date.day}-${date.month}-${date.year}";
    final String className = args?['class'] ?? 'Class 6';
    final String division = args?['division'] ?? 'A';

    return Scaffold(
      appBar: AppHeader(title: "Daily Report – $className $division"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Text('Date: $formatted', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          // sample list
          Expanded(
            child: ListView(
              children: [
                ListTile(title: Text('Aarav'), trailing: Text('Present')),
                ListTile(title: Text('Ishita'), trailing: Text('Absent')),
                ListTile(title: Text('Kunal'), trailing: Text('Present')),
              ],
            ),
          ),
          ReportChartPlaceholder(label: 'Daily attendance bar chart'),
          Row(children: [
            Expanded(child: ElevatedButton(onPressed: () { /* export pdf logic */ }, child: Text('Export as PDF'))),
            SizedBox(width: 8),
            Expanded(child: ElevatedButton(onPressed: () { /* export csv logic */ }, child: Text('Export as CSV'))),
          ])
        ]),
      ),
    );
  }
}
