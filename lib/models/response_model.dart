class ApiResponse<T> {
  final String? message;
  final T? data;
  final String? error;
  final int code;
  final bool success;

  ApiResponse({
    required this.message,
    this.data,
    this.error,
    required this.code,
    required this.success,
  });

  factory ApiResponse.fromJson(dynamic json) => ApiResponse<T>(
      message: json['message'],
      data: json['data'],
      error: json['error'],
      code: json['code'],
      success: json['success'] ?? false,
    );
}