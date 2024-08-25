import 'dart:io';
import 'package:csv/csv.dart';

void exportToCSV(List<Map<String, String>> selectedCustomers) async {
  final List<List<dynamic>> rows = [];

  // افزودن هدر
  rows.add([
    'نام شرکت',
    'مدیر',
    'کد اقتصادی',
    'شناسه',
    'شماره تلفن',
    'کد پستی',
    'آدرس',
    'کد ثبت',
    'اپراتور'
  ]);

  // افزودن داده‌ها
  for (var customer in selectedCustomers) {
    rows.add([
      customer['incname'] ?? '',
      customer['manager_name'] ?? '',
      customer['eghtesadi_code'] ?? '',
      customer['shenase_code'] ?? '',
      customer['tellnumber'] ?? '',
      customer['postal_code'] ?? '',
      customer['addrress'] ?? '',
      customer['sabt_code'] ?? '',
      customer['operator_name'] ?? '',
    ]);
  }

  // مسیر ذخیره فایل CSV
  final csvFile = File('selected_customers.csv');

  // نوشتن داده‌ها به فایل CSV
  String csv = const ListToCsvConverter().convert(rows);
  await csvFile.writeAsString(csv);

  print('فایل CSV با موفقیت ایجاد شد.');
}
