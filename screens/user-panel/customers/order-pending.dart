import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:steelpanel/control/user-info.dart';

class OrderPending extends StatefulWidget {
  const OrderPending({super.key});

  @override
  State<OrderPending> createState() => _OrderPendingState();
}

class _OrderPendingState extends State<OrderPending> {
  double screenWidth = 0;
  double screenHeight = 0;

  @override
  void didChangeDependencies() {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print(UserInfoControll.first_name.value);
    return Container(
      width: screenWidth,
      height: screenHeight,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: screenWidth,
            height: screenHeight * 0.11,
            color: const Color(0xFF2E2E48),
          ),
          Expanded(
            child: Center(
              child: Container(
                  alignment: Alignment.center,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          UserInfoControll.first_name.value,
                          style: TextStyle(color: Colors.orange),
                        ),
                        const Text(
                          'ابتدا احراز هویت را کامل کنید ویا در صورت انجام احراز هویت ، برای تایید  منتظر بمانید',
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
