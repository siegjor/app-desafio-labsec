import 'package:flutter/material.dart';

class CardBox extends StatelessWidget {
  final Widget content;

  const CardBox(this.content);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16.0),
        height: 350,
        width: 400,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: content,
          ),
        ));
  }
}
