import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practice_flutter/models/webtoon_episode_model.dart';

import '../models/webtoon_detail_model.dart';
import '../models/webtoon_model.dart';

class ApiService {
  static const String baseUrl = 'webtoon-crawler.nomadcoders.workers.dev';
  static const String today = "today";

  // 오늘의 웹툰 목록을 불러오는 메서드. async 키워드를 붙였기 때문에 Future를 반환한다.
  static Future<List<WebtoonModel>> getTodayToons() async {
    try {
      // baseUrl과 today를 사용해 HTTPS URI 생성
      // Uri.parse(...)로도 가능(이땐 주소에 프로토콜까지 모두 명시)
      final uri = Uri.https(baseUrl, '/$today');
      // 생성한 URI로 GET 요청을 보내고 응답 대기
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        // String으로 받은 응답 데이터를 JSON으로 디코딩. json.decode(...)로도 가능
        final List<dynamic> webtoons = jsonDecode(response.body);
        // 디코딩된 각 JSON 데이터를 WebtoonModel 인스턴스로 매핑하여 리스트로 반환
        return webtoons.map((data) => WebtoonModel.fromJson(data)).toList();
      } else {
        // 상태 코드가 200이 아닐 경우, 예외 발생
        throw Exception('Failed to load webtoons: ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      // HTTP 클라이언트 예외 발생 시
      throw Exception('Failed to fetch webtoons: $e');
    } on Exception catch (e) {
      // 기타 예외 발생 시
      throw Exception('An unknown error occurred: $e');
    }
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final uri = Uri.https(baseUrl, '/$id');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    } else {
      throw Exception('Failed to load webtoon details: ${response.statusCode}');
    }
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
      String id) async {
    final uri = Uri.https(baseUrl, '/$id');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      return episodes.map((ep) => WebtoonEpisodeModel.fromJson(ep)).toList();
    } else {
      throw Exception('Failed to load webtoon details: ${response.statusCode}');
    }
  }
}
