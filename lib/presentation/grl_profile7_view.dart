import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlProfile7View extends StatefulWidget {
  @override
  State<GrlProfile7View> createState() => _GrlProfile7ViewState();
}

class _GrlProfile7ViewState extends State<GrlProfile7View> {
  Map<String, dynamic> user = {
    "name": "Professor Elena Rodriguez",
    "title": "PhD in Computer Science",
    "university": "Stanford University",
    "department": "Artificial Intelligence Lab",
    "avatar": "https://picsum.photos/100/100?random=22&keyword=professor",
    "experience": "20+ years",
    "courses": 45,
    "students": 12450,
    "papers": 125,
    "citations": 8750,
    "rating": 4.8,
    "reviews": 234,
    "office": "Gates Building, Room 394",
    "email": "elena.rodriguez@stanford.edu",
    "specializations": ["Machine Learning", "Deep Learning", "Computer Vision", "Natural Language Processing"],
  };

  List<Map<String, dynamic>> currentCourses = [
    {
      "code": "CS 229",
      "name": "Machine Learning",
      "students": 450,
      "semester": "Fall 2024",
      "schedule": "Mon/Wed/Fri 10:30-11:20",
      "location": "Hewlett 200",
      "credits": 3,
    },
    {
      "code": "CS 231N",
      "name": "Computer Vision",
      "students": 320,
      "semester": "Fall 2024",
      "schedule": "Tue/Thu 1:30-2:50",
      "location": "NVIDIA Auditorium",
      "credits": 3,
    },
    {
      "code": "CS 224N",
      "name": "Natural Language Processing",
      "students": 380,
      "semester": "Spring 2025",
      "schedule": "Mon/Wed 2:30-3:50",
      "location": "Gates B01",
      "credits": 4,
    },
  ];

  List<Map<String, dynamic>> recentPapers = [
    {
      "title": "Advances in Neural Architecture Search for Computer Vision",
      "journal": "Nature Machine Intelligence",
      "year": 2024,
      "citations": 156,
      "coAuthors": 4,
    },
    {
      "title": "Self-Supervised Learning in Large Language Models",
      "journal": "ICML 2024",
      "year": 2024,
      "citations": 89,
      "coAuthors": 6,
    },
    {
      "title": "Ethical AI: Frameworks for Responsible Machine Learning",
      "journal": "AI Ethics Journal",
      "year": 2023,
      "citations": 234,
      "coAuthors": 3,
    },
    {
      "title": "Transformer Architectures for Multi-Modal Learning",
      "journal": "NeurIPS 2023",
      "year": 2023,
      "citations": 312,
      "coAuthors": 5,
    },
  ];

  List<Map<String, dynamic>> achievements = [
    {
      "icon": Icons.emoji_events,
      "title": "AI Excellence Award",
      "organization": "IEEE Computer Society",
      "year": "2023",
    },
    {
      "icon": Icons.school,
      "title": "Outstanding Educator",
      "organization": "Stanford University",
      "year": "2022",
    },
    {
      "icon": Icons.science,
      "title": "Best Paper Award",
      "organization": "ICML Conference",
      "year": "2021",
    },
    {
      "icon": Icons.group,
      "title": "Diversity in AI Champion",
      "organization": "AI4ALL Foundation",
      "year": "2020",
    },
  ];

  List<Map<String, dynamic>> officeHours = [
    {"day": "Monday", "time": "2:00 PM - 4:00 PM", "type": "In-Person"},
    {"day": "Wednesday", "time": "10:00 AM - 12:00 PM", "type": "Virtual"},
    {"day": "Friday", "time": "3:00 PM - 5:00 PM", "type": "In-Person"},
  ];

