import 'package:flutter/material.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medbook/pages/services/service_page4.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:medbook/components/ImageCarousel.dart';
import 'package:medbook/data/app_data.dart';
 // Make sure this exists

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
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: ImageCarousel(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: serviceList.length,
              itemBuilder: (context, index) {
                final item = serviceList[index] as Map<String, dynamic>;
                final details = item['serviceDetails'] as Map<String, dynamic>;
                final imageUrl = details['image'] ?? 'lib/Assets/images/DoctorPic.png';

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ServicePage4(
                           topic: topic,
                            subTopic: subTopic,
                            detail: item['name'],
                        ),
                      ),
                    );
                  },
                  child: Padding(
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
                                      // Phone call action
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.calendar_month, color: Colors.redAccent),
                                    onPressed: () {
                                      // Calendar action
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
