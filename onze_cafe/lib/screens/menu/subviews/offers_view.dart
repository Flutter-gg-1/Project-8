import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/screens/menu/menu_cubit.dart';

import 'offers_slider.dart';

class OffersView extends StatelessWidget {
  const OffersView({super.key, required this.cubit});
  final MenuCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12.0),
          child: const Text("Offers").styled(weight: FontWeight.bold, size: 18),
        ),
        OffersSlider(cubit: cubit),
      ],
    );
  }
}
