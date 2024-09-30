enum OrderStatus { placed, preparing, ready, onTheWay }

extension TextValue on OrderStatus {
  String name() {
    switch (this) {
      case OrderStatus.placed:
        return 'Order placed';
      case OrderStatus.preparing:
        return 'Working on your coffee';
      case OrderStatus.ready:
        return 'Your coffee is ready';
      case OrderStatus.onTheWay:
        return 'Out for delivery';
    }
  }
}
