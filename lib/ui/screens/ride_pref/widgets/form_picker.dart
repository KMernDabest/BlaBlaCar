import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

Widget formPicker({
  required IconData icon,
  bool showSwapIcon = false,
  required String label,
  String? value,
  required VoidCallback onTap,
  VoidCallback? onSwap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: BlaSpacings.m, vertical: BlaSpacings.m,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: value != null
                ? BlaColors.neutralDark
                : BlaColors.neutralLight,
            size: 24,
          ),
          SizedBox(width: BlaSpacings.m),
          Expanded(
            child: Text(
              value ?? label,
              style: BlaTextStyles.body.copyWith(
                color: value != null
                    ? BlaColors.neutralDark
                    : BlaColors.neutralLight,
              ),
            ),
          ),
          if (showSwapIcon)
            GestureDetector(
              onTap: onSwap,
              child: Icon(Icons.swap_vert, color: BlaColors.primary, size: 24),
            ),
        ],
      ),
    ),
  );
}