import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/model/menu_category.dart';

import '../../extensions/img_ext.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key, required this.categories});
  final List<MenuCategory> categories;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return DefaultTabController(
        length: categories.length,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBar(
            labelColor: C.primary(brightness),
            labelStyle: TextStyle(fontWeight: FontWeight.w800),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
            tabAlignment: TabAlignment.start,
            indicatorColor: Colors.transparent,
            dividerColor: Colors.transparent,
            isScrollable: true,
            tabs: categories
                .map((ctg) => SizedBox(
                      height: 100,
                      child: Tab(
                          child: Row(
                        children: [
                          AspectRatio(
                            aspectRatio: 0.7,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: Img.cold,
                                  width: 40,
                                  fit: BoxFit.contain,
                                ),
                                AspectRatio(
                                  aspectRatio: 2,
                                  child: Text(
                                    ctg.name,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )),
                    ))
                .toList(),
          ),
        ));
  }
}
