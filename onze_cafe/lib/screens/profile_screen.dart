import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Screen'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [],
            ),
          )
        ],
      )),
    );
  }
}
