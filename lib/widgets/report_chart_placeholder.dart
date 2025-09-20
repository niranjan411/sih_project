import 'package:flutter/material.dart';

class ReportChartPlaceholder extends StatelessWidget {
  final String label;
  ReportChartPlaceholder({this.label = "Chart Placeholder"});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.shade100,
      ),
      child: Center(child: Text(label)),
    );
  }
}
