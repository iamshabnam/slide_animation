import 'package:dio/dio.dart';

class RemoteDB {
  RemoteDB._();

  static final instance = RemoteDB._();

  Future<Response<Map<String, dynamic>?>> get(String path,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      void Function(int, int)? onReceiveProgress}) async {
    Response<Map<String, dynamic>?> response;
    try {
      response = await Dio().get(path,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
    } on DioError catch (e) {
      if (e.response is Response<Map<String, dynamic>?>) {
        return e.response as Response<Map<String, dynamic>?>;
      } else {
        return Response<Map<String, dynamic>?>(
          requestOptions: RequestOptions(path: path),
          statusCode: -101,
          statusMessage: 'Unexpected Error',
        );
      }
    }
    return response;
  }
}
