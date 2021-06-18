import 'package:flutter/material.dart';
import 'package:labsec_app/styles/custom_colors.dart';

class InfoText extends StatelessWidget {
  final String _textContent;

  const InfoText(this._textContent);

  @override
  Widget build(BuildContext context) {
    return Text(_textContent,
        style: TextStyle(
          fontSize: 18,
          color: myColors.primary,
          fontWeight: FontWeight.bold,
        ));
  }
}
