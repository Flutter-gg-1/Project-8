import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/date_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/model/offer.dart';
import 'package:onze_cafe/screens/admin_screens/menu_mgmt/network_functions.dart';

import '../../../../extensions/color_ext.dart';
import '../menu_mgmt_cubit.dart';

class OfferCardView extends StatelessWidget {
  const OfferCardView({super.key, required this.offer, required this.cubit});
  final Offer offer;
  final MenuMgmtCubit cubit;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final menuItem = cubit.items
        .where((item) => offer.menuItemId == item.id)
        .toList()
        .firstOrNull;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: menuItem == null
                          ? Text('')
                          : Image.network(menuItem.imgUrl ?? ''),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(menuItem?.name ?? '')
                          .styled(weight: FontWeight.bold),
                      Text('Was: ${menuItem?.price} SAR').styled(),
                      Text('Now: ${offer.price} SAR').styled(),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () => cubit.deleteOffer(context, offer),
                    icon: Icon(CupertinoIcons.trash_circle_fill,
                        color: C.secondary(brightness)))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    'From: ${DateTime.parse(offer.startDate).toFormattedStringWithTime()}'),
                Text(
                    'To: ${DateTime.parse(offer.endDate).toFormattedStringWithTime()}'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
