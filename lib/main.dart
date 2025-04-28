import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ekanth Portfolio',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const PortfolioPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ekanth Portfolio'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HomeSection(),
            const ProjectsSection(),
            const SkillsSection(),
            const ContactSection(),
          ],
        ),
      ),
    );
  }
}

class HomeSection extends StatelessWidget {
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 70,
            backgroundImage: AssetImage('assets/images/profile.jpeg'),
          ),
          const SizedBox(height: 20),
          const Text(
            'Ekanth Gundanahalli Prakash',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Text(
            'Software Engineer | Flutter Developer',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Software Engineer with 3+ years of experience in cross-platform development using Flutter, Kotlin, and Swift. Skilled in CI/CD, scalable cloud integration (Firebase, GCP), and performance optimization across iOS and Android. Strong focus on clean architecture, testing, and building platform-level tools.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = [
      Project(
        title: 'ParkON - Parking App',
        summary: 'Hassle-free parking booking platform.',
        description: 'Designed and developed a crowd-sourced parking solution allowing users to reserve and navigate to available parking spots across homes, apartments, malls, airports, and multilevel complexes. Integrated EV charging points onboarding, live availability status, secure payment gateway, and map-based spot discovery.',
        tech: 'Flutter, Firebase (Auth, Firestore, Storage), Google Maps API, Google Cloud Functions, REST APIs, Provider, GitHub Actions (CI/CD), Docker, GCP Hosting',
        images: [
          'assets/images/parkon-1.jpg', 'assets/images/parkon-2.jpg',
          'assets/images/parkon-3.jpg', 'assets/images/parkon-4.jpg',
          'assets/images/parkon-5.jpg',
        ],
        logoPath: 'assets/images/logo-parkon.png',
      ),
      Project(
        title: 'EPod - EV Charging App',
        summary: 'AI-assisted futuristic EV charging experience.',
        description: 'Built a futuristic AI-assisted EV charging app with real-time location discovery, booking, and crowd-sourced onboarding of EV chargers. Implemented predictive availability based on usage data, automated notifications, dynamic charger management for hosts, and wallet integration for payments.',
        tech: 'Flutter, Firebase (Realtime Database, Cloud Messaging), Google Maps SDK, GCP Cloud Functions, Provider, WebSockets (real-time updates)',
        images: [
          'assets/images/epod-1.jpg', 'assets/images/epod-2.jpg',
          'assets/images/epod-3.jpg', 'assets/images/epod-4.jpg',
          'assets/images/epod-5.jpg',
        ],
        logoPath: 'assets/images/logo-epod.png',
      ),
      Project(
        title: 'Rentl - Property Searching App',
        summary: 'Map-based transparent rental search platform.',
        description: 'Developed a user-friendly mobile platform allowing property owners to list rentals directly. Integrated precise geolocation search, route calculation, and map-based browsing. Enabled users to find rental homes, PGs, apartments, and commercial spaces with transparent pricing and no brokerage',
        tech: 'Flutter, Google Maps SDK, Firebase Firestore, Cloud Functions, Stripe API (for premium listing payments), Provider, Bloc (for complex UI flows), Google Directions API',
        images: [
          'assets/images/rentl-1.jpg', 'assets/images/rentl-2.jpg',
          'assets/images/rentl-3.jpg', 'assets/images/rentl-4.jpg',
        ],
        logoPath: 'assets/images/logo-rentl.png',
      ),
      Project(
        title: 'ATG - Farmers Marketplace App',
        summary: 'One-stop agriculture solution for African farmers.',
        description: 'Built a digital platform providing weather forecasting, crop advisory, fertilizer recommendation, seed sourcing, agri-product purchasing, and news updates for farmers. Deployed live weather APIs, built offline-first architecture, and integrated farmer training modules to enhance agricultural productivity',
        tech: 'Kotlin, ROOM Database (offline support), Retrofit (network layer), Firebase Messaging, REST APIs, LiveData, ViewModel, Hilt Dependency Injection, WeatherStack API, Mapbox SDK',
        images: [
          'assets/images/ATG-1.jpg', 'assets/images/ATG-2.jpg',
          'assets/images/ATG-3.jpg', 'assets/images/ATG-4.jpg',
        ],
        logoPath: 'assets/images/logo-atg.png',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 30),
        const Text(
          'Apps Developed During Work Experience',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        ...projects.map((project) => AnimatedProjectCard(project: project)).toList(),
      ],
    );
  }
}

class Project {
  final String title;
  final String summary;
  final String description;
  final String tech;
  final List<String> images;
  final String logoPath;

  Project({
    required this.title,
    required this.summary,
    required this.description,
    required this.tech,
    required this.images,
    required this.logoPath,
  });
}

class AnimatedProjectCard extends StatefulWidget {
  final Project project;

  const AnimatedProjectCard({super.key, required this.project});

  @override
  State<AnimatedProjectCard> createState() => _AnimatedProjectCardState();
}

class _AnimatedProjectCardState extends State<AnimatedProjectCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  int activeIndex = 0;
  final CarouselSliderController carouselController = CarouselSliderController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _slideAnimation = Tween<Offset>(begin: const Offset(0.5, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _fadeAnimation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    WidgetsBinding.instance.addPostFrameCallback((_) => _controller.forward());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        widget.project.logoPath,
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          widget.project.title,
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  CarouselSlider.builder(
                    carouselController: carouselController,
                    itemCount: widget.project.images.length,
                    itemBuilder: (context, index, realIndex) {
                      final img = widget.project.images[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Theme.of(context).cardColor,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            img,
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 450,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      autoPlay: false,
                      viewportFraction: 0.55,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (index, reason) {
                        setState(() {
                          activeIndex = index;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: AnimatedSmoothIndicator(
                      activeIndex: activeIndex,
                      count: widget.project.images.length,
                      effect: ExpandingDotsEffect(
                        activeDotColor: Theme.of(context).colorScheme.primary,
                        dotHeight: 10,
                        dotWidth: 10,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(widget.project.summary, style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 6),
                  Text(widget.project.description),
                  const SizedBox(height: 6),
                  Text('Technologies: ${widget.project.tech}', style: const TextStyle(fontStyle: FontStyle.italic)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final skills = ['Flutter', 'Dart', 'Firebase', 'GCP', 'Kotlin', 'Swift', 'AWS', 'Python', 'C++'];

    return Column(
      children: [
        const SizedBox(height: 40),
        const Text('Skills', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: skills.map((skill) => Chip(label: Text(skill))).toList(),
        ),
      ],
    );
  }
}

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        const Text('Contact', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () {
            _launchUrl('mailto:ekanthgp57@gmail.com');
          },
          child: const Text('Email: ekanthgp57@gmail.com'),
        ),
        TextButton(
          onPressed: () {
            _launchUrl('https://www.linkedin.com/in/ekanth-gp-5b65481a5/');
          },
          child: const Text('LinkedIn: ekanth-gp-5b65481a5'),
        ),
        // TextButton(
        //   onPressed: () {
        //     _launchUrl('https://github.com/Ekanth57');
        //   },
        //   child: const Text('GitHub: Ekanth57'),
        // ),
        const SizedBox(height: 50),
      ],
    );
  }
}

