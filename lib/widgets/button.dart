import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor;

  const Button({
    // 부모 클래스에 key 전달하여 이 위젯이 고유하게 식별될 수 있도록 함
    super.key,
    required this.text,
    required this.bgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(45),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 42,
        ),
        child: Text(text,
            style: TextStyle(
              fontSize: 20,
              color: textColor,
            )),
      ),
    );
  }
}
