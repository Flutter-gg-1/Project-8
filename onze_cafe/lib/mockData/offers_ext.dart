import 'package:flutter/cupertino.dart';
import 'package:onze_cafe/extensions/img_ext.dart';
import 'package:onze_cafe/mockData/mock_data.dart';

extension MenuItemsExt on MockData {
  List<AssetImage> fetchOfferce() {
    return [
      Img.logo1,
      Img.logo2,
      Img.logo3,
      Img.logo4,
    ];
  }
}
