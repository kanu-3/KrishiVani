import 'package:Krishivani/app/router/route_paths.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:Krishivani/feature/diagnosis/presentation/widgets/diagnosis_history_card.dart';
import 'package:Krishivani/feature/diagnosis/providers/diagnosis_history_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget buildDiagnosisHistory(
    BuildContext context,
    DiagnosisHistoryState state,
    ) {
  if (state.isLoading) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  if (state.diagnoses.isEmpty) {
    return const SizedBox.shrink();
  }

  final diagnoses = state.diagnoses.take(5).toList();

  return SizedBox(
    height: context.scaleH(360),
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: diagnoses.length,
      separatorBuilder: (context, index) {
        return SizedBox(
          width: context.spacingM,
        );
      },
      itemBuilder: (context, index) {
        return DiagnosisHistoryCard(
          diagnosis: diagnoses[index],
          onPressed: () {
            context.go(RoutePaths.history);
          },
        );
      },
    ),
  );
}