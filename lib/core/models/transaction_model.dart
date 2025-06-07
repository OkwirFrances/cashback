class TransactionModel {
  final String id;
  final String userId;
  final String type; // 'cashback', 'purchase', 'withdrawal', 'deposit'
  final double amount;
  final DateTime date;
  final String description;
  final String? merchantId;
  final String? reference;
  final String? status;

  TransactionModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.amount,
    required this.date,
    required this.description,
    this.merchantId,
    this.reference,
    this.status = 'completed',
  });

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      userId: map['userId'],
      type: map['type'],
      amount: map['amount']?.toDouble() ?? 0.0,
      date: DateTime.parse(map['date']),
      description: map['description'],
      merchantId: map['merchantId'],
      reference: map['reference'],
      status: map['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'type': type,
      'amount': amount,
      'date': date.toIso8601String(),
      'description': description,
      if (merchantId != null) 'merchantId': merchantId,
      if (reference != null) 'reference': reference,
      'status': status,
    };
  }
}
