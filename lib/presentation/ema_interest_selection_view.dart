import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaInterestSelectionView extends StatefulWidget {
  const EmaInterestSelectionView({super.key});

  @override
  State<EmaInterestSelectionView> createState() => _EmaInterestSelectionViewState();
}

class _EmaInterestSelectionViewState extends State<EmaInterestSelectionView> {
  List<String> selectedInterests = [];
  
  List<Map<String, dynamic>> interestCategories = [
    {
      "id": "music",
      "title": "Music & Concerts",
      "icon": Icons.music_note,
      "color": Colors.purple,
      "description": "Live music, concerts, festivals",
    },
    {
      "id": "tech",
      "title": "Technology",
      "icon": Icons.computer,
      "color": Colors.blue,
      "description": "Tech talks, workshops, meetups",
    },
    {
      "id": "business",
      "title": "Business & Networking",
      "icon": Icons.business,
      "color": Colors.green,
      "description": "Conferences, seminars, networking",
    },
    {
      "id": "sports",
      "title": "Sports & Fitness",
      "icon": Icons.sports_soccer,
      "color": Colors.orange,
      "description": "Sports events, marathons, fitness",
    },
    {
      "id": "arts",
      "title": "Arts & Culture",
      "icon": Icons.palette,
      "color": Colors.pink,
      "description": "Art exhibitions, theater, culture",
    },
    {
      "id": "food",
      "title": "Food & Drinks",
      "icon": Icons.restaurant,
      "color": Colors.red,
      "description": "Food festivals, tastings, cooking",
    },
    {
      "id": "education",
      "title": "Education & Learning",
      "icon": Icons.school,
      "color": Colors.indigo,
      "description": "Workshops, courses, seminars",
    },
    {
      "id": "travel",
      "title": "Travel & Adventure",
      "icon": Icons.travel_explore,
      "color": Colors.teal,
      "description": "Travel events, outdoor activities",
    },
    {
      "id": "health",
      "title": "Health & Wellness",
      "icon": Icons.favorite,
      "color": Colors.pink.shade300,
      "description": "Wellness workshops, health events",
    },
    {
      "id": "social",
      "title": "Social & Community",
      "icon": Icons.people,
      "color": Colors.amber,
      "description": "Community events, social gatherings",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Your Interests"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
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
                  Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 48,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "What interests you?",
                    style: TextStyle(
                      fontSize: fsH2,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Select your interests to get personalized event recommendations",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(220),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Progress Indicator
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lightbulb,
                    color: infoColor,
                    size: 24,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select at least 3 interests",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "${selectedInterests.length} of ${interestCategories.length} selected",
                          style: TextStyle(
                            fontSize: 14,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "${selectedInterests.length}/${interestCategories.length}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: infoColor,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Interest Categories Grid
            Text(
              "Interest Categories",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            ResponsiveGridView(
              padding: EdgeInsets.all(0),
              minItemWidth: 200,
              children: interestCategories.map((interest) => _buildInterestCard(interest)).toList(),
            ),

            SizedBox(height: spXl),

            // Continue Button
            Container(
              width: double.infinity,
              child: QButton(
                label: selectedInterests.length >= 3 
                    ? "Continue (${selectedInterests.length} selected)"
                    : "Select at least 3 interests",
                size: bs.md,
                onPressed: selectedInterests.length >= 3 ? () => _continueToApp() : null,
              ),
            ),

            SizedBox(height: spMd),

            // Skip Button
            Container(
              width: double.infinity,
              child: GestureDetector(
                onTap: () => _skipSelection(),
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    border: Border.all(color: disabledBoldColor),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Text(
                    "Skip for now",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInterestCard(Map<String, dynamic> interest) {
    bool isSelected = selectedInterests.contains(interest["id"]);
    Color categoryColor = interest["color"] as Color;

    return GestureDetector(
      onTap: () => _toggleInterest(interest["id"]),
      child: Container(
        margin: EdgeInsets.only(bottom: spMd),
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: isSelected ? categoryColor.withAlpha(25) : Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(
            color: isSelected ? categoryColor : disabledOutlineBorderColor,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [shadowSm],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: categoryColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    interest["icon"] as IconData,
                    color: categoryColor,
                    size: 24,
                  ),
                ),
                Spacer(),
                if (isSelected)
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: categoryColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
              ],
            ),
            SizedBox(height: spMd),
            Text(
              "${interest["title"]}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? categoryColor : primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "${interest["description"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleInterest(String interestId) {
    if (selectedInterests.contains(interestId)) {
      selectedInterests.remove(interestId);
    } else {
      selectedInterests.add(interestId);
    }
    setState(() {});
  }

  void _continueToApp() {
    ss("Interests saved! Redirecting to dashboard...");
    //navigateTo('EmaHomeView')
  }

  void _skipSelection() {
    si("You can always set your interests later in settings");
    //navigateTo('EmaHomeView')
  }
}
