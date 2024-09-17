import 'package:flutter/material.dart';

class Webtoon extends StatelessWidget {
  final String title, thumb, id;

  const Webtoon({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
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
          // 네트워크 상의 이미지를 불러올 때 Image.network 사용
          // 모든 네트워크 이미지는 HTTP 헤더와 관계없이 캐시됨
          child: Image.network(thumb, headers: const {
            // HTTP 요청 시 Referer 헤더 추가
            'Referer': 'https://comic.naver.com',
          }),
        ),
        const SizedBox(height: 20),
        Text(title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            )),
      ],
    );
  }
}
