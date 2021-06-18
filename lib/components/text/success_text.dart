import 'package:flutter/material.dart';
import 'package:labsec_app/styles/custom_colors.dart';

class SuccessText extends StatelessWidget {
  final String _textContent;

  const SuccessText(this._textContent);

  @override
  Widget build(BuildContext context) {
    return Text(_textContent,
        style: TextStyle(
          fontSize: 18,
          color: myColors.success,
          fontWeight: FontWeight.bold,
        ));
  }
}
