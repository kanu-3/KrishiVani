import 'dart:typed_data';
import 'package:Krishivani/core/constants/assets_paths.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AppInfoCard extends StatelessWidget {
  const AppInfoCard({
    super.key,
    this.imageUrl,
    this.imageBytes,
    required this.quote,
    this.onPressed,
    this.height = 180,
  });

  final String? imageUrl;
  final Uint8List? imageBytes;
  final String quote;
  final VoidCallback? onPressed;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              buildImage(),

              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.75),
                    ],
                  ),
                ),
              ),

              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Text(
                  quote,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage() {
    if (imageBytes != null) {
      return Image.memory(
        imageBytes!,
        fit: BoxFit.cover,
      );
    }

    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: BoxFit.cover,
        placeholder: (context, url) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        errorWidget: (context, url, error) {
          return const Icon(
            AssetPaths.not_supported,
          );
        },
      );
    }

    return Container(
      color: Colors.grey.shade300,
      child: const Icon(
        AssetPaths.image_outlined,
      ),
    );
  }
}