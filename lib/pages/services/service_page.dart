// service_page.dart
import 'package:flutter/material.dart';
import 'package:medbook/data/app_data.dart';

class ServicePage extends StatelessWidget {
  const ServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List services = data["service"];

    return Scaffold(
      appBar: AppBar(title: const Text("Explore Services")),
      body: ListView.builder(
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          final name = service["serviceName"];
          final slug = name.toLowerCase().replaceAll(' ', '-');

          return ListTile(
            title: Text(name),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(context, "/service/$slug");
            },
          );
        },
      ),
    );
  }
}
