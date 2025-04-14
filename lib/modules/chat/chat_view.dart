import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/extensions/color_extension.dart';
import 'chat_controller.dart';
import 'widgets/button_with_hover.dart';
import 'widgets/chat_history_item.dart';
import 'widgets/chat_input.dart';
import 'widgets/chat_messages.dart';
import 'widgets/icon_button_with_hover.dart';
import 'widgets/sidebar_option.dart';
import 'widgets/welcome_view.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final controller = Get.find<ChatController>();
  final ScrollController _mainScrollController = ScrollController();
  final ScrollController _sidebarScrollController = ScrollController();
  final GlobalKey<ChatMessagesState> _chatKey = GlobalKey();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _mainScrollController.dispose();
    _sidebarScrollController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    _chatKey.currentState?.scrollToBottom();
  }

  Widget _buildSidebar(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: colors.background.withOpacity(0.7), // Nhạt hơn 30%
        border: Border(right: BorderSide(color: colors.divider)),
      ),
      child: Column(
        children: [
          Padding(
            padding: context.padding,
            child: ButtonWithHover(
              onPressed: () => controller.newChat(),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.buttonPrimary,
                padding: context.padding,
                shape: RoundedRectangleBorder(borderRadius: context.radiusS),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: Colors.white),
                  SizedBox(width: context.spacing),
                  Text(
                    'New chat',
                    style: textTheme.labelLarge?.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),

          // Chat History
          Expanded(
            child: Obx(
              () => ListView.builder(
                controller: _sidebarScrollController,
                padding: EdgeInsets.symmetric(horizontal: context.spacing),
                itemCount: controller.chatHistory.length,
                itemBuilder: (context, index) {
                  final chat = controller.chatHistory[index];
                  return ChatHistoryItem(
                    title: chat,
                    isSelected: index == controller.selectedChatIndex.value,
                    onTap: () => controller.selectChat(index),
                  );
                },
              ),
            ),
          ),

          // Bottom Options
          Container(
            padding: context.padding,
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: colors.divider)),
            ),
            child: Column(
              children: [
                SidebarOption(
                  icon: Icons.delete_outline,
                  label: 'Clear conversations',
                  onTap: () => controller.clearConversations(),
                ),
                SidebarOption(
                  icon: Icons.light_mode_outlined,
                  label: 'Light mode',
                  onTap: () => Get.changeThemeMode(ThemeMode.light),
                ),
                SidebarOption(
                  icon: Icons.person_outline,
                  label: 'My account',
                  onTap: () {},
                ),
                SidebarOption(
                  icon: Icons.help_outline,
                  label: 'Updates & FAQ',
                  onTap: () {},
                ),
                SidebarOption(
                  icon: Icons.logout,
                  label: 'Log out',
                  onTap: () => controller.logout(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final bool isMobile = context.isMobile;

    return Scaffold(
      backgroundColor: colors.surface,
      drawer:
          isMobile
              ? Drawer(
                backgroundColor: colors.surface.withValues(alpha: 1),
                child: _buildSidebar(context),
              )
              : null,
      appBar:
          isMobile
              ? AppBar(
                title: Text(
                  'Chat',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                centerTitle: true,
              )
              : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!isMobile) _buildSidebar(context),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Obx(
                    () =>
                        controller.messages.isEmpty
                            ? const WelcomeView()
                            : ChatMessages(
                              key: _chatKey,
                              messages: controller.messages,
                              onNewMessage: _scrollToBottom,
                            ),
                  ),
                ),
                ChatInput(
                  controller: _messageController,
                  onChanged: (text) => controller.messageText.value = text,
                  onSend: () {
                    controller.sendMessage(_messageController.text);
                    _messageController.clear();
                  },
                  isLoading: controller.isLoading,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
