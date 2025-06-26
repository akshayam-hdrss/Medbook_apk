import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ServicePage4 extends StatefulWidget {
  final String topic;
  final String subTopic;
  final String detail;

  const ServicePage4({
    super.key,
    required this.topic,
    required this.subTopic,
    required this.detail,
  });

  @override
  State<ServicePage4> createState() => _ServicePage4State();
}

class _ServicePage4State extends State<ServicePage4> {
  late YoutubePlayerController _youtubeController;

  final List<String> galleryImages = [
    'lib/Assets/images/DoctorPic.png',
    'lib/Assets/images/DoctorPic.png',
    'lib/Assets/images/DoctorPic.png',
  ];

  @override
  void initState() {
    super.initState();
    _youtubeController = YoutubePlayerController.fromVideoId(
      videoId: 'ZJ1h0f-UJzg',
      autoPlay: false,
    );
  }

  @override
  void dispose() {
    _youtubeController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double carouselHeight = screenWidth >= 450 ? 300 : 180;
    return YoutubePlayerScaffold(
      controller: _youtubeController,
      builder: (context, player) => Scaffold(
        appBar: AppBar(title: Text(widget.detail)),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Doctor Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'lib/Assets/images/DoctorPic.png',
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),

              // Name
              const Text(
                "Dr. Ralph Edwards",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 10),

              // Rating & Experience
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6),
                        bottomLeft: Radius.circular(6),
                      ),
                    ),
                    child: const Text("0 Rating"),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(6),
                        bottomRight: Radius.circular(6),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.work, size: 18),
                        SizedBox(width: 5),
                        Text("10 EXP"),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // Call/Calendar/WhatsApp Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.phone, color: Colors.green),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_month, color: Colors.redAccent),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // About Section
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("About", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 8),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Qualifications & Experience", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 4),
              const Text(
                "1. Degrees: MBBS (Mysore Medical College, 1993), MS – Ophthalmology (KMC, Hubli, 1998), DNB (Ophthalmology), FGO, MNAMS\n"
                "2. Experience: ~32 years overall, with ~24 years as a specialist in cataract, cornea, refractive & LASIK surgery.\n"
                "3. Awards: -Dr C P Gupta Best Paper Award (2004) -Shiv Prasad Hardia award. AIOS (2007) - ...",
                style: TextStyle(height: 1.5),
              ),
              const SizedBox(height: 20),

              // YouTube Video
              player,
              const SizedBox(height: 25),

              // Review Section
              _buildReviewSection(),
              const SizedBox(height: 25),

              // Gallery Section
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Gallery", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 10),
              
              CarouselSlider(
                options: CarouselOptions(
                  height: carouselHeight,
                  enlargeCenterPage: true,
                  autoPlay: true,
                ),
                items: galleryImages.map((imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width * 0.8,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Review",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),

        // First review
        _buildReviewItem(
          image: '/lib/Assets/images/DoctorPic.png',
          name: 'Floyd Miles',
          review:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          rating: 3,
        ),
        const SizedBox(height: 15),

        // Second review
        _buildReviewItem(
          image: 'lib/Assets/images/DoctorPic.png',
          name: 'Floyd Miles',
          review:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          rating: 4,
        ),
        const SizedBox(height: 20),

        // Add Comment Button
        Center(
          child: ElevatedButton(
            onPressed: () {
              // Handle comment
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink.shade100,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text("Add Comment"),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewItem({
    required String image,
    required String name,
    required String review,
    double rating = 0,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile photo
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(image),
        ),
        const SizedBox(width: 12),

        // Text
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              if (rating > 0)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: RatingBarIndicator(
                    rating: rating,
                    itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.orange),
                    itemSize: 20,
                  ),
                ),
              const SizedBox(height: 6),
              Text(review, style: const TextStyle(height: 1.4)),
              const SizedBox(height: 6),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey.shade200,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text("Read More"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
