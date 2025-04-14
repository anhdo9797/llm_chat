import 'package:flutter/material.dart';
import '../../../core/extensions/color_extension.dart';

class ChatMessages extends StatefulWidget {
  final List<String> messages;
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
        final isUser = message.startsWith('User:');

        return Align(
          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color:
                  isUser ? colors.messageBubbleUser : colors.messageBubbleBot,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              message.substring(message.indexOf(':') + 2),
              style: textTheme.bodyLarge,
            ),
          ),
        );
      },
    );
  }
}
