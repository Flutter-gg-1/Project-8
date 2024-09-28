import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/screens/item_details/item_details_cubit.dart';

class CountView extends StatelessWidget {
  const CountView({
    super.key,
    required this.cubit,
  });

  final ItemDetailsCubit cubit;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => cubit.decrementCount(),
          icon: Icon(
            CupertinoIcons.minus_rectangle,
            size: 40,
            color: C.bg1(brightness),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text("${cubit.itemCount}",
            style: TextStyle(fontSize: 30, color: C.bg1(brightness))),
        SizedBox(
          width: 10,
        ),
        IconButton(
            onPressed: () => cubit.incrementCount(),
            icon: Icon(
              CupertinoIcons.plus_rectangle,
              size: 39,
              color: C.bg1(brightness),
            )),
      ],
    );
  }
}
