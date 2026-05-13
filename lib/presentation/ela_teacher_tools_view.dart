import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaTeacherToolsView extends StatefulWidget {
  const ElaTeacherToolsView({super.key});

  @override
  State<ElaTeacherToolsView> createState() => _ElaTeacherToolsViewState();
}

class _ElaTeacherToolsViewState extends State<ElaTeacherToolsView> {
  String selectedCategory = "All Tools";

  List<Map<String, dynamic>> categories = [
    {"label": "All Tools", "value": "All Tools"},
    {"label": "Assessment", "value": "Assessment"},
    {"label": "Lesson Planning", "value": "Lesson Planning"},
    {"label": "Student Management", "value": "Student Management"},
    {"label": "Reports", "value": "Reports"},
    {"label": "Resources", "value": "Resources"},
  ];

  List<Map<String, dynamic>> tools = [
    {
      "id": 1,
      "title": "Reading Assessment Builder",
      "category": "Assessment",
      "description": "Create custom reading assessments with auto-grading",
      "icon": Icons.quiz,
      "color": successColor,
      "features": ["Auto-grading", "Rubric builder", "Progress tracking"],
      "usage_count": 24,
      "last_used": "2025-06-14",
      "rating": 4.8,
      "type": "Assessment Tool",
    },
    {
      "id": 2,
      "title": "Lesson Plan Generator",
      "category": "Lesson Planning",
      "description": "AI-powered lesson plan creation for ELA standards",
      "icon": Icons.assignment,
      "color": infoColor,
      "features": ["Standards alignment", "Differentiation", "Resource links"],
      "usage_count": 45,
      "last_used": "2025-06-13",
      "rating": 4.9,
      "type": "Planning Tool",
    },
    {
      "id": 3,
      "title": "Student Progress Tracker",
      "category": "Student Management",
      "description": "Monitor individual and class progress across ELA skills",
      "icon": Icons.trending_up,
      "color": warningColor,
      "features": ["Real-time updates", "Parent reports", "Goal setting"],
      "usage_count": 67,
      "last_used": "2025-06-14",
      "rating": 4.7,
      "type": "Management Tool",
    },
    {
      "id": 4,
      "title": "Comprehension Question Bank",
      "category": "Assessment",
      "description": "Thousands of ready-made reading comprehension questions",
      "icon": Icons.help_outline,
      "color": primaryColor,
      "features": ["Grade level filters", "Skill categories", "Bloom's taxonomy"],
      "usage_count": 89,
      "last_used": "2025-06-12",
      "rating": 4.6,
      "type": "Resource Bank",
    },
    {
      "id": 5,
      "title": "Writing Rubric Creator",
      "category": "Assessment",
      "description": "Build custom writing rubrics for any assignment",
      "icon": Icons.rule,
      "color": dangerColor,
      "features": ["Template library", "Custom criteria", "Student sharing"],
      "usage_count": 32,
      "last_used": "2025-06-11",
      "rating": 4.5,
      "type": "Assessment Tool",
    },
    {
      "id": 6,
      "title": "Class Performance Report",
      "category": "Reports",
      "description": "Generate detailed class and individual performance reports",
      "icon": Icons.bar_chart,
      "color": successColor,
      "features": ["Export options", "Visual charts", "Trend analysis"],
      "usage_count": 18,
      "last_used": "2025-06-10",
      "rating": 4.8,
      "type": "Reporting Tool",
    },
    {
      "id": 7,
      "title": "Vocabulary Builder",
      "category": "Resources",
      "description": "Interactive vocabulary activities and word lists",
      "icon": Icons.translate,
      "color": infoColor,
      "features": ["Word games", "Context practice", "Progress tracking"],
      "usage_count": 156,
      "last_used": "2025-06-14",
      "rating": 4.9,
      "type": "Interactive Resource",
    },
    {
      "id": 8,
      "title": "Differentiation Assistant",
      "category": "Lesson Planning",
      "description": "Adapt lessons for different learning levels and styles",
      "icon": Icons.tune,
      "color": warningColor,
      "features": ["Level adaptation", "Learning styles", "IEP support"],
      "usage_count": 38,
      "last_used": "2025-06-13",
      "rating": 4.7,
      "type": "Planning Tool",
    },
  ];

