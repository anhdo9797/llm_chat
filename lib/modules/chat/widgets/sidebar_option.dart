import 'package:flutter/material.dart';
import '../../../core/extensions/color_extension.dart';

class SidebarOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const SidebarOption({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      onTap: onTap,
      leading: Icon(icon, size: 20, color: colors.textPrimary),
      title: Text(
        label,
        style: textTheme.bodyMedium?.copyWith(color: colors.textPrimary),
      ),
      dense: true,
      visualDensity: VisualDensity.compact,
      hoverColor: colors.hoverLight,
      shape: RoundedRectangleBorder(borderRadius: context.radiusS),
    );
  }
}
