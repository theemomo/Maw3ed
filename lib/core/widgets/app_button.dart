import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const AppButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        minimumSize: Size(double.infinity, size.height * 0.06),
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }
}
