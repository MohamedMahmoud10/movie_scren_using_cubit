import 'package:flutter/material.dart';

class CharacterDivider extends StatelessWidget {
  final double endIndent;

  const CharacterDivider({Key? key, required this.endIndent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.yellow,
      height: 30,
      endIndent: endIndent,
      thickness: 2,
    );
  }
}
