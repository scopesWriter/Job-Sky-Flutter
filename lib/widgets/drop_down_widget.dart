import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/profile_provider.dart';

class DistanceDropdown extends ConsumerWidget {
  const DistanceDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDistance = ref.watch(selectedDistanceProvider);
    var selectedDistancetoString = '10 miles';
    final distances = ['10 miles', '20 miles', '30 miles', '50 miles'];
   setDistance(selectedDistance);
    print('selectedDistance: $selectedDistance');


    return DropdownButton<String>(
      dropdownColor: Colors.white,
      underline:  SizedBox(height: 0,),
      value: selectedDistancetoString,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 2,
      style: const TextStyle(color: Colors.black, fontSize: 16),
      onChanged: (value) {
        ref.read(selectedDistanceProvider.notifier).state = getDistance(value!);
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

double getDistance(String value) {
  switch (value) {
    case '10 miles':
      return 10;
    case '20 miles':
      return 20;
    case '30 miles':
      return 30;
    case '50 miles':
      return 50;
    default:
      return 10;
  }
}

String setDistance(double distance) {
  switch (distance) {
    case 10:
      return '10 miles';
    case 20:
      return '20 miles';
    case 30:
      return '30 miles';
    case 50:
      return '50 miles';
    default:
      return '10 miles';
  }
}