import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/img_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/screens/item_details/item_details_cubit.dart';

class CoffeeStrengthView extends StatelessWidget {
  const CoffeeStrengthView({
    super.key,
    required this.cubit,
    required this.index,
    required this.size,
    required this.title,
  });

  final ItemDetailsCubit cubit;
  final int index;
  final double size;
  final String title;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          InkWell(
            onTap: () => cubit.selectStrength(index),
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
                      width: 2,
                      color: cubit.selectStrengthIndex == index
                          ? C.bg1(brightness)
                          : C.accent(brightness),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Text("$title Roast").styled(
                        weight: FontWeight.bold,
                        color: cubit.selectStrengthIndex == index
                            ? C.bg1(brightness)
                            : C.accent(brightness),
                      ),
                      SizedBox(width: 8,),
                      Image(
                        image: cubit.selectStrengthIndex == index
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
