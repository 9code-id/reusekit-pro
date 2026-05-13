import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlProfile6View extends StatefulWidget {
  @override
  State<GrlProfile6View> createState() => _GrlProfile6ViewState();
}

class _GrlProfile6ViewState extends State<GrlProfile6View> {
  Map<String, dynamic> user = {
    "name": "Isabella Garcia",
    "username": "@chef_isabella",
    "avatar": "https://picsum.photos/100/100?random=17&keyword=chef",
    "profession": "Executive Chef",
    "restaurant": "La Bella Vista",
    "location": "New York, NY",
    "experience": "12+ years",
    "specialties": ["Italian", "Mediterranean", "Fusion"],
    "rating": 4.9,
    "reviews": 487,
    "dishes": 156,
    "awards": 8,
    "followers": 15600,
    "following": 342,
    "verified": true,
  };

  List<Map<String, dynamic>> menuHighlights = [
    {
      "image": "https://picsum.photos/300/200?random=18&keyword=pasta",
      "name": "Truffle Carbonara",
      "price": 28,
      "rating": 4.8,
      "category": "Italian",
      "popular": true,
    },
    {
      "image": "https://picsum.photos/300/200?random=19&keyword=seafood",
      "name": "Mediterranean Sea Bass",
      "price": 35,
      "rating": 4.9,
      "category": "Mediterranean",
      "popular": false,
    },
    {
      "image": "https://picsum.photos/300/200?random=20&keyword=dessert",
      "name": "Tiramisu Reimagined",
      "price": 14,
      "rating": 4.7,
      "category": "Dessert",
      "popular": true,
    },
    {
      "image": "https://picsum.photos/300/200?random=21&keyword=salad",
      "name": "Garden Fresh Caprese",
      "price": 18,
      "rating": 4.6,
      "category": "Appetizer",
      "popular": false,
    },
  ];

  List<Map<String, dynamic>> achievements = [
    {
      "icon": Icons.emoji_events,
      "title": "James Beard Award",
      "year": "2023",
      "description": "Outstanding Chef",
    },
    {
      "icon": Icons.star,
      "title": "Michelin Recognition",
      "year": "2022",
      "description": "Bib Gourmand",
    },
    {
      "icon": Icons.restaurant,
      "title": "Best New Restaurant",
      "year": "2021",
      "description": "Food & Wine Magazine",
    },
    {
      "icon": Icons.school,
      "title": "Culinary Institute",
      "year": "2011",
      "description": "Summa Cum Laude",
    },
  ];

  List<Map<String, dynamic>> cookingClasses = [
    {
      "name": "Authentic Italian Pasta Making",
      "duration": "3 hours",
      "price": 85,
      "capacity": 12,
      "enrolled": 8,
      "nextDate": "Dec 28, 2024",
      "difficulty": "Beginner",
    },
    {
      "name": "Mediterranean Seafood Masterclass",
      "duration": "4 hours",
      "price": 120,
      "capacity": 8,
      "enrolled": 6,
      "nextDate": "Jan 5, 2025",
      "difficulty": "Intermediate",
    },
    {
      "name": "Advanced Fusion Techniques",
      "duration": "6 hours",
      "price": 200,
      "capacity": 6,
      "enrolled": 4,
      "nextDate": "Jan 15, 2025",
      "difficulty": "Advanced",
    },
  ];

