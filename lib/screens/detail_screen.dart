import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/webtoon_detail_model.dart';
import '../models/webtoon_episode_model.dart';
import '../services/api_service.dart';
import '../widgets/episode.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;
  late SharedPreferences prefs;
  static const likedToonsPrefsKey = 'likedToons';
  bool isLiked = false;

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final likedToons = prefs.getStringList(likedToonsPrefsKey);

    // 사용자가 처음으로 앱을 실행할 때
    if (likedToons == null) {
      prefs.setStringList(likedToonsPrefsKey, []);
    } else {
      setState(() {
        isLiked = likedToons.contains(widget.id);
      });
    }
  }

  @override
  initState() {
    super.initState();
    // widget 접근자 속성을 통해 부모 위젯의 프로퍼티 접근
    webtoon = ApiService.getToonById(widget.id);
    episodes = ApiService.getLatestEpisodesById(widget.id);
    initPrefs();
  }

  void onHeartTab() async {
    final likedToons = prefs.getStringList(likedToonsPrefsKey);
    if (likedToons == null) return;

    if (isLiked) {
      likedToons.remove(widget.id);
    } else {
      likedToons.add(widget.id);
    }

    prefs.setStringList(likedToonsPrefsKey, likedToons);
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.green,
          actions: [
            IconButton(
                onPressed: onHeartTab,
                icon: Icon(isLiked ? Icons.favorite : Icons.favorite_outline))
          ],
          title: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 두 화면의 공통 요소에 전환 애니메이션을 적용해 시각적 연결을 제공하는 Hero 위젯
                    Hero(
                      // 두 화면의 Here 위젯 tag 값을 동일하게 지정한다
                      tag: widget.id,
                      child: Container(
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
                        // 네트워크 상의 이미지를 불러올 때 Image.network 사용
                        // 모든 네트워크 이미지는 HTTP 헤더와 관계없이 캐시됨
                        child: Image.network(widget.thumb, headers: const {
                          // HTTP 요청 시 Referer 헤더 추가
                          'Referer': 'https://comic.naver.com',
                        }),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                FutureBuilder(
                  future: webtoon,
                  builder: (BuildContext context,
                      AsyncSnapshot<WebtoonDetailModel> snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!.about,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            '${snapshot.data!.genre} / ${snapshot.data!.age}',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      );
                    }
                    return const Text("...");
                  },
                ),
                const SizedBox(height: 20),
                FutureBuilder(
                    future: episodes,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            for (var episode in snapshot.data!)
                              Episode(
                                episode: episode,
                                webtoonId: widget.id,
                              )
                          ],
                        );
                      }
                      return Container();
                    }),
              ],
            ),
          ),
        ));
  }
}
