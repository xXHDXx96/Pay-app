import 'package:flutter/material.dart';
import '../../core/theme.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('多币种资产')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _assetCard('CNY 人民币', '120,300.00 CNY', '≈ \$16,639.00', Colors.red),
          _assetCard('USD 美元', '85,338.50 USD', '≈ ¥620,000.00', Colors.green),
          _assetCard('USDT 链上加密', '28,900.00 USDT', '≈ ¥210,000.00', Colors.teal),
          _assetCard('BTC 链上加密', '0.42 BTC', '≈ \$84,930.00', Colors.orange),
          _assetCard('ETH 链上加密', '8.50 ETH', '≈ \$27,625.00', Colors.purple),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _actionBtn(Icons.add_circle_outline, '充值', context)),
              const SizedBox(width: 12),
              Expanded(child: _actionBtn(Icons.remove_circle_outline, '提现', context)),
              const SizedBox(width: 12),
              Expanded(child: _actionBtn(Icons.swap_horiz, '一键闪兑', context)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _assetCard(String title, String balance, String fiatValue, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: color.withOpacity(0.2), child: Icon(Icons.currency_bitcoin, color: color)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(fiatValue, style: const TextStyle(color: Colors.grey)),
        trailing: Text(balance, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _actionBtn(IconData icon, String label, BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.cardDark,
        foregroundColor: AppTheme.neonCyan,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}