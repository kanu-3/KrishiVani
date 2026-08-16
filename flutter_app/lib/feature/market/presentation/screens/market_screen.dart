import 'package:Krishivani/app/router/route_paths.dart';
import 'package:Krishivani/core/constants/assets_paths.dart';
import 'package:Krishivani/core/widgets/common/app_header.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../widgets/market_crop_data.dart';
import '../widgets/market_crop_list.dart';
import '../widgets/market_search_section.dart';
import '../widgets/market_section_title.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({
    super.key,
  });

  @override
  State<MarketScreen> createState() =>
      MarketScreenState();
}

class MarketScreenState
    extends State<MarketScreen> {
  final TextEditingController searchController =
  TextEditingController();

  final List<MarketCropData> crops =  [
    MarketCropData(
      name: 'Tomatoes',
      wholesalePrice: 'Wholesale: ₹25–30/kg',
      retailPrice: 'Retail: ₹40–45/kg',
        image: Image.asset(AssetPaths.tomatoes)

    ),
    MarketCropData(
      name: 'Carrot',
      wholesalePrice: 'Wholesale: ₹20–25/kg',
      retailPrice: 'Retail: ₹35–40/kg',
        image: Image.asset(AssetPaths.carrot)
    ),
    MarketCropData(
      name: 'Cucumber',
      wholesalePrice: 'Wholesale: ₹18–22/kg',
      retailPrice: 'Retail: ₹30–35/kg',
        image: Image.asset(AssetPaths.cucumber)
    ),
    MarketCropData(
      name: 'Brinjal',
      wholesalePrice: 'Wholesale: ₹25–35/kg',
      retailPrice: 'Retail: ₹40–50/kg',
        image: Image.asset(AssetPaths.brinjal)
    ),
    MarketCropData(
      name: 'Onion',
      wholesalePrice: 'Wholesale: ₹18–25/kg',
      retailPrice: 'Retail: ₹30–35/kg',
        image: Image.asset(AssetPaths.onion)
    ),
  ];

  List<MarketCropData> get filteredCrops {
    final query =
    searchController.text.trim().toLowerCase();

    if (query.isEmpty) {
      return crops;
    }

    return crops.where(
          (crop) {
        return crop.name
            .toLowerCase()
            .contains(query);
      },
    ).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void openCrop(MarketCropData crop) {
    if (crop.name.toLowerCase() !=
        'tomatoes') {
      return;
    }

    context.push(
      RoutePaths.marketResults,
    );
  }

  @override
  Widget build(BuildContext context) {
    final visibleCrops =
        filteredCrops;

    return Scaffold(
      backgroundColor:
      AppColors.bg,
      appBar: const AppHeader(
        title: 'Market Analysis',
        showBackButton: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: context.bodypad,
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              MarketSearchSection(
                controller: searchController,
                onChanged: (_) {
                  setState(() {});
                },
              ),

              SizedBox(
                height: context.spacingL,
              ),

              const MarketSectionTitle(
                title:
                'See trends for trendy crops',
              ),

              MarketCropList(
                crops: visibleCrops,
                onCropTap: openCrop,
              ),
            ],
          ),
        ),
      ),
    );
  }
}