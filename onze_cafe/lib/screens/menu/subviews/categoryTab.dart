import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
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
          padding: EdgeInsets.zero,
          labelPadding: EdgeInsets.zero,
          onTap: (idx) =>
              cubit.goToSelectedCategory(cubit.categories[idx].id ?? ""),
          labelColor: C.primary(brightness),
          labelStyle: TextStyle(fontWeight: FontWeight.w800),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
          // tabAlignment: TabAlignment.start,
          indicatorColor: Colors.transparent,
          dividerColor: Colors.transparent,
          isScrollable: false,
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
    return AspectRatio(
      aspectRatio: 1,
      child: Tab(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: category.imgUrl == null
                  ? Image(image: Img.logo4, fit: BoxFit.fitWidth)
                  : Image.network(category.imgUrl!, fit: BoxFit.contain),
            ),
            SizedBox(height: 8),
            Expanded(
              child: Text(category.name).styled(
                  size: 10,
                  weight: FontWeight.w300,
                  align: TextAlign.center,
                  lineLimit: 2),
            )
          ],
        ),
      ),
    );
  }
}
