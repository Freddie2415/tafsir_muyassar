import 'package:dio/dio.dart';
import 'package:tafsiri_muyassar/services/http_client.dart';

class JuzsRepository {
  final _url = '/juzs';
  final _httpClient = HttpClient();

  Future<Response> getJuzs({int page = 1}) =>
      _httpClient.request.get("$_url?page=$page&per_page=15");
}
