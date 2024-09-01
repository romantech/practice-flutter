import 'package:flutter/material.dart';

class LifeCycle extends StatefulWidget {
  const LifeCycle({super.key});

  @override
  State<LifeCycle> createState() => _LifeCycleState();
}

// State
class _LifeCycleState extends State<LifeCycle> {
  bool showTitle = true;
  List<int> numbers = [];

  void toggleTitle() {
    setState(() => showTitle = !showTitle);
  }

  void onClicked() {
    // State 클래스에게 데이터가 변경됐다고 알리는 함수
    // setState 함수가 호출되면 build 메서드를 다시 실행시켜서 리렌더링
    // 생각보다 플러터에선 State를 많이 사용하지는 않음(리액트에 비하면)
    setState(() => numbers.add(numbers.length));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme 속성은 MaterialApp에서 전체 애플리케이션의 테마를 정의할 때 사용한다
      // ThemeData 객체를 통해 앱에서 공통적으로 적용할 테마 속성을 설정한다
      theme: ThemeData(
        // TextTheme 클래스를 사용해 앱에서 사용할 텍스트 스타일을 정의한다
        textTheme: const TextTheme(
          // titleLarge 속성에 큰 타이틀에 사용할 텍스트 스타일을 지정한다
          titleLarge: TextStyle(color: Colors.red),
        ),
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFFF4EDDB),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              showTitle ? const LargeTitle() : const Text('nothing to see'),
              IconButton(
                  iconSize: 100,
                  onPressed: toggleTitle,
                  icon: const Icon(Icons.remove_red_eye))
            ],
          ),
        ),
      ),
    );
  }
}

class LargeTitle extends StatefulWidget {
  const LargeTitle({super.key});

  @override
  State<LargeTitle> createState() => _LargeTitleState();
}

class _LargeTitleState extends State<LargeTitle> {
  // 위젯이 트리에 처음 삽입될 때 한 번만 호출된다(build 이전에 호출).
  // 상태 변수가 위젯의 컨텍스트에 의존하거나, 애니메이션 컨트롤러 초기화,
  // Stream 구독과 같은 초기화 작업이 필요할 때 사용한다.
  @override
  void initState() {
    // 항상 super.initState()를 호출하여 부모 클래스의 초기화 작업이 먼저 이뤄져야 한다.
    super.initState();
    print('initState');
  }

  // dispose 메서드는 위젯이 완전히 제거되기 직전에 호출된다.
  // API 호출 취소, 이벤트 구독 해제, 애니메이션 컨트롤러 해제 등 정리 작업에 사용한다.
  @override
  void dispose() {
    // 반드시 super.dispose()를 호출하여 부모 클래스에서 필요한 정리 작업이 수행되도록 해야 한다.
    super.dispose();
    print('dispose!');
  }

  // build 메서드는 위젯의 UI를 렌더링하며, 위젯 트리의 자식 요소들을 반환한다.
  // build는 initState 이후에 호출되고, 상태가 변경(setState 호출 등)될 때마다 호출된다.
  // build 메서드는 부수 효과 없이 입력값에만 의존하는 순수 함수처럼 동작해야 한다.
  @override
  Widget build(BuildContext context) {
    print('build');
    return Text(
      'Large Title',
      style: TextStyle(
        fontSize: 30,
        // Theme.of를 통해 현재 위젯 트리의 상위에 정의된 ThemeData 객체에 접근할 수 있다
        // 아래에선 MaterialApp 테마에 접근하여 titleLarge 색상을 사용하고 있다
        color: Theme.of(context).textTheme.titleLarge?.color,
      ),
    );
  }
}

// 콘솔 출력 결과
// flutter: initState
// flutter: build
// flutter: dispose! (LargeTitle 위젯이 제거됐을 때)
