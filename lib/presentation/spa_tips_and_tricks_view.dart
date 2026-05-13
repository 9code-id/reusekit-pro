import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaTipsAndTricksView extends StatefulWidget {
  const SpaTipsAndTricksView({super.key});

  @override
  State<SpaTipsAndTricksView> createState() => _SpaTipsAndTricksViewState();
}

class _SpaTipsAndTricksViewState extends State<SpaTipsAndTricksView> {
  String selectedTipCategory = "All";
  List<bool> bookmarkedTips = [];

  final List<String> categories = [
    "All",
    "Preparation",
    "During Treatment",
    "Aftercare",
    "Wellness",
    "Booking",
  ];

  final List<Map<String, dynamic>> tips = [
    {
      "title": "Arrive 15 Minutes Early",
      "description": "Give yourself time to relax and complete any necessary paperwork. This helps you transition into a peaceful mindset before your treatment.",
      "category": "Preparation",
      "icon": Icons.schedule,
      "color": primaryColor,
      "difficulty": "Easy",
      "duration": "15 min",
      "steps": [
        "Check traffic conditions before leaving",
        "Complete online check-in if available",
        "Take deep breaths upon arrival",
        "Use the spa facilities to unwind"
      ],
    },
    {
      "title": "Hydrate Before and After",
      "description": "Proper hydration enhances the benefits of spa treatments and helps your body process toxins released during massage therapy.",
      "category": "Preparation",
      "icon": Icons.local_drink,
      "color": infoColor,
      "difficulty": "Easy",
      "duration": "Ongoing",
      "steps": [
        "Drink 2-3 glasses of water 2 hours before",
        "Avoid alcohol 24 hours before treatment",
        "Continue hydrating after your session",
        "Monitor urine color as hydration indicator"
      ],
    },
    {
      "title": "Communicate Your Preferences",
      "description": "Don't hesitate to speak up about pressure, temperature, or any discomfort. Your therapist wants you to have the best experience possible.",
      "category": "During Treatment",
      "icon": Icons.chat_bubble,
      "color": successColor,
      "difficulty": "Medium",
      "duration": "During session",
      "steps": [
        "Discuss any injuries or sensitive areas",
        "Request pressure adjustments as needed",
        "Mention temperature preferences",
        "Ask questions about techniques being used"
      ],
    },
    {
      "title": "Take Your Time Getting Up",
      "description": "After deep relaxation, your body needs time to readjust. Stand up slowly to avoid dizziness and maintain that peaceful feeling.",
      "category": "Aftercare",
      "icon": Icons.self_improvement,
      "color": warningColor,
      "difficulty": "Easy",
      "duration": "5-10 min",
      "steps": [
        "Lie still for 2-3 minutes after treatment",
        "Sit up slowly when ready",
        "Take a few deep breaths",
        "Stand gradually to prevent dizziness"
      ],
    },
    {
      "title": "Book During Off-Peak Hours",
      "description": "Schedule treatments during weekday mornings or early afternoons for better availability and often lower prices.",
      "category": "Booking",
      "icon": Icons.access_time,
      "color": dangerColor,
      "difficulty": "Easy",
      "duration": "Planning",
      "steps": [
        "Check spa's peak and off-peak hours",
        "Consider Tuesday-Thursday for best rates",
        "Book morning slots for freshest experience",
        "Ask about weekday discounts"
      ],
    },
    {
      "title": "Create a Spa Routine at Home",
      "description": "Extend your spa experience with simple at-home practices that maintain your wellness between professional treatments.",
      "category": "Wellness",
      "icon": Icons.home_work,
      "color": primaryColor,
      "difficulty": "Medium",
      "duration": "20-30 min daily",
      "steps": [
        "Set up a dedicated relaxation space",
        "Practice daily meditation or breathing",
        "Use essential oils for aromatherapy",
        "Take weekly detox baths"
      ],
    },
    {
      "title": "Maximize Package Benefits",
      "description": "Spa packages often provide better value and complementary treatments. Learn how to choose and use them effectively.",
      "category": "Booking",
      "icon": Icons.card_giftcard,
      "color": successColor,
      "difficulty": "Medium",
      "duration": "Planning",
      "steps": [
        "Compare individual vs package pricing",
        "Check package expiration dates",
        "Book treatments close together for maximum benefit",
        "Ask about customizing existing packages"
      ],
    },
    {
      "title": "Post-Treatment Nutrition",
      "description": "What you eat after a spa treatment can enhance or diminish its benefits. Choose nourishing foods that support detoxification.",
      "category": "Aftercare",
      "icon": Icons.restaurant,
      "color": infoColor,
      "difficulty": "Medium",
      "duration": "24-48 hours",
      "steps": [
        "Eat light, easily digestible foods",
        "Include antioxidant-rich fruits and vegetables",
        "Avoid heavy, processed foods for 24 hours",
        "Continue drinking plenty of water"
      ],
    },
  ];

