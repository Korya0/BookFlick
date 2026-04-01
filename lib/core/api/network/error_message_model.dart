class ErrorMessageModel {
  final int? code;
  final String message;
  final List<dynamic>? errors;
  final String? domain;
  final String? reason;

  const ErrorMessageModel({
    this.code,
    required this.message,
    this.errors,
    this.domain,
    this.reason,
  });

  factory ErrorMessageModel.fromJson(Map<String, dynamic> json) {
    return ErrorMessageModel(
      code: json['error']?['code'] as int?,
      message: json['error']?['message'] ?? 'Unknown error occurred',
      errors: json['error']?['errors'] as List<dynamic>?,
      domain: json['error']?['domain'] as String?,
      reason: json['error']?['reason'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'error': {
        'code': code,
        'message': message,
        'errors': errors,
        'domain': domain,
        'reason': reason,
      },
    };
  }
}
