import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

class MyListTileWidget extends StatefulWidget {
  final int index;
  const MyListTileWidget({Key? key, required this.index}) : super(key: key);

  @override
  State<MyListTileWidget> createState() => _MyListTileWidgetState();
}

class _MyListTileWidgetState extends State<MyListTileWidget> {
  // Box<Money> hiveBox = Hive.box<Money>('moneyBox');

  @override
  Widget build(BuildContext context) {
    // NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

    // final myFormat = NumberFormat('#,##0.######', 'en_US');

    // final String cointref =
    //     (HomeScreen.moneys[widget.index].countref.toString());
    // print('this is cointref ${cointref}');

    // final String idref = (HomeScreen.moneys[widget.index].countref.toString());
    // HomeScreen.idcheckref = (HomeScreen.moneys[widget.index].id.toString());

    setState(() {});
    // print(HomeScreen.idcheckref);
    // List<Money> usr_rank = hiveBox.values.toList();

    // final int usrRanknum = HomeScreen.moneys[widget.index].countref;
    setState(() {
      // HomeScreen.usernumberRank = usrRanknum!;
    });
    // if (usrRanknum >= 0 && usrRanknum <= 20) {
    //   // HomeScreen.checklevel = 'assets/images/${usrRanknum + 1}.png';
    //   // HomeScreen.checkNumlvl = usrRanknum + 1;
    //   // userlvl.chcknumlvl = HomeScreen.checkNumlvl;
    //   // print('checknum lvl  : ${userlvl.chcknumlvl}');

    //   setState(() {});
    // } else {
    //   print('no');
    //   // HomeScreen.checklevel = 'assets/images/7.png'; // یا مقدار دلخواه دیگر
    // }

    // print(HomeScreen.checkNumlvl.toString());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            // height: 80,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      // color:
                      //     HomeScreen.moneys[index].isReceived ? KGreenColor : kRedColor,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Stack(children: [
                      Center(
                          child: SizedBox(
                        width: 70,
                        height: 70,
                        child: Image.asset('assets/images/level.png'),
                      )),
                      const Center(child: Text('test'))
                    ]),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: SizedBox(
                      // color: Colors.red,
                      width: 100,
                      child: const Text('test1'),
                    ),
                  ),
                ),
                const Spacer(),
                const Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text('test2'),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      // color: Color.fromARGB(255, 182, 166, 230)
                    ),
                    // color: const Color.fromARGB(255, 102, 140, 196),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      alignment: Alignment.centerRight,
                      // color: const Color.fromARGB(255, 51, 84, 149),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('test3'),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 100,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: const SweepGradient(
                                    colors: Colors.accents)),
                            alignment: Alignment.center,
                            child: const Text('test4'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 12),
            child: const Text('test5'),
          ),
        ],
      ),
    );
  }
}

//! Empty Widget
class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Image.asset(
          // 'assets/images/nodata.svg',
          'assets/images/No data-cuate.svg',
          height: 150,
          width: 150,
        ),
        const SizedBox(height: 10),
        const Spacer(),
      ],
    );
  }
}
