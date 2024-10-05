import 'package:employee_app/helper/extinsion/size_config.dart';
import 'package:employee_app/models/product_model.dart';
import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final Function()? editFunction;
  final Function()? removeFunction;
  final ProductModel itemInfo;
  const MenuItem({
    super.key,
    this.editFunction,
    this.removeFunction,
    required this.itemInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getWidth(multiply: 0.4),
      padding: EdgeInsets.symmetric(
        vertical: context.getWidth(multiply: 0.02),
        horizontal: context.getWidth(multiply: 0.02),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xffEFEDEA),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: editFunction,
                icon: const Icon(
                  Icons.edit,
                  color: Color(0xff3D6B7D),
                ),
              ),
              IconButton(
                onPressed: removeFunction,
                icon: const Icon(
                  Icons.highlight_remove_rounded,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          Image.asset('assets/image/menuImage.png'),
          context.addSpacer(multiply: 0.02),
          Text(
            '${itemInfo.name}',
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontFamily: 'Rosarivo'),
          ),
        ],
      ),
    );
  }
}
