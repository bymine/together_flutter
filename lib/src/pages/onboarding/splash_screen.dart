import 'package:flutter/material.dart';
import 'package:together_flutter/src/constants/color_constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: background,
      body: Center(
        child: Text(
          "Together",
          style: TextStyle(fontSize: 48, fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}
