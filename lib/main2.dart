import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Widget Flow',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. 화면 틀 (Scaffold)
    return Scaffold(
      // 2. 상단 제목 (AppBar)
      appBar: AppBar(
        title: const Text('화면 흐름 예제'),
      ),
      // 3. 본문 목록 (ListView)
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // 4. 정보 묶음 (Card)
          Card(
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Card 위젯 (정보 묶음)',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text('ListView 안에 Card를 배치하여 정보를 깔끔하게 묶었습니다.'),
                  const SizedBox(height: 16.0),
                  
                  // 5. 완료 동작 (ElevatedButton)
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // 버튼 클릭 시 동작
                      },
                      child: const Text('완료 동작 (ElevatedButton)'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}