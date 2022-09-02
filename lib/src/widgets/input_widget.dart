import 'package:flutter/material.dart';
import 'package:together_flutter/src/constants/color_constants.dart';

class InputWidget extends StatelessWidget {
  const InputWidget(
      {Key? key,
      this.hintText,
      this.textEditingController,
      this.title,
      this.suffix,
      this.obscureText = false,
      this.inputType,
      this.mode,
      this.button,
      this.validator,
      this.readOnly = false,
      this.onEditingComplete,
      this.focusNode})
      : super(key: key);
  final TextEditingController? textEditingController;
  final String? hintText;
  final String? title;
  final Widget? suffix;
  final bool? obscureText;
  final bool? readOnly;
  final String? Function(String?)? validator;
  final AutovalidateMode? mode;
  final TextInputType? inputType;
  final Widget? button;
  final void Function()? onEditingComplete;
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: textEditingController,
                keyboardType: inputType,
                autovalidateMode: mode,
                readOnly: readOnly!,
                validator: validator,
                obscureText: obscureText!,
                cursorColor: subColor,
                textInputAction: TextInputAction.done,
                onEditingComplete: onEditingComplete,
                focusNode: focusNode,
                decoration: InputDecoration(
                  hintStyle: const TextStyle(color: borderColor, fontSize: 12),
                  hintText: hintText,
                  suffixIcon: suffix,
                  border: const UnderlineInputBorder(
                      borderSide: BorderSide(color: borderColor)),
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: borderColor)),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: borderColor)),
                ),
              ),
            ),
            if (button != null) button!
          ],
        ),
      ],
    );
  }
}
