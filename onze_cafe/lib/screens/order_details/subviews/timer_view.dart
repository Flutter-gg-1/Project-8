import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/gradient_ext.dart';
import 'package:onze_cafe/screens/order_details/order_details_cubit.dart';

class TimerView extends StatelessWidget {
  const TimerView({
    super.key,
    required this.cubit,
  });

  final OrderDetailsCubit cubit;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
            gradient: G.primary,
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 7,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: G.accent,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CircularCountDownTimer(
                  width: MediaQuery.of(context).size.width / 1.4,
                  height: MediaQuery.of(context).size.height / 2,
                  duration: cubit.remainingTime,
                  fillColor: C.bg1(brightness),
                  ringColor: C.primary(brightness),
                  strokeCap: StrokeCap.round,
                  initialDuration: 0,
                  strokeWidth: 8.0,
                  isTimerTextShown: false,
                  fillGradient: G.secondary,
                  ringGradient: LinearGradient(
                    colors: [
                      C.primary(brightness).withOpacity(0.2),
                      C.accent(brightness)
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  backgroundColor: Colors.transparent,
                  isReverse: true,
                  isReverseAnimation: true,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
