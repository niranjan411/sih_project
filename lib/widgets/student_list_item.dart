import 'package:flutter/material.dart';

class StudentListItem extends StatelessWidget {
  final String name;
  final int roll;
  final bool present;
  final ValueChanged<bool> onChanged;

  StudentListItem({required this.name, required this.roll, required this.present, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Text(roll.toString())),
      title: Text(name),
      subtitle: Text("Roll: $roll"),
      trailing: Switch(value: present, onChanged: onChanged),
    );
  }
}
