import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/common/view_models/common_config_vm.dart';
import 'package:tiktok/constants/sizes.dart';

class FormButton extends ConsumerWidget {
  final bool disabled;
  final String text;

  const FormButton({super.key, required this.disabled, this.text = "Next"});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: Sizes.size16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.size5),
            color: disabled
                ? ref.watch(commonConfigProvider).darkMode
                    ? Colors.grey.shade800
                    : Colors.grey.shade200
                : Theme.of(context).primaryColor),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: TextStyle(
            color: disabled ? Colors.grey.shade500 : Colors.white,
            fontWeight: FontWeight.w600,
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
