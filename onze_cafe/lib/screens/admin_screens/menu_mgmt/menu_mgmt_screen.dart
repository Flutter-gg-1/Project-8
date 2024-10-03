import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/screens/admin_screens/menu_mgmt/menu_mgmt_cubit.dart';

import '../../../extensions/color_ext.dart';

class MenuMgmtScreen extends StatelessWidget {
  const MenuMgmtScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MenuMgmtCubit(context),
      child: Builder(builder: (context) {
        final cubit = context.read<MenuMgmtCubit>();
        final brightness = Theme.of(context).brightness;
        return Scaffold(
          backgroundColor: C.bg1(brightness),
          appBar: AppBar(
            backgroundColor: C.bg1(brightness),
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(CupertinoIcons.chevron_left_square_fill),
              iconSize: 40,
              color: C.primary(brightness),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: ListView(
              children: [
                Row(
                  children: [
                    Expanded(child: Text('Categories').styled()),
                    IconButton(
                        onPressed: () => cubit.navigateToAddCat(context, null),
                        icon: Icon(CupertinoIcons.add_circled))
                  ],
                ),
                BlocBuilder<MenuMgmtCubit, MenuMgmtState>(
                  builder: (context, state) {
                    return Column(
                        children: cubit.categories
                            .map((cat) => TextButton(
                                onPressed: () =>
                                    cubit.navigateToAddCat(context, cat),
                                child: Text(cat.name)))
                            .toList());
                  },
                ),
                const Divider(),
                Row(
                  children: [
                    Expanded(child: Text('Menu Items')),
                    IconButton(
                        onPressed: () =>
                            cubit.navigateToAddMenuItem(context, null),
                        icon: Icon(CupertinoIcons.add_circled))
                  ],
                ),
                BlocBuilder<MenuMgmtCubit, MenuMgmtState>(
                  builder: (context, state) {
                    return Column(
                        children: cubit.items
                            .map((item) => TextButton(
                                onPressed: () =>
                                    cubit.navigateToAddMenuItem(context, item),
                                child: Text(item.name)))
                            .toList());
                  },
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
