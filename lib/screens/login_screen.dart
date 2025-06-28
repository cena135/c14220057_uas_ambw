import 'package:flutter/material.dart';
import '../services/supabase_service.dart';
import '../services/session_service.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: passwordController, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            if (error != null) Text(error!, style: const TextStyle(color: Colors.red)),
            ElevatedButton(
              child: const Text('Login'),
              onPressed: () async {
                try {
                  await SupabaseService.signIn(emailController.text, passwordController.text);
                  await SessionService.setLoggedIn(true);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                } catch (e) {
                  setState(() => error = 'Login gagal');
                }
              },
            ),
            TextButton(
              child: const Text('Belum punya akun? Register'),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen())),
            ),
          ],
        ),
      ),
    );
  }
}