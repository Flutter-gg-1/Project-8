import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/model/menu_category.dart';
import 'package:onze_cafe/screens/admin_screens/menu_mgmt/network_functions.dart';

import '../../../../extensions/color_ext.dart';
import '../menu_mgmt_cubit.dart';

class CategoryItemCardView extends StatelessWidget {
  const CategoryItemCardView(
      {super.key, required this.category, required this.cubit});
  final MenuCategory category;
  final MenuMgmtCubit cubit;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Card(
      elevation: 4,
      color: C.bg2(brightness),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(category.imgUrl ?? '')),
          )),
          Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(category.name).styled(weight: FontWeight.bold),
                ],
              )),
          IconButton(
              onPressed: () => cubit.deleteCategory(context, category),
              icon: Icon(CupertinoIcons.trash_circle_fill,
                  color: C.secondary(brightness)))
        ],
      ),
    );
  }
}
