import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmCpeCreditsView extends StatefulWidget {
  const EcmCpeCreditsView({super.key});

  @override
  State<EcmCpeCreditsView> createState() => _EcmCpeCreditsViewState();
}

class _EcmCpeCreditsViewState extends State<EcmCpeCreditsView> {
  int currentTab = 0;
  
  // CPE Credit Management
  String activityTitle = "";
  String activityType = "Training";
  String activityProvider = "";
  String completionDate = "";
  String creditsEarned = "";
  String activityDescription = "";
  bool autoSync = true;
  bool notifications = true;
  
  List<Map<String, dynamic>> activityTypes = [
    {"label": "Training", "value": "Training"},
    {"label": "Conference", "value": "Conference"},
    {"label": "Webinar", "value": "Webinar"},
    {"label": "Workshop", "value": "Workshop"},
    {"label": "Self-Study", "value": "Self-Study"},
    {"label": "Teaching", "value": "Teaching"},
    {"label": "Writing", "value": "Writing"},
    {"label": "Volunteering", "value": "Volunteering"},
  ];

  List<Map<String, dynamic>> cpeActivities = [
    {
      "id": "cpe_001",
      "title": "AWS Advanced Networking",
      "type": "Training",
      "provider": "Amazon Web Services",
      "credits": 8.0,
      "date": "2024-01-15",
      "status": "Approved",
      "certification": "AWS Solutions Architect",
      "category": "Technical",
      "hours": 8,
      "description": "Advanced networking concepts for AWS cloud infrastructure",
    },
    {
      "id": "cpe_002",
      "title": "Cloud Security Best Practices",
      "type": "Webinar",
      "provider": "Cloud Security Alliance",
      "credits": 2.0,
      "date": "2024-01-20",
      "status": "Pending Review",
      "certification": "Google Cloud Platform",
      "category": "Security",
      "hours": 2,
      "description": "Security frameworks and compliance in cloud environments",
    },
    {
      "id": "cpe_003",
      "title": "DevOps Implementation",
      "type": "Conference",
      "provider": "DevOps Institute",
      "credits": 12.0,
      "date": "2024-02-05",
      "status": "Approved",
      "certification": "Microsoft Azure",
      "category": "Process",
      "hours": 12,
      "description": "Implementing DevOps practices in enterprise environments",
    },
    {
      "id": "cpe_004",
      "title": "Machine Learning Fundamentals",
      "type": "Self-Study",
      "provider": "Coursera",
      "credits": 15.0,
      "date": "2024-02-15",
      "status": "In Progress",
      "certification": "AWS Solutions Architect",
      "category": "Technical",
      "hours": 15,
      "description": "Introduction to machine learning algorithms and applications",
    },
  ];

  List<Map<String, dynamic>> certificationRequirements = [
    {
      "certification": "AWS Solutions Architect",
      "requiredCredits": 40,
      "earnedCredits": 23,
      "expiryDate": "2026-06-15",
      "progress": 57.5,
      "remainingDays": 365,
      "status": "On Track",
    },
    {
      "certification": "Google Cloud Platform",
      "requiredCredits": 30,
      "earnedCredits": 14,
      "expiryDate": "2024-03-20",
      "progress": 46.7,
      "remainingDays": 45,
      "status": "Behind",
    },
    {
      "certification": "Microsoft Azure",
      "requiredCredits": 35,
      "earnedCredits": 27,
      "expiryDate": "2025-09-10",
      "progress": 77.1,
      "remainingDays": 210,
      "status": "Ahead",
    },
  ];

  List<Map<String, dynamic>> creditCategories = [
    {
      "category": "Technical",
      "credits": 45,
      "percentage": 60,
      "color": primaryColor,
      "activities": 8,
    },
    {
      "category": "Leadership",
      "credits": 12,
      "percentage": 16,
      "color": successColor,
      "activities": 3,
    },
    {
      "category": "Process",
      "credits": 15,
      "percentage": 20,
      "color": infoColor,
      "activities": 4,
    },
    {
      "category": "Security",
      "credits": 3,
      "percentage": 4,
      "color": warningColor,
      "activities": 2,
    },
  ];

  List<Map<String, dynamic>> upcomingDeadlines = [
    {
      "certification": "Google Cloud Platform",
      "deadline": "2024-03-20",
      "creditsNeeded": 16,
      "daysLeft": 45,
      "priority": "High",
    },
    {
      "certification": "CompTIA Security+",
      "deadline": "2024-05-15",
      "creditsNeeded": 8,
      "daysLeft": 103,
      "priority": "Medium",
    },
    {
      "certification": "Project Management Professional",
      "deadline": "2024-08-30",
      "creditsNeeded": 22,
      "daysLeft": 210,
      "priority": "Low",
    },
  ];

  void _addActivity() {
    ss("CPE activity added successfully");
  }

  void _submitForReview(String activityId) {
    ss("Activity submitted for review");
  }

  void _generateReport() {
    ss("CPE report generated successfully");
  }

