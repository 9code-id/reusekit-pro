import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTutorial9View extends StatefulWidget {
  @override
  State<GrlTutorial9View> createState() => _GrlTutorial9ViewState();
}

class _GrlTutorial9ViewState extends State<GrlTutorial9View> {
  int currentTip = 0;
  bool showAllTips = false;
  
  List<Map<String, dynamic>> tips = [
    {
      "title": "Keyboard Shortcuts",
      "description": "Use Ctrl+S to save, Ctrl+Z to undo, and Ctrl+F to search quickly.",
      "icon": Icons.keyboard,
      "category": "Productivity",
      "color": Color(0xFF3B82F6),
      "difficulty": "Beginner",
    },
    {
      "title": "Dark Mode",
      "description": "Switch to dark mode in settings to reduce eye strain during long sessions.",
      "icon": Icons.dark_mode,
      "category": "Settings",
      "color": Color(0xFF6366F1),
      "difficulty": "Beginner",
    },
    {
      "title": "Backup Data",
      "description": "Enable auto-backup to keep your important data safe in the cloud.",
      "icon": Icons.backup,
      "category": "Security",
      "color": Color(0xFF10B981),
      "difficulty": "Intermediate",
    },
    {
      "title": "Custom Themes",
      "description": "Create and apply custom themes to personalize your workspace.",
      "icon": Icons.palette,
      "category": "Customization",
      "color": Color(0xFFF59E0B),
      "difficulty": "Advanced",
    },
    {
      "title": "Batch Operations",
      "description": "Select multiple items and perform actions on all of them at once.",
      "icon": Icons.select_all,
      "category": "Productivity",
      "color": Color(0xFF8B5CF6),
      "difficulty": "Intermediate",
    },
    {
      "title": "Export Settings",
      "description": "Export your settings and preferences to transfer to other devices.",
      "icon": Icons.download,
      "category": "Settings",
      "color": Color(0xFFEF4444),
      "difficulty": "Advanced",
    },
    {
      "title": "Voice Commands",
      "description": "Use voice commands to navigate and control the app hands-free.",
      "icon": Icons.mic,
      "category": "Accessibility",
      "color": Color(0xFF06B6D4),
      "difficulty": "Advanced",
    },
    {
      "title": "Quick Actions",
      "description": "Access frequently used features through the quick action menu.",
      "icon": Icons.flash_on,
      "category": "Productivity",
      "color": Color(0xFFF97316),
      "difficulty": "Beginner",
    },
  ];

  List<String> categories = ["All", "Productivity", "Settings", "Security", "Customization", "Accessibility"];
  String selectedCategory = "All";

  List<Map<String, dynamic>> get filteredTips {
    if (selectedCategory == "All") return tips;
    return tips.where((tip) => tip["category"] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tips & Tricks"),
        actions: [
          QButton(
            icon: showAllTips ? Icons.view_carousel : Icons.view_list,
            size: bs.sm,
            onPressed: () {
              showAllTips = !showAllTips;
              setState(() {});
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: Column(
        children: [
          // Category filter
          Container(
            height: 50,
            child: QHorizontalScroll(
              children: categories.map((category) {
                final isSelected = selectedCategory == category;
                return GestureDetector(
                  onTap: () {
                    selectedCategory = category;
                    currentTip = 0;
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: spXs),
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spXs),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                      boxShadow: [shadowSm],
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          color: isSelected ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          
          // Tips content
          Expanded(
            child: showAllTips ? _buildAllTipsView() : _buildCarouselView(),
          ),
        ],
      ),
    );
  }

  Widget _buildCarouselView() {
    if (filteredTips.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No tips available for this category",
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      );
    }

    final tip = filteredTips[currentTip];
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Tip counter
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: (tip["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Text(
              "${currentTip + 1} of ${filteredTips.length}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: tip["color"] as Color,
              ),
            ),
          ),
          
          SizedBox(height: spLg),
          
          // Tip card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              children: [
                // Icon and difficulty
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: (tip["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        tip["icon"] as IconData,
                        size: 32,
                        color: tip["color"] as Color,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getDifficultyColor(tip["difficulty"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${tip["difficulty"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _getDifficultyColor(tip["difficulty"]),
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spLg),
                
                // Title
                Text(
                  "${tip["title"]}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                SizedBox(height: spSm),
                
                // Category
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${tip["category"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                ),
                
                SizedBox(height: spLg),
                
                // Description
                Text(
                  "${tip["description"]}",
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                SizedBox(height: spXl),
                
                // Try it button
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Try This Tip",
                    size: bs.md,
                    onPressed: () {
                      ss("Applying tip: ${tip["title"]}");
                    },
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spLg),
          
          // Navigation buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Previous",
                  size: bs.md,
                  color: currentTip > 0 ? primaryColor : disabledColor,
                  onPressed: currentTip > 0 ? () {
                    currentTip--;
                    setState(() {});
                  } : null,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Next",
                  size: bs.md,
                  color: currentTip < filteredTips.length - 1 ? primaryColor : disabledColor,
                  onPressed: currentTip < filteredTips.length - 1 ? () {
                    currentTip++;
                    setState(() {});
                  } : null,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Dots indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(filteredTips.length, (index) {
              return Container(
                width: 8,
                height: 8,
                margin: EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: index == currentTip ? primaryColor : disabledColor,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildAllTipsView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "All Tips",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          ...filteredTips.map((tip) {
            return Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (tip["color"] as Color).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      tip["icon"] as IconData,
                      size: 24,
                      color: tip["color"] as Color,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${tip["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getDifficultyColor(tip["difficulty"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${tip["difficulty"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: _getDifficultyColor(tip["difficulty"]),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${tip["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${tip["category"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: tip["color"] as Color,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: spSm),
                  GestureDetector(
                    onTap: () {
                      ss("Trying tip: ${tip["title"]}");
                    },
                    child: Icon(
                      Icons.play_circle,
                      size: 28,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
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
        return disabledBoldColor;
    }
  }
}
