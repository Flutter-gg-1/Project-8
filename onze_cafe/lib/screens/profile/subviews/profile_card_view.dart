import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/string_ex.dart';

import '../../../extensions/color_ext.dart';
import '../../../extensions/img_ext.dart';

class ProfileCardView extends StatelessWidget {
  const ProfileCardView({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Card(
        elevation: 8,
        shadowColor: C.secondary(brightness),
        color: C.bg1(brightness),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: C.primary(brightness), width: 2)),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ClipOval(child: Image(image: Img.cappuccino)),
                    )),
              ),
            ),
            Expanded(
              flex: 2,
              child: ListTile(
                title: Text('Hello').styled(
                    color: C.primary(brightness),
                    size: 18,
                    weight: FontWeight.bold),
                subtitle: Text('abc@example.com')
                    .styled(color: C.primary(brightness)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
