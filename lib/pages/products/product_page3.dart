import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medbook/data/app_data.dart';
import 'package:medbook/components/ImageCarousel.dart';

class ProductPage3 extends StatelessWidget {
  final String topic;
  final String subTopic;

  const ProductPage3({super.key, required this.topic, required this.subTopic});

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
          orElse: () => <String, dynamic>{},
        );

    if (product.isEmpty) {
      return const Scaffold(body: Center(child: Text('Product not found')));
    }

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red, Colors.deepOrange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Expanded(
                          child: Container(
                            // height: 45,
                            margin: const EdgeInsets.only(left: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const TextField(
                              decoration: InputDecoration(
                                hintText: "Search...",
                                hintStyle: TextStyle(color: Colors.grey),
                                prefixIcon: Icon(Icons.search, color: Colors.grey),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ✅ Add ImageCarousel at the top
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: ImageCarousel(), // your reusable carousel
            ),
            // ✅ Product List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final item = productList[index];
                final details = item['productDetails'] ?? {};

                return Card(
                  margin: const EdgeInsets.all(8),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        // Product Image
                        Container(
                          height: 100,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(item['image'] ?? ''),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Product Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name'] ?? 'Unnamed',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                productType['productType'] ?? '',
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Row(
                                    children: List.generate(4, (index) {
                                      return const Icon(Icons.star, size: 16, color: Colors.orange);
                                    }),
                                  ),
                                  const SizedBox(width: 5),
                                  const Text('4'),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text("Rs.${details['price'] ?? 'N/A'}"),
                              Text(details['area'] ?? 'N/A'),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.call, color: Colors.green),
                                    onPressed: () {
                                      // Call action
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(FontAwesomeIcons.whatsapp, color: Colors.green),
                                    onPressed: () {
                                      // WhatsApp action
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
