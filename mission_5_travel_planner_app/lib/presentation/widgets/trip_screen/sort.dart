import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/sort_provider.dart';

class TripSortDropdown extends ConsumerWidget {
  const TripSortDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSort = ref.watch(sortProvider);

    return DropdownButtonFormField<TripSort>(
      initialValue: currentSort,
      // selectedItemBuilder mengatur tampilan teks yang muncul di dalam kotak putih
      selectedItemBuilder: (BuildContext context) {
        return TripSort.values.map<Widget>((TripSort item) {
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
            'Sort',
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
      items: const [
        DropdownMenuItem(value: TripSort.newest, child: Text('Newest')),
        DropdownMenuItem(value: TripSort.oldest, child: Text('Oldest')),
      ],
      onChanged: (value) {
        if (value != null) ref.read(sortProvider.notifier).setSort(value);
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../providers/sort_provider.dart';

// class TripSortDropdown extends ConsumerWidget {
//   const TripSortDropdown({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final currentSort = ref.watch(sortProvider);

//     return DropdownButtonFormField<TripSort>(
//       initialValue: currentSort,
//       decoration: InputDecoration(
//         labelText: 'Sort',
//         filled: true,
//         fillColor: Colors.white,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//       items: const [
//         DropdownMenuItem(value: TripSort.newest, child: Text('Newest')),
//         DropdownMenuItem(value: TripSort.oldest, child: Text('Oldest')),
//       ],
//       onChanged: (value) {
//         if (value != null) {
//           ref.read(sortProvider.notifier).setSort(value);
//         }
//       },
//     );
//   }
// }
