import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:steelpanel/models/factor-model.dart';

class InvoiceCard extends StatefulWidget {
  final PreInvoice invoice;

  const InvoiceCard({super.key, required this.invoice});

  @override
  State<InvoiceCard> createState() => _InvoiceCardState();
}

class _InvoiceCardState extends State<InvoiceCard> {
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
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('جزئیات پیش‌فاکتور'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text('محصول: ${widget.invoice.product}'),
                    Text('شرکت: ${widget.invoice.customerName}'),
                    Text('گرید: ${widget.invoice.grade}'),
                    Text('نحوه پرداخت: ${widget.invoice.howPay}'),
                    Text('تاریخ سفارش: ${widget.invoice.orderDate}'),
                    Text('وزن: ${widget.invoice.weight} کیلوگرم'),
                    // Text('ضخامت: ${invoice.thickness}'),
                    // Text('عرض: ${invoice.width}'),
                    Text('اندازه: ${widget.invoice.size}'),
                    Text('مالیات: ${widget.invoice.ontax}'),
                    Text('سود ماهانه: ${widget.invoice.profitMonth}'),
                    Text('نام اپراتور: ${widget.invoice.operatorName}'),
                    Text('فی: ${widget.invoice.fee} تومان'),
                    Text('مبلغ: ${widget.invoice.price} تومان'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('بستن'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
              icon: widget.invoice.orderType == 'Forosh'
                  ? Container(
                      child: const Text('فروش'),
                    )
                  : Container(
                      child: const Text('فروش'),
                    ),
            );
          },
        );
      },
      child: Card(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListTile(
            title: Text(widget.invoice.product),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('گرید: ${widget.invoice.grade}'),
                Text('سفارش دهنده: ${widget.invoice.customerName}'),
                Text('نحوه پرداخت: ${widget.invoice.howPay}'),
                Text('تاریخ سفارش: ${widget.invoice.orderDate}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: widget.invoice.orderType == 'Forosh'
                          ? Container(
                              width: 80,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Text(
                                'فروش',
                                style: TextStyle(
                                    fontFamily: 'Irs',
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          : Container(
                              alignment: Alignment.center,
                              width: 80,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Text(
                                'خرید',
                                style: TextStyle(
                                    fontFamily: 'Irs',
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.05,
                    ),
                    Visibility(
                      visible:
                          widget.invoice.orderType == 'Forosh' ? true : false,
                      child: Container(
                        // width: screenWidth * 0.05,
                        height: screenHeight * 0.046,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 2,
                                  spreadRadius: 1)
                            ]),
                        child: const Text(
                          ' تایید نشده ',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            trailing: Container(
              alignment: Alignment.centerRight,
              width: 250,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      print('تایید');
                    },
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.green),
                    ),
                    child: const Text(
                      'تایید',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print('رد');
                    },
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.blue),
                    ),
                    child: const Text(
                      'مشاهده',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(55)),
                    child: IconButton(
                      onPressed: () {
                        // print('حذف پیش‌فاکتور');
                        // deletePreInvoice(invoice.invoiceId.toString());
                      },
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
