class PreInvoice {
  final String invoiceId;
  final String invoiceNumber;
  final String orderId;
  final String customerName;
  final String product;
  final String fee;
  final String weight;
  final String branch;
  // final String thickness;
  // final String width;
  final String size;
  final String grade;
  final String howPay;
  final String untilPay;
  final String orderDate;
  final String ontax;
  final String profitMonth;
  final String operatorName;
  final String orderType;
  final String price;
  // final String total

  PreInvoice({
    required this.invoiceId,
    required this.invoiceNumber,
    required this.orderId,
    required this.customerName,
    required this.product,
    required this.fee,
    required this.weight,
    required this.branch,
    // required this.thickness,
    // required this.width,
    required this.size,
    required this.grade,
    required this.howPay,
    required this.untilPay,
    required this.orderDate,
    required this.ontax,
    required this.profitMonth,
    required this.operatorName,
    required this.orderType,
    required this.price,
  });

  factory PreInvoice.fromJson(Map<String, dynamic> json) {
    return PreInvoice(
        invoiceId: json['invoice_id'],
        invoiceNumber: json['invoice_number'],
        orderId: json['order_id'],
        customerName: json['customer_info']['company_name'],
        product: json['product'],
        fee: json['fee'],
        weight: json['weight'],
        branch: json['branch'],
        // thickness: json['thickness'],
        // width: json['width'],
        size: json['size'],
        grade: json['grade'],
        howPay: json['how_pay'],
        untilPay: json['until_pay'],
        orderDate: json['order_date'],
        ontax: json['ontax'],
        profitMonth: json['profit_month'],
        operatorName: json['operator_name'],
        orderType: json['order_type'] ?? '',
        price: json['price'] ?? '');
  }
}
