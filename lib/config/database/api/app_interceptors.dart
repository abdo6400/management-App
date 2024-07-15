import 'dart:io';
import 'package:dio/dio.dart';
import '../../../app/service_locator.dart';
import '../../../core/utils/app_enums.dart';
import '../../../core/utils/custom_print.dart';
import '../cache/cache_consumer.dart';
import 'end_points.dart';

class AppIntercepters extends Interceptor {
  final Dio client;
  AppIntercepters({required this.client});
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers[HttpHeaders.acceptHeader] = ContentType.json;
    options.headers['authorization'] = await sl<CacheConsumer>()
                .getData(key: MySharedKeys.apiToken.name) !=
            null
        ? '${EndPoints.prefixToken} ${await sl<CacheConsumer>().getData(key: MySharedKeys.apiToken.name)}'
        : null;
    options.queryParameters['ln'] = await sl<CacheConsumer>()
            .getData(key: MySharedKeys.language.name) ??
        'en';

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    CustomPrint.printFullText(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    CustomPrint.printFullText(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}
