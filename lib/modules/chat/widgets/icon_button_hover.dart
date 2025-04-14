import 'package:flutter/material.dart';
import '../../../core/extensions/color_extension.dart';

class IconButtonWithHover extends StatefulWidget {
  final Widget icon;
  final VoidCallback? onPressed;
  final Color? color;

  const IconButtonWithHover({
    super.key,
    required this.icon,
    this.onPressed,
    this.color,
  });

  @override
  State<IconButtonWithHover> createState() => _IconButtonWithHoverState();
}

class _IconButtonWithHoverState extends State<IconButtonWithHover> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: IconButton(
        icon: widget.icon,
        onPressed: widget.onPressed,
        color: widget.color ?? colors.textPrimary,
        visualDensity: VisualDensity.compact,
        style: IconButton.styleFrom(
          backgroundColor: isHovered ? colors.hoverLight : null,
        ),
      ),
    );
  }
}
