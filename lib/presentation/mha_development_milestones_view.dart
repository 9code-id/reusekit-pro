import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaDevelopmentMilestonesView extends StatefulWidget {
  const MhaDevelopmentMilestonesView({super.key});

  @override
  State<MhaDevelopmentMilestonesView> createState() => _MhaDevelopmentMilestonesViewState();
}

class _MhaDevelopmentMilestonesViewState extends State<MhaDevelopmentMilestonesView> {
  int selectedTabIndex = 0;
  String childName = "Emma";
  DateTime childBirthDate = DateTime(2020, 3, 15);
  String selectedAgeGroup = "3-4 years";

  // Calculate child's age
  int get childAgeInMonths {
    final now = DateTime.now();
    final difference = now.difference(childBirthDate);
    return (difference.inDays / 30.44).round();
  }

  String get childAgeText {
    final years = childAgeInMonths ~/ 12;
    final months = childAgeInMonths % 12;
    if (years == 0) {
      return "$months months";
    } else if (months == 0) {
      return "$years years";
    } else {
      return "$years years $months months";
    }
  }

  List<Map<String, dynamic>> milestoneCategories = [
    {
      "title": "Physical Development",
      "icon": Icons.directions_run,
      "color": "primary",
      "completedCount": 8,
      "totalCount": 12,
    },
    {
      "title": "Cognitive Development",
      "icon": Icons.psychology,
      "color": "secondary",
      "completedCount": 6,
      "totalCount": 10,
    },
    {
      "title": "Language & Communication",
      "icon": Icons.record_voice_over,
      "color": "info",
      "completedCount": 9,
      "totalCount": 11,
    },
    {
      "title": "Social & Emotional",
      "icon": Icons.favorite,
      "color": "warning",
      "completedCount": 7,
      "totalCount": 9,
    },
  ];

  List<Map<String, dynamic>> currentMilestones = [
    {
      "category": "Physical Development",
      "title": "Hops and stands on one foot up to 2 seconds",
      "description": "Balance and coordination skills are developing",
      "isCompleted": true,
      "completedDate": "2024-01-15",
      "expectedAge": "3-4 years",
      "tips": "Encourage hopping games and balance beam activities",
      "concernLevel": "normal"
    },
    {
      "category": "Physical Development",
      "title": "Climbs well",
      "description": "Can climb playground equipment confidently",
      "isCompleted": true,
      "completedDate": "2024-02-10",
      "expectedAge": "3-4 years",
      "tips": "Provide safe climbing opportunities like jungle gyms",
      "concernLevel": "normal"
    },
    {
      "category": "Physical Development",
      "title": "Kicks ball forward",
      "description": "Shows improved coordination and balance",
      "isCompleted": false,
      "completedDate": null,
      "expectedAge": "3-4 years",
      "tips": "Practice kicking with larger, softer balls first",
      "concernLevel": "normal"
    },
    {
      "category": "Cognitive Development",
      "title": "Correctly names some colors and numbers",
      "description": "Beginning to understand basic concepts",
      "isCompleted": true,
      "completedDate": "2024-01-20",
      "expectedAge": "3-4 years",
      "tips": "Use color and number games during daily activities",
      "concernLevel": "normal"
    },
    {
      "category": "Cognitive Development",
      "title": "Understands the idea of counting",
      "description": "Can count to 3 or 4 objects",
      "isCompleted": false,
      "completedDate": null,
      "expectedAge": "3-4 years",
      "tips": "Count everyday objects like toys or snacks",
      "concernLevel": "watch"
    },
    {
      "category": "Language & Communication",
      "title": "Says first and last name",
      "description": "Personal identity development",
      "isCompleted": true,
      "completedDate": "2024-01-05",
      "expectedAge": "3-4 years",
      "tips": "Practice during daily routines and play",
      "concernLevel": "normal"
    },
    {
      "category": "Language & Communication",
      "title": "Asks 'who,' 'what,' 'where,' or 'why' questions",
      "description": "Curiosity and language skills expanding",
      "isCompleted": true,
      "completedDate": "2024-02-01",
      "expectedAge": "3-4 years",
      "tips": "Answer questions patiently and ask some back",
      "concernLevel": "normal"
    },
    {
      "category": "Social & Emotional",
      "title": "Copies adults and friends",
      "description": "Learning through imitation",
      "isCompleted": true,
      "completedDate": "2024-01-10",
      "expectedAge": "3-4 years",
      "tips": "Model positive behaviors you want to see",
      "concernLevel": "normal"
    },
    {
      "category": "Social & Emotional",
      "title": "Shows affection for friends without prompting",
      "description": "Developing empathy and friendship skills",
      "isCompleted": false,
      "completedDate": null,
      "expectedAge": "3-4 years",
      "tips": "Encourage kind gestures and sharing",
      "concernLevel": "normal"
    }
  ];

