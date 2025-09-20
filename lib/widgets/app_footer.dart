import 'package:flutter/material.dart';

class AppFooter extends StatelessWidget {
  final String text;
  AppFooter({this.text = "SmartAttendance © 2025"});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo.shade50,
      padding: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      child: Text(text, style: TextStyle(fontSize: 12, color: Colors.black54)),
    );
  }
}
