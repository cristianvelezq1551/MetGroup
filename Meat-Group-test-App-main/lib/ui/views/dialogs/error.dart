import 'package:flutter/material.dart';

void uiErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) => _ErrorDialog(message: message),
  );
}

class _ErrorDialog extends StatelessWidget {
  const _ErrorDialog({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Ok'),
        ),
      ],
    );
  }
}
