import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaSkillTrackingView extends StatefulWidget {
  const RhaSkillTrackingView({super.key});

  @override
  State<RhaSkillTrackingView> createState() => _RhaSkillTrackingViewState();
}

class _RhaSkillTrackingViewState extends State<RhaSkillTrackingView> {
  int currentTab = 0;
  String selectedDepartment = "All";
  String selectedSkillLevel = "All";
  String searchQuery = "";
  bool showGapAnalysis = true;

  List<Map<String, dynamic>> skillsData = [
    {
      "employee": "Sarah Johnson",
      "position": "Software Engineer",
      "department": "Engineering",
      "skills": [
        {"name": "JavaScript", "level": 85, "required": 80, "category": "Technical"},
        {"name": "React", "level": 90, "required": 85, "category": "Technical"},
        {"name": "Node.js", "level": 75, "required": 80, "category": "Technical"},
        {"name": "Leadership", "level": 70, "required": 75, "category": "Soft Skills"},
        {"name": "Communication", "level": 85, "required": 80, "category": "Soft Skills"}
      ],
      "overallScore": 81,
      "skillGaps": 2,
      "strengths": ["React", "Communication"],
      "improvements": ["Node.js", "Leadership"]
    },
    {
      "employee": "Michael Chen",
      "position": "Marketing Manager",
      "department": "Marketing",
      "skills": [
        {"name": "Digital Marketing", "level": 92, "required": 85, "category": "Technical"},
        {"name": "Analytics", "level": 88, "required": 80, "category": "Technical"},
        {"name": "SEO/SEM", "level": 85, "required": 85, "category": "Technical"},
        {"name": "Team Management", "level": 90, "required": 85, "category": "Soft Skills"},
        {"name": "Strategic Planning", "level": 80, "required": 85, "category": "Soft Skills"}
      ],
      "overallScore": 87,
      "skillGaps": 1,
      "strengths": ["Digital Marketing", "Team Management"],
      "improvements": ["Strategic Planning"]
    },
    {
      "employee": "Emily Rodriguez",
      "position": "UX Designer",
      "department": "Design",
      "skills": [
        {"name": "UI Design", "level": 95, "required": 90, "category": "Technical"},
        {"name": "User Research", "level": 88, "required": 85, "category": "Technical"},
        {"name": "Prototyping", "level": 92, "required": 85, "category": "Technical"},
        {"name": "Presentation", "level": 75, "required": 80, "category": "Soft Skills"},
        {"name": "Collaboration", "level": 85, "required": 80, "category": "Soft Skills"}
      ],
      "overallScore": 87,
      "skillGaps": 1,
      "strengths": ["UI Design", "Prototyping"],
      "improvements": ["Presentation"]
    },
    {
      "employee": "James Wilson",
      "position": "Sales Representative",
      "department": "Sales",
      "skills": [
        {"name": "Sales Techniques", "level": 88, "required": 85, "category": "Technical"},
        {"name": "CRM Management", "level": 82, "required": 80, "category": "Technical"},
        {"name": "Product Knowledge", "level": 90, "required": 85, "category": "Technical"},
        {"name": "Negotiation", "level": 85, "required": 85, "category": "Soft Skills"},
        {"name": "Customer Service", "level": 92, "required": 85, "category": "Soft Skills"}
      ],
      "overallScore": 87,
      "skillGaps": 0,
      "strengths": ["Product Knowledge", "Customer Service"],
      "improvements": []
    }
  ];

  List<Map<String, dynamic>> skillCategories = [
    {
      "name": "Technical Skills",
      "count": 156,
      "avgLevel": 84,
      "gapCount": 23,
      "color": primaryColor
    },
    {
      "name": "Soft Skills",
      "count": 98,
      "avgLevel": 78,
      "gapCount": 15,
      "color": successColor
    },
    {
      "name": "Leadership",
      "count": 45,
      "avgLevel": 72,
      "gapCount": 12,
      "color": warningColor
    },
    {
      "name": "Industry Specific",
      "count": 67,
      "avgLevel": 81,
      "gapCount": 8,
      "color": infoColor
    }
  ];

