import 'package:flutter/material.dart';
import 'package:practice_flutter/screens/home_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  // 위젯은 key 라는 걸 가지고 있고, ID 처럼 쓰임
  // Flutter는 ID를 식별하기 위해 ID를 사용함
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
