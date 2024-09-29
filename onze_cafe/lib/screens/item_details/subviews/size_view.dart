import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/img_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/screens/item_details/item_details_cubit.dart';

class SizeView extends StatelessWidget {
  const SizeView({
    super.key,
    required this.cubit,
    required this.index,
    required this.size,
  });

  final ItemDetailsCubit cubit;
  final int index;
  final double size;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    final List<String> sizes = ['Small', 'Medium', 'Large'];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: InkWell(
            onTap: () => cubit.selectSize(index),
            child: Container(
                height: size,
                width: size,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black45,
                      offset: Offset(3, 3),
                      blurRadius: 6,
                    )
                  ],
                  color: cubit.selectedIndex == index
                      ? C.accent(brightness)
                      : C.bg3(brightness),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image(
                    image: Img.cold,
                  ),
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              sizes[index],
            ).styled(
              weight: FontWeight.bold,
              color: cubit.selectedIndex == index
                  ? C.bg1(brightness)
                  : C.accent(brightness),
            ),
          ),
        ),
      ],
    );
  }
}