  List<Map<String, dynamic>> get filteredTips {
    if (selectedTipCategory == "All") return tips;
    return tips.where((tip) => tip["category"] == selectedTipCategory).toList();
  }

  @override
  void initState() {
    super.initState();
    bookmarkedTips = List.filled(tips.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tips & Tricks"),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              si("View your bookmarked tips");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              "Expert Spa Tips",
              style: TextStyle(
                fontSize: fsH3,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "Professional advice to enhance your spa experience",
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
              ),
            ),

            SizedBox(height: spLg),

            // Category Filter
            QCategoryPicker(
              items: categories.map((category) => {
                "label": category,
                "value": category,
              }).toList(),
              value: selectedTipCategory,
              onChanged: (index, label, value, item) {
                selectedTipCategory = value;
                setState(() {});
              },
            ),

            SizedBox(height: spLg),

            // Tips List
            Column(
              children: filteredTips.asMap().entries.map((entry) {
                int index = tips.indexOf(entry.value);
                var tip = entry.value;
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Row
                      Row(
                        children: [
                          // Icon
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: (tip["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Icon(
                              tip["icon"] as IconData,
                              color: tip["color"] as Color,
                              size: 22,
                            ),
                          ),
                          SizedBox(width: spSm),
                          
                          // Title and Meta
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${tip["title"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: (tip["color"] as Color).withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "${tip["difficulty"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: tip["color"] as Color,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${tip["duration"]}",
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
                          
                          // Bookmark Button
                          GestureDetector(
                            onTap: () {
                              bookmarkedTips[index] = !bookmarkedTips[index];
                              setState(() {});
                              if (bookmarkedTips[index]) {
                                ss("Tip bookmarked!");
                              } else {
                                si("Bookmark removed");
                              }
                            },
                            child: Icon(
                              bookmarkedTips[index] 
                                  ? Icons.bookmark 
                                  : Icons.bookmark_border,
                              color: bookmarkedTips[index] 
                                  ? primaryColor 
                                  : disabledBoldColor,
                              size: 24,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spSm),

                      // Description
                      Text(
                        "${tip["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          height: 1.4,
                        ),
                      ),

                      SizedBox(height: spSm),

                      // Steps
                      Text(
                        "Steps to Follow:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      
                      Column(
                        children: ((tip["steps"] as List).asMap().entries.map((stepEntry) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: spXs),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: (tip["color"] as Color).withAlpha(20),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${stepEntry.key + 1}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: tip["color"] as Color,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${stepEntry.value}",
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
                      ),

                      SizedBox(height: spSm),

                      // Action Button
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Try This Tip",
                          size: bs.sm,
                          onPressed: () {
                            ss("Great choice! Remember: ${tip["title"]}");
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spLg),

            // Pro Tips Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor.withAlpha(10),
                    successColor.withAlpha(5),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: primaryColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.lightbulb,
                    size: 40,
                    color: primaryColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Pro Tip of the Day",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Book treatments in pairs or groups for a shared wellness experience and potential group discounts!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      fontStyle: FontStyle.italic,
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
}
