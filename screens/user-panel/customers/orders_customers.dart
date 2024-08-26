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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    fetchOrderDetails('42');
    _invoices = fetchInvoices();
  }

  Future<List<Invoice>> fetchInvoices() async {
    final response = await http.get(Uri.parse(
        'https://test.ht-hermes.com/users/customers/pre_invoices.php?order_id=53'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      print(jsonResponse);
      return jsonResponse.map((data) => Invoice.fromJson(data)).toList();
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
    if (UserInfoControll.status.value == 1) {}
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

  Future<void> fetchOrderDetails(String orderId) async {
    final response = await http.post(
      Uri.parse(
          'https://test.ht-hermes.com/orders/read-order.php?order_id=$orderId'),
      headers: {'Content-Type': 'application/json'},
      // body: jsonEncode({'order_id': orderId}),
    );

    if (response.statusCode == 200) {
      String detalis = jsonDecode(response.body)['order_progress'];
      print(detalis);
    } else {
      print('Error');
    }
  }

  // int orderProgress = 0;

  //  List productList = [];
  // Future<void> fetchOrderDetails(String orderId) async {
  //   final response = await http.post(
  //     Uri.parse('https://test.ht-hermes.com/orders/read-order.php'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({'order_id': orderId}),
  //   );

  //   if (response.statusCode == 200) {
  //     List<dynamic> data = jsonDecode(response.body);
  //     int detalis = jsonDecode(response.body)['order_progress'];
  //     orderProgress = detalis;
  //     print(detalis);
  //     productList.add(jsonDecode(response.body)['product']);
  //     productList.add(jsonDecode(response.body)['size']);
  //     productList.add(jsonDecode(response.body)['weight']);
  //     productList.add(jsonDecode(response.body)['grade']);
  //   } else {
  //     print('Error');
  //   }
  // }

  // int orderProgress = 0;
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
                          return UserInfoControll.user_avatar.value != ''
                              ? Image.memory(
                                  // width: 60,
                                  fit: BoxFit.cover,
                                  base64Decode(
                                      UserInfoControll.user_avatar.value))
                              : Image.memory(
                                  // width: 60,
                                  fit: BoxFit.cover,
                                  base64Decode(
                                      UserInfoControll.testavatar.value));

                          // CircleAvatar(
                          //     child: CachedNetworkImage(
                          //       width: 60,
                          //       height: 60,
                          //       imageUrl:
                          //           "assets/images/user.jpeg",
                          //       placeholder: (context, url) =>
                          //           const CircularProgressIndicator(),
                          //       errorWidget: (context, url,
                          //               error) =>
                          //           const Icon(Icons.error),
                          //     ),
                          //   );
                        }),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      UserInfoControll.username.value,
                      style: TextStyle(color: Colors.white, fontFamily: 'Irs'),
                    )
                  ],
                )
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
                // Tab(text: 'سفارشات قبلی'),
                Tab(text: 'سفارشات رد شده'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Center(
                  child: Container(
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
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: screenHeight * 0.008,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade400,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        'سفارش در حال بررسی',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Irs'),
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenHeight * 0.05,
                                    ),
                                    Row(
                                      children: [
                                        Text('مشخصات سفارش :'),
                                        Container(
                                            width: 600,
                                            alignment: Alignment.center,
                                            child: Container(
                                              height: 50,
                                              // color: Colors.amber,
                                              alignment: Alignment.center,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                padding: EdgeInsets.symmetric(
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
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .black,
                                                                  spreadRadius:
                                                                      1,
                                                                  blurRadius: 3)
                                                            ]),
                                                        child: Center(
                                                            child: Text(
                                                                UserInfoControll
                                                                        .items
                                                                        .value[
                                                                    index])),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible:
                                  UserInfoControll.status > 0 ? true : false,
                              child: Padding(
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
                                            const Text('شماره سفارش: '),
                                            const Text('231321'),
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: const Text('55555'),
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12.0),
                                                child: ListView.builder(
                                                  padding:
                                                      const EdgeInsets.all(0),
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
                                                          isFirst: index == 0,
                                                          isLast: index ==
                                                              _steps.length - 1,
                                                          indicatorStyle:
                                                              IndicatorStyle(
                                                            indicator: index <=
                                                                    steps[0]
                                                                ? const Icon(
                                                                    Icons
                                                                        .circle,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            0,
                                                                            255,
                                                                            131),
                                                                  )
                                                                : const Icon(
                                                                    Icons
                                                                        .circle_outlined,
                                                                    color: Color(
                                                                        0xFF2E2E48),
                                                                    size: 20,
                                                                  ),
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
                                                            child: Container(
                                                              // color: Colors.blue,
                                                              child: Text(
                                                                _steps[index],
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
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
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: const Row(
                                              children: [
                                                Text('کد سفارش : '),
                                                Text('12345'),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Container(
                                          child: Row(
                                            children: [
                                              const Text(
                                                'وضعیت سفارش : ',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                    fontFamily: 'Irs'),
                                              ),
                                              Text(
                                                'تایید فاکتور',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors
                                                        .lightBlue.shade800,
                                                    fontFamily: 'Irs'),
                                              ),
                                              const Expanded(
                                                  child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'مرحله بعدی : ',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black,
                                                        fontFamily: 'Irs'),
                                                  ),
                                                  Text(
                                                    'تایید پرداخت',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black,
                                                        fontFamily: 'Irs'),
                                                  )
                                                ],
                                              ))
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 16.0),
                                        child: Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Expanded(
                                                child: Text(
                                                  'ویژگی سفارش : ',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black,
                                                      fontFamily: 'Irs'),
                                                ),
                                              ),
                                              Center(
                                                child: Container(
                                                  width: screenWidth * 0.45,

                                                  // color: Colors.blue,
                                                  alignment: Alignment.center,
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
                                                            alignment: Alignment
                                                                .center,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                boxShadow: const [
                                                                  BoxShadow(
                                                                      color: Color(
                                                                          0xFF2E2E48),
                                                                      blurRadius:
                                                                          2,
                                                                      spreadRadius:
                                                                          1)
                                                                ],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
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
                                                          color: Colors
                                                              .red.shade600,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                      child: const Text(
                                                        'درخواست لغو',
                                                        style: TextStyle(
                                                            // fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.white,
                                                            fontFamily: 'Irs'),
                                                      )

                                                      // OutlinedButton(
                                                      //     style: ButtonStyle(
                                                      //         backgroundColor:
                                                      //             MaterialStatePropertyAll<
                                                      //                     Color>(
                                                      //                 Colors
                                                      //                     .red.shade600)),
                                                      //     onPressed: () {},
                                                      //     child: const Text(
                                                      //       'درخواست لغو',
                                                      //       style: TextStyle(
                                                      //           // fontSize: 15,
                                                      //           fontWeight:
                                                      //               FontWeight.w500,
                                                      //           color: Colors.white,
                                                      //           fontFamily: 'Irs'),
                                                      //     )),
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                // const Center(child: Text('محتوای سفارشات قبلی')),
                const Center(child: Text('محتوای سفارشات رد شده')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Invoice {
  final String invoiceId;
  final String invoiceNumber;
  final String orderId;
  final Map<String, dynamic> customerInfo;
  final String economicCode;
  final String product;
  final String fee;
  final String weight;
  final String branch;
  final String? thickness;
  final String? width;
  final String size;
  final String grade;
  final String howPay;
  final String untilPay;
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
      invoiceId: json['invoice_id'],
      invoiceNumber: json['invoice_number'],
      orderId: json['order_id'],
      customerInfo: jsonDecode(json['customer_info']),
      economicCode: json['economic_code'],
      product: json['product'],
      fee: json['fee'],
      weight: json['weight'],
      branch: json['branch'],
      thickness: json['thickness'],
      width: json['width'],
      size: json['size'],
      grade: json['grade'],
      howPay: json['how_pay'],
      untilPay: json['until_pay'],
      orderDate: json['order_date'],
      ontax: json['ontax'],
      profitMonth: json['profit_month'],
      operatorName: json['operator_name'],
      createdAt: json['created_at'],
      price: json['price'],
      orderType: json['order_type'],
    );
  }
}
