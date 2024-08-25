import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductSelectionPage extends StatefulWidget {
  const ProductSelectionPage({super.key});

  @override
  _ProductSelectionPageState createState() => _ProductSelectionPageState();
}

class _ProductSelectionPageState extends State<ProductSelectionPage> {
  List products = [];
  List sizes = [];
  String? selectedProduct;
  String? selectedSize;
  int quantity = 0;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final response = await http.post(
      Uri.parse('https://test.ht-hermes.com/factors/test_product_flutter.php'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        products = data['products'];
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<void> fetchSizes(String productId) async {
    final response = await http.post(
      Uri.parse('https://test.ht-hermes.com/factors/test_product_flutter.php'),
      body: {'product_id': productId},
    );
    print(response.body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        sizes = data['sizes'];
      });
    } else {
      throw Exception('Failed to load sizes');
    }
  }

  Future<void> checkInventory(
      String productId, String size, int quantity) async {
    final response = await http.post(
      Uri.parse('https://test.ht-hermes.com/factors/test_product_flutter.php'),
      body: {
        'check_inventory': '1',
        'product_id': productId,
        'size': size,
        'quantity': quantity.toString(),
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['available']) {
        // موجودی کافی است، سفارش را ثبت کنید
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('سفارش با موفقیت ثبت شد')),
        );
      } else {
        // موجودی کافی نیست، نمایش دیالوگ
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('خطا'),
              content:
                  Text('موجودی کافی نیست. موجودی فعلی: ${data['inventory']}'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('باشه'),
                ),
              ],
            );
          },
        );
      }
    } else {
      throw Exception('Failed to check inventory');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('انتخاب محصول و سایز'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<String>(
              hint: const Text('انتخاب محصول'),
              value: selectedProduct,
              onChanged: (newValue) {
                setState(() {
                  selectedProduct = newValue;
                  sizes = [];
                  selectedSize = null;
                  if (newValue != null) {
                    fetchSizes(newValue);
                  }
                });
              },
              items: products.map<DropdownMenuItem<String>>((product) {
                return DropdownMenuItem<String>(
                  value: product['id'].toString(),
                  child: Text(product['name']),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            if (sizes.isNotEmpty) ...[
              const Text('انتخاب سایز:'),
              DropdownButton<String>(
                hint: const Text('انتخاب سایز'),
                value: selectedSize,
                onChanged: (newValue) {
                  setState(() {
                    selectedSize = newValue;
                  });
                },
                items: sizes.map<DropdownMenuItem<String>>((size) {
                  return DropdownMenuItem<String>(
                    value: size['size'].toString(),
                    child: Text('${size['size']} - تعداد: ${size['quantity']}'),
                  );
                }).toList(),
              ),
            ],
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'تعداد',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  quantity = int.parse(value);
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedProduct != null &&
                    selectedSize != null &&
                    quantity > 0) {
                  checkInventory(selectedProduct!, selectedSize!, quantity);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('لطفاً تمامی فیلدها را پر کنید')),
                  );
                }
              },
              child: const Text('ثبت سفارش'),
            ),
          ],
        ),
      ),
    );
  }
}
