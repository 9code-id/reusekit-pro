import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaAboutView extends StatefulWidget {
  const FdaAboutView({super.key});

  @override
  State<FdaAboutView> createState() => _FdaAboutViewState();
}

class _FdaAboutViewState extends State<FdaAboutView> {
  bool loading = false;

  List<Map<String, dynamic>> teamMembers = [
    {
      "name": "Sarah Johnson",
      "role": "CEO & Founder",
      "image": "https://picsum.photos/100/100?random=1&keyword=woman",
      "description": "Passionate about connecting people with great food",
    },
    {
      "name": "Michael Chen",
      "role": "CTO",
      "image": "https://picsum.photos/100/100?random=2&keyword=man",
      "description": "Leading tech innovation in food delivery",
    },
    {
      "name": "Emily Rodriguez",
      "role": "Head of Operations",
      "image": "https://picsum.photos/100/100?random=3&keyword=woman",
      "description": "Ensuring smooth operations across all markets",
    },
    {
      "name": "David Kim",
      "role": "Head of Product",
      "image": "https://picsum.photos/100/100?random=4&keyword=man",
      "description": "Creating amazing user experiences",
    },
  ];

  List<Map<String, dynamic>> achievements = [
    {
      "title": "5M+",
      "subtitle": "Active Users",
      "icon": Icons.people,
    },
    {
      "title": "10K+",
      "subtitle": "Partner Restaurants",
      "icon": Icons.restaurant,
    },
    {
      "title": "50M+",
      "subtitle": "Orders Delivered",
      "icon": Icons.delivery_dining,
    },
    {
      "title": "100+",
      "subtitle": "Cities Served",
      "icon": Icons.location_city,
    },
  ];

  List<Map<String, dynamic>> values = [
    {
      "title": "Quality First",
      "description": "We partner only with restaurants that meet our high standards for food quality and safety.",
      "icon": Icons.verified,
      "color": primaryColor,
    },
    {
      "title": "Fast Delivery",
      "description": "Our advanced logistics ensure your food arrives hot and fresh, typically within 30 minutes.",
      "icon": Icons.flash_on,
      "color": warningColor,
    },
    {
      "title": "Customer Focus",
      "description": "Every decision we make is centered around providing the best possible experience for our customers.",
      "icon": Icons.favorite,
      "color": dangerColor,
    },
    {
      "title": "Sustainability",
      "description": "We're committed to reducing our environmental impact through eco-friendly packaging and practices.",
      "icon": Icons.eco,
      "color": successColor,
    },
  ];

  List<Map<String, dynamic>> milestones = [
    {
      "year": "2020",
      "title": "Company Founded",
      "description": "Started with a vision to revolutionize food delivery",
    },
    {
      "year": "2021",
      "title": "First Million Orders",
      "description": "Reached our first major milestone with 1M successful deliveries",
    },
    {
      "year": "2022",
      "title": "10 Cities Launch",
      "description": "Expanded operations to 10 major cities nationwide",
    },
    {
      "year": "2023",
      "title": "AI Integration",
      "description": "Launched AI-powered recommendations and delivery optimization",
    },
    {
      "year": "2024",
      "title": "Global Expansion",
      "description": "Entered international markets with sustainable delivery solutions",
    },
  ];

  void _contactUs() {
    // Navigate to contact page
  }

  void _visitWebsite() {
    // Open website
  }

  void _shareApp() {
    // Share app
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About FoodApp"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _shareApp,
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Hero Section
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spLg),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          primaryColor,
                          primaryColor.withAlpha(230),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusXl),
                            boxShadow: [shadowLg],
                          ),
                          child: Icon(
                            Icons.restaurant_menu,
                            size: 60,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "FoodApp",
                          style: TextStyle(
                            fontSize: fsH2,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Bringing delicious food to your doorstep",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withAlpha(230),
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Version 2.1.0",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(180),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Our Story Section
                  Container(
                    padding: EdgeInsets.all(spLg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Our Story",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "Founded in 2020, FoodApp started with a simple mission: to connect food lovers with their favorite restaurants while supporting local businesses. What began as a small startup has grown into one of the leading food delivery platforms, serving millions of customers across 100+ cities.",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.6,
                          ),
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "We believe that great food brings people together, and technology can make it more accessible to everyone. Our platform not only serves customers but also empowers restaurant partners to grow their business and reach new audiences.",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Achievements Section
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spLg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Our Impact",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spMd),
                        ResponsiveGridView(
                          padding: EdgeInsets.zero,
                          minItemWidth: 150,
                          children: achievements.map((achievement) {
                            return Container(
                              padding: EdgeInsets.all(spMd),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusMd),
                                boxShadow: [shadowSm],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusMd),
                                    ),
                                    child: Icon(
                                      achievement["icon"] as IconData,
                                      color: primaryColor,
                                      size: 24,
                                    ),
                                  ),
                                  SizedBox(height: spMd),
                                  Text(
                                    "${achievement["title"]}",
                                    style: TextStyle(
                                      fontSize: fsH3,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${achievement["subtitle"]}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spLg),

                  // Our Values Section
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spLg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Our Values",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spMd),
                        ...values.map((value) {
                          return Container(
                            margin: EdgeInsets.only(bottom: spMd),
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusMd),
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
                                SizedBox(width: spMd),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${value["title"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
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
                      ],
                    ),
                  ),

                  SizedBox(height: spLg),

                  // Timeline Section
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spLg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Our Journey",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spMd),
                        ...milestones.map((milestone) {
                          bool isLast = milestones.indexOf(milestone) == milestones.length - 1;
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(radiusLg),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${milestone["year"]}".substring(2),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (!isLast)
                                    Container(
                                      width: 2,
                                      height: 60,
                                      color: disabledOutlineBorderColor,
                                    ),
                                ],
                              ),
                              SizedBox(width: spMd),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(bottom: isLast ? 0 : spMd),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${milestone["title"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${milestone["description"]}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: disabledBoldColor,
                                          height: 1.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  ),

                  SizedBox(height: spLg),

                  // Team Section
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spLg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Meet Our Team",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spMd),
                        ResponsiveGridView(
                          padding: EdgeInsets.zero,
                          minItemWidth: 200,
                          children: teamMembers.map((member) {
                            return Container(
                              padding: EdgeInsets.all(spMd),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusMd),
                                boxShadow: [shadowSm],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(radiusLg),
                                      image: DecorationImage(
                                        image: NetworkImage("${member["image"]}"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: spMd),
                                  Text(
                                    "${member["name"]}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${member["role"]}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: spSm),
                                  Text(
                                    "${member["description"]}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      height: 1.3,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spLg),

                  // Contact Section
                  Container(
                    margin: EdgeInsets.all(spLg),
                    padding: EdgeInsets.all(spLg),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Get in Touch",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Have questions or feedback? We'd love to hear from you!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spMd),
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "Contact Us",
                                size: bs.md,
                                onPressed: _contactUs,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: QButton(
                                label: "Visit Website",
                                size: bs.md,
                                onPressed: _visitWebsite,
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
