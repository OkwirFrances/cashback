import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: authProvider.user?.photoUrl != null
                  ? NetworkImage(authProvider.user!.photoUrl!)
                  : null,
              child: authProvider.user?.photoUrl == null
                  ? const Icon(Icons.person, size: 50)
                  : null,
            ),
            const SizedBox(height: 16),
            Text(
              authProvider.user?.name ?? 'Guest User',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              authProvider.user?.email ?? 'No email',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Profile'),
              onTap: () {
                // Navigate to edit profile
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Transaction History'),
              onTap: () {
                Navigator.pushNamed(context, '/transactions');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help & Support'),
              onTap: () {
                // Navigate to help
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await authProvider.logout();
                if (mounted) {
                  Navigator.pushReplacementNamed(context, '/login');
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
