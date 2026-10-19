import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'week04_widget_lab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const WidgetDashboardPage(),
    );
  }
}

class WidgetDashboardPage extends StatefulWidget {
  const WidgetDashboardPage({super.key});

  @override
  State<WidgetDashboardPage> createState() => _WidgetDashboardPageState();
}

class _WidgetDashboardPageState extends State<WidgetDashboardPage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _items = ['Flutter 위젯 조합', 'Row와 Column 배치 연습'];
  int _likeCount = 0;
  String? _errorMessage;

  // 항목 추가 함수 (동작)
  void _addItem() {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      setState(() {
        _errorMessage = '내용을 입력해주세요.';
      });
      return;
    }

    setState(() {
      _items.add(text);
      _controller.clear();
      _errorMessage = null;
    });
  }

  // 좋아요 카운트 증가 함수 (동작)
  void _incrementLike() {
    setState(() {
      _likeCount++;
    });
  }

  // 항목 삭제 함수 (동작)
  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1. 화면 큰 틀: Scaffold & AppBar
    return Scaffold(
      appBar: AppBar(
        title: const Text('4주차 위젯 조합 화면'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _items.clear();
                _likeCount = 0;
                _errorMessage = null;
              });
            },
            tooltip: '초기화',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 2. 헤더 카드 (Row, Column, Icon, Text 조합)
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.teal,
                      child: Icon(Icons.widgets, color: Colors.white, size: 30),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '학습 위젯 대시보드',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '등록된 메모: ${_items.length}개',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                    // 좋아요 버튼 및 뱃지
                    ElevatedButton.icon(
                      onPressed: _incrementLike,
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      label: Text('$_likeCount'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 3. 입력 창 및 추가 버튼 (Row, TextField, ElevatedButton)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: '새 학습 메모 작성',
                      hintText: '예: ListView 성능 최적화',
                      errorText: _errorMessage,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 54,
                  child: ElevatedButton(
                    onPressed: _addItem,
                    child: const Text('추가'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            const Text(
              '메모 목록',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // 4. 동적 리스트 뷰 (ListView.builder, ListTile, IconButton)
            Expanded(
              child: _items.isEmpty
                  ? const Center(
                      child: Text(
                        '등록된 메모가 없습니다.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            leading: const Icon(Icons.check_circle_outline, color: Colors.teal),
                            title: Text(_items[index]),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                              onPressed: () => _removeItem(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}