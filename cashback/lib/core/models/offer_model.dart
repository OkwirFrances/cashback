class OfferModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double cashback;
  final DateTime startDate;
  final DateTime endDate;
  final String merchantId;
  final List<String>? applicableItems;
  final String? promoCode;

  OfferModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.cashback,
    required this.startDate,
    required this.endDate,
    required this.merchantId,
    this.applicableItems,
    this.promoCode,
  });

  factory OfferModel.fromMap(Map<String, dynamic> map) {
    return OfferModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      cashback: map['cashback']?.toDouble() ?? 0.0,
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
      merchantId: map['merchantId'],
      applicableItems: map['applicableItems'] != null
          ? List<String>.from(map['applicableItems'])
          : null,
      promoCode: map['promoCode'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'cashback': cashback,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'merchantId': merchantId,
      if (applicableItems != null) 'applicableItems': applicableItems,
      if (promoCode != null) 'promoCode': promoCode,
    };
  }
}
