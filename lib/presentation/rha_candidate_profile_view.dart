import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaCandidateProfileView extends StatefulWidget {
  const RhaCandidateProfileView({super.key});

  @override
  State<RhaCandidateProfileView> createState() => _RhaCandidateProfileViewState();
}

class _RhaCandidateProfileViewState extends State<RhaCandidateProfileView> {
  Map<String, dynamic> candidateProfile = {
    "id": "cand_001",
    "name": "John Smith",
    "email": "john.smith@email.com",
    "phone": "+1 (555) 123-4567",
    "position": "Senior Flutter Developer",
    "location": "San Francisco, CA",
    "experience": "5 years",
    "match_score": 92,
    "salary_expectation": "\$130,000",
    "current_salary": "\$115,000",
    "notice_period": "2 weeks",
    "availability": "Immediate",
    "avatar": "https://picsum.photos/300/300?random=1&keyword=person",
    "cover_image": "https://picsum.photos/800/200?random=1&keyword=city",
    "bio": "Passionate Flutter developer with 5+ years of experience in mobile app development. I love creating beautiful, performant applications that solve real-world problems.",
    "skills": [
      {"name": "Flutter", "level": 95, "years": 5},
      {"name": "Dart", "level": 90, "years": 5},
      {"name": "Firebase", "level": 85, "years": 4},
      {"name": "REST API", "level": 88, "years": 5},
      {"name": "Git", "level": 90, "years": 5},
      {"name": "CI/CD", "level": 75, "years": 3},
      {"name": "AWS", "level": 70, "years": 2},
      {"name": "State Management", "level": 92, "years": 4},
    ],
    "languages": [
      {"name": "English", "level": "Native"},
      {"name": "Spanish", "level": "Intermediate"},
      {"name": "French", "level": "Basic"},
    ],
    "social_links": {
      "linkedin": "https://linkedin.com/in/johnsmith",
      "github": "https://github.com/johnsmith",
      "portfolio": "https://johnsmith.dev",
      "twitter": "https://twitter.com/johnsmith",
    },
    "achievements": [
      {
        "title": "Top Performer Award",
        "organization": "TechStart Inc",
        "year": "2023",
        "description": "Recognized for outstanding performance and leadership in mobile development team."
      },
      {
        "title": "Flutter Developer Certification",
        "organization": "Google",
        "year": "2022",
        "description": "Certified Flutter developer with expertise in cross-platform development."
      },
      {
        "title": "Best Mobile App",
        "organization": "Tech Awards 2022",
        "year": "2022",
        "description": "Led development of award-winning mobile application for healthcare sector."
      },
    ],
    "projects": [
      {
        "name": "HealthCare Mobile App",
        "description": "Cross-platform mobile app for healthcare management with 100K+ downloads",
        "technologies": ["Flutter", "Firebase", "REST API"],
        "role": "Lead Developer",
        "duration": "6 months",
        "image": "https://picsum.photos/300/200?random=1&keyword=health",
      },
      {
        "name": "E-commerce Platform",
        "description": "Full-featured e-commerce mobile application with payment integration",
        "technologies": ["Flutter", "Node.js", "MongoDB"],
        "role": "Senior Developer",
        "duration": "8 months",
        "image": "https://picsum.photos/300/200?random=2&keyword=shopping",
      },
      {
        "name": "Food Delivery App",
        "description": "Real-time food delivery application with GPS tracking and notifications",
        "technologies": ["Flutter", "Firebase", "Google Maps"],
        "role": "Full Stack Developer",
        "duration": "4 months",
        "image": "https://picsum.photos/300/200?random=3&keyword=food",
      },
    ],
    "interests": [
      "Mobile Development",
      "UI/UX Design",
      "Open Source",
      "Technology Trends",
      "Photography",
      "Travel",
    ],
  };

