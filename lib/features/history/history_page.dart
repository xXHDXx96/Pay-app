import 'package:flutter/material.dart';
import '../../core/theme.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('账单与对账')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionTitle('交易记录'),
          _orderRow('订单 #MAN1234', '¥128.00', 'PAID', Colors.green),
          _orderRow('订单 #MAN1235', '¥50.00', 'PENDING', Colors.orange),
          const SizedBox(height: 20),
          _sectionTitle('结算批次'),
          _orderRow('批次 #BATCH01', '¥8,450.00', 'PAID', Colors.green),
          const SizedBox(height: 20),
          _sectionTitle('对账差异'),
          _orderRow('对账 #RECON01', '差异 1 单', 'MISMATCH', Colors.red),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.neonCyan)),
    );
  }

  Widget _orderRow(String title, String amount, String status, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(title),
        subtitle: Text(amount),
        trailing: Text(status, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
      ),
    );
  }
}