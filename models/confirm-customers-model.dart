class ConfirmedCustomer {
  final int id;
  final String responsibleName;
  final String companyName;
  final String economicCode;
  final String nationalId;
  final String phoneNumber;
  final String postalCode;
  final String address;
  final String registrationNumber;
  final String operatorName;
  final bool isPremium;
  final bool hasOpenOrder;

  ConfirmedCustomer({
    required this.id,
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

  factory ConfirmedCustomer.fromJson(Map<String, dynamic> json) {
    return ConfirmedCustomer(
      id: json['id'],
      responsibleName: json['responsible_name'],
      companyName: json['company_name'],
      economicCode: json['economic_code'],
      nationalId: json['national_id'],
      phoneNumber: json['phone_number'],
      postalCode: json['postal_code'],
      address: json['address'],
      registrationNumber: json['registration_number'],
      operatorName: json['operator_name'],
      isPremium: json['is_premium'],
      hasOpenOrder: json['has_open_order'],
    );
  }
}