  bool isLoading = false;
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Column(
              children: [
                _buildHeaderSection(),
                _buildProfileContent(),
              ],
            ),
          ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      height: 300,
      child: Stack(
        children: [
          // Cover Image
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("${candidateProfile["cover_image"]}"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withAlpha(50),
                    Colors.black.withAlpha(100),
                  ],
                ),
              ),
            ),
          ),
          // Back Button
          Positioned(
            top: 40,
            left: spMd,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(100),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => back(),
              ),
            ),
          ),
          // Action Buttons
          Positioned(
            top: 40,
            right: spMd,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(100),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.message, color: Colors.white),
                    onPressed: () => _sendMessage(),
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(100),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.more_vert, color: Colors.white),
                    onPressed: () => _showActions(),
                  ),
                ),
              ],
            ),
          ),
          // Profile Info
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(spMd),
              child: Row(
                children: [
                  // Avatar
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage("${candidateProfile["avatar"]}"),
                    ),
                  ),
                  SizedBox(width: spMd),
                  // Basic Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "${candidateProfile["name"]}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "${candidateProfile["position"]}",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 16, color: Colors.white.withAlpha(200)),
                            SizedBox(width: spXs),
                            Text(
                              "${candidateProfile["location"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Match Score
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${candidateProfile["match_score"]}%",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: _getMatchScoreColor(candidateProfile["match_score"]),
                          ),
                        ),
                        Text(
                          "Match",
                          style: TextStyle(
                            fontSize: 10,
                            color: _getMatchScoreColor(candidateProfile["match_score"]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileContent() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildContactInfo(),
          _buildBioSection(),
          _buildTabNavigation(),
          _buildTabContent(),
        ],
      ),
    );
  }

  Widget _buildContactInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.email, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${candidateProfile["email"]}",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              QButton(
                icon: Icons.copy,
                size: bs.sm,
                onPressed: () => _copyToClipboard(candidateProfile["email"]),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.phone, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${candidateProfile["phone"]}",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              QButton(
                icon: Icons.call,
                size: bs.sm,
                onPressed: () => _makeCall(),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.attach_money, color: successColor, size: 20),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Expected: ${candidateProfile["salary_expectation"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: successColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.schedule, color: warningColor, size: 20),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Notice Period: ${candidateProfile["notice_period"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: warningColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBioSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "About",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${candidateProfile["bio"]}",
            style: TextStyle(
              color: disabledBoldColor,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabNavigation() {
    List<String> tabs = ["Skills", "Projects", "Social", "Languages"];
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: tabs.asMap().entries.map((entry) {
          int index = entry.key;
          String tab = entry.value;
          bool isSelected = selectedTab == index;
          
          return Expanded(
            child: GestureDetector(
              onTap: () {
                selectedTab = index;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: spSm),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Center(
                  child: Text(
                    tab,
                    style: TextStyle(
                      color: isSelected ? Colors.white : disabledBoldColor,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case 0:
        return _buildSkillsTab();
      case 1:
        return _buildProjectsTab();
      case 2:
        return _buildSocialTab();
      case 3:
        return _buildLanguagesTab();
      default:
        return Container();
    }
  }

  Widget _buildSkillsTab() {
    return Column(
      spacing: spMd,
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text(
                "Technical Skills",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Column(
                children: (candidateProfile["skills"] as List).map((skill) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${skill["name"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              "${skill["years"]} years",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${skill["level"]}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getSkillLevelColor(skill["level"]),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          height: 6,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: (skill["level"] as int) / 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: _getSkillLevelColor(skill["level"]),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
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
        _buildInterestsSection(),
        _buildAchievementsSection(),
      ],
    );
  }

  Widget _buildInterestsSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Interests",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Wrap(
            spacing: spSm,
            runSpacing: spSm,
            children: (candidateProfile["interests"] as List).map((interest) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: infoColor.withAlpha(40)),
                ),
                child: Text(
                  "$interest",
                  style: TextStyle(
                    color: infoColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementsSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Achievements",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            children: (candidateProfile["achievements"] as List).map((achievement) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: warningColor.withAlpha(30)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: warningColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        Icons.emoji_events,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "${achievement["title"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${achievement["organization"]} • ${achievement["year"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${achievement["description"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                              height: 1.3,
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
    );
  }

  Widget _buildProjectsTab() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Featured Projects",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            children: (candidateProfile["projects"] as List).map((project) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(5),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                        image: DecorationImage(
                          image: NetworkImage("${project["image"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Text(
                            "${project["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${project["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              height: 1.4,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Role: ${project["role"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                "${project["duration"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: (project["technologies"] as List).map((tech) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "$tech",
                                  style: TextStyle(
                                    fontSize: 10,
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
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialTab() {
    Map<String, dynamic> socialLinks = candidateProfile["social_links"];
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Social Links & Portfolio",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            children: socialLinks.entries.map((entry) {
              String platform = entry.key;
              String url = entry.value;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(5),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getSocialColor(platform),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        _getSocialIcon(platform),
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            platform.toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            url,
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    QButton(
                      icon: Icons.open_in_new,
                      size: bs.sm,
                      onPressed: () => _openLink(url),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguagesTab() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Languages",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            children: (candidateProfile["languages"] as List).map((language) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(5),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getLanguageLevelColor(language["level"]),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        Icons.language,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "${language["name"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getLanguageLevelColor(language["level"]),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${language["level"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
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
    );
  }

  Color _getMatchScoreColor(int score) {
    if (score >= 90) return successColor;
    if (score >= 75) return warningColor;
    if (score >= 60) return infoColor;
    return dangerColor;
  }

  Color _getSkillLevelColor(int level) {
    if (level >= 90) return successColor;
    if (level >= 75) return warningColor;
    if (level >= 60) return infoColor;
    return dangerColor;
  }

  Color _getSocialColor(String platform) {
    switch (platform.toLowerCase()) {
      case "linkedin":
        return Color(0xFF0077B5);
      case "github":
        return Color(0xFF333333);
      case "portfolio":
        return primaryColor;
      case "twitter":
        return Color(0xFF1DA1F2);
      default:
        return disabledBoldColor;
    }
  }

  IconData _getSocialIcon(String platform) {
    switch (platform.toLowerCase()) {
      case "linkedin":
        return Icons.business;
      case "github":
        return Icons.code;
      case "portfolio":
        return Icons.web;
      case "twitter":
        return Icons.alternate_email;
      default:
        return Icons.link;
    }
  }

  Color _getLanguageLevelColor(String level) {
    switch (level.toLowerCase()) {
      case "native":
        return successColor;
      case "fluent":
        return primaryColor;
      case "intermediate":
        return warningColor;
      case "basic":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  void _sendMessage() {
    si("Opening message composer for ${candidateProfile["name"]}");
  }

  void _showActions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Text(
              "${candidateProfile["name"]}",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(Icons.schedule, color: primaryColor),
                SizedBox(width: spSm),
                Text("Schedule Interview"),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(Icons.description, color: infoColor),
                SizedBox(width: spSm),
                Text("View Resume"),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(Icons.share, color: warningColor),
                SizedBox(width: spSm),
                Text("Share Profile"),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(Icons.bookmark_add, color: successColor),
                SizedBox(width: spSm),
                Text("Add to Favorites"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _copyToClipboard(String text) {
    ss("$text copied to clipboard");
  }

  void _makeCall() {
    si("Calling ${candidateProfile["phone"]}...");
  }

  void _openLink(String url) {
    si("Opening: $url");
  }
}
