import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:medbook/pages/home_page.dart';
import 'package:medbook/pages/products/product_page.dart';
import 'package:medbook/pages/services/service_page.dart';
import 'package:medbook/pages/services/service_page2.dart';
import 'package:medbook/pages/services/service_page3.dart';
import 'package:medbook/pages/services/service_page4.dart';
// import 'package:medbook/pages/products/product_page.dart';
import 'package:medbook/pages/products/product_page2.dart';
import 'package:medbook/pages/products/product_page3.dart';
import 'package:medbook/admin/adminhome_page.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Service/Product Navigation App',
      
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        final uri = Uri.parse(settings.name!);

        // Home
        if (uri.pathSegments.isEmpty) {
          return MaterialPageRoute(
            builder: (_) => const HomePage(),
            settings: settings,
          );
        }

        // Service Routes
        if (uri.pathSegments.length == 1 && uri.pathSegments[0] == 'service') {
          return MaterialPageRoute(
            builder: (_) => const ServicePage(),
            settings: settings,
          );
        }

        if (uri.pathSegments.length >= 2 && uri.pathSegments[0] == 'service') {
          final topic = uri.pathSegments[1];
          if (uri.pathSegments.length == 2) {
            return MaterialPageRoute(
              builder: (_) => ServicePage2(topic: topic),
              settings: settings,
            );
          } else if (uri.pathSegments.length == 3) {
            final subTopic = uri.pathSegments[2];
            return MaterialPageRoute(
              builder: (_) => ServicePage3(topic: topic, subTopic: subTopic),
              settings: settings,
            );
          } else if (uri.pathSegments.length == 4) {
            final detail = uri.pathSegments[3];
            return MaterialPageRoute(
              builder: (_) => ServicePage4(
                topic: topic,
                subTopic: uri.pathSegments[2],
                detail: detail,
              ),
              settings: settings,
            );
          }
        }

        // Product Routes

        if (uri.pathSegments.length == 1 && uri.pathSegments[0] == 'product') {
          return MaterialPageRoute(
            builder: (_) => const ProductPage(),
            settings: settings,
          );
        }

        if (uri.pathSegments.length >= 2 && uri.pathSegments[0] == 'product') {
          final topic = uri.pathSegments[1];
          if (uri.pathSegments.length == 2) {
            return MaterialPageRoute(
              builder: (_) => ProductPage2(topic: topic),
              settings: settings,
            );
          } else if (uri.pathSegments.length == 3) {
            final subTopic = uri.pathSegments[2];
            return MaterialPageRoute(
              builder: (_) => ProductPage3(topic: topic, subTopic: subTopic),
              settings: settings,
            );
          }
        }

        // Admin
        if (kIsWeb && uri.path == '/admin') {
          return MaterialPageRoute(builder: (_) => const AdminPage());
        }

        // Not Found
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
          settings: settings,
        );
      },
    );
  }
}

