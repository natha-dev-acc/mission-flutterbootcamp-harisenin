import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/filter_provider.dart';

class TripFilterDropdown extends ConsumerWidget {
  const TripFilterDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFilter = ref.watch(filterProvider);

    return DropdownButtonFormField<TripFilter>(
      initialValue: currentFilter,
      // selectedItemBuilder mengatur tampilan teks yang muncul di dalam kotak putih
      selectedItemBuilder: (BuildContext context) {
        return TripFilter.values.map<Widget>((TripFilter item) {
          return Text(
            item.name[0].toUpperCase() + item.name.substring(1),
            style: const TextStyle(color: Colors.black), // Paksa hitam hanya di sini
          );
        }).toList();
      },
      decoration: InputDecoration(
        label: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text(
            'Filter',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      // Items tetap default agar saat diklik warnanya mengikuti tema (Putih di Dark Mode)
      items: const [
        DropdownMenuItem(value: TripFilter.all, child: Text('All')),
        DropdownMenuItem(value: TripFilter.upcoming, child: Text('Upcoming')),
        DropdownMenuItem(value: TripFilter.ongoing, child: Text('Ongoing')),
        DropdownMenuItem(value: TripFilter.completed, child: Text('Completed')),
      ],
      onChanged: (value) {
        if (value != null) ref.read(filterProvider.notifier).setFilter(value);
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../providers/filter_provider.dart';

// class TripFilterDropdown extends ConsumerWidget {
//   const TripFilterDropdown({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final currentFilter = ref.watch(filterProvider);

//     return DropdownButtonFormField<TripFilter>(
//       initialValue: currentFilter,
//       decoration: InputDecoration(
//         labelText: 'Filter',
//         filled: true,
//         fillColor: Colors.white,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//       items: const [
//         DropdownMenuItem(value: TripFilter.all, child: Text('All')),
//         DropdownMenuItem(value: TripFilter.upcoming, child: Text('Upcoming')),
//         DropdownMenuItem(value: TripFilter.ongoing, child: Text('Ongoing')),
//         DropdownMenuItem(value: TripFilter.completed, child: Text('Completed')),
//       ],
//       onChanged: (value) {
//         if (value != null) {
//           ref.read(filterProvider.notifier).setFilter(value);
//         }
//       },
//     );
//   }
// }
