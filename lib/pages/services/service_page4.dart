import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ServicePage4 extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final YoutubePlayerController _youtubeController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
        "https://www.youtube.com/watch?v=ZJ1h0f-UJzg",
      )!,
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );

    final List<String> galleryImages = [
      'lib/Assets/images/DoctorPic.png',
      'lib/Assets/images/DoctorPic.png',
      'lib/Assets/images/DoctorPic.png',
    ];

    return Scaffold(
      appBar: AppBar(title: Text(detail)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Doctor Image
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'lib/Assets/images/DoctorPic.png',
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Doctor Name
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
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

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.phone, color: Colors.green),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.calendar_month,
                    color: Colors.redAccent,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const FaIcon(
                    FontAwesomeIcons.whatsapp,
                    color: Colors.green,
                  ),
                  onPressed: () {},
                ),
              ],
            ),

            const SizedBox(height: 20),

            // About + YouTube Video Side by Side
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "About",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Qualifications & Experience",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "1. Degrees: MBBS (Mysore Medical College, 1993), MS – Ophthalmology (KMC, Hubli, 1998), DNB (Ophthalmology), FGO, MNAMS\n"
              "2. Experience: ~32 years overall, with ~24 years as a specialist in cataract, cornea, refractive & LASIK surgery.\n"
              "3. Awards: -Dr C P Gupta Best Paper Award (2004) -Shiv Prasad Hardia award. AIOS (2007) - ...",
              style: TextStyle(height: 1.5),
            ),
            const SizedBox(height: 20),

            // YouTube Video Section (Below About)
            YoutubePlayer(
              controller: _youtubeController,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.redAccent,
              progressColors: const ProgressBarColors(
                playedColor: Colors.redAccent,
                handleColor: Colors.red,
              ),
            ),
            const SizedBox(height: 25),
            const SizedBox(height: 25),

            // Post Your Review Button
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to review form or show modal
              },
              icon: const Icon(Icons.rate_review),
              label: const Text("Post Your Review"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Gallery Carousel
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Gallery",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            CarouselSlider(
              options: CarouselOptions(
                height: 180.0,
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
    );
  }
}
