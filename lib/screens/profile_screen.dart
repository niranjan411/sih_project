import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile picture
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/images/teacher.png"), 
            ),
            const SizedBox(height: 16),

            const Text(
              "Ramesh Kumar",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Teacher ID: TCH1024",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Info cards
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const Icon(Icons.email, color: Colors.blue),
                title: const Text("Email"),
                subtitle: const Text("ramesh.kumar@school.gov.in"),
              ),
            ),
            const SizedBox(height: 10),

            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const Icon(Icons.phone, color: Colors.green),
                title: const Text("Phone"),
                subtitle: const Text("+91 9876543210"),
              ),
            ),
            const SizedBox(height: 20),

            // Buttons
            ElevatedButton.icon(
              onPressed: () {
                // navigate to Change Password screen later
              },
              icon: const Icon(Icons.lock),
              label: const Text("Change Password"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                // logout logic later
                Navigator.pop(context); 
              },
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
