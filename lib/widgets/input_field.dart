import 'package:flutter/material.dart';
import 'package:function_printer/theme/text_theme.dart';

class InputField extends StatelessWidget {
  final Widget leading;
  final String hintText;
  final Function onChanged;
  final TextInputType inputType;

  InputField({
    this.leading = const SizedBox(),
    this.onChanged,
    this.hintText,
    this.inputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 7.5,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Row(
        children: <Widget>[
          leading,
          Flexible(
            child: TextField(
              style: inputTextStyle,
              keyboardType: inputType,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                hintText: hintText,
                isDense: true,
              ),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
