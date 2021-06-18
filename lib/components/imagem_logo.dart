import 'package:flutter/material.dart';

class ImagemLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 60, top: 20, right: 60, bottom: 0),
      child: Container(
        padding: EdgeInsets.only(left: 40, right: 40),
        child: Image.asset('assets/logo.png'),
      ),
    );
  }
}
