import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaSpeakerView extends StatefulWidget {
  const EmaSpeakerView({super.key});

  @override
  State<EmaSpeakerView> createState() => _EmaSpeakerViewState();
}

class _EmaSpeakerViewState extends State<EmaSpeakerView> {
  bool isFollowing = false;
  String selectedTab = "about";
  
  Map<String, dynamic> speakerData = {
    "id": "speaker_001",
    "name": "Dr. Sarah Johnson",
    "title": "Chief Technology Officer",
    "company": "MedTech Solutions",
    "avatar": "https://picsum.photos/150/150?random=1&keyword=doctor",
    "coverImage": "https://picsum.photos/400/200?random=2&keyword=office",
    "bio": "Dr. Sarah Johnson is a renowned technology leader with over 15 years of experience in healthcare innovation. She has been instrumental in developing cutting-edge AI solutions for medical diagnosis and patient care. Her work has been published in numerous peer-reviewed journals and she regularly speaks at international conferences.",
    "location": "San Francisco, CA",
    "experience": "15+ years",
    "rating": 4.9,
    "totalRatings": 324,
    "followers": 1250,
    "following": 89,
    "expertise": ["Artificial Intelligence", "Healthcare Technology", "Digital Transformation", "Medical Research"],
    "languages": ["English", "Spanish", "French"],
    "education": [
      {
        "degree": "Ph.D. in Computer Science",
        "institution": "Stanford University",
        "year": "2008",
      },
      {
        "degree": "M.S. in Biomedical Engineering",
        "institution": "MIT",
        "year": "2004",
      },
    ],
    "certifications": [
      "Certified AI Professional",
      "Healthcare Technology Specialist",
      "Digital Health Expert",
    ],
    "socialLinks": [
      {
        "platform": "LinkedIn",
        "url": "https://linkedin.com/in/sarahjohnson",
        "icon": Icons.business,
      },
      {
        "platform": "Twitter",
        "url": "https://twitter.com/drsarahjohnson",
        "icon": Icons.alternate_email,
      },
      {
        "platform": "Website",
        "url": "https://sarahjohnson.com",
        "icon": Icons.web,
      },
    ],
    "upcomingSessions": [
      {
        "id": "session_001",
        "title": "AI in Medical Diagnosis",
        "date": "2025-06-20",
        "time": "14:00",
        "duration": "60 min",
        "attendees": 245,
        "type": "presentation",
      },
      {
        "id": "session_002",
        "title": "Healthcare Innovation Workshop",
        "date": "2025-06-21",
        "time": "10:00",
        "duration": "120 min",
        "attendees": 150,
        "type": "workshop",
      },
    ],
    "pastSessions": [
      {
        "id": "session_003",
        "title": "Digital Transformation in Healthcare",
        "date": "2025-06-15",
        "rating": 4.8,
        "attendees": 324,
        "type": "presentation",
      },
      {
        "id": "session_004",
        "title": "Future of Medical Technology",
        "date": "2025-06-10",
        "rating": 4.9,
        "attendees": 456,
        "type": "keynote",
      },
    ],
    "publications": [
      {
        "title": "AI-Driven Healthcare: A Comprehensive Analysis",
        "journal": "Journal of Medical Innovation",
        "year": "2024",
        "citations": 156,
      },
      {
        "title": "Digital Health Transformation Strategies",
        "journal": "Healthcare Technology Review",
        "year": "2023",
        "citations": 89,
      },
    ],
    "awards": [
      {
        "name": "Healthcare Innovation Award",
        "organization": "Medical Technology Association",
        "year": "2024",
      },
      {
        "name": "Top 40 Under 40 in Healthcare",
        "organization": "Healthcare Leaders Magazine",
        "year": "2023",
      },
    ],
  };

  void _toggleFollow() {
    isFollowing = !isFollowing;
    setState(() {});
    ss(isFollowing ? "Following Dr. Sarah Johnson" : "Unfollowed Dr. Sarah Johnson");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Cover Image & Profile Section
            Stack(
              children: [
                // Cover Image
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("${speakerData["coverImage"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
                // Gradient overlay
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withAlpha(150),
                      ],
                    ),
                  ),
                ),

                // App Bar
                Positioned(
                  top: 40,
                  left: spMd,
                  right: spMd,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          //navigateTo back
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(100),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          //navigateTo share speaker
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(100),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.share,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      GestureDetector(
                        onTap: () {
                          //navigateTo speaker options
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(100),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.more_vert,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Profile Info
                Positioned(
                  bottom: spLg,
                  left: spMd,
                  right: spMd,
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(color: Colors.white, width: 3),
                          image: DecorationImage(
                            image: NetworkImage("${speakerData["avatar"]}"),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [shadowMd],
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${speakerData["name"]}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "${speakerData["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withAlpha(220),
                              ),
                            ),
                            Text(
                              "${speakerData["company"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Stats & Actions Section
            Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  // Stats Row
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard("Rating", "${speakerData["rating"]}", Icons.star, warningColor),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard("Followers", "${speakerData["followers"]}", Icons.people, primaryColor),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard("Sessions", "${(speakerData["pastSessions"] as List).length + (speakerData["upcomingSessions"] as List).length}", Icons.event, infoColor),
                      ),
                    ],
                  ),

                  SizedBox(height: spLg),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: QButton(
                          label: isFollowing ? "Following" : "Follow",
                          size: bs.md,
                          onPressed: _toggleFollow,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: QButton(
                          label: "Message",
                          size: bs.md,
                          onPressed: () {
                            //navigateTo message speaker
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: spLg),

                  // Tab Navigation
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        _buildTabButton("About", "about"),
                        _buildTabButton("Sessions", "sessions"),
                        _buildTabButton("Reviews", "reviews"),
                      ],
                    ),
                  ),

