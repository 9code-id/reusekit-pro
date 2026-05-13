import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaEmployeeDetailView extends StatefulWidget {
  const RhaEmployeeDetailView({super.key});

  @override
  State<RhaEmployeeDetailView> createState() => _RhaEmployeeDetailViewState();
}

class _RhaEmployeeDetailViewState extends State<RhaEmployeeDetailView> {
  int currentTab = 0;

  Map<String, dynamic> employee = {
    "id": "EMP001",
    "name": "Sarah Johnson",
    "email": "sarah.johnson@company.com",
    "phone": "+1 (555) 123-4567",
    "department": "Engineering",
    "position": "Senior Developer",
    "status": "Active",
    "avatar": "https://picsum.photos/150/150?random=1&keyword=person",
    "joinDate": "2023-01-15",
    "managerId": "MGR001",
    "managerName": "John Smith",
    "location": "New York, NY",
    "employeeType": "Full-time",
    "workLocation": "Hybrid",
    "salary": 95000,
    "experience": "5 years",
    "bio": "Experienced full-stack developer with expertise in Flutter, React, and Node.js. Passionate about creating clean, efficient code and mentoring junior developers.",
    "skills": ["Flutter", "React", "Node.js", "Python", "AWS", "Docker"],
    "certifications": [
      {
        "name": "AWS Certified Solutions Architect",
        "issuer": "Amazon Web Services",
        "date": "2023-08-15",
        "status": "Valid"
      },
      {
        "name": "Google Cloud Professional Developer",
        "issuer": "Google Cloud",
        "date": "2023-03-20",
        "status": "Valid"
      }
    ],
    "education": [
      {
        "degree": "Master of Computer Science",
        "school": "Stanford University",
        "year": "2019",
        "gpa": "3.8"
      },
      {
        "degree": "Bachelor of Software Engineering",
        "school": "UC Berkeley",
        "year": "2017",
        "gpa": "3.6"
      }
    ]
  };

  List<Map<String, dynamic>> assessmentHistory = [
    {
      "id": "ASS001",
      "title": "Flutter Development Assessment",
      "type": "Technical",
      "date": "2024-01-15",
      "score": 95,
      "status": "Completed",
      "duration": "2h 30m",
      "attempts": 1
    },
    {
      "id": "ASS002",
      "title": "Leadership Skills Evaluation",
      "type": "Soft Skills",
      "date": "2024-01-10",
      "score": 88,
      "status": "Completed",
      "duration": "1h 45m",
      "attempts": 1
    },
    {
      "id": "ASS003",
      "title": "AWS Solutions Architect",
      "type": "Certification",
      "date": "2024-01-05",
      "score": 92,
      "status": "Completed",
      "duration": "3h 00m",
      "attempts": 2
    },
    {
      "id": "ASS004",
      "title": "React Advanced Concepts",
      "type": "Technical",
      "date": "2023-12-20",
      "score": 89,
      "status": "Completed",
      "duration": "2h 15m",
      "attempts": 1
    },
    {
      "id": "ASS005",
      "title": "Project Management Fundamentals",
      "type": "Management",
      "date": "2023-12-15",
      "score": 85,
      "status": "Completed",
      "duration": "1h 30m",
      "attempts": 1
    }
  ];

