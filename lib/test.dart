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
      home: const AcRequirementScreen(),
    );
  }
}

class AcRequirementScreen extends StatelessWidget {
  const AcRequirementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AC 요구사항 구현 화면'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      // AC2: 정보 Card를 스크롤할 수 있도록 ListView 활용
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // ===================================================================
          // [AC1] 아바타 · 이름 · 전공이 머리말(Header)에 표시
          // ===================================================================
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // 아바타
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.teal,
                    child: Icon(Icons.person, size: 35, color: Colors.white),
                  ),
                  SizedBox(width: 16),
                  // 이름 및 전공
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '홍길동',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '컴퓨터공학과',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          const Text(
            '📋 정보 카드 목록 (AC2)',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // ===================================================================
          // [AC2] 정보 Card 세 개를 스크롤해 확인
          // ===================================================================
          _buildInfoCard(
            title: '정보 Card 1',
            description: '첫 번째 정보 카드입니다. 스크롤하여 다른 카드를 확인하세요.',
            icon: Icons.info_outline,
            color: Colors.teal.shade50,
          ),
          _buildInfoCard(
            title: '정보 Card 2',
            description: '두 번째 정보 카드입니다. 다양한 정보를 묶어서 보여줍니다.',
            icon: Icons.article_outlined,
            color: Colors.blue.shade50,
          ),
          _buildInfoCard(
            title: '정보 Card 3',
            description: '세 번째 정보 카드입니다. 아래 버튼을 눌러 피드백을 확인하세요.',
            icon: Icons.assignment_outlined,
            color: Colors.orange.shade50,
          ),
          const SizedBox(height: 20),

          // ===================================================================
          // [AC3] 버튼을 누르면 SnackBar 표시
          // ===================================================================
          ElevatedButton.icon(
            onPressed: () {
              // SnackBar 표시
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('🎉 AC3 조건 만족: SnackBar가 성공적으로 표시되었습니다!'),
                  duration: Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            icon: const Icon(Icons.notifications_active),
            label: const Text('SnackBar 피드백 확인하기 (AC3)'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // AC2: 정보 Card 생성을 위한 공통 메서드
  Widget _buildInfoCard({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      elevation: 2,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 30, color: Colors.black),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}