import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/img_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/model/menu_item.dart';
import 'package:onze_cafe/screens/cart_screen.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({super.key, required this.item});
  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Scaffold(
      backgroundColor: C.bg1(brightness),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                //* edit
                Icon(Icons.arrow_back),
                Stack(
                  children: [
                    AspectRatio(
                        aspectRatio: 1.5,
                        child: Image(
                          image: Img.americano,
                          fit: BoxFit.cover,
                        )),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      color: C.primary(brightness),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(item.name).styled(
                                color: C.bg1(brightness),
                                weight: FontWeight.bold,
                                size: 26),
                            Text('${item.price} RS').styled(
                                color: C.secondary(brightness),
                                weight: FontWeight.bold,
                                size: 24),
                          ],
                        ),

                        Text("Size").styled(
                            color: C.bg1(brightness),
                            weight: FontWeight.w600,
                            size: 18), 
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          TextButton(onPressed: () => (), child: const Text('Add to Cart'))
        ],
      ),
    );
  }
}
