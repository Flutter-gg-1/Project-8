import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/screens/item_details/item_details_cubit.dart';

class SliderView extends StatelessWidget {
  const SliderView({
    super.key,
    required this.cubit,
    required this.title,
  });

  final ItemDetailsCubit cubit;
  final String title;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
            title,
            key: ValueKey<int>(cubit.sliderValue),
            style: TextStyle(
              color: C.bg1(brightness),
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Slider(
            value: cubit.sliderValue.toDouble(),
            min: 0,
            max: 3,
            divisions: 3,
            onChanged: (value) {
              cubit.updateSliderValue(value.toInt());
            },
            thumbColor: C.secondary(brightness),
            activeColor: C.bg1(brightness),
            inactiveColor: C.accent(brightness)),
      ],
    );
  }
}
