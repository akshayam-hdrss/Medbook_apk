import 'package:flutter/material.dart';
import 'package:medbook/data/app_data.dart';

class ProductPage2 extends StatelessWidget {
  final String topic;
  const ProductPage2({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> product = (data['product'] as List)
        .cast<Map<String, dynamic>>()
        .firstWhere(
          (p) => p['productName']
              .toString()
              .toLowerCase()
              .replaceAll(' ', '-') ==
              topic,
          orElse: () => <String, dynamic>{}, // ✅ correct typed fallback
        );

    if (product.isEmpty) {
      return const Scaffold(body: Center(child: Text('Product not found')));
    }

    final List<dynamic> productTypes = product['productTypes'] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text(product['productName'] ?? 'Product')),
      body: ListView.builder(
        itemCount: productTypes.length,
        itemBuilder: (context, index) {
          final type = productTypes[index];
          final subSlug =
              type['productType'].toLowerCase().replaceAll(' ', '-');

          return ListTile(
            title: Text(type['productType']),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(context, "/product/$topic/$subSlug");
            },
          );
        },
      ),
    );
  }
}
