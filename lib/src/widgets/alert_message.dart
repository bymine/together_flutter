import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:together_flutter/src/constants/color_constants.dart';

class AlertMessage extends StatelessWidget {
  final String message;
  const AlertMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(message),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          child: const Text(
            "확인",
            style: TextStyle(color: subColor),
          ),
          onPressed: () => Get.back(),
        ),
      ],
    );
  }
}
