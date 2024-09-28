import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:onze_cafe/mockData/mock_data.dart';
import 'package:onze_cafe/mockData/offers_ext.dart';

class OffersSlider extends StatelessWidget {
  const OffersSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final Offers = MockData().fetchOfferce();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CarouselSlider(
          items: Offers.map((img) => Image(
                image: img,
              )).toList(),
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 4.0,
            enlargeCenterPage: true,
          )),
    );
  }
}
