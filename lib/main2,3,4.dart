import 'package:flutter/material.dart';

void main() {
  runApp(const WarmWidgetApp());
}

class WarmWidgetApp extends StatelessWidget {
  const WarmWidgetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '따뜻한 위젯 가이드 & 예시',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: const Color(0xFFFFF8F0), // 부드러운 크림색 배경
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFFB74D), // 따뜻한 오렌지색
          foregroundColor: Colors.black87,
          elevation: 0,
          centerTitle: true,
        ),
        fontFamily: 'Roboto',
      ),
      home: const WidgetGuideScreen(),
    );
  }
}

class WidgetGuideScreen extends StatelessWidget {
  const WidgetGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '☕ 따뜻한 위젯 가이드',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            child: Text(
              '내용을 확인하고 하단의 버튼을 눌러 실제 동작하는 예시를 확인해 보세요!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5D4037),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // 1번 아코디언: 위젯 조립 순서
          _buildExpandableCard(
            title: '1. 위젯 조립 순서 (화면 흐름)',
            icon: Icons.account_tree_rounded,
            content: const _WidgetFlowContent(),
          ),
          
          // 2번 아코디언: 위젯의 3가지 역할
          _buildExpandableCard(
            title: '2. 위젯의 3가지 역할 분류',
            icon: Icons.category_rounded,
            content: const _WidgetRoleContent(),
          ),

          // 3번 아코디언: 기능으로 위젯 찾기
          _buildExpandableCard(
            title: '3. 기능으로 위젯 찾기 (암기 탈출)',
            icon: Icons.lightbulb_rounded,
            content: const _WidgetCatalogContent(),
          ),
        ],
      ),
    );
  }

  // 공통 아코디언 카드 위젯
  Widget _buildExpandableCard({
    required String title,
    required IconData icon,
    required Widget content,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: const Color(0xFFE65100),
          collapsedIconColor: const Color(0xFF8D6E63),
          title: Row(
            children: [
              Icon(icon, color: const Color(0xFFFFA726)),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4E342E),
                  ),
                ),
              ),
            ],
          ),
          children: [
            Container(
              width: double.infinity,
              color: const Color(0xFFFFF3E0),
              padding: const EdgeInsets.all(16.0),
              child: content,
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// [1] 첫 번째 섹션 내용 및 예시 버튼
// =====================================================================
class _WidgetFlowContent extends StatelessWidget {
  const _WidgetFlowContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Scaffold -> AppBar -> ListView -> Card -> ElevatedButton 순서로 조립합니다.',
          style: TextStyle(color: Color(0xFF5D4037), fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        Center(
          child: ElevatedButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FlowExampleScreen()),
            ),
            icon: const Icon(Icons.play_arrow_rounded),
            label: const Text('조립 순서 예시 보기'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFB74D),
              foregroundColor: Colors.black87,
            ),
          ),
        )
      ],
    );
  }
}

// [1] 첫 번째 섹션의 실제 동작 예시 화면
class FlowExampleScreen extends StatelessWidget {
  const FlowExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Scaffold (화면 틀)
    return Scaffold(
      // 2. AppBar (상단 제목)
      appBar: AppBar(title: const Text('1. 조립 순서 예시')),
      // 3. ListView (본문 목록)
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // 4. Card (정보 묶음)
          Card(
            color: Colors.white,
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Text('설명한 순서대로 만들어진 카드입니다.', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 20),
                  // 5. ElevatedButton (완료 동작)
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('확인 완료 (돌아가기)'),
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

// =====================================================================
// [2] 두 번째 섹션 내용 및 예시 버튼
// =====================================================================
class _WidgetRoleContent extends StatelessWidget {
  const _WidgetRoleContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('보이는 것(Text, Image), 배치하는 것(Row, Column), 반응하는 것(Button)의 조합입니다.'),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RoleExampleScreen()),
          ),
          icon: const Icon(Icons.play_arrow_rounded),
          label: const Text('3가지 역할 조합 예시 보기'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFB74D),
            foregroundColor: Colors.black87,
          ),
        )
      ],
    );
  }
}

// [2] 두 번째 섹션의 실제 동작 예시 화면
class RoleExampleScreen extends StatefulWidget {
  const RoleExampleScreen({super.key});

  @override
  State<RoleExampleScreen> createState() => _RoleExampleScreenState();
}

class _RoleExampleScreenState extends State<RoleExampleScreen> {
  String _inputText = "여기에 입력한 글자가 보입니다.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('2. 위젯 역할 예시')),
      body: Padding(
        // 배치하는 것 (Padding)
        padding: const EdgeInsets.all(20.0),
        // 배치하는 것 (Column)
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 보이는 것 (Icon, Text) + 배치하는 것 (Row)
            Row(
              children: [
                const Icon(Icons.face, size: 40, color: Colors.orange),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _inputText,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // 반응하는 것 (TextField)
            TextField(
              decoration: const InputDecoration(
                labelText: '텍스트를 입력해보세요',
                border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                setState(() {
                  _inputText = text.isEmpty ? "여기에 입력한 글자가 보입니다." : text;
                });
              },
            ),
            const Spacer(),
            // 반응하는 것 (Button) -> 상호작용
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
              child: const Text('이해했어요! (닫기)'),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// [3] 세 번째 섹션 내용 및 예시 버튼
// =====================================================================
class _WidgetCatalogContent extends StatelessWidget {
  const _WidgetCatalogContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Switch, GridView, SnackBar 등 기능과 연결된 위젯들의 모음입니다.'),
        const SizedBox(height: 16),
        Center(
          child: ElevatedButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CatalogExampleScreen()),
            ),
            icon: const Icon(Icons.play_arrow_rounded),
            label: const Text('기능별 위젯 예시 보기'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFB74D),
              foregroundColor: Colors.black87,
            ),
          ),
        )
      ],
    );
  }
}

// [3] 세 번째 섹션의 실제 동작 예시 화면
class CatalogExampleScreen extends StatefulWidget {
  const CatalogExampleScreen({super.key});

  @override
  State<CatalogExampleScreen> createState() => _CatalogExampleScreenState();
}

class _CatalogExampleScreenState extends State<CatalogExampleScreen> {
  bool _isSwitchOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('3. 기능 위젯 예시')),
      // 기능: 스크롤 -> 대표 위젯: ListView
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // 기능: 입력 -> 대표 위젯: Switch
          ListTile(
            title: const Text('다크모드 흉내내기 (Switch)'),
            trailing: Switch(
              value: _isSwitchOn,
              activeColor: Colors.orange,
              onChanged: (val) => setState(() => _isSwitchOn = val),
            ),
          ),
          const Divider(),
          
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text('사진 모음 (GridView)', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          // 기능: 스크롤/격자 -> 대표 위젯: GridView
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true, // ListView 안에서 GridView를 쓸 때 필수
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            children: List.generate(3, (index) {
              return Container(
                color: Colors.orange.shade200,
                child: const Icon(Icons.image, color: Colors.white, size: 40),
              );
            }),
          ),
          const SizedBox(height: 30),

          // 기능: 피드백 -> 대표 위젯: SnackBar
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('저장이 완료되었습니다! (SnackBar)'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('피드백 띄우기 (SnackBar)'),
          ),
          
          const SizedBox(height: 10),
          
          // 기능: 상호작용 -> 대표 위젯: Navigator
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('이전 화면으로 돌아가기 (Navigator)'),
          ),
        ],
      ),
    );
  }
}