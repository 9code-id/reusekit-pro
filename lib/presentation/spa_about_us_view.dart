import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaAboutUsView extends StatefulWidget {
  const SpaAboutUsView({super.key});

  @override
  State<SpaAboutUsView> createState() => _SpaAboutUsViewState();
}

class _SpaAboutUsViewState extends State<SpaAboutUsView> {
  int selectedTeamMember = 0;

  final List<Map<String, dynamic>> teamMembers = [
    {
      "name": "Dr. Sarah Johnson",
      "position": "Founder & Chief Wellness Officer",
      "image": "https://picsum.photos/150/150?random=1&keyword=woman",
      "experience": "15+ years",
      "specialties": ["Aromatherapy", "Deep Tissue Massage", "Wellness Coaching"],
      "bio": "Dr. Sarah founded Spa Paradise with a vision to create a holistic wellness experience. With over 15 years in the industry, she brings expertise in both traditional and modern spa therapies.",
      "certifications": ["Licensed Massage Therapist", "Aromatherapy Specialist", "Wellness Coach"],
    },
    {
      "name": "Michael Chen",
      "position": "Head of Therapeutic Services",
      "image": "https://picsum.photos/150/150?random=2&keyword=man",
      "experience": "12+ years",
      "specialties": ["Sports Massage", "Injury Recovery", "Physical Therapy"],
      "bio": "Michael specializes in therapeutic treatments and injury recovery. His approach combines traditional massage techniques with modern rehabilitation methods.",
      "certifications": ["Physical Therapist", "Sports Massage Specialist", "Injury Recovery Expert"],
    },
    {
      "name": "Emma Rodriguez",
      "position": "Senior Aesthetician",
      "image": "https://picsum.photos/150/150?random=3&keyword=woman",
      "experience": "10+ years",
      "specialties": ["Facial Treatments", "Skin Analysis", "Anti-aging Therapies"],
      "bio": "Emma is our facial treatment expert with extensive knowledge in skincare and anti-aging therapies. She creates personalized treatment plans for optimal results.",
      "certifications": ["Licensed Aesthetician", "Anti-aging Specialist", "Skin Care Expert"],
    },
    {
      "name": "James Wilson",
      "position": "Wellness Coordinator",
      "image": "https://picsum.photos/150/150?random=4&keyword=man",
      "experience": "8+ years",
      "specialties": ["Meditation", "Yoga Therapy", "Stress Management"],
      "bio": "James focuses on mental wellness and stress management. He guides clients through meditation and mindfulness practices that complement physical treatments.",
      "certifications": ["Certified Yoga Instructor", "Meditation Teacher", "Stress Management Coach"],
    },
  ];

  final List<Map<String, dynamic>> achievements = [
    {
      "title": "Best Spa Award 2023",
      "description": "Recognized as the region's top wellness destination",
      "icon": Icons.emoji_events,
      "color": dangerColor,
    },
    {
      "title": "10,000+ Happy Clients",
      "description": "Serving the community with excellence since 2018",
      "icon": Icons.people,
      "color": successColor,
    },
    {
      "title": "Certified Organic Products",
      "description": "100% natural and environmentally conscious treatments",
      "icon": Icons.eco,
      "color": infoColor,
    },
    {
      "title": "5-Star Customer Rating",
      "description": "Consistently rated excellent by our valued clients",
      "icon": Icons.star,
      "color": warningColor,
    },
  ];

