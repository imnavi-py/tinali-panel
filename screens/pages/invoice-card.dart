import 'package:flutter/material.dart';
import 'package:steelpanel/models/factor-model.dart';

class InvoiceCard extends StatelessWidget {
  final PreInvoice invoice;

  const InvoiceCard({super.key, required this.invoice});

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
                    Text('محصول: ${invoice.product}'),
                    Text('شرکت: ${invoice.customerName}'),
                    Text('گرید: ${invoice.grade}'),
                    Text('نحوه پرداخت: ${invoice.howPay}'),
                    Text('تاریخ سفارش: ${invoice.orderDate}'),
                    Text('وزن: ${invoice.weight} کیلوگرم'),
                    // Text('ضخامت: ${invoice.thickness}'),
                    // Text('عرض: ${invoice.width}'),
                    Text('اندازه: ${invoice.size}'),
                    Text('مالیات: ${invoice.ontax}'),
                    Text('سود ماهانه: ${invoice.profitMonth}'),
                    Text('نام اپراتور: ${invoice.operatorName}'),
                    Text('فی: ${invoice.fee} تومان'),
                    Text('مبلغ: ${invoice.price} تومان'),
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
              icon: invoice.orderType == 'Forosh'
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
            title: Text(invoice.product),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('گرید: ${invoice.grade}'),
                Text('سفارش دهنده: ${invoice.customerName}'),
                Text('نحوه پرداخت: ${invoice.howPay}'),
                Text('تاریخ سفارش: ${invoice.orderDate}'),
                Container(
                  alignment: Alignment.center,
                  child: invoice.orderType == 'Forosh'
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
                    child: Text(
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
                    child: Text(
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
