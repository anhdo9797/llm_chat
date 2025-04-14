import 'package:flutter/material.dart';
import '../../../core/extensions/color_extension.dart';
import 'icon_button_with_hover.dart';

class ChatInput extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSend;
  final bool isLoading;

  const ChatInput({
    super.key,
    this.controller,
    this.onChanged,
    this.onSend,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;
    final spacing = context.spacing;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: spacing * 3,
        vertical: spacing * 2,
      ),
      decoration: BoxDecoration(
        color: colors.background1,
        boxShadow: [
          BoxShadow(
            color: colors.textPrimary.withOpacity(0.05),
            blurRadius: spacing,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Container(
        height: 56,
        padding: EdgeInsets.symmetric(horizontal: spacing),
        decoration: BoxDecoration(
          color: colors.background2,
          borderRadius: context.radius,
        ),
        child: Row(
          children: [
            // Mic button
            IconButtonWithHover(
              icon: Icon(Icons.mic_none_outlined, size: 20),
              onPressed: () {},
            ),

            // Image button
            IconButtonWithHover(
              icon: Icon(Icons.image_outlined, size: 20),
              onPressed: () {},
            ),

            // Input area
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                style: textTheme.bodyMedium,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: 'Type input...',
                  hintStyle: textTheme.bodyMedium?.copyWith(
                    color: colors.textSecondary,
                  ),
                  hoverColor: Colors.transparent,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: spacing * 2),
                ),
              ),
            ),

            // Send button
            IconButtonWithHover(
              icon:
                  isLoading
                      ? SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            colors.textPrimary,
                          ),
                        ),
                      )
                      : Icon(Icons.send, size: 20, color: colors.textPrimary),
              onPressed: onSend,
            ),
          ],
        ),
      ),
    );
  }
}
