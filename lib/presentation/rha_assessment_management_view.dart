import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaAssessmentManagementView extends StatefulWidget {
  const RhaAssessmentManagementView({super.key});

  @override
  State<RhaAssessmentManagementView> createState() => _RhaAssessmentManagementViewState();
}

class _RhaAssessmentManagementViewState extends State<RhaAssessmentManagementView> {
  String selectedType = "all";
  String selectedStatus = "all";
  String searchQuery = "";
  int currentTab = 0;

  List<Map<String, dynamic>> assessments = [
    {
      "id": "ASS001",
      "title": "Frontend Developer Assessment",
      "description": "Comprehensive evaluation of React, JavaScript, and CSS skills",
      "type": "technical",
      "status": "active",
      "position": "Frontend Developer",
      "duration": 120,
      "questions": 45,
      "candidates": 28,
      "completed": 22,
      "averageScore": 78.5,
      "passRate": 68.2,
      "createdBy": "John Smith",
      "createdDate": "2024-06-01",
      "lastModified": "2024-06-15",
      "tags": ["React", "JavaScript", "CSS", "HTML"],
      "difficulty": "intermediate",
      "image": "https://picsum.photos/300/200?random=1&keyword=coding",
    },
    {
      "id": "ASS002",
      "title": "Data Science Aptitude Test",
      "description": "Assessment covering statistics, machine learning, and Python programming",
      "type": "technical",
      "status": "active",
      "position": "Data Scientist",
      "duration": 180,
      "questions": 60,
      "candidates": 15,
      "completed": 12,
      "averageScore": 82.3,
      "passRate": 75.0,
      "createdBy": "Dr. Maria Santos",
      "createdDate": "2024-05-28",
      "lastModified": "2024-06-12",
      "tags": ["Python", "Statistics", "ML", "Data Analysis"],
      "difficulty": "advanced",
      "image": "https://picsum.photos/300/200?random=2&keyword=data",
    },
    {
      "id": "ASS003",
      "title": "Leadership Competency Assessment",
      "description": "Behavioral assessment focusing on leadership skills and team management",
      "type": "behavioral",
      "status": "active",
      "position": "Team Lead",
      "duration": 90,
      "questions": 35,
      "candidates": 12,
      "completed": 8,
      "averageScore": 74.8,
      "passRate": 62.5,
      "createdBy": "Lisa Garcia",
      "createdDate": "2024-05-25",
      "lastModified": "2024-06-10",
      "tags": ["Leadership", "Management", "Communication"],
      "difficulty": "intermediate",
      "image": "https://picsum.photos/300/200?random=3&keyword=leadership",
    },
    {
      "id": "ASS004",
      "title": "Product Manager Case Study",
      "description": "Real-world case study assessment for product management roles",
      "type": "case-study",
      "status": "draft",
      "position": "Product Manager",
      "duration": 240,
      "questions": 8,
      "candidates": 0,
      "completed": 0,
      "averageScore": 0,
      "passRate": 0,
      "createdBy": "David Park",
      "createdDate": "2024-06-18",
      "lastModified": "2024-06-18",
      "tags": ["Product Strategy", "Analytics", "User Research"],
      "difficulty": "advanced",
      "image": "https://picsum.photos/300/200?random=4&keyword=product",
    },
    {
      "id": "ASS005",
      "title": "Customer Service Skills Test",
      "description": "Assessment of customer service skills and problem-solving abilities",
      "type": "skills",
      "status": "inactive",
      "position": "Customer Support",
      "duration": 60,
      "questions": 25,
      "candidates": 45,
      "completed": 45,
      "averageScore": 85.2,
      "passRate": 88.9,
      "createdBy": "Rachel Kim",
      "createdDate": "2024-04-15",
      "lastModified": "2024-05-30",
      "tags": ["Customer Service", "Communication", "Problem Solving"],
      "difficulty": "beginner",
      "image": "https://picsum.photos/300/200?random=5&keyword=customer",
    },
    {
      "id": "ASS006",
      "title": "Backend Developer Technical Test",
      "description": "Comprehensive evaluation of backend development skills and system design",
      "type": "technical",
      "status": "active",
      "position": "Backend Developer",
      "duration": 150,
      "questions": 40,
      "candidates": 20,
      "completed": 16,
      "averageScore": 76.8,
      "passRate": 70.0,
      "createdBy": "Tom Wilson",
      "createdDate": "2024-06-05",
      "lastModified": "2024-06-14",
      "tags": ["Node.js", "Database", "API", "System Design"],
      "difficulty": "advanced",
      "image": "https://picsum.photos/300/200?random=6&keyword=server",
    },
  ];