  final List<Map<String, dynamic>> values = [
    {
      "title": "Holistic Wellness",
      "description": "We believe in treating the whole person - mind, body, and spirit - for complete wellness and rejuvenation.",
      "icon": Icons.self_improvement,
      "color": primaryColor,
    },
    {
      "title": "Expert Care",
      "description": "Our certified professionals bring years of experience and ongoing education to every treatment.",
      "icon": Icons.medical_services,
      "color": successColor,
    },
    {
      "title": "Natural Approach",
      "description": "We use only the finest organic products and natural healing methods for safe, effective results.",
      "icon": Icons.nature,
      "color": infoColor,
    },
    {
      "title": "Personal Touch",
      "description": "Every treatment is customized to your unique needs and preferences for the best possible experience.",
      "icon": Icons.favorite,
      "color": dangerColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor.withAlpha(20),
                    primaryColor.withAlpha(5),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.spa,
                      size: 40,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Spa Paradise",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Your Premier Wellness Destination",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Our Story
            Text(
              "Our Story",
              style: TextStyle(
                fontSize: fsH4,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Founded in 2018, Spa Paradise began as a dream to create a sanctuary where people could escape the stresses of daily life and reconnect with their inner peace. What started as a small wellness center has grown into a premier spa destination, serving thousands of clients who trust us with their wellness journey.\n\nOur commitment to excellence, natural healing methods, and personalized care has made us a beloved part of the community. We continue to evolve and expand our services while staying true to our core values of holistic wellness and exceptional service.",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                height: 1.6,
              ),
            ),

            SizedBox(height: spLg),

            // Achievements
            Text(
              "Our Achievements",
              style: TextStyle(
                fontSize: fsH4,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: achievements.map((achievement) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: (achievement["color"] as Color).withAlpha(20),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          achievement["icon"] as IconData,
                          color: achievement["color"] as Color,
                          size: 30,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${achievement["title"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${achievement["description"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spLg),

            // Our Values
            Text(
              "Our Values",
              style: TextStyle(
                fontSize: fsH4,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            Column(
              children: values.map((value) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: (value["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Icon(
                          value["icon"] as IconData,
                          color: value["color"] as Color,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${value["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${value["description"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spLg),

            // Meet Our Team
            Text(
              "Meet Our Team",
              style: TextStyle(
                fontSize: fsH4,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            // Team Member Selector
            QHorizontalScroll(
              children: teamMembers.asMap().entries.map((entry) {
                int index = entry.key;
                var member = entry.value;
                bool isSelected = selectedTeamMember == index;
                
                return GestureDetector(
                  onTap: () {
                    selectedTeamMember = index;
                    setState(() {});
                  },
                  child: Container(
                    width: 100,
                    margin: EdgeInsets.only(
                      right: index < teamMembers.length - 1 ? spSm : 0,
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? primaryColor : Colors.transparent,
                              width: 3,
                            ),
                            boxShadow: [shadowSm],
                          ),
                          child: ClipOval(
                            child: Image.network(
                              "${member["image"]}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${member["name"]}".split(' ')[0],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? primaryColor : disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spLg),

            // Selected Team Member Details
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  // Profile Header
                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [shadowSm],
                        ),
                        child: ClipOval(
                          child: Image.network(
                            "${teamMembers[selectedTeamMember]["image"]}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${teamMembers[selectedTeamMember]["name"]}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${teamMembers[selectedTeamMember]["position"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${teamMembers[selectedTeamMember]["experience"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: spSm),

                  // Bio
                  Text(
                    "${teamMembers[selectedTeamMember]["bio"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.4,
                    ),
                  ),

                  SizedBox(height: spSm),

                  // Specialties
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Specialties:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: ((teamMembers[selectedTeamMember]["specialties"] as List).map((specialty) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "$specialty",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList()),
                      ),
                    ],
                  ),

                  SizedBox(height: spSm),

                  // Certifications
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Certifications:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      ...((teamMembers[selectedTeamMember]["certifications"] as List).map((cert) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: spXs),
                          child: Row(
                            children: [
                              Icon(
                                Icons.verified,
                                size: 16,
                                color: successColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "$cert",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList()),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Contact CTA
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor.withAlpha(20),
                    primaryColor.withAlpha(5),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: primaryColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.contact_support,
                    size: 48,
                    color: primaryColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Ready to Begin Your Wellness Journey?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Contact us today to schedule your personalized spa experience",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Contact Us",
                          size: bs.md,
                          onPressed: () {
                            si("Opening contact form...");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Book Now",
                          size: bs.md,
                          onPressed: () {
                            ss("Redirecting to booking...");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
