import 'package:flutter/material.dart';

class LifeCycle extends StatefulWidget {
  const LifeCycle({super.key});

  @override
  State<LifeCycle> createState() => _LifeCycleState();
}

// State
class _LifeCycleState extends State<LifeCycle> {
  bool showTitle = true;

  void toggleTitle() {
    setState(() {
      showTitle = !showTitle;
    });
  }

  List<int> numbers = [];

  void onClicked() {
    // State 클래스에게 데이터가 변경됐다고 알리는 함수
    // setState 함수가 호출되면 build 메서드를 다시 실행시켜서 리렌더링
    // 생각보다 플러터에선 State를 많이 사용하지는 않음(리액트에 비하면)
    setState(() {
      numbers.add(numbers.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            textTheme: const TextTheme(
                titleLarge: TextStyle(
          color: Colors.red,
        ))),
        home: Scaffold(
          backgroundColor: const Color(0xFFF4EDDB),
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              showTitle ? const MyLargeTitle() : const Text('nothing to see'),
              IconButton(
                  iconSize: 100,
                  onPressed: toggleTitle,
                  icon: const Icon(Icons.remove_red_eye))
            ],
          )),
        ));
  }
}

class MyLargeTitle extends StatefulWidget {
  const MyLargeTitle({
    super.key,
  });

  @override
  State<MyLargeTitle> createState() => _MyLargeTitleState();
}

class _MyLargeTitleState extends State<MyLargeTitle> {
  /// 위젯이 트리에 처음 삽입될 때 한 번만 호출됨(build 이전에 호출)
  /// 상태 변수가 위젯의 컨텍스트에 의존하거나, 애니메이션 컨트롤러 초기화,
  /// Stream 구독과 같은 초기화 작업이 필요할 때 사용
  @override
  void initState() {
    super.initState();
    print('initState');
  }

  /// 위젯이 트리에서 제거되기 전에 호출됨
  /// API 호출 취소, 이벤트 리스너 구독 해제, 애니메이션 컨트롤러 해제 등의
  /// 정리 작업에 사용
  @override
  void dispose() {
    super.dispose();
    print('dispose!');
  }

  /// build 메서드는 위젯의 UI를 렌더링하는 역할을 하며, initState 이후에 호출됨
  /// 상태가 변경될 때마다(setState 등 호출) 다시 호출됨
  /// build는 순수 함수처럼 동작해야 하며, 위젯 트리의 자식 요소들을 반환함
  @override
  Widget build(BuildContext context) {
    print('build');
    return Text('My Large Title',
        style: TextStyle(
          fontSize: 30,

          /// context에는 현재 위젯이 위치한 트리에 대한 정보가 담겨있음
          /// context를 통해 부모 트리의 데이터나 서비스에 접근할 수 있음
          color: Theme.of(context).textTheme.titleLarge?.color,
        ));
  }
}
