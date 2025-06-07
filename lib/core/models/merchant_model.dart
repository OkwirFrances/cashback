class MerchantModel {
  final String id;
  final String name;
  final String logoUrl;
  final double cashbackRate;
  final List<String> categories;
  final double? minPurchaseAmount;
  final bool isFeatured;

  MerchantModel({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.cashbackRate,
    this.categories = const [],
    this.minPurchaseAmount,
    this.isFeatured = false,
  });

  factory MerchantModel.fromMap(Map<String, dynamic> map) {
    return MerchantModel(
      id: map['id'],
      name: map['name'],
      logoUrl: map['logoUrl'],
      cashbackRate: map['cashbackRate']?.toDouble() ?? 0.0,
      categories: List<String>.from(map['categories'] ?? []),
      minPurchaseAmount: map['minPurchaseAmount']?.toDouble(),
      isFeatured: map['isFeatured'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'logoUrl': logoUrl,
      'cashbackRate': cashbackRate,
      'categories': categories,
      if (minPurchaseAmount != null) 'minPurchaseAmount': minPurchaseAmount,
      'isFeatured': isFeatured,
    };
  }
}
