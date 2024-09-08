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
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  var webtoon = snapshot.data![index];
                  return Text(webtoon.title);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 10);
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
