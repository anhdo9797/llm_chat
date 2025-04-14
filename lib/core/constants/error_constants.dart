/// Error messages constants
class ErrorConstants {
  // Prevent instantiation
  ErrorConstants._();

  /// Network Errors
  static const String noInternet = 'Không có kết nối internet';
  static const String connectionTimeout = 'Kết nối tới server quá lâu';
  static const String serverError = 'Lỗi server, vui lòng thử lại sau';
  static const String unauthorized = 'Phiên đăng nhập đã hết hạn';
  static const String forbidden = 'Bạn không có quyền truy cập';
  static const String notFound = 'Không tìm thấy dữ liệu';

  /// Validation Errors
  static const String required = 'Trường này là bắt buộc';
  static const String invalidEmail = 'Email không hợp lệ';
  static const String invalidPhone = 'Số điện thoại không hợp lệ';
  static const String invalidPassword = 'Mật khẩu phải từ 8 đến 32 ký tự';
  static const String passwordNotMatch = 'Mật khẩu không khớp';
  static const String invalidUsername = 'Tên đăng nhập không hợp lệ';

  /// File Errors
  static const String fileTooLarge = 'File quá lớn';
  static const String invalidFileType = 'Định dạng file không hợp lệ';
  static const String uploadFailed = 'Tải file lên thất bại';

  /// Authentication Errors
  static const String invalidCredentials =
      'Thông tin đăng nhập không chính xác';
  static const String accountLocked = 'Tài khoản đã bị khóa';
  static const String accountNotVerified = 'Tài khoản chưa được xác thực';

  /// General Errors
  static const String unknownError = 'Có lỗi xảy ra, vui lòng thử lại';
  static const String operationFailed = 'Thao tác thất bại';
  static const String invalidData = 'Dữ liệu không hợp lệ';
}
