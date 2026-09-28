import 'package:dio/dio.dart';

class Api {
  static const String base = 'https://pay-zdgd.onrender.com/api/v1';
  static final Dio _d = Dio(BaseOptions(baseUrl: base, connectTimeout: const Duration(seconds: 15)));

  // ==================== 订单 ====================
  static Future<Map> createManualOrder(double amount, String merchantId) async =>
      (await _d.post('/manual/create', data: {'amount': amount, 'merchant_id': merchantId})).data;
  static Future<Map> createOrder(Map body) async => (await _d.post('/pay', data: body)).data;
  static Future<List> listOrders({String? merchantId}) async =>
      (await _d.get('/orders', queryParameters: {'merchant_id': merchantId})).data['orders'] ?? [];
  static Future<Map> getOrder(int id) async => (await _d.get('/orders/$id')).data;
  static Future<Map> updateOrder(int id, Map body) async => (await _d.put('/orders/$id', data: body)).data;

  // ==================== 二维码 & 通知 ====================
  static Future<Map> qrcode(Map body) async => (await _d.post('/qrcode', data: body)).data;

  // ==================== 加密货币兑换 ====================
  static Future<Map> quote(double amount) async => (await _d.post('/exchange/quote', data: {'amount': amount})).data;
  static Future<Map> redeem(String orderNo, String wallet) async =>
      (await _d.post('/exchange/redeem', data: {'order_no': orderNo, 'wallet_address': wallet})).data;
  static Future<Map> getRedemption(String orderNo) async => (await _d.get('/exchange', queryParameters: {'order_id': orderNo})).data;

  // ==================== 分账 ====================
  static Future<Map> createSplit(Map body) async => (await _d.post('/splits', data: body)).data;
  static Future<List> listSplits(int orderId) async => (await _d.get('/splits', queryParameters: {'order_id': orderId})).data['splits'] ?? [];

  // ==================== 结算 ====================
  static Future<List> listSettlements(String merchantId) async =>
      (await _d.get('/settlements', queryParameters: {'merchant_id': merchantId})).data['settlements'] ?? [];
  static Future<Map> createSettlement(Map body) async => (await _d.post('/settlements', data: body)).data;
  static Future<List> listSettlementOrders(int batchId) async =>
      (await _d.get('/settlements/$batchId/orders')).data['orders'] ?? [];

  // ==================== 退款 ====================
  static Future<Map> createRefund(Map body) async => (await _d.post('/refunds', data: body)).data;
  static Future<List> listRefunds(int orderId) async =>
      (await _d.get('/refunds', queryParameters: {'order_id': orderId})).data['refunds'] ?? [];

  // ==================== 对账 ====================
  static Future<List> listReconciliations(String channel, String date) async =>
      (await _d.get('/reconciliations', queryParameters: {'channel': channel, 'date': date})).data['recons'] ?? [];
  static Future<Map> createReconciliation(Map body) async => (await _d.post('/reconciliations', data: body)).data;

  // ==================== KYC / AML ====================
  static Future<Map> getKyc(int userId) async => (await _d.get('/kyc', queryParameters: {'user_id': userId})).data;
  static Future<Map> createKyc(Map body) async => (await _d.post('/kyc', data: body)).data;
  static Future<Map> getAml(int userId) async => (await _d.get('/aml', queryParameters: {'user_id': userId})).data;
  static Future<Map> createAml(Map body) async => (await _d.post('/aml', data: body)).data;

  // ==================== 账本 ====================
  static Future<List> listAccounts() async => (await _d.get('/accounts')).data['accounts'] ?? [];
  static Future<List> listLedger(String ref) async =>
      (await _d.get('/ledger', queryParameters: {'reference_id': ref})).data['entries'] ?? [];

  // ==================== 商户 ====================
  static Future<List> listMerchants() async => (await _d.get('/merchants')).data['merchants'] ?? [];
  static Future<Map> createMerchant(Map body) async => (await _d.post('/merchants', data: body)).data;

  // ==================== 风控 ====================
  static Future<List> listRiskRules() async => (await _d.get('/risk/rules')).data['rules'] ?? [];
  static Future<List> listRiskEvents() async => (await _d.get('/risk/events')).data['events'] ?? [];

  // ==================== Webhook ====================
  static Future<List> listWebhooks() async => (await _d.get('/webhooks')).data['deliveries'] ?? [];

  // ==================== 费率 ====================
  static Future<List> listFees() async => (await _d.get('/fees')).data['fees'] ?? [];

  // ==================== 审计 ====================
  static Future<List> listAudit() async => (await _d.get('/audit')).data['logs'] ?? [];
}