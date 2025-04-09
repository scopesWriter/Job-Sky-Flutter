import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/profile_provider.dart';

class DistanceDropdown extends ConsumerWidget {
  const DistanceDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDistance = ref.watch(selectedDistanceProvider);
    print('selectedDistance: $selectedDistance');
    final distances = ['10 miles', '20 miles', '30 miles', '50 miles'];

    return DropdownButton<String>(
      dropdownColor: Colors.white,
      underline:  SizedBox(height: 0,),
      value: selectedDistance,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 2,
      style: const TextStyle(color: Colors.black, fontSize: 16),
      onChanged: (value) {
        ref.read(selectedDistanceProvider.notifier).state = value!;
      },
      items: distances.map((dist) {
        return DropdownMenuItem(
          value: dist,
          child: Text(dist),
        );
      }).toList(),
    );
  }
}