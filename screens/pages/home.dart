import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:steelpanel/control/user-info.dart';
import 'package:steelpanel/screens/buyandsell.dart';
import 'package:steelpanel/screens/factors.dart';
import 'package:steelpanel/screens/homescreen.dart';
import 'package:steelpanel/screens/pages/customers.dart';
import 'package:steelpanel/screens/pages/orders.dart';
import 'package:steelpanel/screens/user-panel/customers/add-order-customer.dart';
import 'package:steelpanel/screens/user-panel/customers/indentity-pending.dart';
import 'package:steelpanel/screens/user-panel/customers/indentity.dart';
import 'package:steelpanel/screens/user-panel/customers/order-pending.dart';
import 'package:steelpanel/screens/user-panel/customers/orders_customers.dart';
import 'package:steelpanel/widgets/add-order-sell.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({Key? key, required this.xxcontroller}) : super(key: key);
  final SidebarXController xxcontroller;
  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  double screenWidth = 0;

  double screenHeight = 0;

//baraye yekbar farakhuni shodan
  @override
  void didChangeDependencies() {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    super.didChangeDependencies();
  }
  // final _controller = SidebarXController(selectedIndex: 0, extended: true);

  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SidebarX Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        canvasColor: canvasColor,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            color: Colors.white,
            fontSize: 46,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      home: Builder(
        builder: (context) {
          final isSmallScreen = MediaQuery.of(context).size.width < 600;
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              key: _key,
              appBar: isSmallScreen
                  ? AppBar(
                      backgroundColor: canvasColor,
                      title: Text(
                          _getTitleByIndex(widget.xxcontroller.selectedIndex)),
                      leading: IconButton(
                        onPressed: () {
                          // if (!Platform.isAndroid && !Platform.isIOS) {
                          //   _controller.setExtended(true);
                          // }
                          _key.currentState?.openDrawer();
                        },
                        icon: const Icon(Icons.menu),
                      ),
                    )
                  : null,
              endDrawer: ExampleSidebarX(controller: widget.xxcontroller),
              body: Row(
                children: [
                  if (!isSmallScreen)
                    ExampleSidebarX(controller: widget.xxcontroller),
                  Expanded(
                    child: Center(
                      child: _ScreensExample(
                        controller: widget.xxcontroller,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ExampleSidebarX extends StatefulWidget {
  ExampleSidebarX({
    Key? key,
    required SidebarXController controller,
  })  : _controller = controller,
        super(key: key);

  final SidebarXController _controller;

  @override
  State<ExampleSidebarX> createState() => _ExampleSidebarXState();
}

class _ExampleSidebarXState extends State<ExampleSidebarX> {
  void _IdentidyError() {
    MotionToast(
      icon: Icons.warning_amber_rounded,
      primaryColor: Colors.grey[400]!,
      secondaryColor: Colors.yellow,
      title: const Text(
        'پیام سیستم',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: const Text(
        'ابتدا احراز هویت را کامل کنید ویا در صورت انجام احراز هویت ، برای تایید  منتظر بمانید',
        textAlign: TextAlign.end,
      ),
      position: MotionToastPosition.top,
      width: 350,
      height: 100,
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    List<SidebarXItem> itemsList;

    switch (UserInfoControll.userType.value) {
      case 'Guests':
        itemsList = guestItems; // لیست مربوط به Guests
        break;
      case 'Customers':
        itemsList = CustomerItems; // لیست مربوط به Customers
        break;
      case 'confirmed_customers':
        itemsList = CustomerItems; // لیست مربوط به confirmed_customer
        break;
      case 'Admin':
        itemsList = Adminlist; // لیست مربوط به Admin
        break;
      default:
        itemsList = guestItems; // لیست پیش‌فرض یا خالی
        break;
    }

    return Directionality(
        textDirection: TextDirection.rtl,
        child: SidebarX(
            controller: widget._controller,
            theme: SidebarXTheme(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: canvasColor,
                borderRadius: BorderRadius.circular(20),
              ),
              hoverColor: scaffoldBackgroundColor,
              textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
              selectedTextStyle: const TextStyle(color: Colors.white),
              hoverTextStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              itemTextPadding: const EdgeInsets.only(left: 30),
              selectedItemTextPadding: const EdgeInsets.only(left: 30),
              itemDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: canvasColor),
              ),
              selectedItemDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: actionColor.withOpacity(0.37),
                ),
                gradient: const LinearGradient(
                  colors: [accentCanvasColor, canvasColor],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.28),
                    blurRadius: 30,
                  )
                ],
              ),
              iconTheme: IconThemeData(
                color: Colors.white.withOpacity(0.7),
                size: 20,
              ),
              selectedIconTheme: const IconThemeData(
                color: Colors.white,
                size: 20,
              ),
            ),
            extendedTheme: const SidebarXTheme(
              width: 200,
              decoration: BoxDecoration(
                color: canvasColor,
              ),
            ),
            footerDivider: divider,
            headerBuilder: (context, extended) {
              return Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                height: 100,
                child: Image.asset('assets/images/hs.png'),
              );
            },
            items: itemsList));
  }

  void _showDisabledAlert(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Item disabled for selecting',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  //////////////////// Item List

  List<SidebarXItem> guestItems = [
    SidebarXItem(
      icon: Icons.home,
      label: 'داشبورد',
      onTap: () {
        debugPrint('Home');
      },
    ),
    SidebarXItem(
      iconWidget: Row(
        children: [
          Visibility(
            visible: UserInfoControll.userType == 'Guest',
            child: const Icon(
              Icons.lock,
              color: Colors.white,
            ),
          ),
          const Icon(
            color: Colors.white,
            Icons.shopping_bag,
          ),
        ],
      ),
      label: 'سفارشات',
      // selectable: false,
      // onTap: () => _showDisabledAlert(context),
    ),
    SidebarXItem(
        // iconWidget: FlutterLogo(size: 20),

        label: 'فاکتورها',
        iconWidget: Row(
          children: [
            Visibility(
              visible: UserInfoControll.userType == 'Guest',
              child: const Icon(
                Icons.lock,
                color: Colors.white,
              ),
            ),
            const Icon(
              color: Colors.white,
              Icons.receipt_long_outlined,
            )
          ],
        )),
    SidebarXItem(
      // icon: Icons.attach_money_sharp,
      iconWidget: Row(
        children: [
          Visibility(
            visible: UserInfoControll.userType == 'Guest',
            child: const Icon(
              Icons.lock,
              color: Colors.white,
            ),
          ),
          const Icon(
            color: Colors.white,
            Icons.attach_money_sharp,
          )
        ],
      ),
      label: 'مالی',
    ),
    SidebarXItem(
      iconWidget: Row(
        children: [
          Visibility(
            visible: UserInfoControll.userType == 'Guest',
            child: const Icon(
              Icons.lock,
              color: Colors.white,
            ),
          ),
          const Icon(
            Icons.insert_drive_file_outlined,
            color: Colors.white,
          )
        ],
      ),
      // icon: Icons.insert_drive_file_outlined,
      label: 'کاتالوگ',
    ),
    const SidebarXItem(
      icon: Icons.insert_drive_file_outlined,
      label: 'احراز هویت',
    ),
  ];

  List<SidebarXItem> Adminlist = [
    SidebarXItem(
      icon: Icons.home,
      label: 'داشبورد',
      onTap: () {
        debugPrint('Home');
      },
    ),
    const SidebarXItem(
      icon: Icons.people,
      label: 'مشتریان',
    ),
    const SidebarXItem(
      icon: Icons.shopping_bag,
      label: 'سفارشات',
      // selectable: false,
      // onTap: () => _showDisabledAlert(context),
    ),
    const SidebarXItem(
      // iconWidget: FlutterLogo(size: 20),
      icon: Icons.receipt_long_outlined,
      label: 'فاکتورها',
    ),
    const SidebarXItem(
      icon: Icons.sell_rounded,
      label: 'خرید و فروش',
    ),
    const SidebarXItem(
      icon: Icons.attach_money_sharp,
      label: 'مالی',
    ),
    const SidebarXItem(
      icon: Icons.bus_alert_outlined,
      label: 'حمل و نقل',
    ),
    const SidebarXItem(
      icon: Icons.sell_rounded,
      label: 'تامین کنندگان',
    ),
    const SidebarXItem(
      icon: Icons.sell_rounded,
      label: 'گزارشات',
    ),
    const SidebarXItem(
      icon: Icons.sell_rounded,
      label: 'گزارشات',
    ),
  ];
}

List<SidebarXItem> CustomerItems = [
  SidebarXItem(
    icon: Icons.home,
    label: 'داشبورد',
    onTap: () {
      debugPrint('Home');
    },
  ),
  SidebarXItem(
    icon: Icons.home,
    label: 'ثبت سفارش',
    onTap: () {
      debugPrint('Home');
    },
  ),
  SidebarXItem(
    icon: Icons.home,
    label: 'پیگیری سفارش',
    onTap: () {
      debugPrint('Home');
    },
  ),
  SidebarXItem(
    icon: Icons.home,
    label: 'سفارشات اخیر',
    onTap: () {
      debugPrint('Home');
    },
  ),
  SidebarXItem(
    icon: Icons.home,
    label: 'احراز هویت',
    onTap: () {
      debugPrint('Home');
    },
  ),
  SidebarXItem(
    icon: Icons.home,
    label: 'کاتالوگ',
    onTap: () {
      debugPrint('Home');
    },
  ),
];

class _ScreensExample extends StatefulWidget {
  const _ScreensExample({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  State<_ScreensExample> createState() => _ScreensExampleState();
}

class _ScreensExampleState extends State<_ScreensExample> {
  bool load = true;
  showMessage() {
    Get.defaultDialog(
      title: 'غیر قابل دسترسی',
      middleText:
          '${UserInfoControll.first_name.value} عزیز مشخصات شما در حال بررسی میباشد',
      titleStyle: const TextStyle(
        fontFamily: 'Irs',
        fontSize: 15,
        color: Colors.white,
      ),
    );
  }

  void refresh() {
    setState(() {});
  }

  void _IdentidyError() {
    MotionToast(
      icon: Icons.warning_amber_rounded,
      primaryColor: Colors.grey[400]!,
      secondaryColor: Colors.yellow,
      title: const Text(
        'پیام سیستم',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: const Text(
        'ابتدا احراز هویت را کامل کنید ویا در صورت انجام احراز هویت ، برای تایید  منتظر بمانید',
        textAlign: TextAlign.end,
      ),
      position: MotionToastPosition.top,
      width: 350,
      height: 100,
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        final pageTitle = _getTitleByIndex(widget.controller.selectedIndex);

        switch (widget.controller.selectedIndex) {
          case 0:
            return HomePage(
              controller: SidebarXController(selectedIndex: 1, extended: true),
            );
          case 1:
            if (UserInfoControll.userType.value == 'Admin') {
              return const CustomersPage();
            } else if (UserInfoControll.userType.value == 'operator') {
              return const CustomersPage();
            } else if (UserInfoControll.userType.value == 'Commerce') {
              return const CustomersPage();
            } else if (UserInfoControll.userType.value == 'Customers' ||
                UserInfoControll.userType.value == 'confirmed_customers') {
              if (UserInfoControll.verify.value == true) {
                return OrdersCustomers(refresh: refresh);
              } else {
                return OrderPending();
              }

              // return showPass();
            } else if (UserInfoControll.userType.value == 'seller') {
              return const CustomersPage();
            } else {
              // در صورتی که نوع کاربر مشخص نشده باشد یا مقدار نامعتبر باشد
              return CustomersPage();
            }
          case 2:
            if (UserInfoControll.userType.value == 'Admin') {
              return OrdersPage(
                refresh: refresh,
              );
            } else if (UserInfoControll.userType.value == 'operator') {
              return CustomersPage();
            } else if (UserInfoControll.userType.value == 'Commerce') {
              return CustomersPage();
            } else if (UserInfoControll.userType.value == 'Customers' ||
                UserInfoControll.userType.value == 'confirmed_customers') {
              return OrderTrackingPage();
            } else if (UserInfoControll.userType.value == 'seller') {
              return CustomersPage();
            } else {
              // در صورتی که نوع کاربر مشخص نشده باشد یا مقدار نامعتبر باشد
              return CustomersPage();
            }

          case 3:
            return InvoicesPage(refresh: refresh);

          case 4:
            if (UserInfoControll.userType.value == 'Admin') {
              return const BuyandSell();
            } else if (UserInfoControll.userType.value == 'operator') {
              return const BuyandSell();
            } else if (UserInfoControll.userType.value == 'Commerce') {
              return const BuyandSell();
            } else if (UserInfoControll.userType.value == 'Customers' ||
                UserInfoControll.userType.value == 'confirmed_customers') {
              print(UserInfoControll.takeData.value);
              return UserInfoControll.takeData.value == 0
                  ? const IndentityPage()
                  : IndentityPending();
            } else if (UserInfoControll.userType.value == 'seller') {
              return const IndentityPage();
            } else {
              // در صورتی که نوع کاربر مشخص نشده باشد یا مقدار نامعتبر باشد
              return const CustomersPage();
            }

          default:
            return Text(
              pageTitle,
              style: theme.textTheme.headlineSmall,
            );
        }
      },
    );
  }

  checkCustomerId(String customerId) async {
    final response = await http.get(Uri.parse(
        'https://test.ht-hermes.com/customers/confirmed/confirmed-customers-read.php?id=$customerId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data != null && data['id'].toString() == customerId) {
        // _showCustomerDialog(data['responsible_name'], data['company_name'],
        //     data['has_open_order'] == 1 ? 'دارد/محدودیت سفارش' : 'ندارد');
        setState(() {
          OrdersCustomers.isCustomerVerified =
              data['has_open_order'] == 0 ? true : false;

          OrdersCustomers.showId = data['has_open_order'] == 0 ? false : true;
          OrdersCustomers.showInfo = data['has_open_order'] == 0 ? true : false;
          OrdersCustomers.customerName = data['responsible_name'];
          OrdersCustomers.companyName = data['company_name'];
        });
        Get.to(HomeMain(
            xxcontroller:
                SidebarXController(selectedIndex: 1, extended: true)));
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => HomeMain(
        //             xxcontroller:
        //                 SidebarXController(selectedIndex: 1, extended: true))
        //         // InvoicesPage(
        //         //       refresh: refresh,
        //         //     )

        //         ),
        //     (route) => false);
        load = false;
        setState(() {});
      } else {
        _showErrorDialog('مشخصات یافت نشد');
        setState(() {
          OrdersCustomers.isCustomerVerified = false;
        });
      }
    } else {
      _showErrorDialog('مشکلی در دریافت داده');
      setState(() {
        OrdersCustomers.isCustomerVerified = false;
      });
    }
  }

  // show error
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('! خطا '),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('تایید'),
            ),
          ],
        );
      },
    );
  }

  // show success
  void _showCustomerDialog(
      String customerName, String companyName, String hasOpenOrder) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            '! مشخصات یافت شد',
            style: TextStyle(fontFamily: 'Irs'),
          ),
          content: Directionality(
            textDirection: TextDirection.rtl,
            child: SizedBox(
              height: 100,
              child: Column(
                children: [
                  Text('نام مشتری: $customerName',
                      style: const TextStyle(fontFamily: 'Irs')),
                  Text('نام کمپانی : $companyName',
                      style: const TextStyle(fontFamily: 'Irs')),
                  Text('سفارش باز : $hasOpenOrder')
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('تایید'),
            ),
          ],
        );
      },
    );
  }
}

String _getTitleByIndex(int index) {
  switch (index) {
    case 0:
      return 'داشبورد';
    case 1:
      return 'مشتریان';
    case 2:
      return 'سفارشات';
    case 3:
      return 'فاکتورها';
    case 4:
      return 'خرید و فروش';
    case 5:
      return 'مالی';
    case 6:
      return 'حمل و نقل';
    default:
      return 'Not found page';
  }
}

const primaryColor = Color(0xFF685BFF);
const canvasColor = Color(0xFF2E2E48);
const scaffoldBackgroundColor = Color(0xFF464667);
const accentCanvasColor = Color(0xFF3E3E61);
const white = Colors.white;
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);
