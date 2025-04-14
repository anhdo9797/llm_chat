import 'package:get/get.dart';
import 'package:llm_chat/data/providers/api_provider.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

/// Global binding cho toàn bộ ứng dụng
class AppBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    // Services
    await Get.putAsync(() => StorageService().init());
    await Get.putAsync<ApiService>(() async {
      final service = ApiService();
      return await service.init();
    });

    // Providers
    Get.put(ApiProvider());
  }
}
