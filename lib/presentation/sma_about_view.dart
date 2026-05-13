import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaAboutView extends StatefulWidget {
  const SmaAboutView({super.key});

  @override
  State<SmaAboutView> createState() => _SmaAboutViewState();
}

class _SmaAboutViewState extends State<SmaAboutView> {
  List<Map<String, dynamic>> teamMembers = [
    {
      "name": "Sarah Johnson",
      "role": "CEO & Founder",
      "image": "https://picsum.photos/100/100?random=1&keyword=woman",
      "description": "Passionate about connecting people through technology",
    },
    {
      "name": "Michael Chen",
      "role": "CTO",
      "image": "https://picsum.photos/100/100?random=2&keyword=man",
      "description": "Building scalable solutions for millions of users",
    },
    {
      "name": "Emily Rodriguez",
      "role": "Head of Design",
      "image": "https://picsum.photos/100/100?random=3&keyword=woman",
      "description": "Creating beautiful and intuitive user experiences",
    },
    {
      "name": "David Kim",
      "role": "Head of Product",
      "image": "https://picsum.photos/100/100?random=4&keyword=man",
      "description": "Turning user feedback into amazing features",
    },
  ];

  List<Map<String, dynamic>> milestones = [
    {
      "year": "2019",
      "title": "Company Founded",
      "description": "Started with a simple idea to connect people better",
    },
    {
      "year": "2020",
      "title": "1M Users",
      "description": "Reached our first million users worldwide",
    },
    {
      "year": "2021",
      "title": "Global Expansion",
      "description": "Launched in 25+ countries across 5 continents",
    },
    {
      "year": "2022",
      "title": "Privacy First",
      "description": "Implemented end-to-end encryption for all messages",
    },
    {
      "year": "2023",
      "title": "10M Users",
      "description": "Celebrated 10 million active users milestone",
    },
    {
      "year": "2024",
      "title": "AI Integration",
      "description": "Launched AI-powered features for better user experience",
    },
  ];

  List<Map<String, dynamic>> values = [
    {
      "title": "Privacy First",
      "description": "Your data belongs to you. We use industry-leading encryption and never sell your personal information.",
      "icon": Icons.privacy_tip,
      "color": primaryColor,
    },
    {
      "title": "Authentic Connections",
      "description": "We believe in fostering genuine relationships and meaningful conversations, not just numbers.",
      "icon": Icons.people,
      "color": successColor,
    },
    {
      "title": "Inclusive Community",
      "description": "Everyone deserves to be heard. We're committed to creating a safe space for all voices.",
      "icon": Icons.diversity_3,
      "color": warningColor,
    },
    {
      "title": "Innovation",
      "description": "We continuously push boundaries to deliver the best social media experience possible.",
      "icon": Icons.rocket_launch,
      "color": infoColor,
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
          spacing: spMd,
          children: [
            // App Logo & Version
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXl),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Icon(
                      Icons.people,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  Text(
                    "SocialConnect",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Version 2.1.4 (Build 2024.12.15)",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Bringing people together, one connection at a time",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

            // Mission Statement
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "Our Mission",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "We believe that technology should bring people closer together, not drive them apart. Our mission is to create a platform where authentic connections flourish, meaningful conversations happen, and communities thrive.",
                      style: TextStyle(
                        fontSize: 15,
                        color: disabledBoldColor,
                        height: 1.5,
                      ),
                    ),
                    Text(
                      "In a world where social media often feels impersonal, we're committed to building a space that prioritizes genuine human connection, privacy, and positive interactions.",
                      style: TextStyle(
                        fontSize: 15,
                        color: disabledBoldColor,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Core Values
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Text(
                      "Our Core Values",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  ...values.map((value) {
                    return Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: disabledOutlineBorderColor, width: 0.5),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: value["color"].withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              value["icon"],
                              color: value["color"],
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
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${value["description"]}",
                                  style: TextStyle(
                                    fontSize: 14,
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

            // Statistics
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "By the Numbers",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    ResponsiveGridView(
                      minItemWidth: 150,
                      children: [
                        _buildStatCard("10M+", "Active Users", Icons.people, successColor),
                        _buildStatCard("50+", "Countries", Icons.public, infoColor),
                        _buildStatCard("500M+", "Messages Sent", Icons.chat, primaryColor),
                        _buildStatCard("99.9%", "Uptime", Icons.speed, warningColor),
                        _buildStatCard("24/7", "Support", Icons.support, dangerColor),
                        _buildStatCard("5 Years", "Experience", Icons.timeline, disabledBoldColor),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Timeline
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "Our Journey",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    ...milestones.map((milestone) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 60,
                            padding: EdgeInsets.symmetric(vertical: spXs, horizontal: spSm),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${milestone["year"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${milestone["title"]}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${milestone["description"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spMd),
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),

            // Team
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Text(
                      "Meet Our Team",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.only(left: spMd, right: spMd, bottom: spMd),
                    minItemWidth: 200,
                    children: teamMembers.map((member) {
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          spacing: spSm,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage("${member["image"]}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              "${member["name"]}",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${member["role"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${member["description"]}",
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
                ],
              ),
            ),

            // Contact Information
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "Get in Touch",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    Row(
                      children: [
                        Icon(Icons.email, color: primaryColor, size: 20),
                        SizedBox(width: spMd),
                        Text(
                          "support@socialconnect.com",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Icon(Icons.public, color: primaryColor, size: 20),
                        SizedBox(width: spMd),
                        Text(
                          "www.socialconnect.com",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Icon(Icons.location_on, color: primaryColor, size: 20),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Text(
                            "123 Innovation Drive, Tech Valley, CA 94000",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Footer
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Text(
                    "Thank you for being part of our community!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "© 2024 SocialConnect. All rights reserved.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
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

  Widget _buildStatCard(String value, String label, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Icon(icon, color: color, size: 24),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}
