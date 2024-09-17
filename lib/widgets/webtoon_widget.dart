import 'package:flutter/material.dart';
import 'package:practice_flutter/screens/detail_screen.dart';

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
    return GestureDetector(
      // 탭(터치) 했을 때 호출
      onTap: () {
        // 현재 화면에서 새로운 화면을 스택에 추가하여 해당 화면으로 전환하는 메서드
        Navigator.push(
            context,
            // 새로운 화면으로 전환할 때 애니메이션과 함께 페이지 전환을 정의하는 라우트 클래스
            // 화면 전환 시 Material 디자인 규칙을 따름(부드럽게 전환되는 애니메이션 등)
            MaterialPageRoute(
              builder: (context) {
                return DetailScreen(
                  title: title,
                  thumb: thumb,
                  id: id,
                );
              },
              // 새로운 화면을 전체 화면 모드로 열고, 뒤로가기 버튼 대신 닫기 버튼 표시하도록 설정
              fullscreenDialog: true,
            ));
      },
      child: Column(
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
      ),
    );
  }
}
