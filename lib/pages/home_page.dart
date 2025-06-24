import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medbook/components/ImageCarousel.dart';
import 'package:medbook/data/app_data.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> services =
        List<Map<String, dynamic>>.from(data['service']);
    final List<Map<String, dynamic>> products =
        List<Map<String, dynamic>>.from(data['product']);

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            ImageCarousel(),
            const SizedBox(height: 20),

            // 👇 HOSPITAL + DOCTOR buttons (your original code)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildIconButton(
                  context,
                  iconPath: 'lib/Assets/icons/hospital.png',
                  label: 'HOSPITALS',
                  route: '/service/hospital',
                ),
                _buildIconButton(
                  context,
                  iconPath: 'lib/Assets/icons/doctor.png',
                  label: 'DOCTORS',
                  route: '/service/doctor',
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text("Choose a Service Category",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // 👇 Grid layout for service buttons
            GridView.builder(
              itemCount: services.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 2.5,
              ),
              itemBuilder: (context, index) {
                final service = services[index];
                final slug = service['serviceName']
                    .toString()
                    .toLowerCase()
                    .replaceAll(' ', '-');
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/service/$slug'),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        const Icon(Icons.local_hospital,
                            size: 32, color: Colors.grey),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            service['serviceName'],
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/service'),
              child: const Text("Explore Services"),
            ),

            const SizedBox(height: 30),
            const Text("Choose a Product Category",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // 👇 Products section
            ...products.map((product) {
              final slug = product['productName']
                  .toString()
                  .toLowerCase()
                  .replaceAll(' ', '-');
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/product/$slug'),
                  child: Text(product['productName']),
                ),
              );
            }),

            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/product'),
              child: const Text("Explore Product"),
            ),

            if (kIsWeb) const SizedBox(height: 10),
            if (kIsWeb)
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/admin'),
                child: const Text("Admin Page (Web Only)"),
              ),
          ],
        ),
      ),
    );
  }

  // 🔁 Reusable Outlined Icon Button for Hospitals & Doctors
  Widget _buildIconButton(BuildContext context,
      {required String iconPath,
      required String label,
      required String route}) {
    return OutlinedButton(
      onPressed: () => Navigator.pushNamed(context, route),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        side: const BorderSide(color: Colors.orangeAccent),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            iconPath,
            height: 24,
            width: 24,
          ),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
