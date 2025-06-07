class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final double walletBalance;
  final String? photoUrl;
  final DateTime? createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.walletBalance,
    this.photoUrl,
    this.createdAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      walletBalance: map['walletBalance']?.toDouble() ?? 0.0,
      photoUrl: map['photoUrl'],
      createdAt: map['createdAt']?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'walletBalance': walletBalance,
      if (photoUrl != null) 'photoUrl': photoUrl,
      if (createdAt != null) 'createdAt': createdAt,
    };
  }
}
