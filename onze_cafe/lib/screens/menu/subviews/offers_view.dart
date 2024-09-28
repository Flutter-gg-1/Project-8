import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/string_ex.dart';

import 'offers_slider.dart';

class OffersView extends StatelessWidget {
  const OffersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: const Text("Offers").styled(weight: FontWeight.bold, size: 18),
        ),
        const OffersSlider(),
      ],
    );
  }
}
