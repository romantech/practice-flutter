import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/webtoon_model.dart';

class ApiService {
  static const String baseUrl = 'webtoon-crawler.nomadcoders.workers.dev';
  static const String today = "today";

  Future<List<WebtoonModel>> getTodayToons() async {
    try {
      // baseUrl과 today를 사용해 HTTPS URI를 생성
      final uri = Uri.https(baseUrl, '/$today');
      // 생성된 URI에 대해 GET 요청을 보내고 응답을 대기
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        // 응답 본문을 JSON으로 디코딩하여 웹툰 데이터 리스트로 변환
        final List<dynamic> webtoons = jsonDecode(response.body);
        // 각 웹툰 데이터를 WebtoonModel로 매핑하여 리스트로 반환
        return webtoons.map((data) => WebtoonModel.fromJson(data)).toList();
      } else {
        // 응답 상태 코드가 200이 아닐 경우, 예외 발생
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
}
