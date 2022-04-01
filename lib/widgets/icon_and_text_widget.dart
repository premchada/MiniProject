import 'package:flutter/material.dart';

class IconAndTextWidget extends StatefulWidget {
  final IconData icon;
  final String text;
  final Color color;
  final Color iconColor;
  const IconAndTextWidget({Key? key,
    required this.icon,
    required this.color,
    required this.iconColor,
    required this.text,}) : super(key: key);

  @override
  State<IconAndTextWidget> createState() => _IconAndTextWidgetState();
}

class _IconAndTextWidgetState extends State<IconAndTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //Icon(icon, color: iconColor,),

      ],
    );
  }
}
