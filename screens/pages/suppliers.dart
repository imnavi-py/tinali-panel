import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ConfirmedSuppliersPage extends StatefulWidget {
  const ConfirmedSuppliersPage({super.key});

  @override
  _ConfirmedSuppliersPageState createState() => _ConfirmedSuppliersPageState();
}

class _ConfirmedSuppliersPageState extends State<ConfirmedSuppliersPage> {
  List<dynamic> suppliers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSuppliers();
  }

  Future<void> fetchSuppliers() async {
    final response = await http.get(
        Uri.parse('https://test.ht-hermes.com/supplier/read-suppliers.php'));

    if (response.statusCode == 200) {
      setState(() {
        suppliers = json.decode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load suppliers');
    }
  }

  void _showAddSupplierSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: AddSupplierForm(onAdd: fetchSuppliers),
      ),
    );
  }

  void _showSupplierDetailsSheet(Map<String, dynamic> supplier) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SupplierDetails(supplier: supplier),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 226, 219, 219),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E2E48),
        title: const Text('اسامی تامین کنندگان'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.blue,
            ),
            onPressed: _showAddSupplierSheet,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: suppliers.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 5.0),
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Text(
                        suppliers[index]['responsible_name'][0],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      suppliers[index]['responsible_name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    subtitle: Text(
                      'ID: ${suppliers[index]['id']}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16.0),
                    onTap: () => _showSupplierDetailsSheet(suppliers[index]),
                  ),
                );
              },
            ),
    );
  }
}

class AddSupplierForm extends StatefulWidget {
  final Function onAdd;

  const AddSupplierForm({super.key, required this.onAdd});

  @override
  _AddSupplierFormState createState() => _AddSupplierFormState();
}

class _AddSupplierFormState extends State<AddSupplierForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController responsibleNameController =
      TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController economicCodeController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController registrationNumberController =
      TextEditingController();
  final TextEditingController operatorNameController = TextEditingController();

  Future<void> _addSupplier() async {
    if (_formKey.currentState?.validate() ?? false) {
      final response = await http.post(
        Uri.parse(
            'https://test.ht-hermes.com/supplier/create-confirmed-supplier.php'),
        body: jsonEncode({
          'responsible_name': responsibleNameController.text,
          'company_name': companyNameController.text,
          'economic_code': economicCodeController.text,
          'national_id': nationalIdController.text,
          'phone_number': phoneNumberController.text,
          'postal_code': postalCodeController.text,
          'address': addressController.text,
          'registration_number': registrationNumberController.text,
          'operator_name': operatorNameController.text,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 201) {
        Navigator.pop(context);
        widget.onAdd();
      } else {
        print(response.body);
        // Handle error
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: responsibleNameController,
              decoration: const InputDecoration(labelText: 'نام مسئول'),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'این فیلد الزامی است' : null,
            ),
            TextFormField(
              controller: companyNameController,
              decoration: const InputDecoration(labelText: 'نام شرکت'),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'این فیلد الزامی است' : null,
            ),
            TextFormField(
              controller: economicCodeController,
              decoration: const InputDecoration(labelText: 'کد اقتصادی'),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'این فیلد الزامی است' : null,
            ),
            TextFormField(
              controller: nationalIdController,
              decoration: const InputDecoration(labelText: 'کد ملی'),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'این فیلد الزامی است' : null,
            ),
            TextFormField(
              controller: phoneNumberController,
              decoration: const InputDecoration(labelText: 'شماره تلفن'),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'این فیلد الزامی است' : null,
            ),
            TextFormField(
              controller: postalCodeController,
              decoration: const InputDecoration(labelText: 'کد پستی'),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'این فیلد الزامی است' : null,
            ),
            TextFormField(
              controller: addressController,
              decoration: const InputDecoration(labelText: 'آدرس'),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'این فیلد الزامی است' : null,
            ),
            TextFormField(
              controller: registrationNumberController,
              decoration: const InputDecoration(labelText: 'شماره ثبت'),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'این فیلد الزامی است' : null,
            ),
            TextFormField(
              controller: operatorNameController,
              decoration: const InputDecoration(labelText: 'نام اپراتور'),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'این فیلد الزامی است' : null,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addSupplier,
              child: const Text('اضافه کردن'),
            ),
          ],
        ),
      ),
    );
  }
}

class SupplierDetails extends StatelessWidget {
  final Map<String, dynamic> supplier;

  const SupplierDetails({super.key, required this.supplier});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              supplier['responsible_name'],
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Text('شرکت: ${supplier['company_name']}'),
            Text('کد اقتصادی: ${supplier['economic_code']}'),
            Text('شماره ملی: ${supplier['national_id']}'),
            Text('شماره تلفن: ${supplier['phone_number']}'),
            Text('کد پستی: ${supplier['postal_code']}'),
            Text('آدرس: ${supplier['address']}'),
            Text('شماره ثبت: ${supplier['registration_number']}'),
            Text('نام اپراتور: ${supplier['operator_name']}'),
          ],
        ),
      ),
    );
  }
}
