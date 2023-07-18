import 'package:flutter/material.dart';
import 'package:soar_mobile/resources/color_manager.dart';
import 'package:soar_mobile/resources/styles_manager.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  final void Function()? onPressed;
  final String label;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        // minimumSize: Size(1.sw, 50.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        label,
        style: getMediumStyle(
          color: ColorManager.white,
          fontSize: 17.0,
        ),
      ),
    );
  }
}