  void _syncCredits() {
    ss("Credits synchronized successfully");
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Approved":
        return successColor;
      case "Pending Review":
        return warningColor;
      case "In Progress":
        return infoColor;
      case "Rejected":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTrackingColor(String status) {
    switch (status) {
      case "On Track":
        return successColor;
      case "Ahead":
        return infoColor;
      case "Behind":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildActivityCard(Map<String, dynamic> activity) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
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
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
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
                      "${activity["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${activity["provider"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor("${activity["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${activity["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: _getStatusColor("${activity["status"]}"),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${activity["description"]}",
            style: TextStyle(
              fontSize: 13,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Type: ${activity["type"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Category: ${activity["category"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Date: ${activity["date"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${activity["credits"]} Credits",
                    style: TextStyle(
                      fontSize: fsH6,
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${activity["hours"]} Hours",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if ("${activity["status"]}" == "Pending Review") ...[
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Submit for Review",
                size: bs.sm,
                onPressed: () => _submitForReview("${activity["id"]}"),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRequirementCard(Map<String, dynamic> req) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getTrackingColor("${req["status"]}"),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${req["certification"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getTrackingColor("${req["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${req["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: _getTrackingColor("${req["status"]}"),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Credits: ${req["earnedCredits"]}/${req["requiredCredits"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Expires: ${req["expiryDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "${req["remainingDays"]} days left",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (req["progress"] as num) / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: _getTrackingColor("${req["status"]}"),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${(req["progress"] as num).toStringAsFixed(1)}% Complete",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: (category["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.category,
              color: category["color"] as Color,
              size: 28,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "${category["category"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${category["credits"]} Credits",
            style: TextStyle(
              fontSize: fsH6,
              color: category["color"] as Color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "${category["activities"]} Activities",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (category["percentage"] as num) / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: category["color"] as Color,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${category["percentage"]}%",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeadlineCard(Map<String, dynamic> deadline) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getPriorityColor("${deadline["priority"]}"),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _getPriorityColor("${deadline["priority"]}").withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.access_time,
              color: _getPriorityColor("${deadline["priority"]}"),
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${deadline["certification"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Need ${deadline["creditsNeeded"]} more credits",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Deadline: ${deadline["deadline"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getPriorityColor("${deadline["priority"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${deadline["priority"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: _getPriorityColor("${deadline["priority"]}"),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${deadline["daysLeft"]} days",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "CPE Credits Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Activities", icon: Icon(Icons.school)),
        Tab(text: "Requirements", icon: Icon(Icons.assignment)),
        Tab(text: "Categories", icon: Icon(Icons.category)),
        Tab(text: "Deadlines", icon: Icon(Icons.schedule)),
        Tab(text: "Add Activity", icon: Icon(Icons.add_circle)),
      ],
      tabChildren: [
        // Overview Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.school,
                            color: Colors.white,
                            size: 32,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "75",
                            style: TextStyle(
                              fontSize: fsH2,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Total CPE Credits",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor,
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.verified,
                            color: Colors.white,
                            size: 32,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "64",
                            style: TextStyle(
                              fontSize: fsH2,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Approved Credits",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: warningColor,
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.pending,
                            color: Colors.white,
                            size: 32,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "11",
                            style: TextStyle(
                              fontSize: fsH2,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Pending Review",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor,
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.trending_up,
                            color: Colors.white,
                            size: 32,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "17",
                            style: TextStyle(
                              fontSize: fsH2,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "This Year",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Text(
                "Quick Actions",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Add Activity",
                      icon: Icons.add,
                      onPressed: () {
                        currentTab = 5;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Generate Report",
                      icon: Icons.report,
                      onPressed: _generateReport,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Sync Credits",
                  icon: Icons.sync,
                  onPressed: _syncCredits,
                ),
              ),
            ],
          ),
        ),
        
        // Activities Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: cpeActivities.map((activity) => _buildActivityCard(activity)).toList(),
          ),
        ),
        
        // Requirements Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: certificationRequirements.map((req) => _buildRequirementCard(req)).toList(),
          ),
        ),
        
        // Categories Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: creditCategories.map((category) => _buildCategoryCard(category)).toList(),
          ),
        ),
        
        // Deadlines Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: upcomingDeadlines.map((deadline) => _buildDeadlineCard(deadline)).toList(),
          ),
        ),
        
        // Add Activity Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text(
                "Add CPE Activity",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QTextField(
                label: "Activity Title",
                value: activityTitle,
                hint: "Enter activity title",
                onChanged: (value) {
                  activityTitle = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Activity Type",
                items: activityTypes,
                value: activityType,
                onChanged: (value, label) {
                  activityType = value;
                  setState(() {});
                },
              ),
              QTextField(
                label: "Activity Provider",
                value: activityProvider,
                hint: "Enter organization or provider",
                onChanged: (value) {
                  activityProvider = value;
                  setState(() {});
                },
              ),
              QDatePicker(
                label: "Completion Date",
                value: completionDate.isEmpty ? DateTime.now() : DateTime.parse(completionDate),
                onChanged: (value) {
                  completionDate = value.toString().split(' ')[0];
                  setState(() {});
                },
              ),
              QNumberField(
                label: "Credits Earned",
                value: creditsEarned,
                hint: "Enter number of credits",
                onChanged: (value) {
                  creditsEarned = value;
                  setState(() {});
                },
              ),
              QMemoField(
                label: "Activity Description",
                value: activityDescription,
                hint: "Describe the learning activity and outcomes",
                onChanged: (value) {
                  activityDescription = value;
                  setState(() {});
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: QSwitch(
                      items: [
                        {
                          "label": "Auto Sync",
                          "value": true,
                          "checked": autoSync,
                        }
                      ],
                      value: [
                        if (autoSync)
                          {
                            "label": "Auto Sync",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        autoSync = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: QSwitch(
                      items: [
                        {
                          "label": "Enable Notifications",
                          "value": true,
                          "checked": notifications,
                        }
                      ],
                      value: [
                        if (notifications)
                          {
                            "label": "Enable Notifications",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        notifications = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Add CPE Activity",
                  onPressed: _addActivity,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
