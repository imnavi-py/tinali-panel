import 'package:flutter/material.dart';

class AddInvoicePage extends StatefulWidget {
  final Function refresh;
  const AddInvoicePage({super.key, required this.refresh});

  @override
  _AddInvoicePageState createState() => _AddInvoicePageState();
}

class _AddInvoicePageState extends State<AddInvoicePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _productController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _gradeController = TextEditingController();
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _howPayController = TextEditingController();
  final TextEditingController _orderDateController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Submit the form and save the invoice
      // You need to implement the API call here to save the invoice
      widget.refresh();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('افزودن فاکتور جدید'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _productController,
                decoration: const InputDecoration(labelText: 'محصول'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'لطفاً محصول را وارد کنید';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _branchController,
                decoration: const InputDecoration(labelText: 'شعبه'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'لطفاً شعبه را وارد کنید';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _gradeController,
                decoration: const InputDecoration(labelText: 'گرید'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'لطفاً گرید را وارد کنید';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _customerNameController,
                decoration: const InputDecoration(labelText: 'نام مشتری'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'لطفاً نام مشتری را وارد کنید';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _howPayController,
                decoration: const InputDecoration(labelText: 'نحوه پرداخت'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'لطفاً نحوه پرداخت را وارد کنید';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _orderDateController,
                decoration: const InputDecoration(labelText: 'تاریخ سفارش'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'لطفاً تاریخ سفارش را وارد کنید';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('ذخیره'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
