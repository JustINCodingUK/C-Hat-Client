import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
          width: 100,
          height: 100,
          child: Image.asset("assets/images/c_hat_logo.png", fit: BoxFit.fill,)),
      );
  }
}