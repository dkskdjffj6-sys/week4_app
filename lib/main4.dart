import 'package:flutter/material.dart';

void main() {
  runApp(const WidgetCheatSheetApp());
}

class WidgetCheatSheetApp extends StatelessWidget {
  const WidgetCheatSheetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '위젯 암기 탈출기',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const WidgetMappingScreen(),
    );
  }
}

class WidgetMappingScreen extends StatefulWidget {
  const WidgetMappingScreen({super.key});

  @override
  State<WidgetMappingScreen> createState() => _WidgetMappingScreenState();
}

class _WidgetMappingScreenState extends State<WidgetMappingScreen> {
  // '알림 켜기 (Switch)' 기능을 위한 상태 변수
  bool _isNotiOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '🔥 위젯 암기 탈출: 기능으로 때려맞추기!',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      // 1. 긴 공지 목록 (스크롤 -> ListView)
      // 화면 전체를 스크롤 가능하게 만들어주는 ListView를 사용합니다.
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // 스크린샷의 핵심 철학 (명언)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF14213D), // 스크린샷과 비슷한 남색
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              "위젯 이름을 달달 외우지 말고,\n'만들 기능'을 대표 위젯에 연결해라! 🧠💡",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),

          /* --- 여기서부터 카탈로그 범주와 대표 위젯 연결 --- */

          // [1] 긴 공지 목록 -> 스크롤 -> ListView
          _buildInfoCard(
            title: '📜 긴 공지 목록 (에타 게시판 느낌)',
            subtitle: '기능: 스크롤  👉  대표 위젯: ListView',
            content: '여러 개의 게시글이나 공지사항을 위아래로 슥슥 스크롤할 때 사용해요.',
            icon: Icons.list_alt,
          ),

          // [2] 알림 켜기 -> 입력 -> Switch
          _buildInfoCard(
            title: '🔔 휴강 알림 켜기',
            subtitle: '기능: 입력  👉  대표 위젯: Switch',
            content: 'ON/OFF 상태를 입력받을 때 씁니다.',
            icon: Icons.toggle_on,
            trailingWidget: Switch(
              value: _isNotiOn,
              activeColor: Colors.deepPurpleAccent,
              onChanged: (value) {
                setState(() {
                  _isNotiOn = value;
                });
              },
            ),
          ),

          // [3] 사진 모음 -> 스크롤·격자 -> GridView
          _buildInfoCard(
            title: '📸 인스타 피드 사진 모음',
            subtitle: '기능: 스크롤·격자  👉  대표 위젯: GridView',
            content: '사진을 바둑판 배열로 예쁘게 깔아둘 때 사용합니다.',
            icon: Icons.grid_view,
            // GridView를 간단히 흉내낸 Row
            trailingWidget: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildMockImage(Colors.pink[200]!),
                const SizedBox(width: 4),
                _buildMockImage(Colors.blue[200]!),
                const SizedBox(width: 4),
                _buildMockImage(Colors.green[200]!),
              ],
            ),
          ),

          // [4] 저장 완료 -> 피드백 -> SnackBar
          _buildInfoCard(
            title: '✅ 수강신청 성공 알림',
            subtitle: '기능: 피드백  👉  대표 위젯: SnackBar',
            content: '화면 아래에서 "저장 완료!" 하고 쓱 올라오는 알림창입니다.',
            icon: Icons.message,
            trailingWidget: ElevatedButton(
              onPressed: () {
                // SnackBar 띄우기
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('🎉 올클 기원! 수강신청이 성공적으로 저장되었습니다.'),
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text('저장하기'),
            ),
          ),

          // [5] 새 화면 열기 -> 상호작용 -> Navigator
          _buildInfoCard(
            title: '🚀 다른 페이지로 넘어가기',
            subtitle: '기능: 상호작용  👉  대표 위젯: Navigator',
            content: '버튼을 눌러 완전히 새로운 화면으로 이동할 때 씁니다.',
            icon: Icons.open_in_new,
            trailingWidget: OutlinedButton(
              onPressed: () {
                // Navigator를 이용한 화면 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DetailScreen(),
                  ),
                );
              },
              child: const Text('새 화면 열기'),
            ),
          ),
        ],
      ),
    );
  }

  // 코드를 깔끔하게 유지하기 위한 커스텀 카드 위젯 빌더
  Widget _buildInfoCard({
    required String title,
    required String subtitle,
    required String content,
    required IconData icon,
    Widget? trailingWidget,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.deepPurple, size: 28),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
              ],
            ),
            const Divider(height: 20, thickness: 1),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    content,
                    style: TextStyle(color: Colors.grey[700], fontSize: 14),
                  ),
                ),
                if (trailingWidget != null) ...[
                  const SizedBox(width: 16),
                  trailingWidget,
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }

  // GridView 예시용 가짜 이미지 박스
  Widget _buildMockImage(Color color) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.image, color: Colors.white, size: 20),
    );
  }
}

// Navigator로 넘어갈 새로운 화면 (새 화면 열기 예시)
class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('새로운 화면 짠! ✨'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Navigator를 타고 성공적으로 넘어왔습니다!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // 뒤로 가기
              },
              child: const Text('뒤로 돌아가기'),
            ),
          ],
        ),
      ),
    );
  }
}