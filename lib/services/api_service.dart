import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/webtoon_model.dart';

class ApiService {
  final String baseUrl = 'https://webtoon-crawler.nomadcoders.workers.dev';
  final String today = "today";

  Future<List<WebtoonModel>> getTodayToons() async {
    final uri = Uri.parse('$baseUrl/$today');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      return webtoons.map((data) => WebtoonModel.fromJson(data)).toList();
    }

    throw Error();
  }
}
