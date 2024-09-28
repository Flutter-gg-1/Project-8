import 'package:onze_cafe/extensions/date_ext.dart';
import 'package:onze_cafe/mockData/mock_data.dart';
import 'package:onze_cafe/model/offer.dart';

extension OffersExt on MockData {
  List<Offer> fetchOffers() {
    return [
      Offer(
        id: '1',
        menuItemId: '1',
        price: 5.5,
        startDate: DateTime.now().toFormattedString(),
        endDate: DateTime.now().add(Duration(days: 10)).toFormattedString(),
      ),
      Offer(
        id: '2',
        menuItemId: '3',
        price: 3.5,
        startDate: DateTime.now().toFormattedString(),
        endDate: DateTime.now().add(Duration(days: 14)).toFormattedString(),
      ),
    ];
  }
}
