import 'package:dio/dio.dart';
import 'package:dio_logger/dio_logger.dart';

class HttpClient {
  final Dio request = Dio(
    BaseOptions(
      baseUrl: 'https://api.tafsiri-muyassar.uz/api',
    ),
  );

  HttpClient() {
    request.interceptors.add(dioLoggerInterceptor);
  }
}
