import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaWorkshopView extends StatefulWidget {
  const EmaWorkshopView({super.key});

  @override
  State<EmaWorkshopView> createState() => _EmaWorkshopViewState();
}

class _EmaWorkshopViewState extends State<EmaWorkshopView> {
  bool isRegistered = false;
  bool showMaterials = false;
  String selectedTab = "overview";
  int currentStep = 0;
  
  Map<String, dynamic> workshopData = {
    "id": "workshop_001",
    "title": "Hands-on AI Development Workshop",
    "subtitle": "Build Your First Machine Learning Model",
    "instructor": {
      "name": "Dr. Sarah Johnson",
      "title": "Senior AI Researcher",
      "company": "TechLab Institute",
      "avatar": "https://picsum.photos/80/80?random=1&keyword=instructor",
      "rating": 4.9,
      "totalWorkshops": 45,
    },
    "description": "Join us for an intensive 3-hour workshop where you'll learn to build, train, and deploy your first machine learning model. Perfect for beginners with basic programming knowledge.",
    "date": "June 25, 2025",
    "time": "2:00 PM - 5:00 PM PST",
    "duration": "3 hours",
    "location": "Virtual Workshop Room",
    "maxParticipants": 50,
    "currentParticipants": 38,
    "price": 89.00,
    "originalPrice": 149.00,
    "level": "Beginner to Intermediate",
    "prerequisites": ["Basic Python knowledge", "Laptop with internet", "Code editor installed"],
    "whatYouWillLearn": [
      "Fundamentals of machine learning concepts",
      "Data preprocessing and cleaning techniques",
      "Building your first neural network",
      "Model training and evaluation",
      "Deploying models to production",
      "Best practices and common pitfalls",
    ],
    "agenda": [
      {
        "time": "2:00 PM",
        "title": "Welcome & Introduction",
        "duration": "15 min",
        "description": "Workshop overview and participant introductions",
        "completed": false,
      },
      {
        "time": "2:15 PM",
        "title": "ML Fundamentals",
        "duration": "30 min",
        "description": "Core concepts and terminology in machine learning",
        "completed": false,
      },
      {
        "time": "2:45 PM",
        "title": "Data Preparation",
        "duration": "45 min",
        "description": "Hands-on data cleaning and preprocessing",
        "completed": false,
      },
      {
        "time": "3:30 PM",
        "title": "Break",
        "duration": "15 min",
        "description": "Short break and Q&A session",
        "completed": false,
      },
      {
        "time": "3:45 PM",
        "title": "Model Building",
        "duration": "60 min",
        "description": "Create and train your first neural network",
        "completed": false,
      },
      {
        "time": "4:45 PM",
        "title": "Deployment & Wrap-up",
        "duration": "15 min",
        "description": "Deploy your model and next steps",
        "completed": false,
      },
    ],
    "materials": [
      {
        "name": "Workshop Workbook",
        "type": "pdf",
        "size": "8.5 MB",
        "description": "Complete guide with exercises and solutions",
        "available": true,
      },
      {
        "name": "Code Templates",
        "type": "zip",
        "size": "2.1 MB",
        "description": "Starter code and project templates",
        "available": true,
      },
      {
        "name": "Dataset Files",
        "type": "csv",
        "size": "12.3 MB",
        "description": "Sample datasets for hands-on practice",
        "available": true,
      },
      {
        "name": "Bonus Resources",
        "type": "link",
        "description": "Additional reading materials and tutorials",
        "available": false,
      },
    ],
    "tools": [
      "Python 3.8+",
      "Jupyter Notebook",
      "Pandas & NumPy",
      "Scikit-learn",
      "TensorFlow",
      "Google Colab",
    ],
    "certificate": {
      "available": true,
      "requirements": "Complete all exercises and final project",
      "accredited": true,
    },
  };

