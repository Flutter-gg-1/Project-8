enum MilkOption { fullCream, creamy, skimmedMilk, lowFat }

extension TextValue on MilkOption {
  String strValue() {
    switch (this) {
      case MilkOption.fullCream:
        return "Full Cream";
      case MilkOption.creamy:
        return "Creamy";
      case MilkOption.skimmedMilk:
        return "Skimmed Milk";
      case MilkOption.lowFat:
        return "Low-Fat Milk";
    }
  }
}
