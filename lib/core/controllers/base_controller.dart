import 'package:get/get.dart';

/// Base controller với các chức năng core
abstract class BaseController extends GetxController {
  // Loading state
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  /// Set loading state
  void setLoading(bool value) {
    _isLoading.value = value;
  }

  /// Hiển thị error message
  void showError(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.error,
      colorText: Get.theme.colorScheme.onError,
      duration: const Duration(seconds: 3),
    );
  }

  /// Hiển thị message thông thường
  void showMessage(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.primary,
      colorText: Get.theme.colorScheme.onPrimary,
      duration: const Duration(seconds: 2),
    );
  }
}
