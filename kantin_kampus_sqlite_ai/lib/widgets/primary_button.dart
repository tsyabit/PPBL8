
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String teks;
  final VoidCallback onPressed;
  final IconData? ikon;
  final bool penuh;

  const PrimaryButton({
    super.key,
    required this.teks,
    required this.onPressed,
    this.ikon,
    this.penuh = true,
  });

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton.icon(
      onPressed: onPressed,
      icon: ikon != null ? Icon(ikon) : const SizedBox.shrink(),
      label: Text(
        teks,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );

    if (penuh) {
      return SizedBox(
        width: double.infinity,
        child: button,
      );
    }

    return button;
  }
}
