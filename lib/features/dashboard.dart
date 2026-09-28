import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../core/api.dart';
import '../core/theme.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List _orders = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() { super.initState(); _load(); }

  Future<void> _load() async {
    setState(() { _loading = true; _error = null; });
    try {
      final list = await Api.listOrders(merchantId: 'demo');
      setState(() { _orders = list; _loading = false; });
    } catch (e) {
      setState(() { _error = '加载失败: $e'; _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('资产大盘'), actions: [
        IconButton(icon: const Icon(Icons.refresh), onPressed: _load),
      ]),
      body: RefreshIndicator(
        onRefresh: _load,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBalanceCard(),
              const SizedBox(height: 20),
              _buildQuickActions(),
              const SizedBox(height: 24),
              _buildChannelChart(),
              const SizedBox(height: 24),
              const Text('最近交易流水', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.cyan)),
              const SizedBox(height: 12),
              _buildTransactionList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppTheme.cyan, AppTheme.purple], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: AppTheme.cyan.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('总资产折合估值', style: TextStyle(color: Colors.white70)),
          SizedBox(height: 8),
          Text('¥ 1,840,454.81', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Text('USD: \$254,558.07  ·  USDT: 28,900.00  ·  BTC: 0.42', style: TextStyle(color: Colors.white70)),
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
    return Column(children: [
      Container(padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppTheme.card, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppTheme.cyan.withOpacity(0.3))),
        child: Icon(icon, color: AppTheme.cyan, size: 28)),
      const SizedBox(height: 8),
      Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.grey)),
    ]);
  }

  Widget _buildChannelChart() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppTheme.card, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('支付通道流量分布', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(value: 42.5, title: '支付宝 42%', color: AppTheme.cyan, radius: 50, titleStyle: const TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold)),
                  PieChartSectionData(value: 38.0, title: '微信 38%', color: AppTheme.purple, radius: 50, titleStyle: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)),
                  PieChartSectionData(value: 12.5, title: '银联 12%', color: AppTheme.green, radius: 50, titleStyle: const TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold)),
                  PieChartSectionData(value: 7.0, title: '钱包 7%', color: AppTheme.orange, radius: 50, titleStyle: const TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionList() {
    if (_loading) return const Center(child: Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator()));
    if (_error != null) return Center(child: Text(_error!, style: const TextStyle(color: AppTheme.red)));
    if (_orders.isEmpty) return const Center(child: Padding(padding: EdgeInsets.all(20), child: Text('暂无交易记录', style: TextStyle(color: AppTheme.grey))));

    return Column(
      children: _orders.take(5).map((o) => Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          title: Text('${o['out_order_no'] ?? '未知订单'}', style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('¥${o['amount_cny'] ?? '0.00'}', style: const TextStyle(color: AppTheme.grey)),
          trailing: Text('${o['status'] ?? 'PENDING'}', style: TextStyle(
            color: o['status'] == 'PAID' ? AppTheme.green : AppTheme.orange, fontWeight: FontWeight.bold)),
        ),
      )).toList(),
    );
  }
}
