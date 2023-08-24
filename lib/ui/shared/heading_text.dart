import 'package:flutter/material.dart';

class HeadingText extends StatelessWidget {

  final String text;

  const HeadingText(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w900,
        color: Theme.of(context).colorScheme.primary,
        fontSize: 32
      )
    );
  }
}