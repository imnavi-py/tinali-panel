import 'package:flutter/material.dart';

class bottombutton extends StatelessWidget {
  bottombutton(
      {super.key, required this.onpress, required this.txt, this.btstyle});
  final Function() onpress;
  final Text txt;
  ButtonStyle? btstyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: onpress,
        style: btstyle,
        child: txt,
      ),
    );
  }
}
