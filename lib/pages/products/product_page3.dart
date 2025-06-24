import 'package:flutter/material.dart';
import 'package:medbook/data/app_data.dart';

class ProductPage3 extends StatelessWidget {
  final String topic;
  final String subTopic;
  const ProductPage3({super.key, required this.topic, required this.subTopic});

  @override
  Widget build(BuildContext context) {
    // Fix: Cast data['product'] properly and use a typed fallback
    final Map<String, dynamic> product = (data['product'] as List)
        .cast<Map<String, dynamic>>()
        .firstWhere(
          (p) => p['productName']
              .toString()
              .toLowerCase()
              .replaceAll(' ', '-') ==
              topic,
          orElse: () => <String, dynamic>{},
        );

    if (product.isEmpty) {
      return const Scaffold(body: Center(child: Text('Product not found')));
    }

    // Fix: Same approach for nested productTypes
    final Map<String, dynamic> productType = (product['productTypes'] as List)
        .cast<Map<String, dynamic>>()
        .firstWhere(
          (t) => t['productType']
              .toString()
              .toLowerCase()
              .replaceAll(' ', '-') ==
              subTopic,
          orElse: () => <String, dynamic>{},
        );

    if (productType.isEmpty) {
      return const Scaffold(body: Center(child: Text('Type not found')));
    }

    final List<dynamic> productList = productType['productList'] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text(productType['productType'] ?? 'Products')),
      body: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          final item = productList[index];
          final details = item['productDetails'] ?? {};
          return ListTile(
            title: Text(item['name'] ?? 'Unnamed'),
            subtitle: Text(
              "Area: ${details['area'] ?? 'N/A'} | Mobile: ${details['mobile'] ?? 'N/A'}",
            ),
          );
        },
      ),
    );
  }
}
