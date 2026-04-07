import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../styles/app_spacing.dart';
import '../../providers/trip_provider.dart';
import '../../../data/models/trip_model.dart';
import '../../widgets/trip_screen/form.dart';

class EditTripScreen extends ConsumerWidget {
  final TripModel trip;

  const EditTripScreen({super.key, required this.trip});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Trip'),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: TripForm(
          initialData: trip,
          submitLabel: 'Update Trip',

          // ================= UPDATE =================
          onSubmit: (updatedTrip) async {
            await ref.read(tripProvider.notifier).updateTrip(updatedTrip);

            if (context.mounted) {
              Navigator.pop(context);
            }
          },
        ),
      ),
    );
  }
}