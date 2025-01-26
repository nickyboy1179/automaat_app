import 'package:flutter/material.dart';

class ConfirmButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color onColor;
  final void Function() onPressed;

  const ConfirmButton({
    super.key,
    required this.text,
    required this.color,
    required this.onColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll<Color>(color),
        fixedSize: const WidgetStatePropertyAll<Size>(Size(400,50)),
        shape: WidgetStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16))
        ),
        elevation: const WidgetStatePropertyAll<double>(4.0),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 22,
          color: onColor,
        ),
      ),
    );
  }
}
