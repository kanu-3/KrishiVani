import 'package:Krishivani/core/constants/app_colors.dart';
import 'package:Krishivani/core/constants/assets_paths.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:Krishivani/core/widgets/common/app_header.dart';
import 'package:Krishivani/feature/profile/presentation/widgets/model_info_row.dart';
import 'package:Krishivani/feature/profile/presentation/widgets/model_language_item.dart';
import 'package:Krishivani/feature/profile/presentation/widgets/model_metric_row.dart';
import 'package:Krishivani/feature/profile/presentation/widgets/model_permission_tile.dart';
import 'package:Krishivani/feature/profile/presentation/widgets/model_settings_action_tile.dart';
import 'package:Krishivani/feature/profile/presentation/widgets/model_settings_header.dart';
import 'package:Krishivani/feature/profile/presentation/widgets/model_settings_section.dart';
import 'package:Krishivani/feature/profile/presentation/widgets/model_type_item.dart';
import 'package:flutter/material.dart';

class ModelSettingsScreen extends StatefulWidget {
  const ModelSettingsScreen({super.key});

  @override
  State<ModelSettingsScreen> createState() => ModelSettingsScreenState();
}

class ModelSettingsScreenState extends State<ModelSettingsScreen> {
  bool cameraEnabled = true;
  bool microphoneEnabled = true;
  bool locationEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: const AppHeader(
        title: 'Model Settings',
      ),
      body: Padding(
        padding: context.bodypad,
        child: SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ModelSettingsHeader(
                onChangeModel: () {},
              ),

              SizedBox(height: context.spacingL),

              ModelSettingsSection(
                title: 'Model Information',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ModelInfoRow(
                      label: 'Name',
                      value: 'Vanni AI',
                    ),

                    SizedBox(height: context.spacingS),

                    Text(
                      'Model type:',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(
                        color: AppColors.blacktext,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: context.spacingXS),

                    ModelTypeItem(
                      number: '1.',
                      text: 'Crop Diagnosis Model',
                    ),
                    ModelTypeItem(
                      number: '2.',
                      text: 'Market Prediction Model',
                    ),
                    ModelTypeItem(
                      number: '3.',
                      text: 'Chatbot',
                    ),
                  ],
                ),
              ),

              SizedBox(height: context.spacingL),

              ModelSettingsSection(
                title: 'Version Info',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ModelInfoRow(
                      label: 'Version',
                      value: '2.3.0',
                    ),
                    SizedBox(height: context.spacingXS),
                    ModelInfoRow(
                      label: 'Release date',
                      value: '03/04/2025',
                    ),
                  ],
                ),
              ),

              SizedBox(height: context.spacingL),

              ModelSettingsSection(
                title: 'Model Accuracy & Metrics',
                child: Column(
                  children: [
                    ModelMetricRow(
                      label: 'Confidence Level',
                      value: '92%',
                    ),
                    ModelMetricRow(
                      label: 'Last Trained',
                      value: '29/01/2025',
                    ),
                    ModelMetricRow(
                      label: 'Training Data Count',
                      value: '25K+ plant images',
                    ),
                    ModelMetricRow(
                      label: 'Feedback Accuracy',
                      value: '4.6 / 5 stars',
                    ),
                  ],
                ),
              ),

              SizedBox(height: context.spacingL),

              ModelSettingsSection(
                title: 'Permissions Management',
                child: Column(
                  children: [
                    ModelPermissionTile(
                      title: 'Allow Camera',
                      value: cameraEnabled,
                      onChanged: (value) {
                        setState(() {
                          cameraEnabled = value;
                        });
                      },
                    ),
                    ModelPermissionTile(
                      title: 'Allow Microphone',
                      value: microphoneEnabled,
                      onChanged: (value) {
                        setState(() {
                          microphoneEnabled = value;
                        });
                      },
                    ),
                    ModelPermissionTile(
                      title: 'Allow Location',
                      value: locationEnabled,
                      onChanged: (value) {
                        setState(() {
                          locationEnabled = value;
                        });
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: context.spacingL),

              ModelSettingsSection(
                title: 'Language Preferences',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ModelLanguageItem(title: 'English'),
                    ModelLanguageItem(title: 'Hindi'),

                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: context.spacingS,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Add more',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                  color: AppColors.blacktext,
                                ),
                              ),
                            ),
                            Icon(
                              AssetPaths.forward,
                              color: AppColors.blacktext,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: context.spacingL),

              ModelSettingsSection(
                title: 'Reset / Improve',
                child: Column(
                  children: [
                    ModelSettingsActionTile(
                      title: 'Reset to default settings',
                      onTap: () {},
                    ),
                    ModelSettingsActionTile(
                      title: 'Provide feedback',
                      onTap: () {},
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
}