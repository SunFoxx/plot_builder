import 'package:flutter/material.dart';
import 'package:function_printer/theme/text_theme.dart';

class RadioButton extends StatelessWidget {
  final value;
  final groupValue;
  final Function onChanged;
  final String label;

  RadioButton({
    @required this.value,
    @required this.groupValue,
    @required this.onChanged,
    this.label = "",
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(value);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        decoration: BoxDecoration(
          color:
              value == groupValue ? Colors.white : Colors.grey.withOpacity(0.7),
        ),
        child: Center(
          child: Text(
            label,
            style: buttonTextStyle.copyWith(
              color: value == groupValue ? Colors.black87 : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
