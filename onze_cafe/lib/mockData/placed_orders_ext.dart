import 'package:onze_cafe/mockData/mock_data.dart';
import 'package:onze_cafe/model/placed_order.dart';

extension PlacedOrdersExt on MockData {
  List<PlacedOrder> fetchPlacedOrders() {
    return [
      PlacedOrder(id: '1', userId: '1', status: 'placed'),
      PlacedOrder(id: '2', userId: '1', status: 'completed'),
    ];
  }
}
