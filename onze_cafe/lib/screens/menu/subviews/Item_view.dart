import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/img_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/model/menu_item.dart';

import '../../../extensions/color_ext.dart';

class ItemView extends StatelessWidget {
  const ItemView({super.key, required this.item});
  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: C.bg3(brightness),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              offset: Offset(3, 3),
              blurRadius: 6,
            )
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              child: AspectRatio(
                aspectRatio: 2,
                child: item.imgUrl == null
                    ? Image(image: Img.logo4, fit: BoxFit.fitWidth)
                    : Image.network(item.imgUrl!, fit: BoxFit.fitWidth),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.name).styled(
                              size: 14, weight: FontWeight.w600, lineLimit: 1),
                          const SizedBox(height: 4),
                          Text("${item.price.toString()} SAR")
                              .styled(size: 12, weight: FontWeight.bold),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            decoration: BoxDecoration(
                                color: C.accent(brightness),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16))),
                            child: Icon(CupertinoIcons.add,
                                size: 20,
                                color: C.primary(brightness),
                                weight: 24)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
