import 'package:flutter/material.dart';
import 'student_list.dart';
import 'add_student.dart';
import 'mark_attendance.dart';
import 'attendance_records.dart';
import 'profile_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _DashboardCard(
            icon: Icons.people,
            label: "View Students",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const StudentListScreen()),
            ),
          ),
          _DashboardCard(
            icon: Icons.person_add,
            label: "Add Student",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddStudentScreen()),
            ),
          ),
          _DashboardCard(
            icon: Icons.check_circle,
            label: "Mark Attendance",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MarkAttendanceScreen()),
            ),
          ),
          _DashboardCard(
            icon: Icons.assignment,
            label: "View Attendance",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AttendanceRecordsScreen()),
            ),
          ),
          _DashboardCard(
            icon: Icons.person,
            label: "Profile",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DashboardCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 50, color: Colors.blue),
              const SizedBox(height: 10),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
