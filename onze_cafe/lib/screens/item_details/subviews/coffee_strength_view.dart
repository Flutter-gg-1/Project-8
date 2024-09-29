import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/img_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/screens/item_details/item_details_cubit.dart';

import '../../../model/enums/coffee_strength.dart';

class CoffeeStrengthView extends StatelessWidget {
  const CoffeeStrengthView({
    super.key,
    required this.cubit,
  });

  final ItemDetailsCubit cubit;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Column(
      children: [
        Row(
          children: [
            Text("Coffee Strength").styled(
                color: C.bg1(brightness), weight: FontWeight.w600, size: 18),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Enable horizontal scrolling
            child: Row(
              children: CoffeeStrength.values
                  .map((strength) =>
                      _StrengthCardView(cubit: cubit, strength: strength))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class _StrengthCardView extends StatelessWidget {
  const _StrengthCardView({required this.cubit, required this.strength});
  final ItemDetailsCubit cubit;
  final CoffeeStrength strength;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          InkWell(
            onTap: () => cubit.selectStrength(strength),
            child: Container(
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black45,
                          offset: Offset(0, 2),
                          blurRadius: 6,
                          blurStyle: BlurStyle.outer)
                    ],
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 3,
                      color: cubit.selectedStrength == strength
                          ? C.secondary(brightness)
                          : C.bg1(brightness),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Text("${strength.name()} Roast").styled(
                        weight: FontWeight.bold,
                        color: cubit.selectedStrength == strength
                            ? C.bg1(brightness)
                            : C.accent(brightness),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Image(
                        image: cubit.selectedStrength == strength
                            ? Img.coffeeBeanR
                            : Img.coffeeBeanB,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