  List<Map<String, dynamic>> departmentItems = [
    {"label": "All", "value": "All"},
    {"label": "Engineering", "value": "Engineering"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Design", "value": "Design"},
    {"label": "Sales", "value": "Sales"},
    {"label": "HR", "value": "HR"}
  ];

  List<Map<String, dynamic>> skillLevelItems = [
    {"label": "All", "value": "All"},
    {"label": "Expert (90-100)", "value": "Expert"},
    {"label": "Advanced (80-89)", "value": "Advanced"},
    {"label": "Intermediate (70-79)", "value": "Intermediate"},
    {"label": "Beginner (0-69)", "value": "Beginner"}
  ];

  Color _getSkillColor(int level, int required) {
    if (level >= required + 10) return successColor;
    if (level >= required) return primaryColor;
    if (level >= required - 10) return warningColor;
    return dangerColor;
  }

  String _getSkillLevelText(int level) {
    if (level >= 90) return "Expert";
    if (level >= 80) return "Advanced";
    if (level >= 70) return "Intermediate";
    return "Beginner";
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Summary Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
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
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.psychology,
                            color: primaryColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Skills",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "366",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
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
              Container(
                padding: EdgeInsets.all(spMd),
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
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.trending_up,
                            color: successColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Avg Score",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "81%",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
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
              Container(
                padding: EdgeInsets.all(spMd),
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
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.warning,
                            color: warningColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Skill Gaps",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "58",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
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
              Container(
                padding: EdgeInsets.all(spMd),
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
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.people,
                            color: infoColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Employees",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "42",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
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

          // Skill Categories
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Skill Categories",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...skillCategories.map((category) => Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    border: Border.all(color: disabledOutlineBorderColor),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 40,
                        decoration: BoxDecoration(
                          color: category["color"] as Color,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${category["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${category["avgLevel"]}%",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: category["color"] as Color,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Text(
                                  "${category["count"]} skills",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Text(
                                  "${category["gapCount"]} gaps",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: dangerColor,
                                  ),
                                ),
                              ],
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
        ],
      ),
    );
  }

  Widget _buildSkillsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Filters
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Department",
                  items: departmentItems,
                  value: selectedDepartment,
                  onChanged: (value, label) {
                    selectedDepartment = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Skill Level",
                  items: skillLevelItems,
                  value: selectedSkillLevel,
                  onChanged: (value, label) {
                    selectedSkillLevel = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Search
          QTextField(
            label: "Search employees or skills",
            value: searchQuery,
            hint: "Enter employee name or skill",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),

          // Employee Skills
          ...skillsData.map((employee) => Container(
            padding: EdgeInsets.all(spMd),
            margin: EdgeInsets.only(bottom: spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                // Employee Header
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: primaryColor.withAlpha(20),
                      child: Text(
                        "${employee["employee"]}".split(" ").map((e) => e[0]).join("").toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${employee["employee"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${employee["position"]} • ${employee["department"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${employee["overallScore"]}%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),

                // Skills List
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Skills Assessment",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    ...(employee["skills"] as List).map((skill) => Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getSkillColor(skill["level"] as int, skill["required"] as int).withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: _getSkillColor(skill["level"] as int, skill["required"] as int).withAlpha(30),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${skill["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: disabledColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${skill["category"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${skill["level"]}%",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: _getSkillColor(skill["level"] as int, skill["required"] as int),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: LinearProgressIndicator(
                                  value: (skill["level"] as int) / 100,
                                  backgroundColor: disabledColor,
                                  color: _getSkillColor(skill["level"] as int, skill["required"] as int),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                _getSkillLevelText(skill["level"] as int),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          if ((skill["level"] as int) < (skill["required"] as int))
                            Text(
                              "Gap: ${(skill["required"] as int) - (skill["level"] as int)}% below required",
                              style: TextStyle(
                                fontSize: 12,
                                color: dangerColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                        ],
                      ),
                    )).toList(),
                  ],
                ),

                // Summary
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Strengths",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                          Text(
                            (employee["strengths"] as List).join(", "),
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if ((employee["improvements"] as List).isNotEmpty)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Needs Improvement",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              (employee["improvements"] as List).join(", "),
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

                // Action Button
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "View Development Plan",
                    size: bs.sm,
                    onPressed: () {
                      ss("View development plan for ${employee["employee"]}");
                    },
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Skill Tracking",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.analytics)),
        Tab(text: "Employee Skills", icon: Icon(Icons.psychology)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildSkillsTab(),
      ],
    );
  }
}
