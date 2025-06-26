import 'package:flutter/material.dart';
import 'package:medbook/components/ImageCarousel.dart';
import 'package:medbook/data/app_data.dart';

class ServicePage2 extends StatelessWidget {
  final String topic;
  const ServicePage2({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    final service = (data['service'] as List)
        .cast<Map<String, dynamic>>()
        .firstWhere(
          (s) => s['serviceName']
              .toString()
              .toLowerCase()
              .replaceAll(' ', '-') ==
              topic,
          orElse: () => {},
        );

    if (service.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('Service not found')),
      );
    }

    final serviceTypes = service['serviceTypes'];

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
      body: Column(
        children: [
          // 👇 Insert the image carousel here
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: ImageCarousel(), // your reusable component
          ),
          // 👇 Expand the list below carousel
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              itemCount: serviceTypes.length,
              itemBuilder: (context, index) {
                final type = serviceTypes[index];
                final subSlug =
                    type['serviceType'].toLowerCase().replaceAll(' ', '-');

                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/service/$topic/$subSlug");
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange.shade200),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        _getIconForService(type['serviceType']),
                        const SizedBox(width: 16),
                        Text(
                          type['serviceType'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getIconForService(String name) {
    switch (name.toLowerCase()) {
      case 'eye care':
        return const Icon(Icons.remove_red_eye, size: 32, color: Colors.blue);
      case 'kiny care':
      case 'kidney care':
        return const Icon(Icons.opacity, size: 32, color: Colors.teal);
      case 'heart care':
        return const Icon(Icons.favorite, size: 32, color: Colors.red);
      default:
        return const Icon(Icons.local_hospital, size: 32, color: Colors.grey);
    }
  }
}
