class Customer {
  // int id;
  String responsibleName;
  String companyName;
  String economicCode;
  String nationalId;
  String phoneNumber;
  String postalCode;
  String address;
  String registrationNumber;
  String operatorName;
  bool isPremium;
  bool hasOpenOrder;

  Customer({
    // required this.id,
    required this.responsibleName,
    required this.companyName,
    required this.economicCode,
    required this.nationalId,
    required this.phoneNumber,
    required this.postalCode,
    required this.address,
    required this.registrationNumber,
    required this.operatorName,
    required this.isPremium,
    required this.hasOpenOrder,
  });

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'responsible_name': responsibleName,
      'company_name': companyName,
      'economic_code': economicCode,
      'national_id': nationalId,
      'phone_number': phoneNumber,
      'postal_code': postalCode,
      'address': address,
      'registration_number': registrationNumber,
      'operator_name': operatorName,
      'is_premium': isPremium,
      'has_open_order': hasOpenOrder,
    };
  }
}
