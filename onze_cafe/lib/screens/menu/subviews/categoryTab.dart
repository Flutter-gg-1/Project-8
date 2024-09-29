import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/mockData/categories_ext.dart';
import 'package:onze_cafe/mockData/mock_data.dart';
import 'package:onze_cafe/model/menu_category.dart';
import 'package:onze_cafe/screens/menu/menu_cubit.dart';

import '../../../extensions/img_ext.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key, required this.cubit});
  final MenuCubit cubit;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return DefaultTabController(
      length: cubit.categories.length,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TabBar(
          onTap: (idx) => cubit.goToSelectedCategory(cubit.categories[idx].id),
          labelColor: C.primary(brightness),
          labelStyle: TextStyle(fontWeight: FontWeight.w800),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
          tabAlignment: TabAlignment.start,
          indicatorColor: Colors.transparent,
          dividerColor: Colors.transparent,
          isScrollable: true,
          tabs: cubit.categories
              .map((ctg) => _CategoryCardView(category: ctg))
              .toList(),
        ),
      ),
    );
  }
}

class _CategoryCardView extends StatelessWidget {
  const _CategoryCardView({required this.category});
  final MenuCategory category;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image(
              //   image: Img.cold,
              //   fit: BoxFit.contain,
              // ),
              Text(
                category.name,
                textAlign: TextAlign.center,
                maxLines: 2,
              )
            ],
          ),
        ],
      ),
    );
  }
}
