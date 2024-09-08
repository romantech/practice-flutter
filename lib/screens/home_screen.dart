import 'package:flutter/material.dart';
import 'package:practice_flutter/services/api_service.dart';

import '../models/webtoon_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  late final Future<List<WebtoonModel>> webtoons = ApiService.getTodayToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.green,
          title: const Text(
            "오늘의 웹툰",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: FutureBuilder(
          future: webtoons,
          // snapshot은 future의 상태라고 보면 됨
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                // 아이템 총 개수 지정
                itemCount: snapshot.data!.length,
                // 화면에 노출된 아이템을 생성할 때 호출되는 함수
                itemBuilder: (BuildContext context, int index) {
                  var webtoon = snapshot.data![index];
                  return Text(webtoon.title);
                },
                // 화면에 노출된 구분선을 생성할 때 호출되는 함수
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(width: 10);
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