  List<Map<String, dynamic>> studentReviews = [
    {
      "studentName": "Alex T.",
      "course": "CS 229",
      "rating": 5,
      "comment": "Professor Rodriguez explains complex ML concepts with clarity. Her passion for the subject is infectious!",
      "semester": "Spring 2024",
    },
    {
      "studentName": "Sarah M.",
      "course": "CS 231N", 
      "rating": 5,
      "comment": "Best computer vision course I've ever taken. The assignments are challenging but very rewarding.",
      "semester": "Fall 2023",
    },
    {
      "studentName": "David K.",
      "course": "CS 224N",
      "rating": 4,
      "comment": "Excellent teaching style and very approachable during office hours. Highly recommend!",
      "semester": "Spring 2024",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Professor Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_border),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Professor Header Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.indigo.shade50,
                    Colors.white,
                  ],
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowLg],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: primaryColor, width: 3),
                          boxShadow: [shadowMd],
                        ),
                        child: ClipOval(
                          child: Image.network(
                            "${user["avatar"]}",
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
                              "${user["name"]}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${user["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: secondaryColor,
                              ),
                            ),
                            Text(
                              "${user["department"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${user["university"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(Icons.schedule, size: 14, color: disabledColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${user["experience"]} experience",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
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
                  
                  // Academic Stats
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatColumn(
                          "${user["courses"]}",
                          "Courses",
                          primaryColor,
                        ),
                      ),
                      Expanded(
                        child: _buildStatColumn(
                          "${(user["students"] as int) / 1000}K",
                          "Students",
                          successColor,
                        ),
                      ),
                      Expanded(
                        child: _buildStatColumn(
                          "${user["papers"]}",
                          "Papers",
                          infoColor,
                        ),
                      ),
                      Expanded(
                        child: _buildStatColumn(
                          "${(user["citations"] as int) / 1000}K",
                          "Citations",
                          warningColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Rating
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.star, color: warningColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "${user["rating"]} rating",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "(${user["reviews"]} reviews)",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "Available",
                            style: TextStyle(
                              fontSize: 10,
                              color: successColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Specializations
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
                    "Research Specializations",
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
                    children: (user["specializations"] as List).map((spec) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(color: primaryColor.withAlpha(100)),
                        ),
                        child: Text(
                          spec,
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

            // Current Courses
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
                    "Current Courses",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Column(
                    children: currentCourses.map((course) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: primaryColor.withAlpha(50)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${course["code"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${course["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${course["credits"]} credits",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(Icons.people, size: 14, color: disabledColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${course["students"]} students",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Icon(Icons.calendar_today, size: 14, color: disabledColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${course["semester"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(Icons.schedule, size: 14, color: disabledColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${course["schedule"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(Icons.location_on, size: 14, color: disabledColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${course["location"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Office Hours
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
                    children: [
                      Text(
                        "Office Hours",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.place, size: 16, color: disabledColor),
                      SizedBox(width: spXs),
                      Text(
                        "${user["office"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Column(
                    children: officeHours.map((hour) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: hour["type"] == "Virtual" 
                              ? infoColor.withAlpha(20) 
                              : successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: hour["type"] == "Virtual" ? infoColor : successColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${hour["day"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${hour["time"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: hour["type"] == "Virtual" ? infoColor : successColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${hour["type"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
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

            // Recent Publications
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
                        "Recent Publications",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 12,
                            color: secondaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Column(
                    children: recentPapers.take(3).map((paper) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${paper["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Text(
                                  "${paper["journal"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "(${paper["year"]})",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(Icons.format_quote, size: 14, color: disabledColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${paper["citations"]} citations",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Icon(Icons.group, size: 14, color: disabledColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${paper["coAuthors"]} co-authors",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Awards & Recognition
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
                    "Awards & Recognition",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: achievements.map((achievement) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              achievement["icon"] as IconData,
                              color: warningColor,
                              size: 24,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${achievement["title"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${achievement["organization"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledColor,
                              ),
                            ),
                            Text(
                              "${achievement["year"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: warningColor,
                                fontWeight: FontWeight.bold,
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

            // Student Reviews
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
                        "Student Reviews",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 12,
                            color: secondaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Column(
                    children: studentReviews.take(2).map((review) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${review["studentName"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${review["course"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  children: List.generate(5, (index) {
                                    return Icon(
                                      index < (review["rating"] as int) 
                                          ? Icons.star 
                                          : Icons.star_border,
                                      color: warningColor,
                                      size: 14,
                                    );
                                  }),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${review["comment"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${review["semester"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledColor,
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
                    "Contact Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Icon(Icons.email, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${user["email"]}",
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
                      Icon(Icons.location_on, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${user["office"]}",
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

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Send Message",
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Schedule Meeting",
                    color: secondaryColor,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: color,
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
    );
  }
}