  List<Map<String, dynamic>> recentActivity = [
    {
      "tool": "Lesson Plan Generator",
      "action": "Created lesson plan for 'Character Analysis'",
      "timestamp": "2025-06-14 14:30",
      "class": "Grade 3A",
    },
    {
      "tool": "Reading Assessment Builder",
      "action": "Built comprehension quiz for 'The Magic Tree'",
      "timestamp": "2025-06-14 10:15",
      "class": "Grade 3B",
    },
    {
      "tool": "Student Progress Tracker",
      "action": "Updated progress for 5 students",
      "timestamp": "2025-06-13 16:45",
      "class": "Grade 3A",
    },
    {
      "tool": "Vocabulary Builder",
      "action": "Assigned word list: 'Weather Terms'",
      "timestamp": "2025-06-13 09:20",
      "class": "Grade 3C",
    },
  ];

  List<Map<String, dynamic>> quickActions = [
    {
      "title": "Create Assessment",
      "description": "Build a new reading or writing assessment",
      "icon": Icons.add_task,
      "color": successColor,
    },
    {
      "title": "Plan Lesson",
      "description": "Generate AI-powered lesson plans",
      "icon": Icons.create,
      "color": infoColor,
    },
    {
      "title": "View Progress",
      "description": "Check student and class progress",
      "icon": Icons.analytics,
      "color": warningColor,
    },
    {
      "title": "Generate Report",
      "description": "Create performance reports",
      "icon": Icons.description,
      "color": primaryColor,
    },
  ];

  List<Map<String, dynamic>> get filteredTools {
    if (selectedCategory == "All Tools") {
      return tools;
    }
    return tools.where((tool) => 
        (tool["category"] as String) == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teacher Tools"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              //navigateTo('favorite_tools')
            },
          ),
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              //navigateTo('tool_help')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Welcome Header
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.school,
                    color: Colors.white,
                    size: 32,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ELA Teacher Toolkit",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Powerful tools to enhance your ELA instruction",
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

            // Quick Actions
            Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Row(
              children: quickActions.map((action) {
                int index = quickActions.indexOf(action);
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      right: index < quickActions.length - 1 ? spSm : 0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        //navigateToQuickAction(action)
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: (action["color"] as Color).withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                action["icon"] as IconData,
                                color: action["color"] as Color,
                                size: 24,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${action["title"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${action["description"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            // Category Filter
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: QDropdownField(
                label: "Tool Category",
                items: categories,
                value: selectedCategory,
                onChanged: (value, label) {
                  selectedCategory = value;
                  setState(() {});
                },
              ),
            ),

            // Tools Grid
            Text(
              "Available Tools",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.all(0),
              minItemWidth: 200,
              children: filteredTools.map((tool) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (tool["color"] as Color).withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              tool["icon"] as IconData,
                              color: tool["color"] as Color,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${tool["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${tool["type"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Text(
                        "${tool["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),

                      // Features
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (tool["features"] as List).map((feature) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: (tool["color"] as Color).withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "$feature",
                              style: TextStyle(
                                fontSize: 10,
                                color: tool["color"] as Color,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      // Stats
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${tool["usage_count"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Uses",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 12,
                                      color: warningColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${tool["rating"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Rating",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Text(
                        "Last used: ${tool["last_used"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),

                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Open Tool",
                          size: bs.sm,
                          onPressed: () {
                            //navigateToTool(tool)
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Recent Activity
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recent Activity",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      QButton(
                        label: "View All",
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('activity_history')
                        },
                      ),
                    ],
                  ),
                  ...recentActivity.map((activity) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border(
                          left: BorderSide(
                            width: 3,
                            color: infoColor,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${activity["tool"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                "${activity["class"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${activity["action"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${activity["timestamp"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Usage Statistics
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "This Week's Usage",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "47",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Tools Used",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "23h",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "Time Saved",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "156",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Items Created",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
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
}
