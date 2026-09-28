import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'features/dashboard/dashboard_page.dart';
import 'features/payment/payment_page.dart';
import 'features/wallet/wallet_page.dart';
import 'features/history/history_page.dart';
import 'features/admin/admin_page.dart';

void main() => runApp(const PaySphereApp());

class PaySphereApp extends StatelessWidget {
  const PaySphereApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PaySphere Enterprise',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const MainShell(),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;
  final _pages = const [
    DashboardPage(),
    PaymentPage(),
    WalletPage(),
    HistoryPage(),
    AdminPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: '仪表盘'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: '收银台'),
          BottomNavigationBarItem(icon: Icon(Icons.currency_exchange), label: '多币种'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: '账单'),
          BottomNavigationBarItem(icon: Icon(Icons.admin_panel_settings), label: '管理'),
        ],
      ),
    );
  }
}