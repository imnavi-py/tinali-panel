import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:steelpanel/control/user-info.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:http/http.dart' as http;

class OrderTrackingPage extends StatefulWidget {
  @override
  _OrderTrackingPageState createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool invoiceLoaded = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    fetchOrderDetails(42);
    checkInvoice();
  }

  List<Invoice> invoices = [];
  Future<List<Invoice>> fetchInvoices() async {
    final response = await http.get(Uri.parse(
        'https://test.ht-hermes.com/users/customers/pre_invoices.php?order_id=53'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      print(jsonResponse);

      // پردازش داده‌ها و تبدیل به لیست Invoice
      invoices = jsonResponse.map((data) => Invoice.fromJson(data)).toList();

      // تنظیم مقدار invoiceLoaded به true بعد از پردازش داده‌ها
      invoiceLoaded = true;
      setState(() {});
      return invoices;
    } else {
      throw Exception('Failed to load invoices');
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  checkInvoice() {
    if (UserInfoControll.status.value == 1) {
      _invoices = fetchInvoices();
    } else {
      print('no status value is : ${UserInfoControll.status.value}');
    }
  }

  final List<int> steps = [UserInfoControll.status.value - 1, 1, 3, 4, 2, 1];
  final List<String> _steps = [
    'صدور پیش فاکتور',
    'فاکتور',
    'بارگیری',
    'ارسال',
    'تحویل',
  ];
  final List<String> status = [
    'ثبت اولیه',
    'تایید شده',
    'صدور پیش فاکتور',
    'در انتظار پرداخت',
    'آماده سازی',
    'ارسال شده',
    'تحویل شده'
  ];
  double screenWidth = 0;

  double screenHeight = 0;

//baraye yekbar farakhuni shodan
  @override
  void didChangeDependencies() {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    super.didChangeDependencies();
  }

  Future<void> fetchOrderDetails(int orderId) async {
    final response = await http.get(
      Uri.parse(
          'https://test.ht-hermes.com/orders/read-order.php?order_id=$orderId'),
      headers: {'Content-Type': 'application/json'},
      // body: jsonEncode({'order_id': orderId}),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      // چاپ کل پاسخ JSON برای درک ساختار آن
      print(jsonResponse);

      // حالا بررسی کنید که jsonResponse یک List است یا Map
      if (jsonResponse is List) {
        // پردازش وقتی که پاسخ از نوع List است
        print('دریافت یک List: $jsonResponse');
        // ممکن است نیاز باشد که درون List را پیمایش کرده و هر مورد را پردازش کنید
      } else if (jsonResponse is Map) {
        // پردازش وقتی که پاسخ از نوع Map است
        print('دریافت یک Map: $jsonResponse');
      } else {
        print('نوع غیرمنتظره برای پاسخ JSON: ${jsonResponse.runtimeType}');
      }
    } else {
      print('خطا: ${response.statusCode}');
    }
  }

  late Future<List<Invoice>> _invoices;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 226, 219, 219),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 60,
              color: const Color(0xFF2E2E48),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.06,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(55),
                          child: Obx(() {
                            return UserInfoControll.user_avatar.value.isNotEmpty
                                ? Image.memory(
                                    base64Decode(
                                        UserInfoControll.user_avatar.value),
                                    fit: BoxFit.cover,
                                  )
                                : Image.memory(
                                    base64Decode(
                                        UserInfoControll.testavatar.value),
                                    fit: BoxFit.cover,
                                  );
                          }),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        UserInfoControll.username.value,
                        style: const TextStyle(
                            color: Colors.white, fontFamily: 'Irs'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: const Color(0xFF2E2E48),
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.blue,
                tabs: const [
                  Tab(text: 'سفارش باز'),
                  Tab(text: 'سفارشات رد شده'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: screenWidth * 0.9,
                                  height: screenHeight * 0.2,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 8),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade400,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Text(
                                          'سفارش در حال بررسی',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Irs',
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        children: [
                                          const Text('مشخصات سفارش: '),
                                          SizedBox(
                                            width: 600,
                                            child: Container(
                                              height: 50,
                                              alignment: Alignment.center,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                itemCount: UserInfoControll
                                                    .items.length,
                                                itemBuilder: (context, index) {
                                                  return Center(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10.0),
                                                      child: Container(
                                                        height: 50,
                                                        width: 100,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color:
                                                                  Colors.black,
                                                              spreadRadius: 1,
                                                              blurRadius: 3,
                                                            ),
                                                          ],
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                              UserInfoControll
                                                                      .items
                                                                      .value[
                                                                  index]),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (UserInfoControll.status.value >
                                  0) // Using an if statement for conditional rendering
                                if (!invoiceLoaded)
                                  SizedBox(
                                    child: CircularProgressIndicator(),
                                  )
                                else
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: screenHeight * 0.4,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                            child: Row(
                                              children: [
                                                Text('شماره سفارش: '),
                                                Text(invoices[index]
                                                    .invoiceNumber),
                                                Expanded(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(invoices[index]
                                                        .orderDate),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: SizedBox(
                                                  height: screenHeight * 0.1,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12.0),
                                                    child: ListView.builder(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: _steps.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Center(
                                                          child: Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.10,
                                                            child: TimelineTile(
                                                              axis: TimelineAxis
                                                                  .horizontal,
                                                              alignment:
                                                                  TimelineAlign
                                                                      .center,
                                                              isFirst:
                                                                  index == 0,
                                                              isLast: index ==
                                                                  _steps.length -
                                                                      1,
                                                              indicatorStyle:
                                                                  IndicatorStyle(
                                                                indicator: index <=
                                                                        steps[0]
                                                                    ? const Icon(
                                                                        Icons
                                                                            .circle,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            0,
                                                                            255,
                                                                            131))
                                                                    : const Icon(
                                                                        Icons
                                                                            .circle_outlined,
                                                                        color: Color(
                                                                            0xFF2E2E48),
                                                                        size:
                                                                            20),
                                                                drawGap: true,
                                                                height: 20,
                                                                width: 20,
                                                                color: index <=
                                                                        steps[0]
                                                                    ? const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        0,
                                                                        255,
                                                                        131)
                                                                    : const Color(
                                                                        0xFF2E2E48),
                                                              ),
                                                              beforeLineStyle:
                                                                  LineStyle(
                                                                color: index <=
                                                                        steps[0]
                                                                    ? const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        0,
                                                                        255,
                                                                        131)
                                                                    : const Color(
                                                                        0xFF2E2E48),
                                                                thickness: 3,
                                                              ),
                                                              endChild: Center(
                                                                child: Text(
                                                                  _steps[index],
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Color(
                                                                        0xFF2E2E48),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Row(
                                                children: [
                                                  Text('کد سفارش: '),
                                                  Text('12345'),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 15),
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Row(
                                              children: [
                                                const Text(
                                                  'وضعیت سفارش: ',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                    fontFamily: 'Irs',
                                                  ),
                                                ),
                                                Text(
                                                  'تایید فاکتور',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors
                                                        .lightBlue.shade800,
                                                    fontFamily: 'Irs',
                                                  ),
                                                ),
                                                const Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'مرحله بعدی: ',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black,
                                                          fontFamily: 'Irs',
                                                        ),
                                                      ),
                                                      Text(
                                                        'تایید پرداخت',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black,
                                                          fontFamily: 'Irs',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 16.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Expanded(
                                                  child: Text(
                                                    'ویژگی سفارش: ',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black,
                                                      fontFamily: 'Irs',
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: SizedBox(
                                                    width: screenWidth * 0.45,
                                                    height: screenHeight * 0.08,
                                                    child: ListView.builder(
                                                      itemCount: 5,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        8.0),
                                                            child: Container(
                                                              height:
                                                                  screenHeight *
                                                                      0.06,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                boxShadow: const [
                                                                  BoxShadow(
                                                                    color: Color(
                                                                        0xFF2E2E48),
                                                                    blurRadius:
                                                                        2,
                                                                    spreadRadius:
                                                                        1,
                                                                  ),
                                                                ],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                              ),
                                                              width: 100,
                                                              child: const Text(
                                                                  'datadatadata'),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 16.0),
                                                    child: Container(
                                                      width: screenWidth * 0.3,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors.red.shade600,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: const Text(
                                                        'درخواست لغو',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white,
                                                          fontFamily: 'Irs',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  const Center(child: Text('محتوای سفارشات رد شده')),
                ],
              ),
            ),
          ],
        ));
  }
}

class Invoice {
  final String invoiceId;
  final String invoiceNumber;
  final String orderId;
  final Map<String, dynamic> customerInfo;
  final String economicCode;
  final String product; // UTF-8 encoded field
  final String fee;
  final String weight; // UTF-8 encoded field
  final String branch;
  final String? thickness;
  final String? width;
  final String size;
  final String grade;
  final String howPay; // UTF-8 encoded field
  final String untilPay; // UTF-8 encoded field
  final String orderDate;
  final String ontax;
  final String profitMonth;
  final String operatorName;
  final String createdAt;
  final String price;
  final String orderType;

  Invoice({
    required this.invoiceId,
    required this.invoiceNumber,
    required this.orderId,
    required this.customerInfo,
    required this.economicCode,
    required this.product,
    required this.fee,
    required this.weight,
    required this.branch,
    this.thickness,
    this.width,
    required this.size,
    required this.grade,
    required this.howPay,
    required this.untilPay,
    required this.orderDate,
    required this.ontax,
    required this.profitMonth,
    required this.operatorName,
    required this.createdAt,
    required this.price,
    required this.orderType,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      invoiceId: json['invoice_id'] as String,
      invoiceNumber: json['invoice_number'] as String,
      orderId: json['order_id'] as String,
      customerInfo: json['customer_info'] as Map<String, dynamic>,
      economicCode: json['economic_code'] as String,
      product: _decodeUtf8(json['product'] as String),
      fee: json['fee'] as String,
      weight: _decodeUtf8(json['weight'] as String),
      branch: json['branch'] as String,
      thickness: json['thickness'] as String?,
      width: json['width'] as String?,
      size: json['size'] as String,
      grade: json['grade'] as String,
      howPay: _decodeUtf8(json['how_pay'] as String),
      untilPay: _decodeUtf8(json['until_pay'] as String),
      orderDate: json['order_date'] as String,
      ontax: json['ontax'] as String,
      profitMonth: json['profit_month'] as String,
      operatorName: json['operator_name'] as String,
      createdAt: json['created_at'] as String,
      price: json['price'] as String,
      orderType: json['order_type'] as String,
    );
  }

  // Helper function to decode UTF-8 encoded strings
  static String _decodeUtf8(String encodedString) {
    try {
      // Decode the string if it contains invalid UTF-8 characters
      return utf8.decode(encodedString.codeUnits);
    } catch (e) {
      // Return the original string if decoding fails
      return encodedString;
    }
  }
}
