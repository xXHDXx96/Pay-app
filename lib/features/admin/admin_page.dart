import 'package:flutter/material.dart';
import '../../core/theme.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('企业管理后台')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _menuItem(Icons.badge, 'KYC 实名认证', '提交/查询用户 KYC 状态'),
          _menuItem(Icons.security, 'AML 风控审核', '查看风险评分与黑名单匹配'),
          _menuItem(Icons.store, '商户管理', '商户信息与费率配置'),
          _menuItem(Icons.warning, '风控规则', '规则配置与风险事件日志'),
          _menuItem(Icons.account_balance, '资金账本', '复式记账与账户余额'),
          _menuItem(Icons.webhook, 'Webhook 推送', '异步通知与重试记录'),
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String title, String subtitle) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: AppTheme.neonPurple.withOpacity(0.2), child: Icon(icon, color: AppTheme.neonPurple)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {},
      ),
    );
  }
}