  List<Map<String, dynamic>> performanceMetrics = [
    {
      "metric": "Overall Performance",
      "value": 92.5,
      "trend": "up",
      "change": 5.2
    },
    {
      "metric": "Technical Skills",
      "value": 95.0,
      "trend": "up",
      "change": 3.1
    },
    {
      "metric": "Soft Skills",
      "value": 88.5,
      "trend": "up",
      "change": 2.8
    },
    {
      "metric": "Leadership",
      "value": 86.0,
      "trend": "stable",
      "change": 0.5
    },
    {
      "metric": "Communication",
      "value": 90.0,
      "trend": "up",
      "change": 4.2
    }
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Inactive":
        return warningColor;
      case "Completed":
        return successColor;
      case "Valid":
        return successColor;
      default:
        return disabledColor;
    }
  }

  Color _getTrendColor(String trend) {
    switch (trend) {
      case "up":
        return successColor;
      case "down":
        return dangerColor;
      case "stable":
        return warningColor;
      default:
        return disabledColor;
    }
  }

  IconData _getTrendIcon(String trend) {
    switch (trend) {
      case "up":
        return Icons.trending_up;
      case "down":
        return Icons.trending_down;
      case "stable":
        return Icons.trending_flat;
      default:
        return Icons.remove;
    }
  }

  Widget _buildOverviewTab() {
    return Column(
      children: [
        _buildPersonalInfo(),
        SizedBox(height: spMd),
        _buildPerformanceOverview(),
        SizedBox(height: spMd),
        _buildSkillsAndCertifications(),
      ],
    );
  }

  Widget _buildPersonalInfo() {
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
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage("${employee["avatar"]}"),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${employee["name"]}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
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
                            color: _getStatusColor(employee["status"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${employee["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor(employee["status"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${employee["position"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: secondaryColor,
                      ),
                    ),
                    Text(
                      "${employee["department"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          _buildInfoRow("Employee ID", "${employee["id"]}"),
          _buildInfoRow("Email", "${employee["email"]}"),
          _buildInfoRow("Phone", "${employee["phone"]}"),
          _buildInfoRow("Join Date", "${employee["joinDate"]}"),
          _buildInfoRow("Manager", "${employee["managerName"]}"),
          _buildInfoRow("Location", "${employee["location"]}"),
          _buildInfoRow("Work Type", "${employee["workLocation"]}"),
          _buildInfoRow("Experience", "${employee["experience"]}"),
          if (employee["bio"] != null && employee["bio"].isNotEmpty) ...[
            SizedBox(height: spSm),
            Text(
              "Bio",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "${employee["bio"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
          ),
          Text(
            ": ",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceOverview() {
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
          Text(
            "Performance Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...performanceMetrics.map((metric) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${metric["metric"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Icon(
                        _getTrendIcon(metric["trend"]),
                        size: 16,
                        color: _getTrendColor(metric["trend"]),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${(metric["value"] as double).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  LinearProgressIndicator(
                    value: (metric["value"] as double) / 100,
                    backgroundColor: disabledColor.withAlpha(30),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _getTrendColor(metric["trend"]),
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

  Widget _buildSkillsAndCertifications() {
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
          Text(
            "Skills & Expertise",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Wrap(
            spacing: spSm,
            runSpacing: spSm,
            children: (employee["skills"] as List).map((skill) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusXs),
                  border: Border.all(
                    color: primaryColor.withAlpha(30),
                    width: 1,
                  ),
                ),
                child: Text(
                  "$skill",
                  style: TextStyle(
                    fontSize: 13,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spMd),
          Text(
            "Certifications",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...(employee["certifications"] as List).map((cert) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(
                  color: successColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.verified,
                    color: successColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${cert["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${cert["issuer"]} • ${cert["date"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spXs,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(cert["status"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${cert["status"]}",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _getStatusColor(cert["status"]),
                      ),
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

  Widget _buildAssessmentsTab() {
    return Column(
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
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Assessment History",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  QButton(
                    label: "Assign Assessment",
                    icon: Icons.add,
                    size: bs.sm,
                    onPressed: () {
                      // Assign new assessment
                    },
                  ),
                ],
              ),
              SizedBox(height: spMd),
              ...assessmentHistory.map((assessment) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusXs),
                    border: Border.all(
                      color: disabledOutlineBorderColor,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 40,
                        decoration: BoxDecoration(
                          color: _getStatusColor(assessment["status"]),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${assessment["title"]}",
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
                                  "${assessment["type"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: secondaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  " • ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${assessment["date"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  " • ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${assessment["duration"]}",
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${assessment["score"]}%",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: _getStatusColor(assessment["status"]),
                            ),
                          ),
                          Text(
                            "Score",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.visibility,
                        size: bs.sm,
                        onPressed: () {
                          // View assessment details
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEducationTab() {
    return Column(
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
            children: [
              Text(
                "Education Background",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              ...(employee["education"] as List).map((edu) {
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusXs),
                    border: Border.all(
                      color: disabledOutlineBorderColor,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Icon(
                          Icons.school,
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
                              "${edu["degree"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${edu["school"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: secondaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Text(
                                  "Graduated: ${edu["year"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                if (edu["gpa"] != null) ...[
                                  Text(
                                    " • GPA: ${edu["gpa"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Employee Details",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.person)),
        Tab(text: "Assessments", icon: Icon(Icons.quiz)),
        Tab(text: "Education", icon: Icon(Icons.school)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildAssessmentsTab(),
        _buildEducationTab(),
      ],
      onInit: (tabController) {
        // Tab controller initialization if needed
      },
    );
  }
}
