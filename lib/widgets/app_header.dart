import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showSchoolName;
  final String? schoolName;
  final Widget? leading;
  final List<Widget>? actions;

  AppHeader({required this.title, this.showSchoolName = false, this.schoolName, this.leading, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showSchoolName && schoolName != null)
            Text(schoolName!, style: TextStyle(fontSize: 14)),
          Text(title),
        ],
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + (showSchoolName ? 6 : 0));
}
