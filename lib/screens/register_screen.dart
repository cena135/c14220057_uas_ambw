import 'package:flutter/material.dart';
import '../services/supabase_service.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: passwordController, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            if (error != null) Text(error!, style: const TextStyle(color: Colors.red)),
            ElevatedButton(
              child: const Text('Register'),
              onPressed: () async {
                try {
                  await SupabaseService.signUp(emailController.text, passwordController.text);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                } catch (e) {
                  setState(() => error = 'Register gagal');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}