import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlProfile2View extends StatefulWidget {
  @override
  State<GrlProfile2View> createState() => _GrlProfile2ViewState();
}

class _GrlProfile2ViewState extends State<GrlProfile2View> {
  Map<String, dynamic> user = {
    "name": "Michael Chen",
    "username": "@michael_chen",
    "email": "michael.chen@company.com",
    "phone": "+1 (555) 987-6543",
    "avatar": "https://picsum.photos/100/100?random=2&keyword=man",
    "coverImage": "https://picsum.photos/400/200?random=3&keyword=city",
    "title": "Senior Software Engineer",
    "company": "Tech Solutions Inc.",
    "experience": "5+ years",
    "skills": ["Flutter", "React", "Node.js", "Python", "AWS"],
    "completionRate": 85,
    "projectsCompleted": 42,
    "rating": 4.8,
    "reviews": 156,
  };

  List<Map<String, dynamic>> achievements = [
    {"icon": Icons.star, "title": "Top Performer", "description": "Achieved 95% client satisfaction"},
    {"icon": Icons.trending_up, "title": "Growth Leader", "description": "Increased team productivity by 30%"},
    {"icon": Icons.workspace_premium, "title": "Certified Expert", "description": "Flutter & AWS Certified"},
    {"icon": Icons.group, "title": "Team Player", "description": "Mentored 10+ junior developers"},
  ];

  List<Map<String, dynamic>> socialLinks = [
    {"icon": Icons.language, "label": "Website", "url": "michael-chen.dev"},
    {"icon": Icons.work, "label": "LinkedIn", "url": "linkedin.com/in/michael-chen"},
    {"icon": Icons.code, "label": "GitHub", "url": "github.com/michael-chen"},
    {"icon": Icons.email, "label": "Email", "url": "michael.chen@company.com"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Cover Image and Avatar Section
            Stack(
              children: [
                // Cover Image
                Container(
                  height: 200,
                  width: double.infinity,
                  child: Image.network(
                    "${user["coverImage"]}",
                    fit: BoxFit.cover,
                  ),
                ),
                
                // Gradient Overlay
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withAlpha(100),
                      ],
                    ),
                  ),
                ),

                // Back Button
                Positioned(
                  top: 40,
                  left: spMd,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(200),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {},
                    ),
                  ),
                ),

                // Settings Button
                Positioned(
                  top: 40,
                  right: spMd,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(200),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.settings, color: Colors.black),
                      onPressed: () {},
                    ),
                  ),
                ),

                // Avatar
                Positioned(
                  bottom: -40,
                  left: spMd,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: [shadowLg],
                    ),
                    child: ClipOval(
                      child: Image.network(
                        "${user["avatar"]}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Profile Content
            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  SizedBox(height: spLg),

                  // Basic Info Section
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${user["name"]}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${user["username"]}",
                              style: TextStyle(
                                fontSize: 16,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${user["title"]} at ${user["company"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: QButton(
                          label: "Follow",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),

                  // Stats Cards
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          "Projects",
                          "${user["projectsCompleted"]}",
                          Icons.work,
                          successColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard(
                          "Rating",
                          "${user["rating"]}★",
                          Icons.star,
                          warningColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard(
                          "Reviews",
                          "${user["reviews"]}",
                          Icons.rate_review,
                          infoColor,
                        ),
                      ),
                    ],
                  ),

                  // Completion Rate Progress
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Profile Completion",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${user["completionRate"]}%",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: disabledColor.withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: (user["completionRate"] as int) / 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Skills Section
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Skills & Expertise",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spMd),
                        Wrap(
                          spacing: spSm,
                          runSpacing: spSm,
                          children: (user["skills"] as List).map((skill) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusLg),
                                border: Border.all(
                                  color: primaryColor.withAlpha(50),
                                ),
                              ),
                              child: Text(
                                skill,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  // Achievements Section
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Achievements",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spMd),
                        Column(
                          children: achievements.map((achievement) {
                            return Container(
                              margin: EdgeInsets.only(bottom: spSm),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: warningColor.withAlpha(20),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      achievement["icon"] as IconData,
                                      color: warningColor,
                                      size: 20,
                                    ),
                                  ),
                                  SizedBox(width: spMd),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${achievement["title"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Text(
                                          "${achievement["description"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledColor,
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
                      ],
                    ),
                  ),

                  // Social Links Section
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Connect With Me",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spMd),
                        Column(
                          children: socialLinks.map((link) {
                            return Container(
                              margin: EdgeInsets.only(bottom: spSm),
                              child: GestureDetector(
                                onTap: () {},
                                child: Row(
                                  children: [
                                    Icon(
                                      link["icon"] as IconData,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                    SizedBox(width: spMd),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${link["label"]}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor,
                                            ),
                                          ),
                                          Text(
                                            "${link["url"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      Icons.open_in_new,
                                      color: disabledColor,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Message",
                          size: bs.md,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.share,
                        size: bs.md,
                        onPressed: () {},
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

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: disabledColor,
            ),
          ),
        ],
      ),
    );
  }
}
