import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController fieldController;
  final FocusNode fieldFocusNode;
  final Function(String)? onFieldSubmitted;
  final String hint;
  final String label;
  final FormFieldValidator<String>? validator;

  TextFieldWidget({
    super.key,
    required this.fieldController,
    required this.onFieldSubmitted,
    required this.hint,
    required this.label,
    required this.validator, required this.fieldFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: fieldController,
      validator: validator,
      focusNode: fieldFocusNode,
      onFieldSubmitted: onFieldSubmitted,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hint: Text(
          hint,
          style: Theme.of(
            context,
          ).textTheme.titleSmall!.copyWith(color: Colors.grey),
        ),
        label: Text(label, style: Theme.of(context).textTheme.titleSmall),
        filled: true,
        // fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
