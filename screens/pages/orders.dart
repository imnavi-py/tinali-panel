import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:searchbar_animation/searchbar_animation.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:steelpanel/api/add-log.dart';
import 'package:steelpanel/api/config.dart';
import 'package:steelpanel/control/user-info.dart';
import 'package:steelpanel/screens/factors.dart';
import 'package:steelpanel/screens/homescreen.dart';
import 'package:steelpanel/screens/pages/orders-data.dart';
import 'package:steelpanel/screens/testfactor.dart';
import 'package:steelpanel/widgets/add-order-buy.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:steelpanel/widgets/add-order-sell.dart';

class OrdersPage extends StatefulWidget {
  final Function() refresh;

  const OrdersPage({super.key, required this.refresh});
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<BuyOrder>> futureBuyOrders;
  late Future<List<SellOrder>> futureSellOrders;
  final TextEditingController searchController = TextEditingController();
  late int tabid = 1;
  bool showHeaderbuy = false;
  bool showHeadersell = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
    futureBuyOrders = fetchBuyOrders();
    futureSellOrders = fetchSellOrders();
  }

  void refresh() {
    futureBuyOrders = fetchBuyOrders();
    futureSellOrders = fetchSellOrders();
    setState(() {});
  }

  Future<List<BuyOrder>> fetchBuyOrders() async {
    final response = await http
        .get(Uri.parse('${apiService.apiurl}/supplier/read-buy-order.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      showHeaderbuy = data.isNotEmpty ? true : false;
      setState(() {});
      return data.map((item) => BuyOrder.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load buy orders');
    }
  }

  Future<List<SellOrder>> fetchSellOrders() async {
    final response = await http
        .post(Uri.parse('https://test.ht-hermes.com/orders/read-order.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      showHeadersell = data.isNotEmpty ? true : false;
      setState(() {});
      return data.map((item) => SellOrder.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load sell orders');
    }
  }

// add to pre_invoice
  String _response = '';
  void _addtoPreinvoce(orderID) async {
    try {
      final response = await http.post(
          Uri.parse('https://test.ht-hermes.com/factors/add_preinvoice.php'),
          body: jsonEncode({"order_id": orderID}));

      if (response.statusCode == 200) {
        print('yes');
        // print(response.body);
        // var data = jsonDecode(response.body)['invoice_number'];
        print(jsonDecode(response.body)['invoice_number']);
        // Get.showSnackbar(GetSnackBar(
        //   title: 'موفقیت',
        //   // message: ' پیش فاکتور با موفقیت صادر شد ',
        //   messageText: Column(
        //     children: [
        //       Text('پیش فاکتور با موفقیت صادر شد '),
        //       Text('شماره سفارش :${data['invoice_number']}')
        //     ],
        //   ),
        // ));
        print('ja inja 1');
        // Get.to(InvoicesPage(refresh: refresh))!
        //     .then((value) => Get.showSnackbar(GetSnackBar(
        //           title: 'موفقیت',
        //           // message: ' پیش فاکتور با موفقیت صادر شد ',
        //           messageText: Column(
        //             children: [
        //               Text('پیش فاکتور با موفقیت صادر شد '),
        //               Text('شماره سفارش :${data['invoice_number']}')
        //             ],
        //           ),
        //         )));
        print('ta inja 2');
        // setState(() {});
      } else {
        setState(() {
          _response = 'Error: ${response.statusCode}';
        });
        // throw Exception('Failed to load buy orders');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 226, 219, 219),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E2E48),
        title: const Text(
          'سفارشات',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        bottom: TabBar(
          onTap: (value) {
            value = tabid;
            setState(() {});
          },
          controller: _tabController,
          tabs: const [
            Tab(text: 'خرید'),
            Tab(text: 'فروش'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(
                    controller:
                        SidebarXController(selectedIndex: 0, extended: true),
                  ),
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          OrdersListView<BuyOrder>(
            futureOrders: futureBuyOrders,
            tabindex: _tabController.index,
            showit: showHeaderbuy,
          ),
          OrdersListView<SellOrder>(
            futureOrders: futureSellOrders,
            tabindex: tabid,
            showit: showHeadersell,
          ),
        ],
      ),
    );
  }
}

class OrdersListView<T> extends StatefulWidget {
  final Future<List<T>> futureOrders;
  final int tabindex;
  final bool showit;
  const OrdersListView(
      {super.key,
      required this.futureOrders,
      required this.tabindex,
      required this.showit});

  @override
  _OrdersListViewState<T> createState() => _OrdersListViewState<T>();
}

class _OrdersListViewState<T> extends State<OrdersListView<T>> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.green.shade400,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  void refresh() {
                    setState(() {});
                  }

                  widget.tabindex == 1
                      ? Get.to(AddOrderPage(
                          refresh: refresh,
                        ))
                      : Get.to(AddBuyOrderPage(refresh: refresh));
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<List<T>>(
            future: widget.futureOrders,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No orders found.'));
              } else {
                List<T> orders = snapshot.data!;
                return Column(
                  children: [
                    widget.showit ? headerWidget(orders.length) : Container(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OrderCard(
                              order: orders[index],
                              tabid: widget.tabindex,
                              onTap: () =>
                                  _showOrderDetails(context, orders[index]),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget headerWidget(int orders) {
    void refresh() {
      setState(() {});
    }

    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  widget.tabindex == 1
                      ? Get.to(AddOrderPage(
                          refresh: refresh,
                        ))
                      : Get.to(AddBuyOrderPage(refresh: refresh));
                },
                icon: const Icon(Icons.add),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                        controller: SidebarXController(
                            selectedIndex: 0, extended: true),
                      ),
                    ),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.home),
              ),
              IconButton(
                onPressed: () {
                  Get.to(const ProductSelectionPage());
                },
                icon: const Icon(
                  Icons.settings,
                  color: Color(0xFF0D47A1),
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
                  orders.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 12.0),
                child: Text(
                  ' تعداد سفارشات',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'BYekan',
                  ),
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
    );
  }

  void _showOrderDetails(BuildContext context, dynamic order) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return OrderDetailsSheet(order: order);
      },
    );
  }
}

class OrderDetailsSheet extends StatefulWidget {
  final dynamic order;
  static TextEditingController economicCodeController = TextEditingController();
  static TextEditingController productController = TextEditingController();
  static TextEditingController feeController = TextEditingController();
  static TextEditingController weightController = TextEditingController();
  static TextEditingController branchController = TextEditingController();
  static TextEditingController thicknessController = TextEditingController();
  static TextEditingController widthController = TextEditingController();
  static TextEditingController sizeController = TextEditingController();
  static TextEditingController gradeController = TextEditingController();
  static TextEditingController howPayController = TextEditingController();
  static TextEditingController untilPayController = TextEditingController();
  static TextEditingController orderDateController = TextEditingController();
  static TextEditingController ontaxController = TextEditingController();
  static TextEditingController profitMonthController = TextEditingController();
  static TextEditingController operatorNameController = TextEditingController();
  static TextEditingController responsibleNameController =
      TextEditingController();
  static TextEditingController customerIdController = TextEditingController();
  static TextEditingController productPrice = TextEditingController();

  const OrderDetailsSheet({super.key, required this.order});

  @override
  _OrderDetailsSheetState createState() => _OrderDetailsSheetState();
}

class _OrderDetailsSheetState extends State<OrderDetailsSheet> {
  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing order data
    OrderDetailsSheet.economicCodeController.text =
        widget.order.economic_code ?? '';
    OrderDetailsSheet.productController.text = widget.order.product ?? '';
    OrderDetailsSheet.feeController.text = widget.order.fee?.toString() ?? '';
    OrderDetailsSheet.weightController.text =
        widget.order.weight?.toString() ?? '';
    OrderDetailsSheet.branchController.text = widget.order.branch ?? '';
    OrderDetailsSheet.thicknessController.text =
        widget.order.thickness?.toString() ?? '';
    OrderDetailsSheet.widthController.text =
        widget.order.width?.toString() ?? '';
    OrderDetailsSheet.sizeController.text = widget.order.size ?? '';
    OrderDetailsSheet.gradeController.text = widget.order.grade ?? '';
    OrderDetailsSheet.howPayController.text = widget.order.how_pay ?? '';
    OrderDetailsSheet.untilPayController.text = widget.order.until_pay ?? '';
    OrderDetailsSheet.orderDateController.text = widget.order.orderDate ?? '';
    OrderDetailsSheet.ontaxController.text = widget.order.ontax ?? '';
    OrderDetailsSheet.profitMonthController.text =
        widget.order.profit_month ?? '';
    OrderDetailsSheet.operatorNameController.text =
        widget.order.operator_name ?? '';
    OrderDetailsSheet.responsibleNameController.text =
        widget.order.customerName ?? '';
    OrderDetailsSheet.productPrice.text = widget.order.price ?? '';
  }

  resfresh() {
    setState(() {});
  }

  Future<void> _updateOrder() async {
    final response = await http.post(
      Uri.parse('https://test.ht-hermes.com/orders/update-order.php'),
      body: jsonEncode({
        'order_id': widget.order.order_id,
        'economic_code':
            OrderDetailsSheet.economicCodeController.text.isNotEmpty
                ? OrderDetailsSheet.economicCodeController.text
                : null,
        'product': OrderDetailsSheet.productController.text.isNotEmpty
            ? OrderDetailsSheet.productController.text
            : null,
        'fee': OrderDetailsSheet.feeController.text.isNotEmpty
            ? double.tryParse(OrderDetailsSheet.feeController.text)
            : null,
        'weight': OrderDetailsSheet.weightController.text.isNotEmpty
            ? double.tryParse(OrderDetailsSheet.weightController.text)
            : null,
        'branch': OrderDetailsSheet.branchController.text.isNotEmpty
            ? OrderDetailsSheet.branchController.text
            : null,
        'thickness': OrderDetailsSheet.thicknessController.text.isNotEmpty
            ? double.tryParse(OrderDetailsSheet.thicknessController.text)
            : null,
        'width': OrderDetailsSheet.widthController.text.isNotEmpty
            ? double.tryParse(OrderDetailsSheet.widthController.text)
            : null,
        'size': OrderDetailsSheet.sizeController.text.isNotEmpty
            ? OrderDetailsSheet.sizeController.text
            : null,
        'grade': OrderDetailsSheet.gradeController.text.isNotEmpty
            ? OrderDetailsSheet.gradeController.text
            : null,
        'how_pay': OrderDetailsSheet.howPayController.text.isNotEmpty
            ? OrderDetailsSheet.howPayController.text
            : null,
        'until_pay': OrderDetailsSheet.untilPayController.text.isNotEmpty
            ? OrderDetailsSheet.untilPayController.text
            : null,
        'order_date': OrderDetailsSheet.orderDateController.text.isNotEmpty
            ? OrderDetailsSheet.orderDateController.text
            : null,
        'ontax': OrderDetailsSheet.ontaxController.text.isNotEmpty
            ? OrderDetailsSheet.ontaxController.text
            : null,
        'profit_month': OrderDetailsSheet.profitMonthController.text.isNotEmpty
            ? OrderDetailsSheet.profitMonthController.text
            : null,
        'operator_name':
            OrderDetailsSheet.operatorNameController.text.isNotEmpty
                ? OrderDetailsSheet.operatorNameController.text
                : null,
        // 'responsible_name': responsibleNameController.text.isNotEmpty
        //     ? responsibleNameController.text
        //     : null,
        'price': OrderDetailsSheet.productPrice.text.isNotEmpty
            ? OrderDetailsSheet.productPrice.text
            : null,
      }),
      // headers: {
      //   'Content-Type': 'application/json',
      // },
    );

    if (response.statusCode == 200) {
      void refresh() {
        setState(() {});
      }

      print(response.body);
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return OrdersPage(refresh: refresh);
        },
      ));
      // Navigator.pop(context); // Close the Bottom Sheet on success
    } else {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update order.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600, // Set the height of the BottomSheet here
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                // readOnly: true,
                controller: OrderDetailsSheet.productPrice,
                decoration: const InputDecoration(labelText: 'قیمت تمام شده'),
              ),
              TextField(
                readOnly: true,
                controller: OrderDetailsSheet.economicCodeController,
                decoration: const InputDecoration(labelText: 'کد اقتصادی'),
              ),
              TextField(
                readOnly: true,
                controller: OrderDetailsSheet.productController,
                decoration: const InputDecoration(labelText: 'نوع محصول'),
              ),
              TextField(
                // readOnly: true,
                controller: OrderDetailsSheet.feeController,
                decoration: const InputDecoration(labelText: 'فی'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                readOnly: true,
                controller: OrderDetailsSheet.weightController,
                decoration: const InputDecoration(labelText: 'وزن'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: OrderDetailsSheet.branchController,
                decoration: const InputDecoration(labelText: 'شاخه'),
              ),
              // TextField(
              //   controller: thicknessController,
              //   decoration: InputDecoration(labelText: 'ضخامت'),
              //   keyboardType: TextInputType.number,
              // ),
              // TextField(
              //   controller: widthController,
              //   decoration: InputDecoration(labelText: 'عرض'),
              //   keyboardType: TextInputType.number,
              // ),
              TextField(
                readOnly: true,
                controller: OrderDetailsSheet.sizeController,
                decoration: const InputDecoration(labelText: 'ویژگی/اندازه'),
              ),
              TextField(
                readOnly: true,
                controller: OrderDetailsSheet.gradeController,
                decoration: const InputDecoration(labelText: 'گرید'),
              ),
              TextField(
                controller: OrderDetailsSheet.howPayController,
                decoration: const InputDecoration(labelText: 'نحوه پرداخت'),
              ),
              TextField(
                controller: OrderDetailsSheet.untilPayController,
                decoration: const InputDecoration(labelText: 'تاریخ پرداخت'),
              ),
              TextField(
                readOnly: true,
                controller: OrderDetailsSheet.orderDateController,
                decoration: const InputDecoration(labelText: 'تاریخ سفارش'),
              ),
              TextField(
                controller: OrderDetailsSheet.ontaxController,
                decoration: const InputDecoration(labelText: 'ارزش افزوده'),
              ),
              TextField(
                controller: OrderDetailsSheet.profitMonthController,
                decoration: const InputDecoration(labelText: 'سود ماهیانه'),
              ),
              TextField(
                readOnly: true,
                controller: OrderDetailsSheet.operatorNameController,
                decoration: const InputDecoration(labelText: 'نام اپراتور'),
              ),
              TextField(
                readOnly: true,
                controller: OrderDetailsSheet.responsibleNameController,
                decoration: const InputDecoration(labelText: 'نام مسئول'),
              ),
              // TextField(
              //   readOnly: true,
              //   controller: customerIdController,
              //   decoration: InputDecoration(labelText: 'شناسه مشتری'),
              //   keyboardType: TextInputType.name,
              // ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _updateOrder,
                child: const Text('آپدیت'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuyOrder {
  final String product;
  final String orderDate;
  final String branch;
  final String customerName;
  final String grade;
  final String how_pay;
  final int order_id;
  final String economic_code;
  final String fee;
  final String weight;
  final String size;
  // final String how_pay;
  final String until_pay;
  final String ontax;
  final String profit_month;
  final String operator_name;
  final String responsible_name;
  final String thickness;
  final String width;
  final String price;

  BuyOrder({
    required this.price,
    required this.thickness,
    required this.width,
    required this.weight,
    required this.size,
    required this.until_pay,
    required this.ontax,
    required this.profit_month,
    required this.operator_name,
    required this.responsible_name,
    required this.fee,
    required this.economic_code,
    required this.grade,
    required this.how_pay,
    required this.product,
    required this.customerName,
    required this.orderDate,
    required this.order_id,
    required this.branch,
  });

  factory BuyOrder.fromJson(Map<String, dynamic> json) {
    return BuyOrder(
      order_id: json['order_id'],
      product: json['product'],
      orderDate: json['order_date'],
      branch: json['branch'],
      grade: json['grade'],
      customerName: json['responsible_name'],
      how_pay: json['how_pay'],
      price: json['price'] ?? '',
      thickness: json['thickness'] ?? '',
      width: json['width'] ?? '',
      ontax: json['ontax'] ?? '',
      operator_name: json['operator_name'] ?? '',
      profit_month: json['profit_month'] ?? '',
      responsible_name: json['responsible_name'] ?? '',
      size: json['size'] ?? '',
      until_pay: json['until_pay'] ?? '',
      weight: json['weight'] ?? '',
      economic_code: json['economic_code'],
      fee: json['fee'],
    );
  }
}

class SellOrder {
  final String product;
  final String orderDate;
  final String branch;
  final String customerName;
  final String grade;
  final String how_pay;
  final int order_id;
  final String economic_code;
  final String fee;
  final String weight;
  final String size;
  // final String how_pay;
  final String until_pay;
  final String ontax;
  final String profit_month;
  final String operator_name;
  final String responsible_name;
  final String thickness;
  final String width;
  final String price;

  SellOrder({
    required this.price,
    required this.thickness,
    required this.width,
    required this.weight,
    required this.size,
    required this.until_pay,
    required this.ontax,
    required this.profit_month,
    required this.operator_name,
    required this.responsible_name,
    required this.fee,
    required this.economic_code,
    required this.grade,
    required this.how_pay,
    required this.product,
    required this.customerName,
    required this.orderDate,
    required this.order_id,
    required this.branch,
  });

  factory SellOrder.fromJson(Map<String, dynamic> json) {
    return SellOrder(
      price: json['price'] ?? '',
      thickness: json['thickness'] ?? '',
      width: json['width'] ?? '',
      ontax: json['ontax'] ?? '',
      operator_name: json['operator_name'] ?? '',
      profit_month: json['profit_month'] ?? '',
      responsible_name: json['responsible_name'] ?? '',
      size: json['size'] ?? '',
      until_pay: json['until_pay'] ?? '',
      weight: json['weight'] ?? '',
      order_id: json['order_id'] ?? '',
      product: json['product'] ?? '',
      orderDate: json['order_date'] ?? '',
      branch: json['branch'] ?? '',
      customerName: json['responsible_name'] ?? '',
      grade: json['grade'],
      how_pay: json['how_pay'] ?? '',
      economic_code: json['economic_code'] ?? '',
      fee: json['fee'] ?? '',
    );
  }
}

final Dio dio = Dio();
final Dio diobuy = Dio();

Future<void> deleteBuyOrder(String orderIdbuy) async {
  try {
    final response = await diobuy.delete(
      'https://test.ht-hermes.com/orders/delete-sell-order.php',
      data: {'order_id': orderIdbuy},
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      print('Success!');
      AddtoLogs('سفارشات',
          'کاربر ${UserInfoControll.username}با آیدی:${UserInfoControll.user_id} کاربر با آیدی سفارش:$orderIdbuy را پاک کردن');
    } else {
      print('Error: ${response.data}');
    }
  } catch (e) {
    print('Exception caught: $e');
  }
}

Future<void> deleteSellOrder(String orderId) async {
  try {
    final response = await dio.delete(
      'https://test.ht-hermes.com/orders/delete-sell-order.php',
      data: {'order_id': orderId},
    );

    if (response.statusCode == 200) {
      print('Success!');
      AddtoLogs('سفارشات',
          'کاربر ${UserInfoControll.username}با آیدی:${UserInfoControll.user_id} کاربر با آیدی سفارش:$orderId را پاک کردن');
    } else {
      print('Error: ${response.data}');
    }
  } catch (e) {
    print('Exception caught: $e');
  }
}
