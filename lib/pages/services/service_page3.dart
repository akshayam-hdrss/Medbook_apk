import 'package:flutter/material.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
// import 'package:medbook/components/ImageCarousel.dart';
import 'package:medbook/data/app_data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:medbook/components/ImageCarousel.dart';


class ServicePage3 extends StatelessWidget {
  final String topic;
  final String subTopic;

  const ServicePage3({super.key, required this.topic, required this.subTopic});

  @override
  Widget build(BuildContext context) {
    final serviceListData = data['service'] as List<dynamic>;

    final service = serviceListData.cast<Map<String, dynamic>>().firstWhere(
      (s) =>
          s['serviceName'].toString().toLowerCase().replaceAll(' ', '-') ==
          topic,
      orElse: () => <String, dynamic>{},
    );

    if (service.isEmpty) {
      return const Scaffold(body: Center(child: Text('Service not found')));
    }

    final serviceTypes = service['serviceTypes'] as List<dynamic>;

    final type = serviceTypes.cast<Map<String, dynamic>>().firstWhere(
      (t) =>
          t['serviceType'].toString().toLowerCase().replaceAll(' ', '-') ==
          subTopic,
      orElse: () => <String, dynamic>{},
    );

    if (type.isEmpty) {
      return const Scaffold(body: Center(child: Text('Subcategory not found')));
    }

    final serviceList = type['serviceList'] as List<dynamic>;

    return Scaffold(
      appBar: AppBar(title: Text(type['serviceType'])),
      body: Column(
  children: [
    Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: ImageCarousel(), // your reusable component
          ),
    Expanded(
      child: ListView.builder(
        itemCount: serviceList.length,
        itemBuilder: (context, index) {
          final item = serviceList[index] as Map<String, dynamic>;
          final details = item['serviceDetails'] as Map<String, dynamic>;
          final imageUrl = details['image'] ?? 'lib/Assets/images/DoctorPic.png';

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    imageUrl,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(details['specialization'] ?? type['serviceType']),
                      Text(details['area'] ?? ''),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.phone, color: Colors.green),
                            onPressed: () {
                              // Call action
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.calendar_month, color: Colors.redAccent),
                            onPressed: () {
                              // Schedule action
                            },
                          ),
                          IconButton(
                            icon: const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green),
                            onPressed: () async {
                              final url = Uri.parse("https://wa.me/+923045873730/?text=Hello");
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url, mode: LaunchMode.externalApplication);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ),
  ],
),

     );
  }
}
