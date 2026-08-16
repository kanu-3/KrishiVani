import 'package:Krishivani/feature/market/presentation/widgets/market_crop_data.dart';
import 'package:flutter/material.dart';
import '../../../../core/extensions/context_extensions.dart';
import 'market_crop_card.dart';

class MarketCropList extends StatelessWidget {
  const MarketCropList({
    super.key,
    required this.crops,
    this.onCropTap,
  });

  final List<MarketCropData> crops;
  final ValueChanged<MarketCropData>? onCropTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: crops.length,
      separatorBuilder: (
          context,
          index,
          ) {
        return SizedBox(
          height: context.spacingS,
        );
      },
      itemBuilder: (
          context,
          index,
          ) {
        final crop = crops[index];

        return MarketCropCard(
          cropName: crop.name,
          wholesalePrice: crop.wholesalePrice,
          retailPrice: crop.retailPrice,
          
          onTap: () {
            onCropTap?.call(crop);
          }, image: crop.image,
        );
      },
    );
  }
}