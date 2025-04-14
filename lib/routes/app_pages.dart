import 'package:get/get.dart';
import '../modules/chat/chat_binding.dart';
import '../modules/chat/chat_view.dart';
import 'app_routes.dart';

abstract class AppPages {
  static const initial = Routes.chat;

  static final List<GetPage<dynamic>> routes = [
    GetPage(
      name: Routes.chat,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
  ];

  AppPages._(); // Prevents instantiation
}
