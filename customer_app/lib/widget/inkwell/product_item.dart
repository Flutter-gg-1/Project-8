import 'package:customer_app/helper/extinsion/size_config.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String name,price;
  final Function()? onTap;
  const ProductItem({
    super.key, required this.name, required this.price, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: context.getWidth(multiply: 0.05),
          vertical: context.getHeight(multiply: 0.02)),
        padding: EdgeInsets.symmetric(horizontal: context.getWidth(multiply: 0.05),
        vertical: context.getHeight(multiply: 0.01)),
        height: context.getHeight(multiply: 0.08),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: const Color(0xff87B1C5)),
        child:  Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('assets/image/appBarProfile.png',),
            ),
            const VerticalDivider(color: Color(0xff3D6B7D),),
            Column(
              children: [
                Text(name,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                Text('$price SR')
              ],
            )
          ],
        ),
      ),
    );
  }
}
