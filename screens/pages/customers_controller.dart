import 'package:get/get.dart';

class CustomersController extends GetxController {
  static Map<String, dynamic> formData = {};
  // لیست های داده برای مدیریت مشتریان "در انتظار" و "تأیید شده"
  var jsonData = [].obs; // از لیست قابل مشاهده GetX استفاده کنید
  var confirmedCustomers = [].obs;

  // void updateCustomers(List<dynamic> newCustomers) {
  //   jsonData.clear();
  //   jsonData.addAll(
  //       newCustomers.map((customer) => customer.cast<String, String>()));
  // }

  void updateFormData(Map<String, dynamic> newData) {
    CustomersController.formData.addAll(newData);
  }

  void removeCustomer(Map<String, String> customer) {
    jsonData.remove(customer);
    confirmedCustomers.remove(customer);
  }

  void confirmCustomer(Map<String, String> customer) {
    confirmedCustomers.add(customer);
    jsonData.remove(customer);
  }

  void updateCustomers(List<dynamic> customers) {
    jsonData.value = customers;
  }

  void updateConfirmedCustomers(List<dynamic> customers) {
    confirmedCustomers.value = customers;
  }
  // var confirmedCustomers = [
  //   {
  //     "نام کامل شرکت": "هرمس استیل",
  //     "نام مسئول": "اقای ایکس",
  //     "شناسه ملی": "12345",
  //     "کد اقتصادی": "123456",
  //     "کد پستی": ";12345678910",
  //     "تلفن": "+9821 123456",
  //     "آدرس": "تهران- تهران - بزرگراه ... خیابان ...",
  //     "نام اپراتور": "مهندس ایکس",
  //     "شماره ثبت": "12345678"
  //   }
  // ].obs; // از لیست قابل مشاهده GetX استفاده کنید

  // متد برای به روز رسانی لیست های مشتریان و اطلاع رسانی UI در مورد تغییرات
  void updateCustomerList(Map<String, String> customerData) {
    jsonData.removeWhere((element) => element == customerData);
    confirmedCustomers.add(customerData);
    update(); // UI را در مورد تغییرات مطلع کنید
  }
}
