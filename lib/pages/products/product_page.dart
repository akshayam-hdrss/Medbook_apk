import 'package:flutter/material.dart';
import 'package:medbook/data/app_data.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> products =
        List<Map<String, dynamic>>.from(data['product']);

    return Scaffold(
      appBar: AppBar(title: const Text("Product Categories")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Choose a Product Category",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...products.map((product) {
              final slug = product['productName']
                  .toString()
                  .toLowerCase()
                  .replaceAll(' ', '-');
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/product/$slug'),
                  child: Text(product['productName']),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}