import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/managers/alert_mgr.dart';
import 'package:onze_cafe/screens/admin_screens/menu_mgmt/menu_mgmt_cubit.dart';
import 'package:onze_cafe/screens/admin_screens/menu_mgmt/subviews/category_item_card_view.dart';
import 'package:onze_cafe/screens/admin_screens/menu_mgmt/subviews/menu_item_card_view.dart';
import 'package:onze_cafe/screens/admin_screens/menu_mgmt/subviews/offer_card_view.dart';

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
        return BlocListener<MenuMgmtCubit, MenuMgmtState>(
          listener: (context, state) {
            if (state is LoadingState) {
              AlertManager().showAlert(context: context);
            }
            if (state is UpdateUIState) {
              AlertManager().dismissPreviousAlert(context);
            }
          },
          child: Scaffold(
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
                      Expanded(
                          child: Text('Offers')
                              .styled(size: 18, weight: FontWeight.bold)),
                      IconButton(
                          onPressed: () =>
                              cubit.navigateToAddOffer(context, null),
                          icon: Icon(CupertinoIcons.add_circled))
                    ],
                  ),
                  BlocBuilder<MenuMgmtCubit, MenuMgmtState>(
                    builder: (context, state) {
                      return GridView(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3,
                          ),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: cubit.offers
                              .map((offer) =>
                                  OfferCardView(offer: offer, cubit: cubit))
                              .toList());
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text('Categories')
                              .styled(size: 18, weight: FontWeight.bold)),
                      IconButton(
                          onPressed: () =>
                              cubit.navigateToAddCat(context, null),
                          icon: Icon(CupertinoIcons.add_circled))
                    ],
                  ),
                  BlocBuilder<MenuMgmtCubit, MenuMgmtState>(
                    builder: (context, state) {
                      return GridView(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 6,
                          ),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: cubit.categories
                              .map((cat) => CategoryItemCardView(
                                  category: cat, cubit: cubit))
                              .toList());
                    },
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                          child: Text('Menu Items')
                              .styled(size: 18, weight: FontWeight.bold)),
                      IconButton(
                          onPressed: () =>
                              cubit.navigateToAddMenuItem(context, null),
                          icon: Icon(CupertinoIcons.add_circled))
                    ],
                  ),
                  BlocBuilder<MenuMgmtCubit, MenuMgmtState>(
                    builder: (context, state) {
                      return GridView(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 6,
                          ),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: cubit.items
                              .map(
                                (item) => InkWell(
                                    onTap: () => cubit.navigateToAddMenuItem(
                                        context, item),
                                    child: MenuItemCardView(
                                      item: item,
                                      cubit: cubit,
                                    )),
                              )
                              .toList());
                    },
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
