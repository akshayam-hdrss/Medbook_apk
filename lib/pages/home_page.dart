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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text(
          'MedBook',
          style: TextStyle(
      fontFamily: 'Impact',   // 👈 Use the custom font
      fontSize: 24,
      color: Colors.white,
    ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            ImageCarousel(),
            const SizedBox(height: 20),

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
            const Text(
              "Choose a Service Category",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            GridView.builder(
              itemCount: services.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 3,
              ),
              itemBuilder: (context, index) {
                final service = services[index];
                final slug = service['serviceName']
                    .toString()
                    .toLowerCase()
                    .replaceAll(' ', '-');

                IconData icon = Icons.cleaning_services;
                final name = service['serviceName'].toString().toLowerCase();
                if (name.contains('hospital')) {
                  icon = Icons.local_hospital;
                } else if (name.contains('home')) {
                  icon = Icons.home_repair_service;
                } else if (name.contains('doctor')) {
                  icon = Icons.medical_information;
                } else if (name.contains('pharmacy')) {
                  icon = Icons.local_pharmacy;
                }

                return GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, '/service/$slug'),
                  child: _buildCard(icon, service['serviceName'],
                      backgroundColor: Colors.orange.shade100,
                      iconColor: Colors.orange),
                );
              },
            ),

            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/service'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              child: const Text("Explore Services"),
            ),

            const SizedBox(height: 30),
            const Text(
              "Choose a Product Category",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            GridView.builder(
              itemCount: products.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 3,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                final slug = product['productName']
                    .toString()
                    .toLowerCase()
                    .replaceAll(' ', '-');

                IconData icon = Icons.medical_services;
                final name = product['productName'].toString().toLowerCase();
                if (name.contains('mask')) {
                  icon = Icons.masks;
                } else if (name.contains('medicine')) {
                  icon = Icons.healing;
                } else if (name.contains('kit')) {
                  icon = Icons.inventory_2;
                }

                return GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, '/product/$slug'),
                  child: _buildCard(icon, product['productName'],
                      backgroundColor: Colors.blue.shade100,
                      iconColor: Colors.blue),
                );
              },
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/product'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
              ),
              child: const Text("Explore Product"),
            ),
          ],
        ),
      ),
    );
  }

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
          Image.asset(iconPath, height: 24, width: 24),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildCard(IconData icon, String title,
      {required Color backgroundColor, required Color iconColor}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: backgroundColor,
              child: Icon(icon, size: 20, color: iconColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
     ),
  );
}
}