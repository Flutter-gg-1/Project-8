import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/model/menu_category.dart';

import '../menu_mgmt_cubit.dart';

class CategoryItemCardView extends StatelessWidget {
  const CategoryItemCardView(
      {super.key, required this.category, required this.cubit});
  final MenuCategory category;
  final MenuMgmtCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(4),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(category.imgUrl ?? '')),
          )),
          Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(category.name).styled(weight: FontWeight.bold),
                ],
              ))
        ],
      ),
    );
  }
}
