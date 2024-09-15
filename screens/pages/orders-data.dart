import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:steelpanel/control/user-info.dart';
import 'package:steelpanel/screens/pages/orders.dart';
import 'package:http/http.dart' as http;

class OrderCard extends StatefulWidget {
  final dynamic order;
  final int tabid;
  final VoidCallback onTap;

  const OrderCard(
      {super.key,
      required this.order,
      required this.tabid,
      required this.onTap});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  void _showDialog(String message, String preinvoiceNum) {
    showDialog(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: const Text('پیام', style: TextStyle(fontFamily: 'Irs')),
            content: Row(
              children: [
                Text(message, style: const TextStyle(fontFamily: 'Irs')),
                Text(preinvoiceNum, style: const TextStyle(fontFamily: 'Irs')),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('تایید', style: TextStyle(fontFamily: 'Irs')),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListTile(
          title: Text(widget.order.product),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('گرید: ${widget.order.grade}'),
              Text('سفارش دهنده: ${widget.order.customerName}'),
              Text('نحوه پرداخت: ${widget.order.how_pay}'),
              Text('تاریخ سفارش: ${widget.order.orderDate}'),
            ],
          ),
          onTap: widget.onTap,
          onLongPress: () {},
          trailing: Container(
            alignment: Alignment.centerRight,
            width: 200,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle approval
                    if (UserInfoControll.userType.value == 'Commerce' ||
                        UserInfoControll.userType.value == 'SellOperator' ||
                        UserInfoControll.userType.value == 'oprator' ||
                        UserInfoControll.userType.value == 'Admin') {
                      if (widget.tabid == 1) {
                        if (OrderDetailsSheet.economicCodeController.text != '' &&
                            OrderDetailsSheet.productController.text != '' &&
                            OrderDetailsSheet.feeController.text != '' &&
                            OrderDetailsSheet.weightController.text != '' &&
                            OrderDetailsSheet.branchController.text != '' &&
                            OrderDetailsSheet.sizeController.text != '' &&
                            OrderDetailsSheet.gradeController.text != '' &&
                            OrderDetailsSheet.howPayController.text != '' &&
                            OrderDetailsSheet.untilPayController.text != '' &&
                            OrderDetailsSheet.orderDateController.text != '' &&
                            OrderDetailsSheet.ontaxController.text != '' &&
                            OrderDetailsSheet.profitMonthController.text !=
                                '' &&
                            OrderDetailsSheet.operatorNameController.text !=
                                '' &&
                            OrderDetailsSheet.responsibleNameController.text !=
                                '' &&
                            OrderDetailsSheet.productPrice.text != '') {
                          _addtoPreinvoce(widget.order.order_id, 'Forosh');
                        } else {
                          Get.defaultDialog(
                              title: 'خطا',
                              middleText: 'تمامی اطلاعات سفارش پر شود');
                        }
                      } else {
                        _addtoPreinvocebuy(widget.order.order_id);
                      }

                      print(widget.tabid);
                    } else {
                      Get.defaultDialog(
                          title: 'خطا',
                          middleText: 'مجوز تایید سفارش را ندارید');
                    }
                    // if (widget.tabid == 1) {
                    //   _addtoPreinvoce(widget.order.order_id);
                    // } else {
                    //   _addtoPreinvocebuy(widget.order.order_id);
                    // }

                    print(widget.tabid);
                  },
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                      Color.fromARGB(255, 141, 245, 145),
                    ),
                  ),
                  child: const Text('تایید'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.red),
                  ),
                  child: const Text('رد'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }

  // add to pre_invoice
  Future<void> _addtoPreinvoce(orderID, ordertype) async {
    print('this is order id $orderID');
    final response = await http.post(
        Uri.parse('https://test.ht-hermes.com/factors/add_preinvoice.php'),
        body: jsonEncode({'order_id': orderID, "order_type": ordertype}));

    if (response.statusCode == 200) {
      print(response.body);
      var data = jsonDecode(response.body)['invoice_number'];
      print(jsonDecode(response.body)['invoice_number']);
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return OrdersPage(refresh: refresh);
        },
      ));
      _showDialog('سفارش پیش فاکتور شد',
          'شماره پیش فاکتور : ${jsonDecode(response.body)['invoice_number']}');
    } else {
      throw Exception('Failed to load buy orders');
    }
  }

  Future<void> _addtoPreinvocebuy(orderID) async {
    print('this is order id $orderID');
    final response = await http.post(
        Uri.parse('https://test.ht-hermes.com/factors/add_preinvoice_buy.php'),
        body: jsonEncode({'order_id': orderID}));

    if (response.statusCode == 200) {
      print(response.body);
      var data = jsonDecode(response.body)['invoice_number'];
      print(jsonDecode(response.body)['invoice_number']);
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return OrdersPage(refresh: refresh);
        },
      ));
      _showDialog('سفارش پیش فاکتور شد',
          'شماره پیش فاکتور : ${jsonDecode(response.body)['invoice_number']}');
    } else {
      throw Exception('Failed to load buy orders');
    }
  }
}
