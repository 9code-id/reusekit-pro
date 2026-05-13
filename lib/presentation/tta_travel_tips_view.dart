import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaTravelTipsView extends StatefulWidget {
  const TtaTravelTipsView({super.key});

  @override
  State<TtaTravelTipsView> createState() => _TtaTravelTipsViewState();
}

class _TtaTravelTipsViewState extends State<TtaTravelTipsView> {
  String selectedCategory = "All";

  List<Map<String, dynamic>> tipCategories = [
    {"label": "All", "value": "All"},
    {"label": "Budget", "value": "Budget"},
    {"label": "Safety", "value": "Safety"},
    {"label": "Packing", "value": "Packing"},
    {"label": "Local Culture", "value": "Culture"},
    {"label": "Photography", "value": "Photography"},
  ];

  List<Map<String, dynamic>> travelTips = [
    {
      "id": 1,
      "title": "10 Essential Items for Budget Backpacking",
      "category": "Budget",
      "author": "Travel Expert",
      "readTime": "5 min read",
      "image": "https://picsum.photos/300/200?random=1&keyword=backpack",
      "summary": "Must-have items that won't break your budget but will make your journey comfortable and safe.",
      "tips": [
        "Lightweight sleeping bag for hostels",
        "Portable water filter bottle",
        "Quick-dry travel towel",
        "Universal power adapter",
        "First aid essentials kit"
      ],
      "likes": 2456,
      "saves": 890,
      "isLiked": false,
      "isSaved": true,
      "difficulty": "Beginner",
      "location": "Worldwide"
    },
    {
      "id": 2,
      "title": "How to Stay Safe While Solo Traveling",
      "category": "Safety",
      "author": "Safety Guru",
      "readTime": "8 min read",
      "image": "https://picsum.photos/300/200?random=2&keyword=safety",
      "summary": "Essential safety tips for solo travelers to stay secure and confident on their adventures.",
      "tips": [
        "Share your itinerary with trusted contacts",
        "Research local customs and laws",
        "Keep copies of important documents",
        "Trust your instincts in uncertain situations",
        "Stay connected with regular check-ins"
      ],
      "likes": 3124,
      "saves": 1567,
      "isLiked": true,
      "isSaved": false,
      "difficulty": "Intermediate",
      "location": "Solo Travel"
    },
    {
      "id": 3,
      "title": "Mastering the Art of Light Packing",
      "category": "Packing",
      "author": "Minimalist Traveler",
      "readTime": "6 min read",
      "image": "https://picsum.photos/300/200?random=3&keyword=suitcase",
      "summary": "Learn how to pack efficiently and never worry about luggage weight limits again.",
      "tips": [
        "Roll clothes instead of folding",
        "Use packing cubes for organization",
        "Choose versatile clothing items",
        "Limit shoes to 2-3 pairs maximum",
        "Pack for laundry every 7-10 days"
      ],
      "likes": 1890,
      "saves": 743,
      "isLiked": false,
      "isSaved": true,
      "difficulty": "Beginner",
      "location": "General"
    },
    {
      "id": 4,
      "title": "Cultural Etiquette: What NOT to Do",
      "category": "Culture",
      "author": "Cultural Guide",
      "readTime": "10 min read",
      "image": "https://picsum.photos/300/200?random=4&keyword=culture",
      "summary": "Avoid cultural faux pas and show respect to local customs wherever you travel.",
      "tips": [
        "Research greeting customs beforehand",
        "Dress appropriately for religious sites",
        "Learn basic phrases in local language",
        "Understand tipping customs",
        "Respect photography restrictions"
      ],
      "likes": 2735,
      "saves": 1234,
      "isLiked": true,
      "isSaved": false,
      "difficulty": "Intermediate",
      "location": "Worldwide"
    },
    {
      "id": 5,
      "title": "Photography Tips for Travel Beginners",
      "category": "Photography",
      "author": "Travel Photographer",
      "readTime": "7 min read",
      "image": "https://picsum.photos/300/200?random=5&keyword=camera",
      "summary": "Capture stunning travel memories with these simple photography techniques.",
      "tips": [
        "Use natural light whenever possible",
        "Follow the rule of thirds",
        "Include people for scale and story",
        "Take photos during golden hour",
        "Don't forget to capture details"
      ],
      "likes": 1654,
      "saves": 567,
      "isLiked": false,
      "isSaved": true,
      "difficulty": "Beginner",
      "location": "General"
    },
  ];

