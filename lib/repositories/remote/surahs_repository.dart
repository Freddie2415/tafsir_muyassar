import 'package:dio/dio.dart';
import 'package:tafsiri_muyassar/services/http_client.dart';

class SurahsRepository {
  final _url = '/surahs';
  final _httpClient = HttpClient();

  Future<Response> getSurahs({int page = 1}) {
    return _httpClient.request.get("$_url?page=$page&per_page=15");
  }
}
