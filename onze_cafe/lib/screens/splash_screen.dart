import 'package:flutter/material.dart';

import 'auth/auth_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void navigateToAuth(BuildContext context) =>
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const AuthScreen()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Splash Screen'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                TextButton(
                    onPressed: () => navigateToAuth(context),
                    child: const Text('Navigate to Auth'))
              ],
            ),
          )
        ],
      )),
    );
  }
}
