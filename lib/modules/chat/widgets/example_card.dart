import 'package:flutter/material.dart';
import '../../../core/extensions/color_extension.dart';

class ExampleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<String> examples;

  const ExampleCard({
    super.key,
    required this.icon,
    required this.title,
    required this.examples,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;
    final spacing = context.spacing;

    return Container(
      width: 280,
      padding: EdgeInsets.all(spacing * 2),
      decoration: BoxDecoration(
        color: colors.background2,
        borderRadius: context.radius,
        border: Border.all(color: colors.divider),
      ),
      child: Column(
        children: [
          Icon(icon, size: 30, color: colors.textPrimary),
          SizedBox(height: spacing),
          Text(
            title,
            style: textTheme.titleMedium?.copyWith(color: colors.textPrimary),
          ),
          SizedBox(height: spacing * 2),
          ...examples.map(
            (example) => Padding(
              padding: EdgeInsets.only(bottom: spacing),
              child: Text(
                example,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  color: colors.textSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
