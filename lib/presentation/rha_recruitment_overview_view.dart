import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaRecruitmentOverviewView extends StatefulWidget {
  const RhaRecruitmentOverviewView({super.key});

  @override
  State<RhaRecruitmentOverviewView> createState() => _RhaRecruitmentOverviewViewState();
}

class _RhaRecruitmentOverviewViewState extends State<RhaRecruitmentOverviewView> {
  String searchQuery = "";
  String selectedStatus = "";
  String selectedDepartment = "";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Active", "value": "active"},
    {"label": "Draft", "value": "draft"},
    {"label": "Closed", "value": "closed"},
    {"label": "On Hold", "value": "on_hold"},
  ];

  List<Map<String, dynamic>> departmentOptions = [
    {"label": "All Departments", "value": ""},
    {"label": "Engineering", "value": "engineering"},
    {"label": "Sales", "value": "sales"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "HR", "value": "hr"},
    {"label": "Finance", "value": "finance"},
  ];

  List<Map<String, dynamic>> recruitmentStats = [
    {
      "title": "Total Jobs",
      "value": 25,
      "change": "+3",
      "isPositive": true,
      "icon": Icons.work,
    },
    {
      "title": "Applications",
      "value": 342,
      "change": "+45",
      "isPositive": true,
      "icon": Icons.description,
    },
    {
      "title": "Interviews",
      "value": 68,
      "change": "+12",
      "isPositive": true,
      "icon": Icons.record_voice_over,
    },
    {
      "title": "Hired",
      "value": 15,
      "change": "+8",
      "isPositive": true,
      "icon": Icons.check_circle,
    },
  ];

  List<Map<String, dynamic>> jobPostings = [
    {
      "title": "Senior Frontend Developer",
      "department": "Engineering",
      "location": "Remote",
      "type": "Full-time",
      "applications": 45,
      "posted": "2024-03-15",
      "status": "active",
      "salary": "80,000 - 120,000",
      "urgency": "high",
    },
    {
      "title": "Marketing Manager",
      "department": "Marketing",
      "location": "New York",
      "type": "Full-time",
      "applications": 32,
      "posted": "2024-03-12",
      "status": "active",
      "salary": "70,000 - 90,000",
      "urgency": "medium",
    },
    {
      "title": "Sales Representative",
      "department": "Sales",
      "location": "Chicago",
      "type": "Full-time",
      "applications": 28,
      "posted": "2024-03-10",
      "status": "active",
      "salary": "50,000 - 70,000",
      "urgency": "low",
    },
    {
      "title": "HR Specialist",
      "department": "HR",
      "location": "Los Angeles",
      "type": "Full-time",
      "applications": 15,
      "posted": "2024-03-08",
      "status": "on_hold",
      "salary": "55,000 - 75,000",
      "urgency": "low",
    },
    {
      "title": "Product Designer",
      "department": "Design",
      "location": "San Francisco",
      "type": "Contract",
      "applications": 52,
      "posted": "2024-03-05",
      "status": "closed",
      "salary": "90,000 - 110,000",
      "urgency": "high",
    },
  ];

  List<Map<String, dynamic>> recentApplications = [
    {
      "name": "John Smith",
      "position": "Senior Frontend Developer",
      "experience": "5 years",
      "status": "screening",
      "applied": "2 hours ago",
      "score": 95,
    },
    {
      "name": "Sarah Johnson",
      "position": "Marketing Manager",
      "experience": "7 years",
      "status": "interview",
      "applied": "1 day ago",
      "score": 88,
    },
    {
      "name": "Mike Davis",
      "position": "Sales Representative",
      "experience": "3 years",
      "status": "offer",
      "applied": "3 days ago",
      "score": 92,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recruitment Overview"),
        actions: [
          IconButton(
            onPressed: () {
              // Add new job posting
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search jobs or candidates",
                          value: searchQuery,
                          hint: "Job title, department, skills...",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.search,
                        size: bs.sm,
                        onPressed: () {
                          // Perform search
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: statusOptions,
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Department",
                          items: departmentOptions,
                          value: selectedDepartment,
                          onChanged: (value, label) {
                            selectedDepartment = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Recruitment Statistics
            Text(
              "Recruitment Statistics",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: recruitmentStats.map((stat) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              stat["icon"],
                              color: primaryColor,
                              size: 20,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: (stat["isPositive"] as bool)
                                  ? successColor.withAlpha(20)
                                  : dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${stat["change"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: (stat["isPositive"] as bool)
                                    ? successColor
                                    : dangerColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${stat["value"]}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${stat["title"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Active Job Postings
            Row(
              children: [
                Text(
                  "Active Job Postings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    // View all jobs
                  },
                  child: Text(
                    "View All",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: jobPostings.take(4).map((job) {
                  int index = jobPostings.indexOf(job);
                  Color statusColor = _getStatusColor(job["status"]);
                  Color urgencyColor = _getUrgencyColor(job["urgency"]);
                  
                  return Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: index < 3
                              ? disabledOutlineBorderColor
                              : Colors.transparent,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Column(
                      spacing: spSm,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                        "${job["title"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: urgencyColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${job["urgency"]}".toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                            color: urgencyColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${job["department"]} • ${job["location"]} • ${job["type"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "Salary: \$${job["salary"]}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: statusColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${job["status"]}".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: statusColor,
                                    ),
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${job["applications"]} applications",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Posted: ${job["posted"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () {
                                // View job details
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            // Recent Applications
            Text(
              "Recent Applications",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: recentApplications.map((application) {
                  int index = recentApplications.indexOf(application);
                  Color statusColor = _getApplicationStatusColor(application["status"]);
                  
                  return Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: index < recentApplications.length - 1
                              ? disabledOutlineBorderColor
                              : Colors.transparent,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            Icons.person,
                            color: primaryColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${application["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: successColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${application["score"]}%",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: successColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${application["position"]} • ${application["experience"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: statusColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${application["status"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: statusColor,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${application["applied"]}",
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
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "draft":
        return warningColor;
      case "closed":
        return disabledBoldColor;
      case "on_hold":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getUrgencyColor(String urgency) {
    switch (urgency) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getApplicationStatusColor(String status) {
    switch (status) {
      case "screening":
        return infoColor;
      case "interview":
        return warningColor;
      case "offer":
        return successColor;
      case "rejected":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
