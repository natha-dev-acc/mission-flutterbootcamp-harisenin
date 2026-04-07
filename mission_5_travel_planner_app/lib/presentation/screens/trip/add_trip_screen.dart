import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/styles/app_spacing.dart';
import '../../providers/trip_provider.dart';
// import '../../../data/models/trip_model.dart';
import '../../widgets/trip_screen/form.dart';

class AddTripScreen extends ConsumerWidget {
  const AddTripScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Trip'),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: TripForm(
          submitLabel: 'Save Trip',

          // ================= SAVE =================
          onSubmit: (trip) async {
            await ref.read(tripProvider.notifier).addTrip(trip);

            if (context.mounted) {
              Navigator.pop(context);
            }
          },
        ),
      ),
    );
  }
}