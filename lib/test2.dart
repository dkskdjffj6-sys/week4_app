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
      title: 'AC 요구사항 구현 예제',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF4F6F8),
      ),
      home: const AcRequirementsScreen(),
    );
  }
}

class AcRequirementsScreen extends StatelessWidget {
  const AcRequirementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('요구사항 구현 화면'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // =========================================================
          // [AC1] 머리말 (Header): 아바타 · 이름 · 전공 표시
          // =========================================================
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                // 아바타
                const CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.teal,
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
                const SizedBox(width: 16.0),
                // 이름 및 전공 (머리말 정보)
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '김플러터',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      '컴퓨터공학과',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),

          const Text(
            '📋 정보 카드 목록 (AC2 & AC3)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12.0),

          // =========================================================
          // [AC2] 정보 Card 세 개를 스크롤해 확인
          // [AC3] 버튼을 누르면 SnackBar 표시 (Feedback)
          // =========================================================
          _buildInfoCard(
            context: context,
            cardNumber: '01',
            title: '첫 번째 정보 Card',
            description: '첫 번째 정보 카드입니다. 스크롤하여 세 개의 카드를 확인할 수 있습니다.',
            snackMessage: '🎉 첫 번째 카드의 버튼이 클릭되었습니다!',
            buttonColor: Colors.teal,
          ),
          _buildInfoCard(
            context: context,
            cardNumber: '02',
            title: '두 번째 정보 Card',
            description: '두 번째 정보 카드입니다. 각 카드는 독립적인 피드백 버튼을 가집니다.',
            snackMessage: '💡 두 번째 카드의 버튼이 클릭되었습니다!',
            buttonColor: Colors.indigo,
          ),
          _buildInfoCard(
            context: context,
            cardNumber: '03',
            title: '세 번째 정보 Card',
            description: '세 번째 정보 카드입니다. 버튼을 누르면 아래에 SnackBar가 뜹니다.',
            snackMessage: '✨ 세 번째 카드의 버튼이 클릭되었습니다!',
            buttonColor: Colors.deepOrange,
          ),
        ],
      ),
    );
  }

  // AC2(Card 생성) 및 AC3(SnackBar 피드백 동작)을 위한 공통 카드 빌더 함수
  Widget _buildInfoCard({
    required BuildContext context,
    required String cardNumber,
    required String title,
    required String description,
    required String snackMessage,
    required Color buttonColor,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: buttonColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Card $cardNumber',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: buttonColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              description,
              style: const TextStyle(color: Colors.black, fontSize: 14),
            ),
            const SizedBox(height: 16.0),
            // [AC3] 버튼을 누르면 SnackBar 표시
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  // SnackBar 피드백 표시
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(snackMessage),
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                      action: SnackBarAction(
                        label: '확인',
                        textColor: Colors.amber,
                        onPressed: () {},
                      ),
                    ),
                  );
                },
                child: const Text('SnackBar 알림 띄우기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}