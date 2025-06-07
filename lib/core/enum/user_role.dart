enum UserRole {
  customer,
  merchant,
  admin,
}

extension UserRoleExtension on UserRole {
  String get name {
    switch (this) {
      case UserRole.customer:
        return 'Customer';
      case UserRole.merchant:
        return 'Merchant';
      case UserRole.admin:
        return 'Admin';
    }
  }

  String get value {
    return toString().split('.').last;
  }

  static UserRole fromString(String value) {
    return UserRole.values.firstWhere(
      (e) => e.value == value,
      orElse: () => UserRole.customer,
    );
  }
}
