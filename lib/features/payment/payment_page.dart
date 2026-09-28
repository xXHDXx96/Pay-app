import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../core/api.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _amountCtrl = TextEditingController();
  final _api = ApiClient();
  Timer? _timer;
  String? _qrData, _orderNo;
  String _status = 'IDLE';

  void _createOrder() async {
    if (_amountCtrl.text.isEmpty) return;
    setState(() => _status = 'CREATING');
    try {
      final data = await _api.createOrder(double.parse(_amountCtrl.text));
      setState(() {
        _orderNo = data['order_no'];
        _qrData = 'alipay://pay?amount=${data['actual_amount']}&order=$_orderNo';
        _status = 'PENDING';
      });
      _timer = Timer.periodic(const Duration(seconds: 3), (t) async {
        final s = await _api.getOrderStatus(_orderNo!);
        if (s['status'] == 'PAID') { t.cancel(); setState(() => _status = 'SUCCESS'); }
      });
    } catch (e) {
      setState(() => _status = 'IDLE');
    }
  }

  @override
  void dispose() { _timer?.cancel(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('聚合收银台')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_status == 'IDLE' || _status == 'CREATING') ...[
              TextField(
                controller: _amountCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: '输入金额 (元)', prefixIcon: Icon(Icons.attach_money)),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _channelChip('支付宝', true)),
                  const SizedBox(width: 8),
                  Expanded(child: _channelChip('微信', false)),
                  const SizedBox(width: 8),
                  Expanded(child: _channelChip('USDT', false)),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity, height: 50,
                child: ElevatedButton(
                  onPressed: _createOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00E5FF),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('生成聚合收款码', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
            if (_status == 'PENDING' && _qrData != null) ...[
              QrImageView(data: _qrData!, size: 220, backgroundColor: Colors.white, padding: const EdgeInsets.all(12)),
              const SizedBox(height: 16),
              Text('订单号: $_orderNo', style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 8),
              const Text('请使用支付宝/微信扫码支付', style: TextStyle(color: Colors.grey)),
            ],
            if (_status == 'SUCCESS') ...[
              const Icon(Icons.check_circle, color: Colors.green, size: 80),
              const SizedBox(height: 12),
              const Text('支付成功！', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ]
          ],
        ),
      ),
    );
  }

  Widget _channelChip(String label, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF00E5FF).withOpacity(0.2) : const Color(0xFF141A29),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: selected ? const Color(0xFF00E5FF) : Colors.transparent),
      ),
      child: Center(child: Text(label, style: TextStyle(color: selected ? const Color(0xFF00E5FF) : Colors.white70))),
    );
  }
}