import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/theme.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('资产大盘'),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_none), onPressed: () {}),
          IconButton(icon: const Icon(Icons.qr_code), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 1. 总资产卡片（对接 Account / Ledger 接口）
            _buildBalanceCard(),
            const SizedBox(height: 20),
            // 2. 4个核心快捷操作（收款、付款、闪兑、卡包）
            _buildQuickActions(),
            const SizedBox(height: 20),
            // 3. 支付通道流量分布（对接支付渠道统计接口）
            _buildChannelChart(),
            const SizedBox(height: 20),
            // 4. 最近交易流水（对接 ListOrders 接口）
            _buildRecentTransactions(),
            const SizedBox(height: 20),
            // 5. 待结算与对账（对接 Settlement / Reconciliation 接口）
            _buildSettlementSummary(),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.neonCyan, AppTheme.neonPurple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: AppTheme.neonCyan.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('总资产折合估值', style: TextStyle(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: 8),
          const Text('¥ 1,840,454.81', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: const [
              Text('USD: \$254,558.07', style: TextStyle(color: Colors.white70)),
              SizedBox(width: 16),
              Text('USDT: 28,900.00', style: TextStyle(color: Colors.white70)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('双记账平账 ✓', style: TextStyle(color: Colors.white, fontSize: 12)),
              Text('实时汇率折算中', style: TextStyle(color: Colors.white, fontSize: 12)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _actionBtn(Icons.qr_code_scanner, '扫码付款'),
        _actionBtn(Icons.payment, '商户收款'),
        _actionBtn(Icons.swap_horiz, '一键闪兑'),
        _actionBtn(Icons.account_balance_wallet, '提现卡包'),
      ],
    );
  }

  Widget _actionBtn(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.cardDark,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.neonCyan.withOpacity(0.3)),
          ),
          child: Icon(icon, color: AppTheme.neonCyan, size: 28),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
      ],
    );
  }

  Widget _buildChannelChart() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('支付通道流量分布', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(value: 42.5, title: '42.5%', color: AppTheme.neonCyan, radius: 50),
                    PieChartSectionData(value: 38.0, title: '38.0%', color: AppTheme.neonPurple, radius: 50),
                    PieChartSectionData(value: 12.5, title: '12.5%', color: Colors.green, radius: 50),
                    PieChartSectionData(value: 7.0, title: '7.0%', color: Colors.orange, radius: 50),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentTransactions() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('最近交易流水', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('查看全部 >', style: TextStyle(color: AppTheme.neonCyan)),
              ],
            ),
            const SizedBox(height: 16),
            _txRow('星巴克咖啡臻选旗舰店', '-¥128.00', '支付成功', Colors.green),
            _txRow('USDT 链上充值', '+28,900.00 USDT', '已确认', Colors.green),
            _txRow('商户 A 结算', '-¥8,450.00', '结算中', Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _txRow(String title, String amount, String status, Color statusColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 4),
              Text(status, style: TextStyle(color: statusColor, fontSize: 12)),
            ],
          ),
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSettlementSummary() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('待审核退款工单', style: TextStyle(fontSize: 14)),
            Text('1 单', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}