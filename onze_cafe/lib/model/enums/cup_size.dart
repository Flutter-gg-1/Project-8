enum CupSize { small, medium, large }

extension TextValue on CupSize {
  String name() {
    switch (this) {
      case CupSize.small:
        return 'Small';
      case CupSize.medium:
        return 'Medium';
      case CupSize.large:
        return 'Large';
    }
  }
}
