import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/img_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/mockData/mock_data.dart';
import 'package:onze_cafe/mockData/offers_ext.dart';

import '../../../extensions/color_ext.dart';
import '../../../model/menu_item.dart';
import '../../../model/offer.dart';

class OffersSlider extends StatelessWidget {
  const OffersSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final offers = MockData().fetchOffers();
    return CarouselSlider(
      items: offers.map((offer) {
        // Get the corresponding MenuItem for the offer
        MenuItem? menuItem = MockData().getMenuItemById(offer.menuItemId);
        return menuItem == null
            ? Text('')
            : _CarouselItem(offer: offer, menuItem: menuItem);
      }).toList(),
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 3.0,
        enlargeCenterPage: true,
      ),
    );
  }
}

class _CarouselItem extends StatelessWidget {
  const _CarouselItem({required this.offer, required this.menuItem});
  final Offer offer;
  final MenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        color: C.bg3(brightness),
        elevation: 4,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Card(
              elevation: 2,
              color: C.accent(brightness),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                        '${((1 - (offer.price / menuItem.price)) * 100).toStringAsPrecision(2)}%')
                    .styled(weight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: menuItem.imgUrl != null
                      ? Padding(
                          padding: const EdgeInsets.all(4),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: menuItem.imgUrl == null ||
                                      menuItem.imgUrl == ''
                                  ? Image(image: Img.logo4, fit: BoxFit.contain)
                                  : Image.network(menuItem.imgUrl ?? '',
                                      fit: BoxFit.fill)),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(4),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image(image: Img.late, fit: BoxFit.fill)),
                        ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(menuItem.name)
                            .styled(weight: FontWeight.bold, size: 16),
                        Row(
                          children: [
                            Text(menuItem.price.toStringAsPrecision(3)).styled(
                                color: C.secondary(brightness),
                                size: 12,
                                weight: FontWeight.w500,
                                cross: true),
                            Text(' SAR').styled(
                                color: C.secondary(brightness),
                                weight: FontWeight.bold,
                                cross: true),
                          ],
                        ),
                        Row(
                          children: [
                            Text(offer.price.toStringAsPrecision(3)).styled(
                                color: C.primary(brightness),
                                weight: FontWeight.bold),
                            Text(' SAR').styled(
                                color: C.primary(brightness),
                                weight: FontWeight.bold),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
