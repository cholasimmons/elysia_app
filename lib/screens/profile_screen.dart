import 'package:elysia_app/providers/auth_provider.dart';
import 'package:elysia_app/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  final String title = 'Profile';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: provider.userData?.id != null ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(title: Text(provider.userData?.firstname ?? 'No Name'), subtitle: const Text('First Name')),
            const Text('Last Name: Doe', style: TextStyle(fontSize: 18)),
            const Text('Username: johndoe', style: TextStyle(fontSize: 18)),
            const Text('User ID: 12345', style: TextStyle(fontSize: 18)),
            const Text('Created Date: 2024-01-01', style: TextStyle(fontSize: 18)),
            const Divider(),
            // Button to create profile if it doesn't exist
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle create profile
                },
                child: const Text('Create Profile'),
              ),
            ),
          ],
        ) : Center(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthPage()));
            },
            label: const Text('Sign In'),
        ),),
      ),
    );
  }
}