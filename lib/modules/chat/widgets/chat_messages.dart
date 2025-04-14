import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../../core/extensions/color_extension.dart';
import '../../../data/models/message_history_model.dart';
import 'type_loading_indicator.dart';

class ChatMessages extends StatefulWidget {
  final List<MessageHistoryModel> messages;
  final VoidCallback onNewMessage;

  const ChatMessages({
    super.key,
    required this.messages,
    required this.onNewMessage,
  });

  @override
  State<ChatMessages> createState() => ChatMessagesState();
}

class ChatMessagesState extends State<ChatMessages> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToBottom();
      widget.onNewMessage();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ChatMessages oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.messages.length > oldWidget.messages.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) => scrollToBottom());
    }
  }

  void scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Widget _buildMessageBubble(
    BuildContext context, {
    required String content,
    required bool isUser,
    required bool isTyping,
    required ColorScheme colors,
    required TextTheme textTheme,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.6,
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isUser ? colors.messageBubbleUser : colors.messageBubbleBot,
          borderRadius: BorderRadius.circular(12),
        ),
        child:
            isTyping
                ? const TypeLoadingIndicator()
                : isUser
                ? Text(content, style: textTheme.bodyLarge)
                : AnimatedSize(
                  duration: const Duration(milliseconds: 100),
                  child: MarkdownBody(
                    data: content,
                    styleSheet: MarkdownStyleSheet(
                      p: textTheme.bodyLarge,
                      code: textTheme.bodyLarge?.copyWith(
                        fontFamily: 'monospace',
                        backgroundColor: colors.background.withOpacity(0.3),
                      ),
                      blockquote: textTheme.bodyLarge?.copyWith(
                        color: colors.textSecondary,
                        fontStyle: FontStyle.italic,
                      ),
                      h1: textTheme.headlineMedium,
                      h2: textTheme.headlineSmall,
                      h3: textTheme.titleLarge,
                      h4: textTheme.titleMedium,
                      h5: textTheme.titleSmall,
                      h6: textTheme.titleSmall,
                    ),
                  ),
                ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(20),
      itemCount: widget.messages.length,
      itemBuilder: (context, index) {
        final message = widget.messages[index];
        final isUser = message.query.isNotEmpty;
        final content = isUser ? message.query : message.answer;
        final isTyping = !isUser && content.isEmpty;

        return Align(
          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
          child:
              isUser
                  ? _buildMessageBubble(
                    context,
                    content: content,
                    isUser: isUser,
                    isTyping: isTyping,
                    colors: colors,
                    textTheme: textTheme,
                  )
                  : Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: colors.background,
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Image.asset('assets/images/logo.png'),
                          ),
                        ),
                      ),
                      _buildMessageBubble(
                        context,
                        content: content,
                        isUser: isUser,
                        isTyping: isTyping,
                        colors: colors,
                        textTheme: textTheme,
                      ),
                    ],
                  ),
        );
      },
    );
  }
}
