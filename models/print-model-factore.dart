import 'package:flutter/material.dart';

class PrintableFactor extends StatefulWidget {
  const PrintableFactor({super.key});

  @override
  State<PrintableFactor> createState() => _PrintableFactorState();
}

class _PrintableFactorState extends State<PrintableFactor> {
  TextStyle matnfactor = const TextStyle(fontFamily: '');

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              SizedBox(
                width: screenWidth * 0.9,
                height: screenWidth * 0.05,
                // color: Colors.blue,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: screenWidth * 0.05,
                        // color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 80.0),
                          child: Row(
                            children: [
                              Center(
                                child: Container(
                                  width: screenWidth * 0.09,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0),
                                          width: 0.5)),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '20',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontFamily: 'Irs',
                                        ),
                                      ),
                                      Text(
                                        '1403/04/20',
                                        style: TextStyle(fontFamily: 'Irs'),
                                      ),
                                      Text(
                                        '1403/04/21',
                                        style: TextStyle(fontFamily: 'Irs'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: screenWidth * 0.09,
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '431221323',
                                      style: TextStyle(fontFamily: 'Irs'),
                                    ),
                                    Text(' : تاریخ سفارش'),
                                    Text(' : تاریخ اعتبار'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        height: screenWidth * 0.05,
                        // color: Colors.purple,
                        child: const Text(
                          'فاکتور خرید و فروش کالا',
                          style: TextStyle(
                              fontFamily: 'Irs',
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        width: screenWidth * 0.05,
                        // color: Colors.amber,
                        child: Image.asset('assets/images/hs.png'),
                      ),
                    )
                  ],
                ),
              ),
              titleWidget(
                screenWidth: screenWidth,
                title: 'مشخصات فروشنده',
              ),
              InfoWidget(screenWidth: screenWidth)
              /////////////////////////////////////
              ,
              titleWidget(screenWidth: screenWidth, title: 'مشخصات خریدار'),
              InfoWidget(screenWidth: screenWidth),
              titleWidget(screenWidth: screenWidth, title: 'مشخصات کالا'),
              Column(
                children: [
                  SizedBox(
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
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                            width: 0.5)),
                                    alignment: Alignment.center,
                                    // color: Colors.red,
                                    child: const Text(
                                      'ردیف',
                                      textAlign: TextAlign.center,
                                    ))),
                            Expanded(
                                flex: 1,
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                            width: 0.5)),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'کد کالا',
                                      textAlign: TextAlign.center,
                                    ))),
                            Expanded(
                                flex: 1,
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                            width: 0.5)),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'شرح کالا / خدمت',
                                      textAlign: TextAlign.center,
                                    ))),
                            Expanded(
                                flex: 1,
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                            width: 0.5)),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'تعداد / مقدار',
                                      textAlign: TextAlign.center,
                                    ))),
                            Expanded(
                                flex: 1,
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                            width: 0.5)),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'واحد اندازه گیری',
                                      textAlign: TextAlign.center,
                                    ))),
                            Expanded(
                                flex: 1,
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                            width: 0.5)),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'مبلغ واحد',
                                      textAlign: TextAlign.center,
                                    ))),
                            Expanded(
                                flex: 1,
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                            width: 0.5)),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'مبلغ کل',
                                      textAlign: TextAlign.center,
                                    ))),
                            Expanded(
                                flex: 1,
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                            width: 0.5)),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'مبلغ تخفیف',
                                      textAlign: TextAlign.center,
                                    ))),
                            Expanded(
                                flex: 1,
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                            width: 0.5)),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'مبلغ اضافات',
                                      textAlign: TextAlign.center,
                                    ))),
                            Expanded(
                                flex: 1,
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                            width: 0.5)),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'مبلغ کل پس از تخفیف و اضافات',
                                      textAlign: TextAlign.center,
                                    ))),
                            Expanded(
                                flex: 1,
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                            width: 0.5)),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'حمع مالیات وعوارض',
                                      textAlign: TextAlign.center,
                                    ))),
                            Expanded(
                                flex: 1,
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                            width: 0.5)),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'خالص فاکتور',
                                      textAlign: TextAlign.center,
                                    ))),
                          ],
                        ),
                      ),
                    ),
                  ),

                  ////////////////////////
                  ///
                  ///

                  ////////data to from
                  ///
                  ///

                  SizedBox(
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
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
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
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
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
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
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
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
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
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
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
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
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
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
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
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
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
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
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
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
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
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
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
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
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
                  ),
                  Container(
                    width: screenWidth * 0.9,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            width: 0.5)),
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          child: const Center(
                            child: Text(
                                'پانصد و بیست و سه میلیون و دویست هزار تومان'),
                          ),
                        )),
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  width: 0.5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: false,
                                    onChanged: (value) {},
                                  ),
                                  const Text('غیر نقدی')
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: false,
                                    onChanged: (value) {},
                                  ),
                                  const Text('نقدی')
                                ],
                              ),
                              const Text('شرایط و نحوه فروش')
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: screenWidth * 0.9,
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 0, 0, 0), width: 0.5)),
                child: const Text(' : توضیحات'),
              ),
              Container(
                width: screenWidth * 0.9,
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 0, 0, 0), width: 0.5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                width: 0.5)),
                        child: const Text(
                          ' : مهر و امضای فروشنده',
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                width: 0.5)),
                        child: const Text(
                          ' : مهر و امضای خریدار',
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  ],
                ),
              )
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

class titleWidget extends StatelessWidget {
  const titleWidget({
    super.key,
    required this.screenWidth,
    required this.title,
  });

  final double screenWidth;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: screenWidth * 0.9,
      height: 30,
      decoration: BoxDecoration(
        border:
            Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 0.5),
      ),
      child: Text(
        title,
        style: const TextStyle(
            fontFamily: 'Irs',
            color: Color.fromARGB(255, 2, 2, 2),
            fontSize: 15,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

void main() => runApp(const MaterialApp(
      home: PrintableFactor(),
    ));
