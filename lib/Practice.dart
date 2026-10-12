import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const TypingPracticeApp());
}

class TypingPracticeApp extends StatelessWidget {
  const TypingPracticeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '한컴타자 연습 클론',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: const Color(0xFFFFF8F0), // 따뜻한 크림색 배경
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFFB74D),
          foregroundColor: Colors.black87,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      home: const TypingPracticeScreen(),
    );
  }
}

class TypingPracticeScreen extends StatefulWidget {
  const TypingPracticeScreen({super.key});

  @override
  State<TypingPracticeScreen> createState() => _TypingPracticeScreenState();
}

class _TypingPracticeScreenState extends State<TypingPracticeScreen> {
  // 연습용 문장 목록
  final List<String> _sentences = [
    "동해물과 백두산이 마르고 닳도록",
    "하느님이 보우하사 우리나라 만세",
    "플러터로 만드는 즐거운 타자 연습 프로그램",
    "위젯 이름을 외우지 말고 기능과 연결하세요",
    "천 리 길도 한 걸음부터 시작합니다",
  ];

  int _currentIndex = 0; // 현재 문장 인덱스
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  // 타자 측정 관련 상태 변수
  DateTime? _startTime;
  int _wpm = 0; // 분당 타수
  double _accuracy = 100.0; // 정확도 (%)
  int _completedCount = 0; // 완료한 문장 수

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _textController.removeListener(_onTextChanged);
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // 텍스트 입력 시 실시간 정확도 및 타수 계산
  void _onTextChanged() {
    final input = _textController.text;
    final target = _sentences[_currentIndex];

    // 첫 글자 입력 시 시간 측정 시작
    if (input.isNotEmpty && _startTime == null) {
      _startTime = DateTime.now();
    }

    if (input.isEmpty) {
      setState(() {
        _accuracy = 100.0;
        _wpm = 0;
      });
      return;
    }

    // 1. 정확도 계산
    int correctChars = 0;
    int checkLength = input.length < target.length ? input.length : target.length;
    for (int i = 0; i < checkLength; i++) {
      if (input[i] == target[i]) {
        correctChars++;
      }
    }
    double currentAccuracy = (correctChars / input.length) * 100;

    // 2. 분당 타수(WPM) 계산
    int currentWpm = 0;
    if (_startTime != null) {
      final elapsedSeconds = DateTime.now().difference(_startTime!).inMilliseconds / 1000.0;
      if (elapsedSeconds > 0.5) {
        // (입력 글자 수 / 초) * 60초
        currentWpm = ((input.length / elapsedSeconds) * 60).round();
      }
    }

    setState(() {
      _accuracy = currentAccuracy.isNaN ? 100.0 : currentAccuracy;
      _wpm = currentWpm;
    });
  }

  // 엔터 입력 시 다음 문장으로 이동
  void _submitSentence(String value) {
    if (value.isEmpty) return;

    setState(() {
      _completedCount++;
      _currentIndex = (_currentIndex + 1) % _sentences.length;
      _textController.clear();
      _startTime = null;
      _wpm = 0;
      _accuracy = 100.0;
    });

    // 다음 문장 입력을 위해 포커스 유지
    FocusScope.of(context).requestFocus(_focusNode);
  }

  @override
  Widget build(BuildContext context) {
    final currentTarget = _sentences[_currentIndex];
    final currentInput = _textController.text;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '⌨️ 한컴타자 연습',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // 1. 상단 점수판 (타수, 정확도, 진행 상황)
            Row(
              children: [
                _buildStatCard('현재 타수', '$_wpm 타', Colors.orange),
                const SizedBox(width: 12),
                _buildStatCard('정확도', '${_accuracy.toStringAsFixed(1)}%', Colors.green),
                const SizedBox(width: 12),
                _buildStatCard('완료 문장', '$_completedCount 개', Colors.blue),
              ],
            ),
            const SizedBox(height: 30),

            // 2. 제시어 출력 카드 (한글자씩 비교하여 색상 표시)
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '제시문 (${_currentIndex + 1}/${_sentences.length})',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                          ),
                        ),
                        const Icon(Icons.menu_book_rounded, color: Colors.orange),
                      ],
                    ),
                    const Divider(height: 20),
                    const SizedBox(height: 10),

                    // 실시간 일치 여부에 따른 글자 색상 처리
                    RichText(
                      text: TextSpan(
                        children: List.generate(currentTarget.length, (index) {
                          Color charColor = Colors.grey[400]!; // 아직 입력 안 함

                          if (index < currentInput.length) {
                            if (currentInput[index] == currentTarget[index]) {
                              charColor = Colors.blue[700]!; // 일치 (파란색)
                            } else {
                              charColor = Colors.red[600]!; // 오타 (빨간색)
                            }
                          }

                          return TextSpan(
                            text: currentTarget[index],
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: charColor,
                              backgroundColor: (index < currentInput.length &&
                                      currentInput[index] != currentTarget[index])
                                  ? Colors.red[50]
                                  : null,
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // 3. 사용자 입력창
            TextField(
              controller: _textController,
              focusNode: _focusNode,
              autofocus: true,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                hintText: '위 문장을 그대로 입력하고 Enter를 누르세요',
                hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.orange.shade200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.orange, width: 2),
                ),
              ),
              onSubmitted: _submitSentence,
            ),
            const SizedBox(height: 20),

            // 4. 리셋 및 안내 문구
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '💡 Tip: 오타가 나면 빨간색으로 표시됩니다.',
                  style: TextStyle(color: Colors.grey[700], fontSize: 13),
                ),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _currentIndex = 0;
                      _completedCount = 0;
                      _textController.clear();
                      _startTime = null;
                      _wpm = 0;
                      _accuracy = 100.0;
                    });
                  },
                  icon: const Icon(Icons.refresh_rounded, size: 18),
                  label: const Text('처음부터'),
                  style: TextButton.styleFrom(foregroundColor: Colors.orange[800]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 상단 스탯 카드 빌더 함수
  Widget _buildStatCard(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
      ),
    );
  }
}