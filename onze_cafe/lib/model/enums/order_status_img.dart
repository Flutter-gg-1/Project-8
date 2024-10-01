import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/img_ext.dart';

enum StatusImage { an1, an2, an3, an4 }

extension OrderStatusImg on StatusImage {
  AssetImage image() {
    switch (this) {
      case StatusImage.an1:
        return Img.an1;
      case StatusImage.an2:
        return Img.an2;
      case StatusImage.an3:
        return Img.an3;
      case StatusImage.an4:
        return Img.an4;
    }
  }
}
