import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaAboutView extends StatefulWidget {
  const RmaAboutView({super.key});

  @override
  State<RmaAboutView> createState() => _RmaAboutViewState();
}

class _RmaAboutViewState extends State<RmaAboutView> {
  List<Map<String, dynamic>> teamMembers = [
    {
      "name": "Sarah Johnson",
      "role": "CEO & Founder",
      "image": "https://picsum.photos/200/200?random=1&keyword=woman",
      "description": "Real estate industry veteran with 15+ years experience",
    },
    {
      "name": "Michael Chen",
      "role": "CTO",
      "image": "https://picsum.photos/200/200?random=2&keyword=man",
      "description": "Technology leader specializing in real estate solutions",
    },
    {
      "name": "Emily Rodriguez",
      "role": "Head of Design",
      "image": "https://picsum.photos/200/200?random=3&keyword=woman",
      "description": "UX/UI designer passionate about user-centric solutions",
    },
    {
      "name": "David Kim",
      "role": "Lead Developer",
      "image": "https://picsum.photos/200/200?random=4&keyword=man",
      "description": "Full-stack developer with expertise in mobile applications",
    },
  ];

  List<Map<String, dynamic>> features = [
    {
      "title": "Property Management",
      "description": "Comprehensive tools for managing your real estate portfolio",
      "icon": Icons.home,
    },
    {
      "title": "Market Analytics",
      "description": "Real-time market data and investment insights",
      "icon": Icons.analytics,
    },
    {
      "title": "Client Portal",
      "description": "Secure platform for client communication and document sharing",
      "icon": Icons.people,
    },
    {
      "title": "Document Storage",
      "description": "Cloud-based storage for all your real estate documents",
      "icon": Icons.cloud_upload,
    },
    {
      "title": "Transaction Tracking",
      "description": "Monitor all your deals from listing to closing",
      "icon": Icons.track_changes,
    },
    {
      "title": "Mobile Access",
      "description": "Access your data anywhere with our mobile app",
      "icon": Icons.mobile_friendly,
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
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spLg),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.business,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                  SizedBox(height: spLg),
                  Text(
                    "Real Estate Manager",
                    style: TextStyle(
                      fontSize: fsH2,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Empowering real estate professionals with innovative technology solutions",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(220),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: spLg),
                  Row(
                    children: [
                      _buildStatCard("50K+", "Users", Icons.people),
                      SizedBox(width: spMd),
                      _buildStatCard("500K+", "Properties", Icons.home),
                      SizedBox(width: spMd),
                      _buildStatCard("99.9%", "Uptime", Icons.cloud_done),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Our Story Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.auto_stories,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spMd),
                      Text(
                        "Our Story",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Founded in 2020, Real Estate Manager was born from the vision of simplifying property management for real estate professionals. Our team of industry experts and technology innovators came together to create a comprehensive platform that addresses the unique challenges faced by agents, brokers, and property managers.",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                      height: 1.6,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Today, we're proud to serve over 50,000 real estate professionals worldwide, helping them manage their properties, track transactions, and grow their businesses more efficiently than ever before.",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Mission & Vision
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: successColor.withAlpha(100)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.flag,
                          color: successColor,
                          size: 32,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "Our Mission",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "To empower real estate professionals with innovative technology that simplifies property management and enhances business growth.",
                          style: TextStyle(
                            fontSize: 14,
                            color: successColor,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: infoColor.withAlpha(100)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.visibility,
                          color: infoColor,
                          size: 32,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "Our Vision",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "To become the leading global platform for real estate management, making property transactions seamless and transparent.",
                          style: TextStyle(
                            fontSize: 14,
                            color: infoColor,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Features Section
            Text(
              "Key Features",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: features.map((feature) => _buildFeatureCard(feature)).toList(),
            ),

            SizedBox(height: spLg),

            // Team Section
            Text(
              "Meet Our Team",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            Column(
              children: teamMembers.map((member) => _buildTeamMemberCard(member)).toList(),
            ),

            SizedBox(height: spLg),

            // Company Info
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Company Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  _buildInfoRow("Founded", "2020"),
                  _buildInfoRow("Headquarters", "San Francisco, CA"),
                  _buildInfoRow("Employees", "250+"),
                  _buildInfoRow("Countries", "15+"),
                  _buildInfoRow("App Version", "2.1.0"),
                  _buildInfoRow("Last Updated", "June 2024"),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Contact & Support
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(100)),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.support_agent,
                    color: primaryColor,
                    size: 48,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Need Help?",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Our support team is here to help you succeed. Contact us anytime for assistance.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Contact Support",
                          size: bs.sm,
                          onPressed: () {
                            ss("Opening contact support");
                          },
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: QButton(
                          label: "Help Center",
                          size: bs.sm,
                          onPressed: () {
                            ss("Opening help center");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Legal Links
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                children: [
                  Text(
                    "Legal Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => ss("Opening privacy policy"),
                        child: Text(
                          "Privacy Policy",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text("•", style: TextStyle(color: disabledBoldColor)),
                      GestureDetector(
                        onTap: () => ss("Opening terms of service"),
                        child: Text(
                          "Terms of Service",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text("•", style: TextStyle(color: disabledBoldColor)),
                      GestureDetector(
                        onTap: () => ss("Opening licenses"),
                        child: Text(
                          "Licenses",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "© 2024 Real Estate Manager Inc. All rights reserved.",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(25),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: Colors.white.withAlpha(200),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(Map<String, dynamic> feature) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              feature["icon"],
              color: primaryColor,
              size: 24,
            ),
          ),
          SizedBox(height: spMd),
          Text(
            "${feature["title"]}",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "${feature["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMemberCard(Map<String, dynamic> member) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusLg),
            child: Image.network(
              "${member["image"]}",
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  "${member["role"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: successColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "${member["description"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spSm),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
