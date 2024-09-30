import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/gradient_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Scaffold(
      backgroundColor: C.bg2(brightness),
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Your order is Placed")
                    .styled(weight: FontWeight.w400, size: 20),
              ),
              OrderDetailsView(),
            ],
          ),
        ),
      )),
    ); 
  }
}

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final int duration = 20;
    final CountDownController controller = CountDownController();

    return CircularCountDownTimer(
      width: 300,
      height: 300,
      duration: duration,
      fillColor: C.bg1(brightness),
      ringColor: C.primary(brightness),
      initialDuration: 20,
      strokeWidth: 20.0,
      fillGradient: G.accent,
      ringGradient: G.primary,
    )
        // Container(
        //   decoration: BoxDecoration(
        //     color: C.bg2(brightness),
        //     shape: BoxShape.circle,
        //     boxShadow: const [
        //       BoxShadow(
        //         color: Colors.black45,
        //         blurRadius: 7,
        //       )
        //     ],
        //   ),
        //   child: Padding(
        //     padding: const EdgeInsets.all(16.0),
        //     child: Container(
        //       height: 200,
        //       width: 200,
        //       decoration: BoxDecoration(
        //         gradient: G.accent,
        //         shape: BoxShape.circle,
        //         boxShadow: const [
        //           BoxShadow(
        //             color: Colors.black26,
        //             blurRadius: 6,
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        // )
        ;
  }
}
