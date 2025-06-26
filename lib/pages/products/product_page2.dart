import 'package:flutter/material.dart';
import 'package:medbook/data/app_data.dart';
import 'package:medbook/components/ImageCarousel.dart';

class ProductPage2 extends StatelessWidget {
  final String topic;
  const ProductPage2({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> product = (data['product'] as List)
        .cast<Map<String, dynamic>>()
        .firstWhere(
          (p) =>
              p['productName'].toString().toLowerCase().replaceAll(' ', '-') ==
              topic,
          orElse: () => <String, dynamic>{},
        );

    if (product.isEmpty) {
      return const Scaffold(body: Center(child: Text('Product not found')));
    }

    final List<dynamic> productTypes = product['productTypes'] ?? [];

    return Scaffold(
      // backgroundColor: Colors.orange.shade50,
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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: ImageCarousel(),
          ),

          const SizedBox(height: 20),
          const Text(
            'Categories',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: productTypes.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 3 / 3.5,
            ),
            itemBuilder: (context, index) {
              final type = productTypes[index];
              final productTypeName = type['productType'].toString();
              final subSlug = productTypeName.toLowerCase().replaceAll(' ', '-');

              final useDummyImage = productTypeName.toLowerCase().contains('diagnostic') ||
                  productTypeName.toLowerCase().contains('surgical');

              return GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, "/product/$topic/$subSlug"),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 3,
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.vertical(top: Radius.circular(8)),
                          child: useDummyImage
                              ? Image.asset(
                                  'lib/Assets/images/product_page2/dummy.jpg',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                )
                              : Image.network(
                                  type['image'] ??
                                      'https://via.placeholder.com/200x200.png?text=Product',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          productTypeName,
                          style: const TextStyle(fontWeight: FontWeight.w600),
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
);
}
}