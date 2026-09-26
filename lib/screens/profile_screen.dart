import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy user data
    const String fullName = 'Ahmed Youssef';
    const String email = 'ahmed.youssef@example.com';

    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 70, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              fullName,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              email,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
