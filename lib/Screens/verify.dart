import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Verify extends StatelessWidget {
  const Verify({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: LottieBuilder.asset("Animation - 1711951385422.json"),
      ),
    );
  }
}