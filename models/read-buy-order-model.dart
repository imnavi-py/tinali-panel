class BuyOrder {
  final int orderId;
  final int supplier_id;
  final String economicCode;
  final String product;
  final double fee;
  final String weight;
  final String branch;
  final String thickness;
  final String width;
  final String size;
  final String grade;
  final String howPay;
  final String untilPay;
  final DateTime orderDate;
  final String ontax;
  final String profitMonth;
  final String operatorName;

  BuyOrder({
    required this.orderId,
    required this.supplier_id,
    required this.economicCode,
    required this.product,
    required this.fee,
    required this.weight,
    required this.branch,
    required this.thickness,
    required this.width,
    required this.size,
    required this.grade,
    required this.howPay,
    required this.untilPay,
    required this.orderDate,
    required this.ontax,
    required this.profitMonth,
    required this.operatorName,
  });

  factory BuyOrder.fromJson(Map<String, dynamic> json) {
    return BuyOrder(
      orderId: json['order_id'],
      supplier_id: json['supplier_id'],
      economicCode: json['economic_code'],
      product: json['product'],
      fee: json['fee'].toDouble(),
      weight: json['weight'],
      branch: json['branch'],
      thickness: json['thickness'],
      width: json['width'],
      size: json['size'],
      grade: json['grade'],
      howPay: json['how_pay'],
      untilPay: json['until_pay'],
      orderDate: DateTime.parse(json['order_date']),
      ontax: json['ontax'],
      profitMonth: json['profit_month'],
      operatorName: json['operator_name'],
    );
  }
}
