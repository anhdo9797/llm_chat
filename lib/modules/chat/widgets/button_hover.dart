import 'package:flutter/material.dart';
import '../../../core/extensions/color_extension.dart';

class ButtonWithHover extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final ButtonStyle? style;

  const ButtonWithHover({
    super.key,
    required this.child,
    this.onPressed,
    this.style,
  });

  @override
  State<ButtonWithHover> createState() => _ButtonWithHoverState();
}

class _ButtonWithHoverState extends State<ButtonWithHover> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: widget.style?.copyWith(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (isHovered) {
              return colors.buttonSecondary;
            }
            return null;
          }),
        ),
        child: widget.child,
      ),
    );
  }
}
