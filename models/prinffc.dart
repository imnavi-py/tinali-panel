import 'package:flutter/material.dart';

class ProinfAtFactor extends StatelessWidget {
  const ProinfAtFactor({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth * 0.9,
      height: 60,
      child: Center(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              width: 0.5)),
                      alignment: Alignment.center,
                      // color: Colors.red,
                      child: const Text(
                        '1',
                        textAlign: TextAlign.center,
                      ))),
              Expanded(
                  flex: 1,
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              width: 0.5)),
                      alignment: Alignment.center,
                      child: const Text(
                        '041',
                        textAlign: TextAlign.center,
                      ))),
              Expanded(
                  flex: 1,
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              width: 0.5)),
                      alignment: Alignment.center,
                      child: const Text(
                        'ضایعات خاک اسید',
                        textAlign: TextAlign.center,
                      ))),
              Expanded(
                  flex: 1,
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              width: 0.5)),
                      alignment: Alignment.center,
                      child: const Text(
                        '30,000',
                        textAlign: TextAlign.center,
                      ))),
              Expanded(
                  flex: 1,
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              width: 0.5)),
                      alignment: Alignment.center,
                      child: const Text(
                        'کیلوگرم',
                        textAlign: TextAlign.center,
                      ))),
              Expanded(
                  flex: 1,
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              width: 0.5)),
                      alignment: Alignment.center,
                      child: const Text(
                        '16,000',
                        textAlign: TextAlign.center,
                      ))),
              Expanded(
                  flex: 1,
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              width: 0.5)),
                      alignment: Alignment.center,
                      child: const Text(
                        '480,000,000',
                        textAlign: TextAlign.center,
                      ))),
              Expanded(
                  flex: 1,
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              width: 0.5)),
                      alignment: Alignment.center,
                      child: const Text(
                        '0',
                        textAlign: TextAlign.center,
                      ))),
              Expanded(
                  flex: 1,
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              width: 0.5)),
                      alignment: Alignment.center,
                      child: const Text(
                        '0',
                        textAlign: TextAlign.center,
                      ))),
              Expanded(
                  flex: 1,
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              width: 0.5)),
                      alignment: Alignment.center,
                      child: const Text(
                        '480,000,000',
                        textAlign: TextAlign.center,
                      ))),
              Expanded(
                  flex: 1,
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              width: 0.5)),
                      alignment: Alignment.center,
                      child: const Text(
                        '43,200,000',
                        textAlign: TextAlign.center,
                      ))),
              Expanded(
                  flex: 1,
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              width: 0.5)),
                      alignment: Alignment.center,
                      child: const Text(
                        '523,200,00',
                        textAlign: TextAlign.center,
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        alignment: Alignment.topCenter,
        width: screenWidth * 0.9,
        height: 120,
        decoration: BoxDecoration(
            border: Border.all(
                color: const Color.fromARGB(255, 0, 0, 0), width: 0.5)),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 0, 0, 0), width: 0.5)),
                alignment: Alignment.center,
                height: screenWidth * 0.07,
                // color: Colors.purple,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          width: 0.5)),
                  alignment: Alignment.centerLeft,
                  height: screenWidth * 0.07,
                  // color: Colors.red,
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '5466',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontFamily: 'Irs',
                              ),
                            ),
                            Text(
                              ' :  شناسه ملی',
                              style: TextStyle(fontFamily: 'Irs'),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '431221323',
                              style: TextStyle(fontFamily: 'Irs'),
                            ),
                            Text(' :  شماره فکس'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 0, 0, 0), width: 0.5)),
                alignment: Alignment.center,
                height: screenWidth * 0.07,
                // color: Colors.purple,
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '5466',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontFamily: 'Irs',
                            ),
                          ),
                          Text(
                            ' :  شماره ثبت/شماره ملی',
                            style: TextStyle(fontFamily: 'Irs'),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '431221323',
                            style: TextStyle(fontFamily: 'Irs'),
                          ),
                          Text(' :  شماره تلفن'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 0, 0, 0), width: 0.5)),
                alignment: Alignment.center,
                height: screenWidth * 0.07,
                // color: Colors.purple,
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '234344345344',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontFamily: 'Irs',
                              ),
                            ),
                            Text(
                              ' : شماره اقتصادی',
                              style: TextStyle(fontFamily: 'Irs'),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '334553245444',
                                  style: TextStyle(fontFamily: 'Irs'),
                                ),
                                Text(' :  کد پستی'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 0, 0, 0), width: 0.5)),
                alignment: Alignment.center,
                height: screenWidth * 0.07,
                // color: Colors.purple,
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'هرمس',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontFamily: 'Irs',
                            ),
                          ),
                          Text(
                            ' : نام شخص حقیقی / حقوقی',
                            style: TextStyle(fontFamily: 'Irs'),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(' : آدرس کامل'),
                          Text(
                            'استان تهران، شهر تهران، میدان ونک، خیابان حقانی، طبقه سوم',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontFamily: 'Irs'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
