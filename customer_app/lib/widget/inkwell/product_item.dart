import 'package:customer_app/helper/extinsion/size_config.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String name;
  final int price, cal, time;
  final String id, description, type;
  final Function()? onTap;
  const ProductItem({
    super.key,
    required this.name,
    required this.price,
    this.onTap,
    required this.id,
    required this.cal,
    required this.time,
    required this.description,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: context.getWidth(multiply: 0.05),
            vertical: context.getHeight(multiply: 0.01)),
        padding: EdgeInsets.symmetric(
            horizontal: context.getWidth(multiply: 0.05),
            vertical: context.getHeight(multiply: 0.01)),
        height: context.getHeight(multiply: 0.08),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: kElevationToShadow[4],
            color: const Color(0xffeeedea)),
        child: Row(
          children: [
            Image.asset(
              'assets/image/appBarProfile (2).png',
              filterQuality: FilterQuality.high,
            ),
            const VerticalDivider(
              color: Color(0xff3D6B7D),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name.length <= 15 ? name : '${name.substring(0,15)}...',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins'),
                ),
                Text('$price SR')
              ],
            ),
            const Spacer(),
            Container(
              width: 32,
              height: 28,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xffA8483D)),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 17,
              ),
            )
          ],
        ),
      ),
    );
  }
}
