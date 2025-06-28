import 'package:flutter/material.dart';
import '../services/session_service.dart';
import 'login_screen.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Get Started'),
          onPressed: () async {
            await SessionService.setSeenGetStarted();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            );
          },
        ),
      ),
    );
  }
}