import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:steelpanel/screens/homescreen.dart';

class CustomerOrder extends StatefulWidget {
  final Function() refresh;

  const CustomerOrder({super.key, required this.refresh});
  @override
  _CustomerOrderState createState() => _CustomerOrderState();
}

class _CustomerOrderState extends State<CustomerOrder>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // late Future<List<BuyOrder>> futureBuyOrders;
  // late Future<List<SellOrder>> futureSellOrders;
  final TextEditingController searchController = TextEditingController();
  late int tabid = 1;
  bool showHeaderbuy = false;
  bool showHeadersell = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
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
        children: const [
          // OrdersListView<BuyOrder>(
          //   futureOrders: futureBuyOrders,
          //   tabindex: _tabController.index,
          //   showit: showHeaderbuy,
          // ),
          // OrdersListView<SellOrder>(
          //   futureOrders: futureSellOrders,
          //   tabindex: tabid,
          //   showit: showHeadersell,
          // ),
        ],
      ),
    );
  }
}