  List<Map<String, dynamic>> reviews = [
    {
      "customerName": "David K.",
      "rating": 5,
      "comment": "Chef Isabella's carbonara is absolutely divine! The truffle flavor is perfectly balanced.",
      "date": "1 week ago",
      "verified": true,
      "dish": "Truffle Carbonara",
    },
    {
      "customerName": "Maria S.",
      "rating": 5,
      "comment": "Took her pasta making class - incredible experience! Learned so much and had a blast.",
      "date": "2 weeks ago",
      "verified": true,
      "dish": "Cooking Class",
    },
    {
      "customerName": "James R.",
      "rating": 4,
      "comment": "Outstanding Mediterranean dishes. The sea bass was cooked to perfection.",
      "date": "3 weeks ago",
      "verified": true,
      "dish": "Mediterranean Sea Bass",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chef Profile"),
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
        child: Column(
          children: [
            // Chef Header
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.orange.shade50,
                    Colors.white,
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    // Avatar and Basic Info
                    Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: warningColor, width: 3),
                                boxShadow: [shadowLg],
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  "${user["avatar"]}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            if (user["verified"] == true)
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: warningColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 2),
                                  ),
                                  child: Icon(
                                    Icons.restaurant,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${user["name"]}",
                                    style: TextStyle(
                                      fontSize: fsH4,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  if (user["verified"] == true) ...[
                                    SizedBox(width: spXs),
                                    Icon(
                                      Icons.verified,
                                      color: warningColor,
                                      size: 20,
                                    ),
                                  ],
                                ],
                              ),
                              Text(
                                "${user["username"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${user["profession"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "${user["restaurant"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Location and Experience
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 16, color: disabledColor),
                        SizedBox(width: spXs),
                        Text(
                          "${user["location"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Icon(Icons.schedule, size: 16, color: disabledColor),
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
                    
                    SizedBox(height: spMd),
                    
                    // Specialties
                    Wrap(
                      spacing: spSm,
                      children: (user["specialties"] as List).map((specialty) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: Border.all(color: warningColor.withAlpha(100)),
                          ),
                          child: Text(
                            specialty,
                            style: TextStyle(
                              fontSize: 12,
                              color: warningColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Stats Row
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatColumn(
                            "${user["rating"]}★",
                            "Rating",
                            warningColor,
                          ),
                        ),
                        Expanded(
                          child: _buildStatColumn(
                            "${user["reviews"]}",
                            "Reviews",
                            infoColor,
                          ),
                        ),
                        Expanded(
                          child: _buildStatColumn(
                            "${user["dishes"]}",
                            "Dishes",
                            successColor,
                          ),
                        ),
                        Expanded(
                          child: _buildStatColumn(
                            "${user["awards"]}",
                            "Awards",
                            dangerColor,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Follow Chef",
                            color: warningColor,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Book Table",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.message,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  // Menu Highlights
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
                              "Signature Dishes",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "View Menu",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spMd),
                        QHorizontalScroll(
                          children: menuHighlights.map((dish) {
                            return Container(
                              width: 200,
                              margin: EdgeInsets.only(right: spSm),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(radiusSm),
                                        ),
                                        child: Image.network(
                                          "${dish["image"]}",
                                          width: 200,
                                          height: 120,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      if (dish["popular"] == true)
                                        Positioned(
                                          top: spSm,
                                          left: spSm,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spSm,
                                              vertical: spXs,
                                            ),
                                            decoration: BoxDecoration(
                                              color: dangerColor,
                                              borderRadius: BorderRadius.circular(radiusSm),
                                            ),
                                            child: Text(
                                              "Popular",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(spSm),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${dish["name"]}",
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
                                              "${dish["category"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledColor,
                                              ),
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.star,
                                              size: 12,
                                              color: warningColor,
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              "${dish["rating"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: spXs),
                                        Text(
                                          "\$${dish["price"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: warningColor,
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

                  // Cooking Classes
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
                          "Cooking Classes",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spMd),
                        Column(
                          children: cookingClasses.map((classItem) {
                            double enrollmentRate = (classItem["enrolled"] as int) / (classItem["capacity"] as int);
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
                                      Expanded(
                                        child: Text(
                                          "${classItem["name"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getDifficultyColor(classItem["difficulty"]).withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "${classItem["difficulty"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: _getDifficultyColor(classItem["difficulty"]),
                                            fontWeight: FontWeight.bold,
                                          ),
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
                                        "${classItem["duration"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledColor,
                                        ),
                                      ),
                                      SizedBox(width: spMd),
                                      Icon(Icons.calendar_today, size: 14, color: disabledColor),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${classItem["nextDate"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spSm),
                                  Row(
                                    children: [
                                      Text(
                                        "\$${classItem["price"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: warningColor,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${classItem["enrolled"]}/${classItem["capacity"]} enrolled",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Container(
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: disabledColor.withAlpha(50),
                                      borderRadius: BorderRadius.circular(radiusLg),
                                    ),
                                    child: FractionallySizedBox(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: enrollmentRate,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: enrollmentRate > 0.8 ? dangerColor : successColor,
                                          borderRadius: BorderRadius.circular(radiusLg),
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
                                    "${achievement["year"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: warningColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${achievement["description"]}",
                                    textAlign: TextAlign.center,
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

                  // Customer Reviews
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
                              "Customer Reviews",
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
                                  color: warningColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spMd),
                        Column(
                          children: reviews.take(2).map((review) {
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
                                        "${review["customerName"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      if (review["verified"] == true) ...[
                                        SizedBox(width: spXs),
                                        Icon(
                                          Icons.verified,
                                          color: successColor,
                                          size: 14,
                                        ),
                                      ],
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
                                  Row(
                                    children: [
                                      Text(
                                        "Dish: ${review["dish"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: warningColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${review["date"]}",
                                        style: TextStyle(
                                          fontSize: 10,
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

                  // Contact Actions
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Full Menu",
                          size: bs.md,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Book Class",
                          color: warningColor,
                          size: bs.md,
                          onPressed: () {},
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

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Beginner":
        return successColor;
      case "Intermediate":
        return warningColor;
      case "Advanced":
        return dangerColor;
      default:
        return disabledColor;
    }
  }
}
