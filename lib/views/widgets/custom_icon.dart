import 'package:flutter/material.dart';


class CustomIcon extends StatelessWidget {
  final IconData icon;
  EdgeInsets margin;
  CustomIcon({super.key,required this.icon,this.margin=const EdgeInsets.only(right: 10),this.onPressed});
  VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin,
    decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(12),
    ),
      child: IconButton(onPressed: onPressed, icon:Icon(icon,color: Colors.white),)
    );
  }
}
