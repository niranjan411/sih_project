import 'package:flutter/material.dart';
import '../widgets/app_header.dart';
import '../widgets/report_chart_placeholder.dart';

class MonthlyReportView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>?;
    final String className = args?['class'] ?? 'Class 6';
    final String division = args?['division'] ?? 'A';

    return Scaffold(
      appBar: AppHeader(title: "Monthly Report – $className $division"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Text('Month: September 2025', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Total Working Days: 22'),
          Text('Average Attendance: 93%'),
          SizedBox(height: 12),
          ReportChartPlaceholder(label: 'Monthly bar chart (x: day, y: % attendance)'),
          Spacer(),
          Row(children: [
            Expanded(child: ElevatedButton(onPressed: () { /* export pdf */ }, child: Text('Export as PDF'))),
            SizedBox(width: 8),
            Expanded(child: ElevatedButton(onPressed: () { /* export csv */ }, child: Text('Export as CSV'))),
          ])
        ]),
      ),
    );
  }
}
