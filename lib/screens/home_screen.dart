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
              return Column(
                children: [
                  const SizedBox(height: 50),
                  Expanded(child: makeList(snapshot)),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      scrollDirection: Axis.horizontal,
      // 아이템 총 개수 지정
      itemCount: snapshot.data!.length,
      // 화면에 노출된 아이템을 생성할 때 호출되는 함수
      itemBuilder: (BuildContext context, int index) {
        var webtoon = snapshot.data![index];
        return Column(
          children: [
            Container(
              width: 250,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    offset: const Offset(10, 10),
                    color: Colors.black.withOpacity(0.5),
                  )
                ],
              ),
              child: Image.network(webtoon.thumb, headers: const {
                'Referer': 'https://comic.naver.com',
              }),
            ),
            const SizedBox(height: 20),
            Text(webtoon.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                )),
          ],
        );
      },
      // 화면에 노출된 구분선을 생성할 때 호출되는 함수
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(width: 40);
      },
    );
  }
}
