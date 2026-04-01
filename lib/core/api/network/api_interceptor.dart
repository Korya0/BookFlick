import 'package:bookna_app/core/utils/logging/app_logger.dart';
import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.info('🌐 API REQUEST: [${options.method}] ${options.uri}');
    if (options.data != null) {
      AppLogger.debug('📦 Request Body: ${options.data}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.info(
      '✅ API RESPONSE: [${response.statusCode}] ${response.requestOptions.uri}',
    );
    // Summarize response if it's too long
    final responseStr = response.data.toString();
    final summary = responseStr.length > 200
        ? '${responseStr.substring(0, 200)}...'
        : responseStr;
    AppLogger.debug('📥 Response Data: $summary');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.error(
      '❌ API ERROR: [${err.response?.statusCode}] ${err.requestOptions.uri}',
      err.error,
      err.stackTrace,
    );
    if (err.response?.data != null) {
      AppLogger.debug('🔌 Error Data: ${err.response?.data}');
    }
    super.onError(err, handler);
  }
}
