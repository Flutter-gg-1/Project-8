enum CoffeeStrength { light, medium, dark }

extension TextValue on CoffeeStrength {
  String strValue() {
    switch (this) {
      case CoffeeStrength.light:
        return 'Light';
      case CoffeeStrength.medium:
        return 'Medium';
      case CoffeeStrength.dark:
        return 'Dark';
    }
  }
}
