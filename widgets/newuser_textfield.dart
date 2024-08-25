import 'package:flutter/material.dart';
import 'package:steelpanel/screens/pages/customers.dart';
import 'package:steelpanel/screens/pages/customers_controller.dart';
import 'package:steelpanel/widgets/bottombutton.dart';
import 'package:steelpanel/widgets/mytextfield.dart';

class MyTextFieldnu extends StatefulWidget {
  const MyTextFieldnu({super.key});

  @override
  State<MyTextFieldnu> createState() => _MyTextFieldnuState();
}

class _MyTextFieldnuState extends State<MyTextFieldnu> {
  double screenWidth = 0;

  double screenHeight = 0;

//baraye yekbar farakhuni shodan
  @override
  void didChangeDependencies() {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: screenHeight * .7,
      width: screenWidth * .6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 40,
                  child: myTextField(
                      onchanged: (value) {
                        print(value);
                        CustomersController.formData['company_name'] = value;
                      },
                      controller: CustomersPage.incname,
                      hintText: 'نام شرکت',
                      type: TextInputType.name,
                      errorText: 'نام شرکت را وارد کنید',
                      prefixicon: const Icon(Icons.apartment_sharp)),
                ),
              )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 40,
                  child: myTextField(
                      onchanged: (value) {
                        print(value);
                        CustomersController.formData['responsible_name'] =
                            value;
                      },
                      controller: CustomersPage.manager_name,
                      hintText: 'نام مسئول',
                      type: TextInputType.name,
                      errorText: 'نام مسئول را وارد کنید',
                      prefixicon: const Icon(Icons.person_2_rounded)),
                ),
              )),
            ],
          ),

          //
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 40,
                  child: myTextField(
                      onchanged: (value) {
                        CustomersController.formData['national_id'] = value;
                      },
                      controller: CustomersPage.shenase_code,
                      hintText: 'شناسه ملی',
                      type: TextInputType.name,
                      errorText: 'شناسه ملی را وارد کنید',
                      prefixicon: const Icon(Icons.numbers)),
                ),
              )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 40,
                  child: myTextField(
                      onchanged: (value) {
                        CustomersController.formData['economic_code'] = value;
                      },
                      controller: CustomersPage.eghtsadi_code,
                      hintText: 'کد اقتصادی',
                      type: TextInputType.name,
                      errorText: 'کد اقتصادی را وارد کنید',
                      prefixicon: const Icon(Icons.money)),
                ),
              )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 40,
                  child: myTextField(
                      onchanged: (value) {
                        CustomersController.formData['postal_code'] = value;
                      },
                      controller: CustomersPage.postal_code,
                      hintText: 'کد پستی',
                      type: TextInputType.name,
                      errorText: 'کد پستی الزامی است',
                      prefixicon: const Icon(Icons.local_post_office_outlined)),
                ),
              )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 40,
                  child: myTextField(
                      onchanged: (value) {
                        CustomersController.formData['phone_number'] = value;
                      },
                      controller: CustomersPage.tellnumber,
                      hintText: 'شماره تلفن',
                      type: TextInputType.name,
                      errorText: 'شماره تلفن را وارد کنید',
                      prefixicon: const Icon(Icons.phone)),
                ),
              )),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 40,
                  child: myTextField(
                      onchanged: (value) {
                        CustomersController.formData['address'] = value;
                      },
                      controller: CustomersPage.addrress,
                      hintText: 'آدرس',
                      type: TextInputType.name,
                      errorText: 'آدرس الزامی است',
                      prefixicon: const Icon(Icons.streetview)),
                ),
              )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 40,
                  child: myTextField(
                      onchanged: (value) {
                        CustomersController.formData['operator_name'] = value;
                      },
                      controller: CustomersPage.operator_name,
                      hintText: 'نام اپراتور',
                      type: TextInputType.name,
                      errorText: 'نام اپراتور را وارد کنید',
                      prefixicon: const Icon(Icons.sensor_occupied_rounded)),
                ),
              )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 40,
                  child: myTextField(
                      onchanged: (value) {
                        CustomersController.formData['registration_number'] =
                            value;
                      },
                      controller: CustomersPage.sabt_code,
                      hintText: 'شماره ثبت',
                      type: TextInputType.name,
                      errorText: 'شماره ثبت را وارد کنید',
                      prefixicon: const Icon(Icons.numbers_rounded)),
                ),
              )),
            ],
          ),
        ],
      ),
    );
  }
}