  List<Map<String, dynamic>> upcomingMilestones = [
    {
      "category": "Physical Development",
      "title": "Catches a bounced ball most of the time",
      "expectedAge": "4-5 years",
      "description": "Hand-eye coordination improvement",
      "tips": "Start with larger, softer balls and short distances"
    },
    {
      "category": "Cognitive Development",
      "title": "Understands the idea of 'same' and 'different'",
      "expectedAge": "4-5 years",
      "description": "Comparison and categorization skills",
      "tips": "Play sorting and matching games"
    },
    {
      "category": "Language & Communication",
      "title": "Tells stories",
      "expectedAge": "4-5 years",
      "description": "Narrative skills and imagination",
      "tips": "Read together and encourage storytelling"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Development Milestones"),
        actions: [
          IconButton(
            icon: Icon(Icons.child_care),
            onPressed: _showChildInfo,
          ),
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: _showMilestoneInfo,
          ),
        ],
      ),
      body: Column(
        children: [
          // Child Info Header
          Container(
            margin: EdgeInsets.all(spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor.withAlpha(20), secondaryColor.withAlpha(20)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    Icons.child_care,
                    color: primaryColor,
                    size: 32,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        childName,
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Age: $childAgeText",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Born: ${childBirthDate.dMMMy}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
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
                        "On Track",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "30/42 milestones",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Progress Overview
          Container(
            margin: EdgeInsets.symmetric(horizontal: spMd),
            child: ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: milestoneCategories.map((category) {
                final completedCount = category["completedCount"] as int;
                final totalCount = category["totalCount"] as int;
                final progress = completedCount / totalCount;
                final color = _getCategoryColor(category["color"] as String);

                return Container(
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
                          Icon(
                            category["icon"] as IconData,
                            color: color,
                            size: 24,
                          ),
                          Spacer(),
                          Text(
                            "$completedCount/$totalCount",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: color,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${category["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      LinearProgressIndicator(
                        value: progress,
                        backgroundColor: color.withAlpha(20),
                        valueColor: AlwaysStoppedAnimation<Color>(color),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${(progress * 100).toInt()}% Complete",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          SizedBox(height: spMd),

          // Tab Selection
          Container(
            margin: EdgeInsets.symmetric(horizontal: spMd),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTabIndex = 0;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTabIndex == 0 
                            ? primaryColor 
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "Current Milestones",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: selectedTabIndex == 0 
                              ? Colors.white 
                              : primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTabIndex = 1;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTabIndex == 1 
                            ? primaryColor 
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "Upcoming",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: selectedTabIndex == 1 
                              ? Colors.white 
                              : primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Content based on selected tab
          Expanded(
            child: selectedTabIndex == 0 
                ? _buildCurrentMilestones()
                : _buildUpcomingMilestones(),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentMilestones() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      itemCount: currentMilestones.length,
      itemBuilder: (context, index) {
        final milestone = currentMilestones[index];
        final isCompleted = milestone["isCompleted"] as bool;
        final concernLevel = milestone["concernLevel"] as String;
        
        Color statusColor = successColor;
        if (concernLevel == "watch") statusColor = warningColor;
        if (concernLevel == "concern") statusColor = dangerColor;

        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
            border: Border.all(
              color: isCompleted 
                  ? successColor.withAlpha(30)
                  : statusColor.withAlpha(30),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: isCompleted 
                          ? successColor 
                          : statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      isCompleted ? Icons.check : Icons.schedule,
                      size: 16,
                      color: isCompleted ? Colors.white : statusColor,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${milestone["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${milestone["category"]} • ${milestone["expectedAge"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isCompleted)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spXs,
                        vertical: spXs / 2,
                      ),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "Completed",
                        style: TextStyle(
                          fontSize: 10,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
              
              SizedBox(height: spSm),
              
              Text(
                "${milestone["description"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
              
              if (milestone["completedDate"] != null) ...[
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.event_available,
                        size: 16,
                        color: successColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Completed on ${DateTime.parse(milestone["completedDate"] as String).dMMMy}",
                        style: TextStyle(
                          fontSize: 11,
                          color: successColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              
              SizedBox(height: spSm),
              
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      size: 16,
                      color: infoColor,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${milestone["tips"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: infoColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              if (!isCompleted)
                Column(
                  children: [
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Mark Complete",
                            size: bs.sm,
                            onPressed: () {
                              _markMilestoneComplete(index);
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Need Help",
                            size: bs.sm,
                            onPressed: () {
                              _showMilestoneHelp(milestone);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUpcomingMilestones() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      itemCount: upcomingMilestones.length,
      itemBuilder: (context, index) {
        final milestone = upcomingMilestones[index];
        
        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
            border: Border.all(
              color: infoColor.withAlpha(30),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.schedule,
                      size: 16,
                      color: infoColor,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${milestone["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${milestone["category"]} • Expected: ${milestone["expectedAge"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spXs,
                      vertical: spXs / 2,
                    ),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "Upcoming",
                      style: TextStyle(
                        fontSize: 10,
                        color: infoColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: spSm),
              
              Text(
                "${milestone["description"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
              
              SizedBox(height: spSm),
              
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.tips_and_updates,
                      size: 16,
                      color: warningColor,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "Preparation tip: ${milestone["tips"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: warningColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getCategoryColor(String colorName) {
    switch (colorName) {
      case "primary":
        return primaryColor;
      case "secondary":
        return secondaryColor;
      case "info":
        return infoColor;
      case "warning":
        return warningColor;
      case "success":
        return successColor;
      case "danger":
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  void _markMilestoneComplete(int index) {
    currentMilestones[index]["isCompleted"] = true;
    currentMilestones[index]["completedDate"] = DateTime.now().toIso8601String();
    setState(() {});
    ss("Milestone marked as complete!");
  }

  void _showMilestoneHelp(Map<String, dynamic> milestone) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Milestone Support",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "${milestone["title"]}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Activities to help your child reach this milestone:",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "${milestone["tips"]}",
              style: TextStyle(
                fontSize: 13,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Contact Pediatrician",
                    size: bs.sm,
                    onPressed: () {
                      Navigator.pop(context);
                      // Navigate to contact doctor
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Learn More",
                    size: bs.sm,
                    onPressed: () {
                      Navigator.pop(context);
                      // Navigate to educational resources
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showChildInfo() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Child Information",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Icon(Icons.child_care, color: primaryColor),
                SizedBox(width: spSm),
                Text("Name: $childName", style: TextStyle(fontSize: 14)),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(Icons.cake, color: primaryColor),
                SizedBox(width: spSm),
                Text("Birth Date: ${childBirthDate.dMMMy}", style: TextStyle(fontSize: 14)),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(Icons.schedule, color: primaryColor),
                SizedBox(width: spSm),
                Text("Current Age: $childAgeText", style: TextStyle(fontSize: 14)),
              ],
            ),
            SizedBox(height: spMd),
            QButton(
              label: "Edit Child Information",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
                // Navigate to edit child info
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showMilestoneInfo() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "About Developmental Milestones",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "Developmental milestones are behaviors or physical skills seen in infants and children as they grow and develop. Rolling over, crawling, walking, and talking are all examples of developmental milestones.",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Remember:",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "• Every child develops at their own pace\n• These are general guidelines\n• Contact your pediatrician if you have concerns",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
