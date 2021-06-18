import 'package:flutter/material.dart';
import 'package:labsec_app/styles/custom_colors.dart';

class GoBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.pop(context),
      child: Text('Voltar'),
      style: ElevatedButton.styleFrom(
        side: BorderSide(color: myColors.error, width: 1.5),
        onPrimary: myColors.error,
      ),
    );
  }
}
