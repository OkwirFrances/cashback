import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/providers/auth_provider.dart';
import '../../../shared/widgets/ug_phone_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome Back',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: authProvider.isLoading
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          final success = await authProvider.login(
                            _emailController.text,
                            _passwordController.text,
                          );
                          if (success && mounted) {
                            Navigator.pushReplacementNamed(context, '/home');
                          }
                        }
                      },
                child: authProvider.isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text('Create an account'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
