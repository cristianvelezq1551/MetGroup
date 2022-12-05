import 'package:flutter/material.dart';

///The error view.
///[message] is the error message.
///[onRetry] is the callback when the user taps the retry button.
class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.message, this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ///The error message.
            Text(message),
            const SizedBox(height: 16),

            ///The retry button.
            ElevatedButton(
                onPressed: onRetry,
                child: Text('Reintentar',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        ?.copyWith(color: Colors.white))),
          ],
        ),
      ),
    );
  }
}
