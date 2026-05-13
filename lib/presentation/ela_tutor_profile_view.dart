import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaTutorProfileView extends StatefulWidget {
  const ElaTutorProfileView({super.key});

  @override
  State<ElaTutorProfileView> createState() => _ElaTutorProfileViewState();
}

class _ElaTutorProfileViewState extends State<ElaTutorProfileView> {
  bool loading = false;
  int selectedTab = 0;

  Map<String, dynamic> tutor = {
    "id": 1,
    "name": "Dr. Sarah Johnson",
    "title": "ELA Specialist & Academic Coach",
    "avatar": "https://picsum.photos/150/150?random=1&keyword=teacher",
    "rating": 4.9,
    "totalReviews": 247,
    "experience": "12 years",
    "hourlyRate": 85,
    "specializations": ["Reading Comprehension", "Creative Writing", "Grammar", "Test Preparation"],
    "languages": ["English (Native)", "Spanish (Conversational)"],
    "education": [
      "Ph.D. in English Literature - Harvard University",
      "M.A. in Education - Stanford University",
      "B.A. in English - Yale University"
    ],
    "certifications": [
      "Certified Reading Specialist",
      "TESOL Certification",
      "Academic Writing Coach Certification"
    ],
    "about": "Passionate ELA educator with over 12 years of experience helping students excel in reading, writing, and critical thinking. I specialize in personalized learning approaches that make English Language Arts engaging and accessible for all learners.",
    "teachingStyle": "Interactive and student-centered approach focusing on building confidence through practical application and positive reinforcement.",
    "totalStudents": 156,
    "successRate": 95,
    "availability": "Mon-Fri: 9:00 AM - 6:00 PM EST",
    "responseTime": "Within 2 hours",
  };

  List<Map<String, dynamic>> reviews = [
    {
      "id": 1,
      "studentName": "Emily Chen",
      "rating": 5,
      "date": "2024-01-15",
      "comment": "Dr. Johnson helped me improve my writing skills dramatically. Her feedback is always constructive and encouraging.",
      "subject": "Creative Writing",
    },
    {
      "id": 2,
      "studentName": "Michael Rodriguez",
      "rating": 5,
      "date": "2024-01-10",
      "comment": "Excellent tutor! Made reading comprehension so much easier to understand. Highly recommend!",
      "subject": "Reading Comprehension",
    },
    {
      "id": 3,
      "studentName": "Ashley Williams",
      "rating": 4,
      "date": "2024-01-08",
      "comment": "Great teacher with lots of patience. Helped me prepare for my SAT English section.",
      "subject": "Test Preparation",
    },
  ];

  List<Map<String, dynamic>> achievements = [
    {
      "title": "Top Rated Tutor 2023",
      "description": "Highest student satisfaction rate",
      "icon": Icons.star,
      "color": warningColor,
    },
    {
      "title": "100+ Students Taught",
      "description": "Milestone achievement",
      "icon": Icons.people,
      "color": successColor,
    },
    {
      "title": "Perfect Attendance",
      "description": "No missed sessions in 2023",
      "icon": Icons.calendar_today,
      "color": infoColor,
    },
    {
      "title": "Advanced Certification",
      "description": "Reading Specialist Certified",
      "icon": Icons.school,
      "color": primaryColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tutor Profile"),
        actions: [
          QButton(
            icon: Icons.bookmark_border,
            size: bs.sm,
            onPressed: () {
              ss("Tutor bookmarked");
            },
          ),
          QButton(
            icon: Icons.share,
            size: bs.sm,
            onPressed: () {
              ss("Profile shared");
            },
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTutorHeader(),
                  SizedBox(height: spLg),
                  _buildStatsSection(),
                  SizedBox(height: spLg),
                  _buildTabNavigation(),
                  SizedBox(height: spMd),
                  _buildTabContent(),
                  SizedBox(height: spLg),
                  _buildActionButtons(),
                ],
              ),
            ),
    );
  }

  Widget _buildTutorHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radiusLg),
                  child: Image.network(
                    "${tutor["avatar"]}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${tutor["name"]}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${tutor["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Icon(Icons.star, color: warningColor, size: 18),
                        SizedBox(width: spXs),
                        Text(
                          "${tutor["rating"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "(${tutor["totalReviews"]} reviews)",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "\$${tutor["hourlyRate"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "per hour",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${tutor["experience"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "experience",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Performance Stats",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: [
            _buildStatCard(
              "Total Students",
              "${tutor["totalStudents"]}",
              Icons.people,
              infoColor,
            ),
            _buildStatCard(
              "Success Rate",
              "${tutor["successRate"]}%",
              Icons.trending_up,
              successColor,
            ),
            _buildStatCard(
              "Response Time",
              "${tutor["responseTime"]}",
              Icons.schedule,
              warningColor,
            ),
            _buildStatCard(
              "Availability",
              "Mon-Fri",
              Icons.calendar_today,
              primaryColor,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            color: color,
            width: 4,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabNavigation() {
    List<String> tabs = ["About", "Reviews", "Achievements"];
    
    return Row(
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
              child: Text(
                tab,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : disabledBoldColor,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case 0:
        return _buildAboutTab();
      case 1:
        return _buildReviewsTab();
      case 2:
        return _buildAchievementsTab();
      default:
        return _buildAboutTab();
    }
  }

  Widget _buildAboutTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            children: [
              Text(
                "About",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "${tutor["about"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  height: 1.5,
                ),
              ),
              SizedBox(height: spMd),
              Text(
                "Teaching Style",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "${tutor["teachingStyle"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: spMd),
        Container(
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
                "Specializations",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Wrap(
                spacing: spSm,
                runSpacing: spSm,
                children: (tutor["specializations"] as List).map((spec) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "$spec",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        SizedBox(height: spMd),
        Container(
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
                "Education",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Column(
                children: (tutor["education"] as List).map((edu) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Row(
                      children: [
                        Icon(
                          Icons.school,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "$edu",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
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
      ],
    );
  }

  Widget _buildReviewsTab() {
    return Column(
      children: reviews.map((review) => _buildReviewCard(review)).toList(),
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${review["studentName"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${review["subject"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < (review["rating"] as int) ? Icons.star : Icons.star_border,
                    color: warningColor,
                    size: 16,
                  );
                }),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${review["comment"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              height: 1.4,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "${DateTime.parse(review["date"]).dMMMy}",
            style: TextStyle(
              fontSize: 12,
              color: disabledColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementsTab() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: achievements.map((achievement) => _buildAchievementCard(achievement)).toList(),
    );
  }

  Widget _buildAchievementCard(Map<String, dynamic> achievement) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            color: achievement["color"] as Color,
            width: 4,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (achievement["color"] as Color).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  achievement["icon"] as IconData,
                  color: achievement["color"] as Color,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${achievement["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${achievement["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Book Session",
            size: bs.md,
            onPressed: () {
              // Navigate to booking
              ss("Booking session with ${tutor["name"]}");
            },
          ),
        ),
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Send Message",
                size: bs.md,
                onPressed: () {
                  // Navigate to chat
                  ss("Opening chat with ${tutor["name"]}");
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "View Schedule",
                size: bs.md,
                onPressed: () {
                  // Navigate to schedule
                  ss("Viewing schedule for ${tutor["name"]}");
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
