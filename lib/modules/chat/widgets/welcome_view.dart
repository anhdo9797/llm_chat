import 'package:flutter/material.dart';
import 'package:llm_chat/core/constants/app_constants.dart';
import '../../../core/extensions/color_extension.dart';
import 'example_card.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;
    final spacing = context.spacing;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spacing * 3),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo and Title
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage(AppConstants.appLogo),
                  width: 40,
                  height: 40,
                ),
                SizedBox(width: spacing),
                Text(
                  AppConstants.appName,
                  style: textTheme.headlineMedium?.copyWith(
                    color: colors.textPrimary,
                  ),
                ),
              ],
            ),
            SizedBox(height: spacing * 5),

            // Examples Grid
            Wrap(
              spacing: spacing * 2.5,
              runSpacing: spacing * 2.5,
              alignment: WrapAlignment.center,
              children: [
                ExampleCard(
                  icon: Icons.chat_bubble_outline,
                  title: 'Examples',
                  examples: [
                    '"Explain quantum computing in simple terms"',
                    '"Got any creative ideas for a 10 year old\'s birthday?"',
                    '"How do I make an HTTP request in Javascript?"',
                  ],
                ),
                ExampleCard(
                  icon: Icons.star_outline,
                  title: 'Capabilities',
                  examples: [
                    'Remembers what user said earlier in the conversation',
                    'Allows user to provide follow-up corrections',
                    'Trained to decline inappropriate requests',
                  ],
                ),
                ExampleCard(
                  icon: Icons.warning_amber_outlined,
                  title: 'Limitations',
                  examples: [
                    'May occasionally generate incorrect information',
                    'May occasionally produce harmful instructions or biased content',
                    'Limited knowledge of world and events after 2021',
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
