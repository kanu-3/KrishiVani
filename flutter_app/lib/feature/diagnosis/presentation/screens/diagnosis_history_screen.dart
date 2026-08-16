import 'package:Krishivani/core/widgets/common/app_header.dart';
import 'package:Krishivani/feature/diagnosis/presentation/widgets/diagnosis_history_card.dart';
import 'package:Krishivani/feature/diagnosis/providers/diagnosis_history_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiagnosisHistoryScreen extends ConsumerStatefulWidget {
  const DiagnosisHistoryScreen({
    super.key,
  });

  @override
  ConsumerState<DiagnosisHistoryScreen> createState() =>
      DiagnosisHistoryScreenState();
}

class DiagnosisHistoryScreenState
    extends ConsumerState<DiagnosisHistoryScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(
          () {
        ref
            .read(diagnosisHistoryProvider.notifier)
            .loadHistory();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(
      diagnosisHistoryProvider,
    );

    return Scaffold(
      appBar: const AppHeader(
        title: 'Diagnosis History',
      ),
      body: state.isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : state.error != null
          ? Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            state.error!,
            textAlign: TextAlign.center,
          ),
        ),
      )
          : state.diagnoses.isEmpty
          ? const Center(
        child: Text(
          'No diagnosis history yet.',
        ),
      )
          : RefreshIndicator(
        onRefresh: () {
          return ref
              .read(
            diagnosisHistoryProvider
                .notifier,
          )
              .refresh();
        },
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: state.diagnoses.length,
          itemBuilder: (context, index) {
            return DiagnosisHistoryCard(
              diagnosis: state.diagnoses[index],
            );
          },
        ),
      ),
    );
  }
}