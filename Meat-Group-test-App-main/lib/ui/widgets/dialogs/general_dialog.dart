import 'package:flutter/material.dart';

///The class that contains the alert dialog widget for the application.
///[uiSuccessDialog] is the success dialog widget.
///[uiErrorDialog] is the error dialog widget.
///[uiInfoDialog] is the info dialog widget.
abstract class AppDialogs {
  ///?Success dialog
  static void uiSuccessDialog(BuildContext context,
          {required String title, required String message}) =>
      showDialog(
        context: context,
        builder: (context) => _SuccessDialog(title: title, message: message),
      );

  ///?Error dialog
  static void uiErrorDialog(BuildContext context, {required String message}) =>
      showDialog(
        context: context,
        builder: (context) => _ErrorDialog(message: message),
      );

  ///?Info dialog
  static void uiInfoDialog(BuildContext context, {required String message}) =>
      showDialog(
        context: context,
        builder: (context) => _InfoDialog(message: message),
      );
}

///Widget of success dialog
class _SuccessDialog extends StatelessWidget {
  const _SuccessDialog({super.key, required this.title, required this.message});

  final String title, message;

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text('Ok'),
          ),
        ],
      );
}

///Widget of error dialog
class _ErrorDialog extends StatelessWidget {
  const _ErrorDialog({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text('Algo salió mal'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text('Ok'),
          ),
        ],
      );
}

///Widget of info dialog
class _InfoDialog extends StatelessWidget {
  const _InfoDialog({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text('Información'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text('Ok'),
          ),
        ],
      );
}
