import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../service/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _tokenController = TextEditingController();
  final AuthService _authService = AuthService(
    Dio(),
    'https://example.com/api/v1/google/login',
  );
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final token = _tokenController.text;

    final success = await _authService.login(token);

    setState(() {
      _isLoading = false;
    });

    if (success) {
      // Navigate to the home screen or any other screen after successful login
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() {
        _errorMessage = 'Login failed. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tokenController,
              decoration: InputDecoration(
                labelText: 'Enter Token',
                errorText: _errorMessage,
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isLoading ? null : _login,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
