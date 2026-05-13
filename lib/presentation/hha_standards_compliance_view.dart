import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaStandardsComplianceView extends StatefulWidget {
  const HhaStandardsComplianceView({super.key});

  @override
  State<HhaStandardsComplianceView> createState() => _HhaStandardsComplianceViewState();
}

class _HhaStandardsComplianceViewState extends State<HhaStandardsComplianceView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedStatus = "All";
  String selectedPriority = "All";

  List<Map<String, dynamic>> standards = [
    {
      "id": "STD001",
      "title": "Fire Safety Compliance",
      "description": "Fire alarm systems, sprinklers, and emergency exits inspection",
      "category": "Safety",
      "priority": "Critical",
      "status": "Compliant",
      "lastInspection": "2024-01-15",
      "nextInspection": "2024-07-15",
      "inspector": "Fire Marshal Johnson",
      "score": 98,
      "violations": 0,
      "requirements": [
        "Emergency exit signs functional",
        "Fire alarm system tested monthly",
        "Sprinkler system operational",
        "Fire extinguishers accessible"
      ],
      "correctedIssues": 2,
      "department": "Safety & Security",
      "certificateValid": true,
      "image": "https://picsum.photos/400/250?random=1&keyword=fire-safety"
    },
    {
      "id": "STD002",
      "title": "Food Safety Standards",
      "description": "Kitchen hygiene, food storage, and preparation compliance",
      "category": "Health",
      "priority": "High",
      "status": "Compliant",
      "lastInspection": "2024-02-20",
      "nextInspection": "2024-05-20",
      "inspector": "Health Inspector Martinez",
      "score": 92,
      "violations": 1,
      "requirements": [
        "Temperature monitoring systems",
        "Staff hygiene protocols",
        "Food storage procedures",
        "Cleaning and sanitization"
      ],
      "correctedIssues": 1,
      "department": "Food & Beverage",
      "certificateValid": true,
      "image": "https://picsum.photos/400/250?random=2&keyword=kitchen"
    },
    {
      "id": "STD003",
      "title": "ADA Accessibility",
      "description": "Americans with Disabilities Act compliance check",
      "category": "Accessibility",
      "priority": "High",
      "status": "Non-Compliant",
      "lastInspection": "2024-03-10",
      "nextInspection": "2024-04-10",
      "inspector": "ADA Inspector Wilson",
      "score": 78,
      "violations": 3,
      "requirements": [
        "Wheelchair accessible entrances",
        "Accessible restroom facilities",
        "Elevator compliance",
        "Room accessibility features"
      ],
      "correctedIssues": 0,
      "department": "Facilities",
      "certificateValid": false,
      "image": "https://picsum.photos/400/250?random=3&keyword=accessibility"
    },
    {
      "id": "STD004",
      "title": "Environmental Standards",
      "description": "Waste management and environmental impact compliance",
      "category": "Environmental",
      "priority": "Medium",
      "status": "Compliant",
      "lastInspection": "2024-01-25",
      "nextInspection": "2024-07-25",
      "inspector": "Environmental Officer Chen",
      "score": 89,
      "violations": 2,
      "requirements": [
        "Waste segregation protocols",
        "Water conservation measures",
        "Energy efficiency standards",
        "Chemical storage safety"
      ],
      "correctedIssues": 2,
      "department": "Sustainability",
      "certificateValid": true,
      "image": "https://picsum.photos/400/250?random=4&keyword=environment"
    },
    {
      "id": "STD005",
      "title": "Building Code Compliance",
      "description": "Structural integrity and building code adherence",
      "category": "Building",
      "priority": "Critical",
      "status": "Under Review",
      "lastInspection": "2024-03-05",
      "nextInspection": "2024-04-05",
      "inspector": "Building Inspector Rodriguez",
      "score": 85,
      "violations": 4,
      "requirements": [
        "Structural safety assessment",
        "Electrical code compliance",
        "Plumbing standards",
        "HVAC system requirements"
      ],
      "correctedIssues": 1,
      "department": "Engineering",
      "certificateValid": false,
      "image": "https://picsum.photos/400/250?random=5&keyword=building"
    },
    {
      "id": "STD006",
      "title": "Security Standards",
      "description": "Guest safety and property security measures",
      "category": "Security",
      "priority": "High",
      "status": "Compliant",
      "lastInspection": "2024-02-12",
      "nextInspection": "2024-08-12",
      "inspector": "Security Auditor Thompson",
      "score": 94,
      "violations": 1,
      "requirements": [
        "CCTV system coverage",
        "Access control systems",
        "Guest room security",
        "Emergency response procedures"
      ],
      "correctedIssues": 1,
      "department": "Security",
      "certificateValid": true,
      "image": "https://picsum.photos/400/250?random=6&keyword=security"
    },
    {
      "id": "STD007",
      "title": "Labor Standards",
      "description": "Employee rights, working conditions, and labor law compliance",
      "category": "Labor",
      "priority": "Medium",
      "status": "Compliant",
      "lastInspection": "2024-01-30",
      "nextInspection": "2024-07-30",
      "inspector": "Labor Inspector Davis",
      "score": 91,
      "violations": 2,
      "requirements": [
        "Working hours compliance",
        "Workplace safety measures",
        "Employee benefit standards",
        "Anti-discrimination policies"
      ],
      "correctedIssues": 2,
      "department": "Human Resources",
      "certificateValid": true,
      "image": "https://picsum.photos/400/250?random=7&keyword=workplace"
    },
    {
      "id": "STD008",
      "title": "Guest Privacy Protection",
      "description": "Data protection and guest privacy compliance",
      "category": "Privacy",
      "priority": "High",
      "status": "Partial Compliance",
      "lastInspection": "2024-02-28",
      "nextInspection": "2024-05-28",
      "inspector": "Privacy Officer Lee",
      "score": 82,
      "violations": 3,
      "requirements": [
        "Data encryption standards",
        "Guest information protection",
        "GDPR compliance measures",
        "Staff privacy training"
      ],
      "correctedIssues": 1,
      "department": "IT & Legal",
      "certificateValid": false,
      "image": "https://picsum.photos/400/250?random=8&keyword=privacy"
    }
  ];

  List<Map<String, dynamic>> get filteredStandards {
    return standards.where((standard) {
      final matchesSearch = standard["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          standard["description"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          standard["inspector"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      final matchesCategory = selectedCategory == "All" || standard["category"] == selectedCategory;
      final matchesStatus = selectedStatus == "All" || standard["status"] == selectedStatus;
      final matchesPriority = selectedPriority == "All" || standard["priority"] == selectedPriority;
      
      return matchesSearch && matchesCategory && matchesStatus && matchesPriority;
    }).toList();
  }

  List<Map<String, dynamic>> get dashboardStats {
    final compliantStandards = standards.where((s) => s["status"] == "Compliant").length;
    final nonCompliantStandards = standards.where((s) => s["status"] == "Non-Compliant").length;
    final avgScore = standards.isEmpty ? 0.0 : standards.fold(0, (sum, s) => sum + (s["score"] as int)) / standards.length;
    final totalViolations = standards.fold(0, (sum, s) => sum + (s["violations"] as int));

    return [
      {
        "title": "Compliant Standards",
        "value": compliantStandards,
        "icon": Icons.verified,
        "color": successColor,
        "trend": "+2"
      },
      {
        "title": "Non-Compliant",
        "value": nonCompliantStandards,
        "icon": Icons.warning,
        "color": dangerColor,
        "trend": "-1"
      },
      {
        "title": "Average Score",
        "value": "${avgScore.toStringAsFixed(0)}%",
        "icon": Icons.score,
        "color": primaryColor,
        "trend": "+3%"
      },
      {
        "title": "Total Violations",
        "value": totalViolations,
        "icon": Icons.error_outline,
        "color": warningColor,
        "trend": "-2"
      }
    ];
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Compliant":
        return successColor;
      case "Non-Compliant":
        return dangerColor;
      case "Partial Compliance":
        return warningColor;
      case "Under Review":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  Color _getScoreColor(int score) {
    if (score >= 90) return successColor;
    if (score >= 80) return warningColor;
    return dangerColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Standards Compliance"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_chart),
            onPressed: () {
              // navigateTo(HhaComplianceReportView());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Dashboard Stats
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: dashboardStats.map((stat) {
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
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (stat["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              stat["icon"] as IconData,
                              color: stat["color"] as Color,
                              size: 24,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: (stat["trend"].toString().startsWith('+') || stat["trend"].toString().startsWith('-')) ?
                                  (stat["trend"].toString().startsWith('+') ? successColor : dangerColor).withAlpha(20) :
                                  disabledColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${stat["trend"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: (stat["trend"].toString().startsWith('+') || stat["trend"].toString().startsWith('-')) ?
                                    (stat["trend"].toString().startsWith('+') ? successColor : dangerColor) :
                                    disabledColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${stat["value"]}",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${stat["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Search and Filters
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  QTextField(
                    label: "Search standards...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: [
                            {"label": "All", "value": "All"},
                            {"label": "Safety", "value": "Safety"},
                            {"label": "Health", "value": "Health"},
                            {"label": "Accessibility", "value": "Accessibility"},
                            {"label": "Environmental", "value": "Environmental"},
                            {"label": "Building", "value": "Building"},
                            {"label": "Security", "value": "Security"},
                            {"label": "Labor", "value": "Labor"},
                            {"label": "Privacy", "value": "Privacy"},
                          ],
                          value: selectedCategory,
                          onChanged: (value, label) {
                            selectedCategory = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: [
                            {"label": "All", "value": "All"},
                            {"label": "Compliant", "value": "Compliant"},
                            {"label": "Non-Compliant", "value": "Non-Compliant"},
                            {"label": "Partial Compliance", "value": "Partial Compliance"},
                            {"label": "Under Review", "value": "Under Review"},
                          ],
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Priority",
                          items: [
                            {"label": "All", "value": "All"},
                            {"label": "Critical", "value": "Critical"},
                            {"label": "High", "value": "High"},
                            {"label": "Medium", "value": "Medium"},
                            {"label": "Low", "value": "Low"},
                          ],
                          value: selectedPriority,
                          onChanged: (value, label) {
                            selectedPriority = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Standards List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Compliance Standards (${filteredStandards.length})",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Generate Report",
                          icon: Icons.assessment,
                          size: bs.sm,
                          onPressed: () {
                            // Generate compliance report
                          },
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredStandards.length,
                    itemBuilder: (context, index) {
                      final standard = filteredStandards[index];
                      return Container(
                        margin: EdgeInsets.all(spSm),
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: disabledOutlineBorderColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${standard["title"]}",
                                            style: TextStyle(
                                              fontSize: fsH6,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                          SizedBox(width: spSm),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: _getPriorityColor(standard["priority"] as String).withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${standard["priority"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: _getPriorityColor(standard["priority"] as String),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${standard["description"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    image: DecorationImage(
                                      image: NetworkImage("${standard["image"]}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(standard["status"] as String).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${standard["status"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: _getStatusColor(standard["status"] as String),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: _getScoreColor(standard["score"] as int).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "Score: ${standard["score"]}%",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: _getScoreColor(standard["score"] as int),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  (standard["certificateValid"] as bool) ? Icons.verified : Icons.warning,
                                  color: (standard["certificateValid"] as bool) ? successColor : dangerColor,
                                  size: 20,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Inspector: ${standard["inspector"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "Department: ${standard["department"]}",
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Violations: ${standard["violations"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: (standard["violations"] as int) > 0 ? dangerColor : successColor,
                                        ),
                                      ),
                                      Text(
                                        "Corrected: ${standard["correctedIssues"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: successColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Next Inspection",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledColor,
                                        ),
                                      ),
                                      Text(
                                        "${DateTime.parse(standard["nextInspection"] as String).dMMMy}",
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
                            if ((standard["requirements"] as List).isNotEmpty) ...[
                              Text(
                                "Requirements Checklist:",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              ...(standard["requirements"] as List).map((requirement) => 
                                Padding(
                                  padding: EdgeInsets.only(left: spSm, bottom: 2),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        size: 12,
                                        color: successColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Expanded(
                                        child: Text(
                                          "$requirement",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                            Container(
                              width: double.infinity,
                              child: QButton(
                                label: "View Details",
                                size: bs.sm,
                                onPressed: () {
                                  // navigateTo(HhaStandardsDetailView(standard: standard));
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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
