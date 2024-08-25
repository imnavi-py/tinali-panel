class Invoice {
  String invoiceId;
  String preinvoiceId;
  String orderId;
  String customerId;
  String responsibleName;
  String companyName;
  String economicCode;
  Products products;
  CustomerInfo customerInfo;
  String howPay;
  String untilPay;
  String orderDate;
  String ontax;
  String profitMonth;
  String operatorName;
  String invoiceNumber;
  String createdAt;
  String orderType;
  var price;
  String totalPrice;
  String status;

  Invoice({
    required this.invoiceId,
    required this.preinvoiceId,
    required this.orderId,
    required this.customerId,
    required this.responsibleName,
    required this.companyName,
    required this.economicCode,
    required this.products,
    required this.customerInfo,
    required this.howPay,
    required this.untilPay,
    required this.orderDate,
    required this.ontax,
    required this.profitMonth,
    required this.operatorName,
    required this.invoiceNumber,
    required this.createdAt,
    required this.orderType,
    required this.price,
    required this.totalPrice,
    required this.status,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      invoiceId: json['invoice_id'] ?? '',
      preinvoiceId: json['preinvoice_id'] ?? '',
      orderId: json['order_id'] ?? '',
      customerId: json['customer_id'] ?? '',
      responsibleName: json['responsible_name'] ?? '',
      companyName: json['company_name'] ?? '',
      economicCode: json['economic_code'] ?? '',
      products: Products.fromJson(json['products'] ?? {}),
      customerInfo: CustomerInfo.fromJson(json['customer_info'] ?? {}),
      howPay: json['how_pay'] ?? '',
      untilPay: json['until_pay'] ?? '',
      orderDate: json['order_date'] ?? '',
      ontax: json['ontax'] ?? '',
      profitMonth: json['profit_month'] ?? '',
      operatorName: json['operator_name'] ?? '',
      invoiceNumber: json['invoice_number'] ?? '',
      createdAt: json['created_at'] ?? '',
      orderType: json['order_type'] ?? '',
      price: json['price'] ?? '',
      totalPrice: json['total_price'] ?? '',
      status: json['status'] ?? '',
    );
  }
}

class Products {
  String fee;
  String size;
  String grade;
  String ontax;
  String price;
  String branch;
  String weight;
  String howPay;
  String product;
  int orderId;
  String untilPay;
  String orderDate;
  String profitMonth;
  String operatorName;

  Products({
    required this.fee,
    required this.size,
    required this.grade,
    required this.ontax,
    required this.price,
    required this.branch,
    required this.weight,
    required this.howPay,
    required this.product,
    required this.orderId,
    required this.untilPay,
    required this.orderDate,
    required this.profitMonth,
    required this.operatorName,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      fee: json['fee'] ?? '',
      size: json['size'] ?? '',
      grade: json['grade'] ?? '',
      ontax: json['ontax'] ?? '',
      price: json['price'] ?? '',
      branch: json['branch'] ?? '',
      weight: json['weight'] ?? '',
      howPay: json['how_pay'] ?? '',
      product: json['product'] ?? '',
      orderId: json['order_id'] ?? 0,
      untilPay: json['until_pay'] ?? '',
      orderDate: json['order_date'] ?? '',
      profitMonth: json['profit_month'] ?? '',
      operatorName: json['operator_name'] ?? '',
    );
  }
}

class CustomerInfo {
  int id;
  String address;
  String createdAt;
  String nationalId;
  String postalCode;
  String companyName;
  String phoneNumber;
  String economicCode;
  String operatorName;
  int hasOpenOrder;
  String responsibleName;
  String registrationNumber;

  CustomerInfo({
    required this.id,
    required this.address,
    required this.createdAt,
    required this.nationalId,
    required this.postalCode,
    required this.companyName,
    required this.phoneNumber,
    required this.economicCode,
    required this.operatorName,
    required this.hasOpenOrder,
    required this.responsibleName,
    required this.registrationNumber,
  });

  factory CustomerInfo.fromJson(Map<String, dynamic> json) {
    return CustomerInfo(
      id: json['id'] ?? 0,
      address: json['address'] ?? '',
      createdAt: json['created_at'] ?? '',
      nationalId: json['national_id'] ?? '',
      postalCode: json['postal_code'] ?? '',
      companyName: json['company_name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      economicCode: json['economic_code'] ?? '',
      operatorName: json['operator_name'] ?? '',
      hasOpenOrder: json['has_open_order'] ?? 0,
      responsibleName: json['responsible_name'] ?? '',
      registrationNumber: json['registration_number'] ?? '',
    );
  }
}
