import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchbar_animation/searchbar_animation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:steelpanel/api/config.dart';
import 'package:steelpanel/models/factor-model.dart';
import 'package:steelpanel/models/invoice-model.dart';
import 'package:steelpanel/models/prinffc.dart';
import 'package:steelpanel/models/print-model-factore.dart';
import 'package:steelpanel/screens/homescreen.dart';
import 'package:steelpanel/screens/pages/home.dart';
import 'package:steelpanel/screens/pages/invoice-card.dart';

class InvoicesPage extends StatefulWidget {
  final Function() refresh;

  const InvoicesPage({super.key, required this.refresh});
  @override
  _InvoicesPageState createState() => _InvoicesPageState();
}

class _InvoicesPageState extends State<InvoicesPage>
    with SingleTickerProviderStateMixin {
  double screenWidth = 0;
  double screenHeight = 0;

  @override
  void didChangeDependencies() {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    super.didChangeDependencies();
  }

  late TabController _tabController;
  late Future<List<PreInvoice>> futurePreInvoices;
  final TextEditingController searchController = TextEditingController();

  late Future<List<Invoice>> invoices;

  Future<List<Invoice>> fetchInvoices() async {
    final response = await http
        .get(Uri.parse('${apiService.apiurl}/factors/read_invoices.php'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      return jsonResponse.map((data) => Invoice.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load invoices');
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    futurePreInvoices = fetchPreInvoices();
    invoices = fetchInvoices();
  }

  Future<List<PreInvoice>> fetchPreInvoices() async {
    final response = await http.get(
        Uri.parse('https://test.ht-hermes.com/factors/read_preinvoices.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => PreInvoice.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load pre-invoices');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 226, 219, 219),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E2E48),
        title: const Text('فاکتورها'),
        centerTitle: true,
        titleTextStyle: const TextStyle(color: Colors.white),
        toolbarTextStyle: const TextStyle(color: Colors.white),
        bottom: TabBar(
          labelStyle: const TextStyle(color: Colors.white),
          unselectedLabelStyle:
              const TextStyle(color: Color.fromARGB(255, 184, 180, 180)),
          controller: _tabController,
          tabs: const [
            Tab(
              text: 'پیش‌فاکتور',
            ),
            Tab(text: 'فاکتور'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          FutureBuilder<List<PreInvoice>>(
            future: futurePreInvoices,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No pre-invoices found.'));
              } else {
                List<PreInvoice> preInvoices = snapshot.data!;
                return Column(
                  children: [
                    headerWidget(preInvoices.length),
                    Expanded(
                      child: ListView.builder(
                        itemCount: preInvoices.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InvoiceCard(invoice: preInvoices[index]),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            },
          ),
          Center(
            child: FutureBuilder<List<Invoice>>(
                future: invoices,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No invoices found'));
                  } else {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: screenWidth > 0 && screenWidth < 850
                              ? 1
                              : screenWidth > 850 && screenWidth < 1900
                                  ? 2
                                  : screenWidth > 2400 && screenWidth < 3000
                                      ? 3
                                      : 4),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Invoice invoice = snapshot.data![index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            // width: screenWidth * 0.5,
                            height: 200,
                            color: Colors.white,
                            child: SizedBox(
                                width: screenWidth,
                                height: screenHeight,
                                child: Column(
                                  children: [
                                    factorindex1(
                                      txt_left1: invoice.createdAt,
                                      txt_right1: 'تاریخ : ',
                                      txt_left2: invoice.invoiceNumber,
                                      txt_right2: 'شماره فاکتور : ',
                                    ),

                                    //

                                    Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: factorindex1(
                                            txt_left1: invoice.customerId,
                                            txt_right1: 'آیدی کاربری : ',
                                            txt_left2:
                                                'آقای ${invoice.responsibleName} ',
                                            txt_right2: 'نام : ')),
                                    factorindex1(
                                        txt_left1: invoice
                                            .customerInfo.registrationNumber,
                                        txt_right1: 'شماره ثبت : ',
                                        txt_left2: invoice.economicCode,
                                        txt_right2: 'کد اقتصادی : '),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                child: const Text('پرداخت : '),
                                              ),
                                              Container(
                                                width: 50,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  invoice.howPay.toString(),
                                                  style: const TextStyle(
                                                      fontFamily: 'Irs',
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                child: const Text(
                                                  'نوع سفارش : ',
                                                  style: TextStyle(
                                                      color: Colors.amber),
                                                ),
                                              ),
                                              Container(
                                                width: 50,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  invoice.orderType == 'sell'
                                                      ? 'فروش'
                                                      : 'خرید',
                                                  style: const TextStyle(
                                                      fontFamily: 'Irs',
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 226, 219, 219),
                                              showDragHandle: true,
                                              context: context,
                                              builder: (context) {
                                                return Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Container(
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          child: factorindex1(
                                                              txt_left1: invoice
                                                                  .customerInfo
                                                                  .id
                                                                  .toString(),
                                                              txt_right1:
                                                                  ' : آیدی',
                                                              txt_left2: invoice
                                                                  .responsibleName,
                                                              txt_right2:
                                                                  ' : نام'),
                                                        ),
                                                        factorindex1(
                                                            txt_left1: invoice
                                                                .customerInfo
                                                                .nationalId,
                                                            txt_right1:
                                                                ' : شماره ملی',
                                                            txt_left2: invoice
                                                                .companyName,
                                                            txt_right2:
                                                                ' : نام شرکت'),
                                                        factorindex1(
                                                          txt_right1:
                                                              ' : شماره ثبت',
                                                          txt_left1: invoice
                                                              .customerInfo
                                                              .registrationNumber,
                                                          txt_right2:
                                                              ' : کد اقتصادی',
                                                          txt_left2: invoice
                                                              .customerInfo
                                                              .economicCode,
                                                        ),
                                                        factorindex1(
                                                            txt_left1: invoice
                                                                .customerInfo
                                                                .postalCode,
                                                            txt_right1:
                                                                ' : کد پستی',
                                                            txt_left2: invoice
                                                                .customerInfo
                                                                .phoneNumber,
                                                            txt_right2:
                                                                ' : شماره تماس'),
                                                        factorindex1(
                                                            txt_left1: invoice
                                                                .customerInfo
                                                                .operatorName,
                                                            txt_right1:
                                                                ' : اپراتور',
                                                            txt_left2: invoice
                                                                .customerInfo
                                                                .createdAt,
                                                            txt_right2:
                                                                ' : تاریخ ثبت'),
                                                        Center(
                                                          child: Text(invoice
                                                              .customerInfo
                                                              .address),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: const Text(
                                              'دیدن مشخصات مشتری',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Irs',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 226, 219, 219),
                                              showDragHandle: true,
                                              context: context,
                                              builder: (context) {
                                                return Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Container(
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                                  border: Border
                                                                      .all()),
                                                          child: factorindex1(
                                                              txt_left1: invoice
                                                                  .products
                                                                  .size,
                                                              txt_right1:
                                                                  ' :  سایز/ویژگی',
                                                              txt_left2: invoice
                                                                  .products
                                                                  .product,
                                                              txt_right2:
                                                                  ' : محصول'),
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                                  border: Border
                                                                      .all()),
                                                          child: factorindex1(
                                                              txt_left1: invoice
                                                                  .products
                                                                  .grade,
                                                              txt_right1:
                                                                  ' :  گرید',
                                                              txt_left2: invoice
                                                                  .products
                                                                  .weight,
                                                              txt_right2:
                                                                  ' :  وزن'),
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                                  border: Border
                                                                      .all()),
                                                          child: factorindex1(
                                                              txt_left1: invoice
                                                                  .products.fee,
                                                              txt_right1:
                                                                  ' :  فی',
                                                              txt_left2: invoice
                                                                  .products
                                                                  .branch,
                                                              txt_right2:
                                                                  ' :  شاخه/بندیل'),
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                                  border: Border
                                                                      .all()),
                                                          child: factorindex1(
                                                              txt_left1: invoice
                                                                  .products
                                                                  .orderId
                                                                  .toString(),
                                                              txt_right1:
                                                                  ' :   شماره سفارش',
                                                              txt_left2: invoice
                                                                  .customerInfo
                                                                  .operatorName,
                                                              txt_right2:
                                                                  ' :   اپراتور'),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: const Text(
                                              'دیدن مشخصات سفارش',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Irs',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),

                                    //

                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: const [
                                                BoxShadow(
                                                    blurStyle: BlurStyle.inner,
                                                    color: Colors.grey,
                                                    blurRadius: 1,
                                                    spreadRadius: 2)
                                              ]),
                                          child: Text(
                                            ' وضعیت فاکتور : ',
                                            style: TextStyle(
                                                fontFamily: 'Irs',
                                                fontSize: 15,
                                                color: Colors.grey.shade100),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            invoice.status == 'Pending'
                                                ? 'در انتظار تایید'
                                                : 'تایید شده',
                                            style: const TextStyle(
                                                fontFamily: 'Irs',
                                                fontSize: 15,
                                                color: Colors.orange,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(
                                      height: 25,
                                    ),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 25,
                                          width: 120,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            'تایید نهایی',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Irs',
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          height: 25,
                                          width: 120,
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            'لغو فاکتور',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Irs',
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 25,
                                          width: 120,
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            'آماده سازی',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Irs',
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.to(const PrintableFactor());
                                          },
                                          child: Container(
                                            height: 25,
                                            width: 120,
                                            decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            alignment: Alignment.center,
                                            child: const Text(
                                              'پرینت فاکتور',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Irs',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                        );
                      },
                    );
                  }
                }),
          )
        ],
      ),
    );
  }

  Widget headerWidget(int invoices) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return HomeMain(
                            xxcontroller: SidebarXController(
                                selectedIndex: 0, extended: false),
                          );
                        },
                      ));
                    },
                    icon: const Icon(
                      Icons.home,
                      color: Colors.black,
                    )),
                const Padding(
                  padding: EdgeInsets.only(right: 12.0),
                  child: Text(
                    'تعداد فاکتورها : ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'BYekan',
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 25,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade900,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    invoices.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 12.0),
                  child: Text(
                    'آماده به فاکتور : ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'BYekan',
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 25,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade900,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Text(
                    '2',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: SearchBarAnimation(
                  isOriginalAnimation: false,
                  textEditingController: searchController,
                  buttonWidget: Icon(
                    Icons.search,
                    color: Colors.blue.shade300,
                  ),
                  secondaryButtonWidget: const Icon(Icons.close),
                  trailingWidget: const Icon(Icons.search_rounded),
                  buttonShadowColour: Colors.black26,
                  buttonBorderColour: Colors.black26,
                  onFieldSubmitted: (String text) {
                    // Handle search
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class factorindex1 extends StatelessWidget {
  const factorindex1({
    super.key,
    required this.txt_left1,
    required this.txt_right1,
    required this.txt_left2,
    required this.txt_right2,
  });
  final String txt_left1;
  final String txt_right1;
  final String txt_left2;
  final String txt_right2;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(115, 235, 227, 227),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  child: Text(txt_right1),
                ),
                Container(
                  child: Text(txt_left1),
                ),
              ],
            ),
            //

            Row(
              children: [
                Container(
                  child: Text(txt_right2),
                ),
                Container(
                  child: Text(txt_left2),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
