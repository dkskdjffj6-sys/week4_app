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
      title: 'Widget Classification Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WidgetExampleScreen(),
    );
  }
}

class WidgetExampleScreen extends StatefulWidget {
  const WidgetExampleScreen({super.key});

  @override
  State<WidgetExampleScreen> createState() => _WidgetExampleScreenState();
}

class _WidgetExampleScreenState extends State<WidgetExampleScreen> {
  // 반응하는 것(TextField)을 위한 컨트롤러와 상태 변수
  final TextEditingController _controller = TextEditingController();
  String _displayText = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('플러터 위젯 분류 예제'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. 보이는 것 (Text, Icon, Image) 예시
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '1. 보이는 것 (Text · Icon · Image)',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    const SizedBox(height: 8),
                    // Text 예시
                    const Text(
                      '이것은 Text 위젯입니다.',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    const SizedBox(height: 12),
                    // Icon 예시
                    const Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 30),
                        SizedBox(width: 8),
                        Text('Icon 위젯 (별 모양)'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Image 예시 (네트워크 이미지 대체)
                    Container(
                      height: 120,
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(Icons.image, size: 50, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 2. 배치하는 것 (Row, Column, Padding) 예시
            Card(
              elevation: 3,
              child: Padding(
                // Padding 예시 (내부 여백 지정)
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '2. 배치하는 것 (Row · Column · Padding)',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    const SizedBox(height: 8),
                    const Text('Column 위젯으로 아래로 쌓은 뒤, Row 위젯으로 가로 배치:'),
                    const SizedBox(height: 12),
                    // Row 예시 (가로 배치)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          color: Colors.blue[100],
                          child: const Text('항목 A'),
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          color: Colors.green[100],
                          child: const Text('항목 B'),
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          color: Colors.orange[100],
                          child: const Text('항목 C'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 3. 반응하는 것 (Button, TextField, Navigator) 예시
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '3. 반응하는 것 (Button · TextField · Navigator)',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    const SizedBox(height: 8),
                    // TextField 예시 (사용자 입력 반응)
                    TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        labelText: '텍스트를 입력하세요',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // ElevatedButton (동작 반응) 및 Navigator 예시
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _displayText = _controller.text;
                            });
                          },
                          child: const Text('입력 확인 (Button)'),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            // Navigator 예시 (화면 이동 팝업 다이얼로그)
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Navigator / Dialog 예시'),
                                content: Text('입력된 내용: $_displayText'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('닫기'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const Text('팝업 열기 (Navigator)'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '결과: $_displayText',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}