  List<Map<String, dynamic>> get filteredAssessments {
    return assessments.where((assessment) {
      bool matchesType = selectedType == "all" || assessment["type"] == selectedType;
      bool matchesStatus = selectedStatus == "all" || assessment["status"] == selectedStatus;
      bool matchesSearch = searchQuery.isEmpty ||
          (assessment["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (assessment["position"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      return matchesType && matchesStatus && matchesSearch;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "draft":
        return warningColor;
      case "inactive":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "active":
        return "Active";
      case "draft":
        return "Draft";
      case "inactive":
        return "Inactive";
      default:
        return "Unknown";
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "technical":
        return primaryColor;
      case "behavioral":
        return infoColor;
      case "case-study":
        return warningColor;
      case "skills":
        return successColor;
      default:
        return disabledColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "technical":
        return Icons.code;
      case "behavioral":
        return Icons.psychology;
      case "case-study":
        return Icons.assignment;
      case "skills":
        return Icons.star;
      default:
        return Icons.help;
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "beginner":
        return successColor;
      case "intermediate":
        return warningColor;
      case "advanced":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildAssessmentCard(Map<String, dynamic> assessment) {
    double completionRate = assessment["candidates"] > 0 ? 
        (assessment["completed"] as int) / (assessment["candidates"] as int) : 0.0;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: disabledOutlineBorderColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Image
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusMd),
                topRight: Radius.circular(radiusMd),
              ),
              image: DecorationImage(
                image: NetworkImage("${assessment["image"]}"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radiusMd),
                      topRight: Radius.circular(radiusMd),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withAlpha(128),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getTypeColor(assessment["type"]).withAlpha(204),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getTypeIcon(assessment["type"]),
                          size: 14,
                          color: Colors.white,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${assessment["type"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: spSm,
                  right: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getStatusColor(assessment["status"]),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      _getStatusLabel(assessment["status"]),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${assessment["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getDifficultyColor(assessment["difficulty"]).withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${assessment["difficulty"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: _getDifficultyColor(assessment["difficulty"]),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "Position: ${assessment["position"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${assessment["description"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spSm),
                
                // Assessment Stats
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: disabledColor.withAlpha(26),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "${assessment["duration"]} min",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Duration",
                                  style: TextStyle(
                                    fontSize: 11,
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
                                  "${assessment["questions"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Questions",
                                  style: TextStyle(
                                    fontSize: 11,
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
                                  "${assessment["candidates"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Candidates",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (assessment["candidates"] > 0) ...[
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "${(assessment["averageScore"] as double).toStringAsFixed(1)}%",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                  Text(
                                    "Avg Score",
                                    style: TextStyle(
                                      fontSize: 11,
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
                                    "${(assessment["passRate"] as double).toStringAsFixed(1)}%",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: infoColor,
                                    ),
                                  ),
                                  Text(
                                    "Pass Rate",
                                    style: TextStyle(
                                      fontSize: 11,
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
                                    "${(completionRate * 100).toInt()}%",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: warningColor,
                                    ),
                                  ),
                                  Text(
                                    "Completed",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(height: spSm),
                
                // Tags
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (assessment["tags"] as List).take(4).map((tag) => 
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(26),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "$tag",
                        style: TextStyle(
                          fontSize: 10,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ).toList(),
                ),
                SizedBox(height: spSm),
                
                // Creator and Date
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "Created by ${assessment["createdBy"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                    Text(
                      "${assessment["createdDate"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.edit,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.analytics,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.more_vert,
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
  }

  Widget _buildStatsCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: disabledOutlineBorderColor,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color.withAlpha(51),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assessment Management"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.analytics),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Overview
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 120,
              children: [
                _buildStatsCard("Total Assessments", "${assessments.length}", primaryColor, Icons.assignment),
                _buildStatsCard("Active", "${assessments.where((a) => a["status"] == "active").length}", successColor, Icons.play_circle),
                _buildStatsCard("Draft", "${assessments.where((a) => a["status"] == "draft").length}", warningColor, Icons.edit),
                _buildStatsCard("Candidates", "${assessments.fold(0, (sum, a) => sum + (a["candidates"] as int))}", infoColor, Icons.people),
              ],
            ),
            SizedBox(height: spLg),
            
            // Search and Filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search assessments",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.filter_list,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: spSm),
            
            // Type Filter
            QCategoryPicker(
              items: [
                {"label": "All Types", "value": "all"},
                {"label": "Technical", "value": "technical"},
                {"label": "Behavioral", "value": "behavioral"},
                {"label": "Case Study", "value": "case-study"},
                {"label": "Skills", "value": "skills"},
              ],
              value: selectedType,
              onChanged: (index, label, value, item) {
                selectedType = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            
            // Status Filter
            QCategoryPicker(
              items: [
                {"label": "All Status", "value": "all"},
                {"label": "Active", "value": "active"},
                {"label": "Draft", "value": "draft"},
                {"label": "Inactive", "value": "inactive"},
              ],
              value: selectedStatus,
              onChanged: (index, label, value, item) {
                selectedStatus = value;
                setState(() {});
              },
            ),
            SizedBox(height: spLg),
            
            // Assessments List
            Text(
              "Assessments (${filteredAssessments.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 300,
              children: filteredAssessments.map((assessment) => _buildAssessmentCard(assessment)).toList(),
            ),
            
            if (filteredAssessments.isEmpty) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.assignment,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No assessments found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search or filter criteria",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
