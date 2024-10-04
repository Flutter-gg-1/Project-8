import 'package:flutter/material.dart';
import 'package:onze_cafe/data_layer/data_layer.dart';
import 'package:onze_cafe/services/notification.dart';
import 'package:onze_cafe/services/setup.dart';

class Testing extends StatelessWidget {
  const Testing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () {
              sendNotification(externalKey: locator.get<DataLayer>().externalKey!);
            },
            child: const Text('send notification')),
      ),
    );
  }
}


