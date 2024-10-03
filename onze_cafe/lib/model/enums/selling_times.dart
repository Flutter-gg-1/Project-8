enum SellingTimes {
  eight,
  nine,
  ten,
  eleven,
  twelve,
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eightPm,
}

extension TextValue on SellingTimes {
  String hour() {
    switch (this) {
      case SellingTimes.eight:
        return '8';
      case SellingTimes.nine:
        return '9';
      case SellingTimes.ten:
        return '10';
      case SellingTimes.eleven:
        return '11';
      case SellingTimes.twelve:
        return '12';
      case SellingTimes.one:
        return '1';
      case SellingTimes.two:
        return '2';
      case SellingTimes.three:
        return '3';
      case SellingTimes.four:
        return '4';
      case SellingTimes.five:
        return '5';
      case SellingTimes.six:
        return '6';
      case SellingTimes.seven:
        return '7';
      case SellingTimes.eightPm:
        return '8';
    }
  }
}
