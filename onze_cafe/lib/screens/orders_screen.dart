import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders Screen'),
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
