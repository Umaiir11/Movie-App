class ApiResponse<T> {
  final bool? success;
  final String? message;
  final int? code;
  final T? data;
  final String? token;

  ApiResponse({
    this.success,
    this.message,
    this.code,
    this.data,
    this.token,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic>? json,
      T Function(dynamic json)? fromJsonT,
      ) {
    if (json == null) {
      return ApiResponse();
    }

    final status = json['status'];
    final success = json['success'];
    final isSuccess = success == true || status == 'success';

    dynamic extractedData = json;
    T? parsedData;
    if (extractedData != null && fromJsonT != null) {
      try {
        parsedData = fromJsonT(extractedData);
      } catch (e) {
        print('Error parsing data with fromJsonT: $e');
      }
    }

    return ApiResponse(
      success: isSuccess,
      message: json['message'] as String?,
      code: json['code'] as int?,
      data: parsedData,
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T)? toJsonT) {
    return {
      'success': success,
      'message': message,
      'code': code,
      'data': (data != null && toJsonT != null) ? toJsonT(data as T) : null,
      'token': token,
    };
  }
}