import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class GeneralButton extends StatelessWidget {
  const GeneralButton(
      {super.key,
      this.textColor = UIColors.black,
      required this.text,
      this.onPressed,
      this.isLoading = false});

  ///The text color of the button.
  final Color textColor;

  ///The text of the button.
  final String text;

  ///The function that will be executed when the button is pressed.
  final VoidCallback? onPressed;

  ///The boolean that indicates if the button is loading.
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? () {} : onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(100, 50),
        shape: const StadiumBorder(),
      ),
      child: isLoading
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            )
          : Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .button
                  ?.copyWith(color: textColor),
            ),
    );
  }
}
