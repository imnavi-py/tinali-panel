import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:steelpanel/control/user-info.dart';

class IndentityPending extends StatefulWidget {
  const IndentityPending({super.key});

  @override
  State<IndentityPending> createState() => _IndentityPendingState();
}

class _IndentityPendingState extends State<IndentityPending> {
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
    return SizedBox(
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
                          style: const TextStyle(color: Colors.orange),
                        ),
                        UserInfoControll.verify.value == false
                            ? const Text(
                                ' عزیز اطلاعات شما در حال پردازش است',
                                style: TextStyle(color: Colors.white),
                              )
                            : const Text(
                                ' عزیز اطلاعات شما تایید شده است',
                                style: TextStyle(color: Colors.white),
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
