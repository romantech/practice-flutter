import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/webtoon_model.dart';

class ApiService {
  static const String baseUrl = 'webtoon-crawler.nomadcoders.workers.dev';
  static const String today = "today";

  // 오늘의 웹툰 목록을 불러오는 메서드. async 키워드를 붙였기 때문에 Future를 반환한다.
  Future<List<WebtoonModel>> getTodayToons() async {
    try {
      // baseUrl과 today를 사용해 HTTPS URI 생성
      // Uri.parse(...)로도 가능(이땐 주소에 프로토콜까지 모두 명시)
      final uri = Uri.https(baseUrl, '/$today');
      // 생성한 URI로 GET 요청을 보내고 응답 대기
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        // JSON 응답을 디코딩하여 웹툰 데이터 리스트로 변환
        // json.decode(...)로도 가능
        final List<dynamic> webtoons = jsonDecode(response.body);
        // 각 데이터를 WebtoonModel로 매핑하여 리스트로 반환
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
}
