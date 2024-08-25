import 'package:get/get.dart';

class OrdersController extends GetxController {
  static Map<String, dynamic> formData = {};
  // لیست های داده برای مدیریت مشتریان "در انتظار" و "تأیید شده"
  var sellOrders = [].obs; // از لیست قابل مشاهده GetX استفاده کنید
  var buyOrders = [].obs;

  // void updateCustomers(List<dynamic> newCustomers) {
  //   jsonData.clear();
  //   jsonData.addAll(
  //       newCustomers.map((customer) => customer.cast<String, String>()));
  // }

  void updateFormData(Map<String, dynamic> newData) {
    OrdersController.formData.addAll(newData);
  }

  void removeOrders(Map<String, String> customer) {
    sellOrders.remove(customer);
    buyOrders.remove(customer);
  }

  void confirmCustomer(Map<String, String> customer) {
    buyOrders.add(customer);
    sellOrders.remove(customer);
  }

  void updateSellOrders(List<dynamic> sellOrder) {
    sellOrders.value = sellOrder;
  }

  void updateBuyOrders(List<dynamic> buyOrder) {
    sellOrders.value = buyOrder;
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
    sellOrders.removeWhere((element) => element == customerData);
    sellOrders.add(customerData);
    update(); // UI را در مورد تغییرات مطلع کنید
  }
}
