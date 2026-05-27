import 'package:flutter/material.dart';

void main() {
  runApp(const MyPWAApp());
}

class MyPWAApp extends StatelessWidget {
  const MyPWAApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '指令與圖片 PWA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CommandImageScreen(),
    );
  }
}

class CommandImageScreen extends StatefulWidget {
  const CommandImageScreen({super.key});

  @override
  State<CommandImageScreen> createState() => _CommandImageScreenState();
}

class _CommandImageScreenState extends State<CommandImageScreen> {
  String _recognizedText = "尚未收到指令";
  String _currentImageUrl = "https://via.placeholder.com/300?text=Waiting+for+Command";

  // 模擬接收指令並觸發圖片更新的邏輯
  void _processCommand(String command) {
    setState(() {
      _recognizedText = command;
      // 這裡可以換成實際的圖片邏輯，例如聽到特定關鍵字（如：吃水餃）就顯示對應圖片
      if (command.contains("水餃")) {
        _currentImageUrl = "https://via.placeholder.com/300?text=Dumplings+Image";
      } else {
        _currentImageUrl = "https://via.placeholder.com/300?text=Unknown+Item";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('互動圖片展示'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '目前接收到的指令：',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Text(
              _recognizedText,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            // 圖片顯示區塊
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                _currentImageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => 
                  const Center(child: Text('圖片載入失敗')),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 模擬觸發輸入事件
          _processCommand("吃水餃我想吃水餃");
        },
        tooltip: '發送指令',
        child: const Icon(Icons.mic),
      ),
    );
  }
}