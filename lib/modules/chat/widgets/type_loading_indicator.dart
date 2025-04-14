import 'package:flutter/material.dart';
import '../../../core/extensions/color_extension.dart';

/// Loading indicator hiển thị dạng typing animation
class TypeLoadingIndicator extends StatefulWidget {
  const TypeLoadingIndicator({super.key});

  @override
  State<TypeLoadingIndicator> createState() => _TypeLoadingIndicatorState();
}

class _TypeLoadingIndicatorState extends State<TypeLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            final delay = index * 0.2;
            final progress = (_controller.value - delay).clamp(0.0, 0.6) / 0.6;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Transform.translate(
                offset: Offset(0, -3 * progress),
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: colors.textPrimary.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
