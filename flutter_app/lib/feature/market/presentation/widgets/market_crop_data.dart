import 'package:flutter/material.dart';

class MarketCropData {
  final String name;
  final String wholesalePrice;
  final String retailPrice;
  final Widget image;

  const MarketCropData({
    required this.name,
    required this.wholesalePrice,
    required this.retailPrice,
    required this.image,
  });
}