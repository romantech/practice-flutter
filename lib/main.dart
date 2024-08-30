import 'package:flutter/material.dart';

import 'widgets/Button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // 중첩 위젯 최상위 트리에 const 키워드를 붙이면 그 하위 위젯들은 자동으로 const 처리된다
  // 위젯이 const 생성자일 때만 const 키워드를 붙일 수 있다.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF181818),
        body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                width: double.infinity,
                height: 80,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Hey, Selena',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                        )),
                    Text('Welcome Back',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 18,
                        )),
                  ],
                )
              ]),
              const SizedBox(
                height: 120,
              ),
              Text('Total Balance',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white.withOpacity(0.8),
                  )),
              const SizedBox(height: 5),
              const Text('\$5 194 482',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  )),
              const SizedBox(height: 30),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Button(
                    text: 'Transfer',
                    bgColor: Colors.amber,
                    textColor: Colors.black,
                  ),
                  Button(
                    text: 'Request',
                    bgColor: Color(0xFF1F2123),
                    textColor: Colors.white,
                  ),
                ],
              ),
              const SizedBox(height: 100),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Wallets',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w600,
                        )),
                    Text('View All',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 18,
                        )),
                  ]),
              const SizedBox(height: 20),
              Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1F2123),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Euro',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w600,
                                    )),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Text('6 428',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        )),
                                    const SizedBox(width: 5),
                                    Text('EUR',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.8),
                                          fontSize: 20,
                                        )),
                                  ],
                                )
                              ]),
                          Transform.scale(
                              scale: 2.2,
                              child: Transform.translate(
                                offset: const Offset(-5, 12),
                                child: const Icon(
                                  Icons.euro_rounded,
                                  color: Colors.white,
                                  size: 88,
                                ),
                              ))
                        ]),
                  )),
            ])),
      ),
    );
  }
}
