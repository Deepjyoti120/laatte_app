import 'package:flutter/material.dart';

class MaterialIconButton extends StatelessWidget {
  const MaterialIconButton({
    super.key,
    required this.icon,
    this.color,
    this.onPressed,   this.size,
  });
  final Widget icon;
  final Color? color;
  final Function()? onPressed;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(60),
      color: color,
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: size??40,
        height:size?? 40,
        child: IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: onPressed, icon: icon),
      ),
    );
  }
}
