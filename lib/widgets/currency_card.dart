import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  final String name, code, amount;
  final IconData icon;
  final bool isInverted;
  final double order;

  final _blackColor = const Color(0xFF1F2123);
  final _baseOffset = -20;

  const CurrencyCard({
    super.key,
    required this.name,
    required this.code,
    required this.amount,
    required this.icon,
    required this.isInverted,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    // 위젯의 위치를 특정 방향으로 이동시킬 때 사용하는 Transform.translate
    // 부모 위젯의 크기나 레이아웃에 영향을 주지 않음
    return Transform.translate(
      // 좌표나 거리 등을 나타내기 위해 사용하는 Offset 클래스
      offset: Offset(0, (order - 1) * _baseOffset),
      child: Container(
          // 위젯의 잘림 방식을 정의할 때 사용하는 clipBehavior 속성
          // Clip.hardEdge는 위젯의 경계를 기준으로 즉시 잘라내는 방식
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: isInverted ? Colors.white : _blackColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            style: TextStyle(
                              color: isInverted ? _blackColor : Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                            )),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(amount,
                                style: TextStyle(
                                  color:
                                      isInverted ? _blackColor : Colors.white,
                                  fontSize: 20,
                                )),
                            const SizedBox(width: 5),
                            Text(code,
                                style: TextStyle(
                                  color: isInverted
                                      ? _blackColor
                                      : Colors.white.withOpacity(0.8),
                                  fontSize: 20,
                                )),
                          ],
                        )
                      ]),
                  // 자식 위젯의 크기를 확대/축소할 때 사용하는 Transform.scale
                  // 자식 위젯의 크기만 변경하고 레이아웃에는 영향 안줌
                  Transform.scale(
                      scale: 2.2,
                      child: Transform.translate(
                        offset: const Offset(-5, 12),
                        // 아이콘을 표시하기 위해 사용하는 Icon 위젯
                        child: Icon(
                          icon,
                          color: isInverted ? _blackColor : Colors.white,
                          size: 88,
                        ),
                      ))
                ]),
          )),
    );
  }
}
