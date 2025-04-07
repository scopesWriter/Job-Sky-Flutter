import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme/app_colors.dart';

class CustomSwitch extends ConsumerWidget {
  const CustomSwitch({
    super.key,
    required this.switchValue,
    required this.provider,
  });

  final bool switchValue;
  final StateProvider provider;


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Switch(
      activeTrackColor: AppColors.authButtonColor,
      inactiveTrackColor: AppColors.textFieldBackgroundColor,
      inactiveThumbColor: Colors.grey,
      trackOutlineColor: WidgetStatePropertyAll(
        Colors.transparent,
      ),
      value: switchValue,
      onChanged: (switchValue) {
        ref.read(provider.notifier).state =
            switchValue;
      },
    );
  }
}
