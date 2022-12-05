import 'package:flutter/material.dart';

class GeneralInput extends StatelessWidget {
  const GeneralInput(
      {super.key,
      required this.controller,
      this.validator,
      required this.label});

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        label: Text(label),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
