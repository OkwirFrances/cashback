import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/providers/auth_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Preferences',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SwitchListTile(
            title: const Text('Enable Notifications'),
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: _darkModeEnabled,
            onChanged: (value) {
              setState(() {
                _darkModeEnabled = value;
              });
            },
          ),
          const Divider(),
          const Text(
            'Account',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ListTile(
            title: const Text('Change Password'),
            onTap: () {
              // Navigate to change password
            },
          ),
          ListTile(
            title: const Text('Delete Account'),
            onTap: () {
              _showDeleteAccountDialog(context, authProvider);
            },
          ),
          const Divider(),
          const Text(
            'About',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ListTile(
            title: const Text('Terms of Service'),
            onTap: () {
              // Navigate to terms
            },
          ),
          ListTile(
            title: const Text('Privacy Policy'),
            onTap: () {
              // Navigate to privacy policy
            },
          ),
          ListTile(
            title: const Text('App Version'),
            subtitle: const Text('1.0.0'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(
      BuildContext context, AuthProvider authProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
            'Are you sure you want to delete your account? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              // Implement account deletion
              await authProvider.logout();
              if (mounted) {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