  List<Map<String, dynamic>> quickTips = [
    {
      "tip": "Book flights on Tuesday afternoons for better deals",
      "category": "Budget",
      "icon": Icons.flight
    },
    {
      "tip": "Download offline maps before traveling",
      "category": "Safety",
      "icon": Icons.map
    },
    {
      "tip": "Pack one extra day's worth of essentials in carry-on",
      "category": "Packing",
      "icon": Icons.luggage
    },
    {
      "tip": "Learn to say 'hello', 'thank you', and 'sorry' in local language",
      "category": "Culture",
      "icon": Icons.translate
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredTips = selectedCategory == "All" 
        ? travelTips 
        : travelTips.where((tip) => tip["category"] == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Travel Tips"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.bookmark_border),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick Tips Section
            Container(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Text(
                      "Quick Tips",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: QHorizontalScroll(
                      children: quickTips.map((tip) {
                        return Container(
                          width: 280,
                          margin: EdgeInsets.only(left: spMd),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusMd),
                            border: Border.all(
                              color: primaryColor.withAlpha(30),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  tip["icon"] as IconData,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${tip["tip"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${tip["category"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
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
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Filter Categories
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: QCategoryPicker(
                items: tipCategories,
                value: selectedCategory,
                onChanged: (index, label, value, item) {
                  selectedCategory = value;
                  setState(() {});
                },
              ),
            ),

            SizedBox(height: spLg),

            // Travel Tips List
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Text(
                "Detailed Guides",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: spSm),

            Column(
              children: filteredTips.map((tip) {
                return Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: spMd,
                    vertical: spSm,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tip Image
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(radiusMd),
                        ),
                        child: Image.network(
                          "${tip["image"]}",
                          width: double.infinity,
                          height: 180,
                          fit: BoxFit.cover,
                        ),
                      ),

                      // Tip Content
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Category and Difficulty
                            Row(
                              children: [
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
                                    "${tip["category"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getDifficultyColor(tip["difficulty"] as String).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${tip["difficulty"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: _getDifficultyColor(tip["difficulty"] as String),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${tip["readTime"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: spSm),

                            // Title
                            Text(
                              "${tip["title"]}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: spXs),

                            // Summary
                            Text(
                              "${tip["summary"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),

                            SizedBox(height: spSm),

                            // Author Info
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${tip["author"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${tip["location"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: spSm),

                            // Key Tips Preview
                            Text(
                              "Key Tips:",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: spXs),
                            ...((tip["tips"] as List).take(3).map((tipItem) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: spXs),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 6,
                                      height: 6,
                                      margin: EdgeInsets.only(top: 6),
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Text(
                                        "$tipItem",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList()),

                            SizedBox(height: spSm),

                            // Actions
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    tip["isLiked"] = !(tip["isLiked"] as bool);
                                    setState(() {});
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        (tip["isLiked"] as bool) 
                                            ? Icons.favorite 
                                            : Icons.favorite_border,
                                        size: 18,
                                        color: (tip["isLiked"] as bool) 
                                            ? Colors.red 
                                            : disabledBoldColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${tip["likes"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: spSm),
                                GestureDetector(
                                  onTap: () {
                                    tip["isSaved"] = !(tip["isSaved"] as bool);
                                    setState(() {});
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        (tip["isSaved"] as bool) 
                                            ? Icons.bookmark 
                                            : Icons.bookmark_border,
                                        size: 18,
                                        color: (tip["isSaved"] as bool) 
                                            ? primaryColor 
                                            : disabledBoldColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${tip["saves"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                QButton(
                                  label: "Read More",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spLg),
          ],
        ),
      ),
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
        return primaryColor;
    }
  }
}
