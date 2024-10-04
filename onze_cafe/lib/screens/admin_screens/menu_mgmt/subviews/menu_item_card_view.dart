import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/string_ex.dart';

import '../../../../model/menu_item.dart';
import '../menu_mgmt_cubit.dart';

class MenuItemCardView extends StatelessWidget {
  const MenuItemCardView({super.key, required this.item, required this.cubit});
  final MenuItem item;
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
                child: Image.network(item.imgUrl ?? '')),
          )),
          Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name).styled(weight: FontWeight.bold),
                  Text(
                      'Category: ${cubit.categories.where((cat) => cat.id == item.categoryId).toList().firstOrNull?.name ?? ''}'),
                ],
              ))
        ],
      ),
    );
  }
}
