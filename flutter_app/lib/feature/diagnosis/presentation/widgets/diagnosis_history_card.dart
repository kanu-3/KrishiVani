import 'package:Krishivani/core/constants/assets_paths.dart';
import 'package:Krishivani/feature/diagnosis/data/models/diagnosis_history_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';

class DiagnosisHistoryCard extends StatelessWidget {
  const DiagnosisHistoryCard({
    super.key,
    required this.diagnosis,
    this.onPressed,
  });

  final DiagnosisHistoryModel diagnosis;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:context.padAllXS,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: context.borderRadiusM,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: context.scaleH(130),
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: diagnosis.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return const Center(
                      child: Icon(
                        AssetPaths.imagebroken,
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: context.padAllXS,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      diagnosis.plantName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    // SizedBox(height: context.spacingXXS),

                    Text(
                      diagnosis.diseaseName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium,
                    ),

                    // SizedBox(height: context.spacingXXS),

                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Confidence',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall,
                          ),
                        ),
                        Text(
                          '${diagnosis.confidencePercentage.toStringAsFixed(2)}%',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    // SizedBox(height: context.spacingXXS),

                    Text(
                      formatDate(diagnosis.createdAt),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatDate(DateTime date) {
    final localDate = date.toLocal();

    return '${localDate.day.toString().padLeft(2, '0')}/'
        '${localDate.month.toString().padLeft(2, '0')}/'
        '${localDate.year}';
  }
}