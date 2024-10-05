import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/screens/item_details/item_details_cubit.dart';

import '../../../model/enums/milk_options.dart';

class MilkSliderView extends StatelessWidget {
  const MilkSliderView({
    super.key,
    required this.cubit,
    required this.milkOption,
  });

  final ItemDetailsCubit cubit;
  final MilkOption milkOption;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Text("Milk").styled(
                color: C.bg1(brightness), weight: FontWeight.w600, size: 18),
          ],
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            final offsetAnimation = TweenSequence([
              TweenSequenceItem(
                tween: Tween<Offset>(
                  begin: Offset(0.0, 0.5),
                  end: Offset(0.0, 0.0),
                ),
                weight: 1,
              ),
              TweenSequenceItem(
                tween: ConstantTween(Offset(0.0, 0.0)),
                weight: 3,
              ),
              TweenSequenceItem(
                tween: Tween<Offset>(
                  begin: Offset(0.0, 0.0),
                  end: Offset(0.0, -0.2),
                ),
                weight: 1,
              ),
            ]).animate(animation);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
          child: Text(
            milkOption.strValue(),
            key: ValueKey<int>(cubit.milkSlider),
            style: TextStyle(
              color: C.bg1(brightness),
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 10.0, // Adjust the height of the slider track
            thumbShape: RoundSliderThumbShape(
                enabledThumbRadius: 16.0), // Adjust the size of the thumb
          ),
          child: Slider(
            value: cubit.milkSlider.toDouble(),
            min: 0,
            max: 3,
            divisions: 3,
            onChanged: (value) => cubit.updateSliderValue(value.toInt()),
            thumbColor: C.secondary(brightness),
            activeColor: C.accent(brightness),
            inactiveColor: C.bg1(brightness),
          ),
        ),
        Text('slide to Adjust').styled(color: C.bg1(brightness))
      ],
    );
  }
}