  List<Map<String, dynamic>> reviews = [
    {
      "user": "Alex Chen",
      "rating": 5,
      "date": "2 weeks ago",
      "comment": "Excellent workshop! Dr. Johnson explains complex concepts in a very understandable way. The hands-on approach really helped solidify the learning.",
      "avatar": "https://picsum.photos/40/40?random=2&keyword=student",
    },
    {
      "user": "Maria Rodriguez",
      "rating": 5,
      "date": "1 month ago",
      "comment": "Perfect for beginners. I came with zero ML knowledge and left feeling confident about building my own models.",
      "avatar": "https://picsum.photos/40/40?random=3&keyword=woman",
    },
    {
      "user": "David Park",
      "rating": 4,
      "date": "1 month ago",
      "comment": "Great content and practical exercises. Would have liked a bit more time for Q&A, but overall very valuable.",
      "avatar": "https://picsum.photos/40/40?random=4&keyword=man",
    },
  ];

  void _toggleRegistration() {
    isRegistered = !isRegistered;
    setState(() {});
    ss(isRegistered ? "Registered for workshop successfully!" : "Registration cancelled");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Workshop Details"),
        actions: [
          GestureDetector(
            onTap: () {
              //navigateTo share workshop
            },
            child: Icon(
              Icons.share,
              color: primaryColor,
            ),
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Workshop Header
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: warningColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "WORKSHOP",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Spacer(),
                      if ((workshopData["maxParticipants"] as int) - (workshopData["currentParticipants"] as int) <= 5)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: dangerColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "Almost Full",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "${workshopData["title"]}",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "${workshopData["subtitle"]}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(220),
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusMd),
                          image: DecorationImage(
                            image: NetworkImage("${workshopData["instructor"]["avatar"]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: spMd),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${workshopData["instructor"]["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "${workshopData["instructor"]["title"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, color: warningColor, size: 14),
                              SizedBox(width: spXs),
                              Text(
                                "${workshopData["instructor"]["rating"]} • ${workshopData["instructor"]["totalWorkshops"]} workshops",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withAlpha(200),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Quick Info Cards
            ResponsiveGridView(
              minItemWidth: 200,
              children: [
                _buildInfoCard("Date & Time", "${workshopData["date"]}\n${workshopData["time"]}", Icons.schedule, primaryColor),
                _buildInfoCard("Duration", "${workshopData["duration"]}", Icons.timer, infoColor),
                _buildInfoCard("Participants", "${workshopData["currentParticipants"]}/${workshopData["maxParticipants"]}", Icons.people, successColor),
                _buildInfoCard("Level", "${workshopData["level"]}", Icons.signal_cellular_4_bar, warningColor),
              ],
            ),

            SizedBox(height: spLg),

            // Price and Registration
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "\$${(workshopData["price"] as double).toStringAsFixed(0)}",
                            style: TextStyle(
                              fontSize: fsH3,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "\$${(workshopData["originalPrice"] as double).toStringAsFixed(0)}",
                            style: TextStyle(
                              fontSize: 16,
                              color: disabledBoldColor,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Save \$${((workshopData["originalPrice"] as double) - (workshopData["price"] as double)).toStringAsFixed(0)}",
                        style: TextStyle(
                          fontSize: 14,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Expanded(
                    child: QButton(
                      label: isRegistered ? "Registered ✓" : "Register Now",
                      size: bs.md,
                      onPressed: _toggleRegistration,
                    ),
                  ),
                ],
              ),
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
                  _buildTabButton("Overview", "overview"),
                  _buildTabButton("Agenda", "agenda"),
                  _buildTabButton("Reviews", "reviews"),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Tab Content
            if (selectedTab == "overview") _buildOverviewTab(),
            if (selectedTab == "agenda") _buildAgendaTab(),
            if (selectedTab == "reviews") _buildReviewsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon, Color color) {
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
            size: 28,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
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

  Widget _buildOverviewTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Description
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
                "About This Workshop",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              Text(
                "${workshopData["description"]}",
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

        // What You'll Learn
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
                "What You'll Learn",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              ...(workshopData["whatYouWillLearn"] as List).map((item) => Container(
                margin: EdgeInsets.only(bottom: spSm),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: successColor,
                      size: 20,
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Text(
                        "$item",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ],
          ),
        ),

        SizedBox(height: spMd),

        // Prerequisites
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
                "Prerequisites",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              ...(workshopData["prerequisites"] as List).map((item) => Container(
                margin: EdgeInsets.only(bottom: spSm),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_right,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Text(
                        "$item",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ],
          ),
        ),

        SizedBox(height: spMd),

        // Tools & Software
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
                "Tools & Software",
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
                children: (workshopData["tools"] as List).map((tool) => Container(
                  padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Text(
                    "$tool",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: infoColor,
                    ),
                  ),
                )).toList(),
              ),
            ],
          ),
        ),

        SizedBox(height: spMd),

        // Materials
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
                  Text(
                    "Workshop Materials",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  if (isRegistered)
                    Text(
                      "Available",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
              SizedBox(height: spMd),
              ...(workshopData["materials"] as List).map((material) => Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: material["available"] || isRegistered ? successColor.withAlpha(25) : disabledColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Row(
                  children: [
                    Icon(
                      material["type"] == "pdf" ? Icons.picture_as_pdf :
                      material["type"] == "zip" ? Icons.archive :
                      material["type"] == "csv" ? Icons.table_chart :
                      Icons.link,
                      color: material["available"] || isRegistered ? successColor : disabledBoldColor,
                      size: 24,
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${material["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: material["available"] || isRegistered ? successColor : disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${material["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          if (material["size"] != null)
                            Text(
                              "${material["size"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledColor,
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (material["available"] || isRegistered)
                      QButton(
                        label: "Download",
                        size: bs.sm,
                        onPressed: () {
                          ss("Downloading ${material["name"]}");
                        },
                      ),
                  ],
                ),
              )).toList(),
            ],
          ),
        ),

        SizedBox(height: spMd),

        // Certificate Info
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: warningColor.withAlpha(25),
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(color: warningColor.withAlpha(50)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.verified, color: warningColor, size: 24),
                  SizedBox(width: spMd),
                  Text(
                    "Certificate of Completion",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: warningColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Text(
                "${workshopData["certificate"]["requirements"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: warningColor,
                ),
              ),
              if (workshopData["certificate"]["accredited"])
                Text(
                  "✓ Accredited certificate included",
                  style: TextStyle(
                    fontSize: 12,
                    color: warningColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAgendaTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                "Workshop Schedule",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              ...(workshopData["agenda"] as List).asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> item = entry.value;
                bool isCompleted = item["completed"];
                bool isCurrent = index == currentStep;
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  child: Row(
                    children: [
                      // Timeline
                      Container(
                        width: 40,
                        child: Column(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: isCompleted ? successColor : 
                                       isCurrent ? primaryColor : disabledOutlineBorderColor,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              child: Icon(
                                isCompleted ? Icons.check : 
                                isCurrent ? Icons.play_arrow : Icons.circle,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                            if (index < (workshopData["agenda"] as List).length - 1)
                              Container(
                                width: 2,
                                height: 60,
                                color: disabledOutlineBorderColor,
                              ),
                          ],
                        ),
                      ),
                      
                      // Content
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: isCurrent ? primaryColor.withAlpha(25) : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusMd),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${item["time"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(width: spMd),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: disabledColor.withAlpha(50),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${item["duration"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "${item["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isCurrent ? primaryColor : disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${item["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
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
                "${workshopData["instructor"]["rating"]}",
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
                  color: index < (workshopData["instructor"]["rating"] as double).floor() ? warningColor : disabledColor,
                  size: 20,
                )),
              ),
              SizedBox(height: spSm),
              Text(
                "Based on ${reviews.length} reviews",
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
          "Student Reviews",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),

        ...reviews.map((review) => Container(
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
