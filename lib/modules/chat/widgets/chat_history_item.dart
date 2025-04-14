import 'package:flutter/material.dart';
import '../../../core/extensions/color_extension.dart';

class ChatHistoryItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const ChatHistoryItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      onTap: onTap,
      dense: true,
      selected: isSelected,
      selectedTileColor: colors.buttonSecondary,
      hoverColor: colors.hoverLight,
      shape: RoundedRectangleBorder(borderRadius: context.radiusS),
      leading: Icon(
        Icons.chat_bubble_outline,
        size: 20,
        color: colors.textPrimary,
      ),
      title: Text(
        title,
        style: textTheme.bodyMedium?.copyWith(color: colors.textPrimary),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
