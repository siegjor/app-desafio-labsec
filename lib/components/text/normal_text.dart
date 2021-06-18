import 'package:flutter/material.dart';

class NormalText extends StatelessWidget {
  final String _textContent;

  const NormalText(this._textContent);

  @override
  Widget build(BuildContext context) {
    return Text(_textContent,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ));
  }
}
