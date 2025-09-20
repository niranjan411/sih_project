import 'package:flutter/material.dart';
import '../widgets/app_header.dart';
import '../widgets/report_chart_placeholder.dart';

class WeeklyReportView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>?;
    final String className = args?['class'] ?? 'Class 6';
    final String division = args?['division'] ?? 'A';

    return Scaffold(
      appBar: AppHeader(title: "Weekly Report – $className $division"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Text('Week: 1 Sep - 7 Sep', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          DataTable(columns: [
            DataColumn(label: Text('Date')),
            DataColumn(label: Text('Present')),
            DataColumn(label: Text('Absent')),
            DataColumn(label: Text('%')),
          ], rows: [
            DataRow(cells: [DataCell(Text('01 Sep')), DataCell(Text('44')), DataCell(Text('3')), DataCell(Text('94%'))]),
            DataRow(cells: [DataCell(Text('02 Sep')), DataCell(Text('45')), DataCell(Text('2')), DataCell(Text('95%'))]),
          ]),
          ReportChartPlaceholder(label: 'Weekly trend chart'),
          SizedBox(height: 12),
          ElevatedButton(onPressed: () { /* export pdf */ }, child: Text('Export as PDF'))
        ]),
      ),
    );
  }
}
