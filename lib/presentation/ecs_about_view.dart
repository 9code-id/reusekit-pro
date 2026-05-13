import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsAboutView extends StatefulWidget {
  const EcsAboutView({super.key});

  @override
  State<EcsAboutView> createState() => _EcsAboutViewState();
}

class _EcsAboutViewState extends State<EcsAboutView> {
  List<Map<String, dynamic>> teamMembers = [
    {
      "name": "John Smith",
      "position": "CEO & Founder",
      "image": "https://picsum.photos/100/100?random=1&keyword=ceo",
      "bio": "Visionary leader with 15+ years in e-commerce"
    },
    {
      "name": "Sarah Johnson",
      "position": "CTO",
      "image": "https://picsum.photos/100/100?random=2&keyword=tech",
      "bio": "Technology expert specializing in mobile platforms"
    },
    {
      "name": "Mike Chen",
      "position": "Head of Design",
      "image": "https://picsum.photos/100/100?random=3&keyword=design",
      "bio": "Award-winning UX designer with passion for innovation"
    },
    {
      "name": "Emily Davis",
      "position": "Marketing Director",
      "image": "https://picsum.photos/100/100?random=4&keyword=marketing",
      "bio": "Brand strategist building meaningful customer relationships"
    },
  ];

  List<Map<String, dynamic>> achievements = [
    {
      "title": "10M+",
      "subtitle": "Happy Customers",
      "icon": Icons.people,
      "color": primaryColor,
    },
    {
      "title": "500K+",
      "subtitle": "Products Sold",
      "icon": Icons.shopping_bag,
      "color": successColor,
    },
    {
      "title": "150+",
      "subtitle": "Countries Served",
      "icon": Icons.public,
      "color": infoColor,
    },
    {
      "title": "99.9%",
      "subtitle": "Uptime",
      "icon": Icons.verified,
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> values = [
    {
      "title": "Quality First",
      "description": "We never compromise on product quality and customer satisfaction",
      "icon": Icons.star,
    },
    {
      "title": "Innovation",
      "description": "Constantly evolving with the latest technology and trends",
      "icon": Icons.lightbulb,
    },
    {
      "title": "Sustainability",
      "description": "Committed to eco-friendly practices and sustainable business",
      "icon": Icons.eco,
    },
    {
      "title": "Community",
      "description": "Building a global community of satisfied customers and partners",
      "icon": Icons.group,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About ShopEase"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Company Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spLg),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.shopping_cart,
                      size: 48,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "ShopEase",
                    style: TextStyle(
                      fontSize: fsH2,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Your Premier E-commerce Destination",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fsH6,
                      color: Colors.white.withAlpha(230),
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Founded in 2018",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Company Story
            Text(
              "Our Story",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Text(
                "ShopEase was born from a simple idea: make online shopping effortless and enjoyable for everyone. What started as a small startup in 2018 has grown into a global platform serving millions of customers worldwide.\n\nWe believe that great products should be accessible to everyone, and technology should simplify life, not complicate it. That's why we've built an intuitive, fast, and secure shopping experience that puts our customers first.",
                style: TextStyle(
                  fontSize: 15,
                  color: disabledBoldColor,
                  height: 1.6,
                ),
              ),
            ),

            SizedBox(height: spMd),

            // Achievements
            Text(
              "Our Achievements",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: achievements.map((achievement) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (achievement["color"] as Color).withAlpha(20),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          achievement["icon"] as IconData,
                          color: achievement["color"] as Color,
                          size: 32,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${achievement["title"]}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: achievement["color"] as Color,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${achievement["subtitle"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spMd),

            // Company Values
            Text(
              "Our Values",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            ...values.map((value) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        value["icon"] as IconData,
                        color: primaryColor,
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
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),

            SizedBox(height: spMd),

            // Team Section
            Text(
              "Meet Our Team",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: teamMembers.map((member) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage("${member["image"]}"),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${member["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${member["position"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${member["bio"]}",
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

            SizedBox(height: spMd),

            // Contact Information
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Get in Touch",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "123 Commerce Street, Digital City, DC 12345",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.email,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "hello@shopease.com",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "+1 (800) 123-4567",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // App Version
            Center(
              child: Column(
                children: [
                  Text(
                    "ShopEase Mobile App",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Version 2.1.0 (Build 210)",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "© 2024 ShopEase Inc. All rights reserved.",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
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