                  SizedBox(height: spLg),

                  // Tab Content
                  if (selectedTab == "about") _buildAboutTab(),
                  if (selectedTab == "sessions") _buildSessionsTab(),
                  if (selectedTab == "reviews") _buildReviewsTab(),
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
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, String tab) {
    bool isSelected = selectedTab == tab;
    
    return Expanded(
      child: GestureDetector(
        onTap: () {
          selectedTab = tab;
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: spMd),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          child: Text(
            label,
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
  }

  Widget _buildAboutTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bio Section
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
                "About",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              Text(
                "${speakerData["bio"]}",
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

        // Basic Info
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spMd,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on, color: disabledBoldColor, size: 20),
                  SizedBox(width: spMd),
                  Text(
                    "Location:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${speakerData["location"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.work, color: disabledBoldColor, size: 20),
                  SizedBox(width: spMd),
                  Text(
                    "Experience:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${speakerData["experience"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.language, color: disabledBoldColor, size: 20),
                  SizedBox(width: spMd),
                  Text(
                    "Languages:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    (speakerData["languages"] as List).join(", "),
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: spMd),

        // Expertise
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
                "Expertise",
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
                children: (speakerData["expertise"] as List).map((skill) => Container(
                  padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Text(
                    "$skill",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                )).toList(),
              ),
            ],
          ),
        ),

        SizedBox(height: spMd),

        // Education
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
                "Education",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              ...(speakerData["education"] as List).map((edu) => Container(
                margin: EdgeInsets.only(bottom: spMd),
                child: Row(
                  children: [
                    Icon(Icons.school, color: primaryColor, size: 20),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${edu["degree"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${edu["institution"]} • ${edu["year"]}",
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
              )).toList(),
            ],
          ),
        ),

        SizedBox(height: spMd),

        // Social Links
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
                "Connect",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              Row(
                children: (speakerData["socialLinks"] as List).map((link) => Expanded(
                  child: GestureDetector(
                    onTap: () {
                      ss("Opening ${link["platform"]}");
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: spSm),
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            link["icon"],
                            color: primaryColor,
                            size: 24,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "${link["platform"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSessionsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Upcoming Sessions
        if ((speakerData["upcomingSessions"] as List).isNotEmpty) ...[
          Text(
            "Upcoming Sessions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...(speakerData["upcomingSessions"] as List).map((session) => Container(
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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${session["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${session["type"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(Icons.schedule, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${session["date"]} • ${session["time"]} • ${session["duration"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.people, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${session["attendees"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Join Session",
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo session view
                    },
                  ),
                ),
              ],
            ),
          )).toList(),
          SizedBox(height: spLg),
        ],

        // Past Sessions
        Text(
          "Past Sessions",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        ...(speakerData["pastSessions"] as List).map((session) => Container(
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
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "${session["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: warningColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "${session["rating"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Icon(Icons.calendar_today, color: disabledBoldColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "${session["date"]}",
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.people, color: disabledBoldColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "${session["attendees"]} attendees",
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )).toList(),
      ],
    );
  }

  Widget _buildReviewsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Reviews Summary
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spLg),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              Text(
                "${speakerData["rating"]}",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) => Icon(
                  Icons.star,
                  color: index < (speakerData["rating"] as double).floor() ? warningColor : disabledColor,
                  size: 20,
                )),
              ),
              SizedBox(height: spSm),
              Text(
                "Based on ${speakerData["totalRatings"]} reviews",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: spLg),

        // Individual Reviews
        Text(
          "Recent Reviews",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),

        // Sample reviews
        ...[
          {
            "user": "Michael Chen",
            "rating": 5,
            "date": "2 days ago",
            "comment": "Excellent presentation on AI in healthcare. Dr. Johnson's insights were incredibly valuable and well-presented.",
            "avatar": "https://picsum.photos/40/40?random=4&keyword=man",
          },
          {
            "user": "Jennifer Walsh",
            "rating": 5,
            "date": "1 week ago", 
            "comment": "Outstanding workshop! Very engaging and informative. Highly recommend attending her sessions.",
            "avatar": "https://picsum.photos/40/40?random=5&keyword=woman",
          },
          {
            "user": "David Park",
            "rating": 4,
            "date": "2 weeks ago",
            "comment": "Great content and delivery. Would love to see more technical details in future sessions.",
            "avatar": "https://picsum.photos/40/40?random=6&keyword=man",
          },
        ].map((review) => Container(
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
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusMd),
                      image: DecorationImage(
                        image: NetworkImage("${review["avatar"]}"),
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
                          "${review["user"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Row(
                          children: [
                            Row(
                              children: List.generate(5, (index) => Icon(
                                Icons.star,
                                color: index < (review["rating"] as int) ? warningColor : disabledColor,
                                size: 14,
                              )),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${review["date"]}",
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
              Text(
                "${review["comment"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  height: 1.4,
                ),
              ),
            ],
          ),
        )).toList(),
      ],
    );
  }
}
