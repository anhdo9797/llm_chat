import 'package:get/get.dart';

import '../../data/repositories/chat_repository.dart';
import 'chat_controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize repositories
    Get.lazyPut(() => ChatRepository(apiProvider: Get.find()));

    // Initialize controllers
    Get.lazyPut(() => ChatController(chatRepository: Get.find()));
  }
}
