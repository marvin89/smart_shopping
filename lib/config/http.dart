import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';

BaseOptions options = new BaseOptions(
  baseUrl: 'http://192.168.87.113:8080',
  connectTimeout: 5000,
  receiveTimeout: 3000,
);

class HttpClient {
  static final Dio singleton = _generate(options);

  static Dio _generate(BaseOptions options) {
    final _client = new Dio(options);

    _client.interceptors.add(InterceptorsWrapper(
      onError: (DioError e) async {
        return e;
      },
    ));
    _client.transformer = new FlutterTransformer();

    return _client;
  }
}

Dio http = HttpClient.singleton;
