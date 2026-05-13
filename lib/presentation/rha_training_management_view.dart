import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaTrainingManagementView extends StatefulWidget {
  const RhaTrainingManagementView({super.key});

  @override
  State<RhaTrainingManagementView> createState() => _RhaTrainingManagementViewState();
}

class _RhaTrainingManagementViewState extends State<RhaTrainingManagementView> {
  int currentTab = 0;
  String selectedStatus = "All";
  String selectedCategory = "All";
  String searchQuery = "";
  bool showUpcoming = true;

  List<Map<String, dynamic>> trainingPrograms = [
    {
      "id": "TR001",
      "title": "Advanced JavaScript Development",
      "category": "Technical",
      "instructor": "John Smith",
      "duration": "40 hours",
      "format": "Online",
      "status": "Active",
      "startDate": "2024-07-01",
      "endDate": "2024-08-15",
      "enrolled": 24,
      "capacity": 30,
      "completionRate": 85,
      "rating": 4.7,
      "cost": 1200,
      "skills": ["JavaScript", "ES6", "Async Programming"],
      "description": "Comprehensive JavaScript course covering advanced concepts and best practices",
      "department": "Engineering"
    },
    {
      "id": "TR002",
      "title": "Leadership Excellence Program",
      "category": "Leadership",
      "instructor": "Sarah Wilson",
      "duration": "32 hours",
      "format": "Hybrid",
      "status": "Upcoming",
      "startDate": "2024-08-01",
      "endDate": "2024-09-30",
      "enrolled": 18,
      "capacity": 25,
      "completionRate": 0,
      "rating": 0,
      "cost": 1800,
      "skills": ["Leadership", "Team Management", "Strategic Thinking"],
      "description": "Develop essential leadership skills for managing teams and driving organizational success",
      "department": "All"
    },
    {
      "id": "TR003",
      "title": "Digital Marketing Mastery",
      "category": "Marketing",
      "instructor": "Mike Johnson",
      "duration": "24 hours",
      "format": "Online",
      "status": "Completed",
      "startDate": "2024-04-01",
      "endDate": "2024-05-15",
      "enrolled": 32,
      "capacity": 35,
      "completionRate": 94,
      "rating": 4.9,
      "cost": 800,
      "skills": ["SEO", "SEM", "Social Media Marketing", "Analytics"],
      "description": "Master digital marketing strategies and tools for modern business growth",
      "department": "Marketing"
    },
    {
      "id": "TR004",
      "title": "Data Analysis with Python",
      "category": "Technical",
      "instructor": "Emily Chen",
      "duration": "48 hours",
      "format": "Online",
      "status": "Active",
      "startDate": "2024-06-15",
      "endDate": "2024-08-30",
      "enrolled": 28,
      "capacity": 30,
      "completionRate": 60,
      "rating": 4.5,
      "cost": 1500,
      "skills": ["Python", "Pandas", "Data Visualization", "Machine Learning"],
      "description": "Learn data analysis and visualization using Python and popular libraries",
      "department": "Data Science"
    }
  ];

  List<Map<String, dynamic>> trainingRequests = [
    {
      "id": "REQ001",
      "employee": "Alex Thompson",
      "position": "Junior Developer",
      "department": "Engineering",
      "requestedTraining": "React Native Development",
      "justification": "Need to develop mobile applications for upcoming projects",
      "priority": "High",
      "estimatedCost": 1000,
      "requestDate": "2024-06-15",
      "status": "Pending",
      "manager": "John Smith"
    },
    {
      "id": "REQ002",
      "employee": "Maria Garcia",
      "position": "Marketing Specialist",
      "department": "Marketing",
      "requestedTraining": "Google Analytics 4 Certification",
      "justification": "Need to upgrade skills for new analytics platform",
      "priority": "Medium",
      "estimatedCost": 300,
      "requestDate": "2024-06-18",
      "status": "Approved",
      "manager": "Lisa Wong"
    },
    {
      "id": "REQ003",
      "employee": "David Park",
      "position": "Sales Manager",
      "department": "Sales",
      "requestedTraining": "Advanced Negotiation Skills",
      "justification": "To improve closing rates with enterprise clients",
      "priority": "High",
      "estimatedCost": 1200,
      "requestDate": "2024-06-20",
      "status": "Under Review",
      "manager": "Rachel Green"
    }
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Upcoming", "value": "Upcoming"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Cancelled", "value": "Cancelled"}
  ];

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All", "value": "All"},
    {"label": "Technical", "value": "Technical"},
    {"label": "Leadership", "value": "Leadership"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Sales", "value": "Sales"},
    {"label": "Soft Skills", "value": "Soft Skills"}
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return primaryColor;
      case "Upcoming":
        return infoColor;
      case "Completed":
        return successColor;
      case "Cancelled":
        return dangerColor;
      case "Approved":
        return successColor;
      case "Pending":
        return warningColor;
      case "Under Review":
        return infoColor;
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
        return successColor;
      default:
        return disabledBoldColor;
    }
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
                                "Active Programs",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "12",
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
                            Icons.people,
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
                                "Enrolled",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "186",
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
                            Icons.assessment,
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
                                "Completion Rate",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "84%",
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
                            Icons.request_page,
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
                                "Pending Requests",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "8",
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

          // Upcoming Training Programs
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Upcoming Training",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    QButton(
                      label: "View All",
                      size: bs.sm,
                      onPressed: () {
                        currentTab = 1;
                        setState(() {});
                      },
                    ),
                  ],
                ),
                ...trainingPrograms.where((program) => program["status"] == "Upcoming").take(3).map((program) => Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    border: Border.all(color: disabledOutlineBorderColor),
                    borderRadius: BorderRadius.circular(radiusSm),
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
                              color: _getStatusColor("${program["status"]}").withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.school,
                              color: _getStatusColor("${program["status"]}"),
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${program["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "Starts ${DateTime.parse("${program["startDate"]}").dMMMy}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: _getStatusColor("${program["status"]}").withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${program["enrolled"]}/${program["capacity"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getStatusColor("${program["status"]}"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),

          // Recent Requests
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recent Requests",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    QButton(
                      label: "View All",
                      size: bs.sm,
                      onPressed: () {
                        currentTab = 2;
                        setState(() {});
                      },
                    ),
                  ],
                ),
                ...trainingRequests.take(3).map((request) => Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    border: Border.all(color: disabledOutlineBorderColor),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: _getStatusColor("${request["status"]}").withAlpha(20),
                        child: Text(
                          "${request["employee"]}".split(" ").map((e) => e[0]).join("").toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: _getStatusColor("${request["status"]}"),
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${request["requestedTraining"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${request["employee"]} • ${request["department"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: _getStatusColor("${request["status"]}").withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${request["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _getStatusColor("${request["status"]}"),
                          ),
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

  Widget _buildProgramsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Action Buttons
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Create Program",
                  icon: Icons.add,
                  onPressed: () {
                    ss("Create training program clicked");
                  },
                ),
              ),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: () {
                  ss("Filter programs clicked");
                },
              ),
            ],
          ),

          // Filters
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusItems,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryItems,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Search
          QTextField(
            label: "Search training programs",
            value: searchQuery,
            hint: "Enter program title or instructor",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),

          // Training Programs
          ...trainingPrograms.map((program) => Container(
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
                // Header
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getStatusColor("${program["status"]}").withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.school,
                        color: _getStatusColor("${program["status"]}"),
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
                              Expanded(
                                child: Text(
                                  "${program["title"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getStatusColor("${program["status"]}").withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${program["status"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: _getStatusColor("${program["status"]}"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Instructor: ${program["instructor"]} • ${program["category"]}",
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

                // Program Details
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "Duration: ${program["duration"]}",
                              style: TextStyle(fontSize: 14, color: disabledBoldColor),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.computer, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "Format: ${program["format"]}",
                              style: TextStyle(fontSize: 14, color: disabledBoldColor),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.attach_money, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "Cost: \$${((program["cost"] as int).toDouble()).currency}",
                              style: TextStyle(fontSize: 14, color: disabledBoldColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${DateTime.parse("${program["startDate"]}").dMMMy} - ${DateTime.parse("${program["endDate"]}").dMMMy}",
                              style: TextStyle(fontSize: 14, color: disabledBoldColor),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.people, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "Enrolled: ${program["enrolled"]}/${program["capacity"]}",
                              style: TextStyle(fontSize: 14, color: disabledBoldColor),
                            ),
                          ],
                        ),
                        if ((program["rating"] as num) > 0)
                          Row(
                            children: [
                              Icon(Icons.star, size: 16, color: warningColor),
                              SizedBox(width: spXs),
                              Text(
                                "${(program["rating"] as num).toStringAsFixed(1)} rating",
                                style: TextStyle(fontSize: 14, color: disabledBoldColor),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),

                // Description
                Text(
                  "${program["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),

                // Skills
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Skills Covered",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (program["skills"] as List).map((skill) => Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: primaryColor.withAlpha(30)),
                        ),
                        child: Text(
                          "$skill",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )).toList(),
                    ),
                  ],
                ),

                // Progress (for active programs)
                if (program["status"] == "Active" && (program["completionRate"] as num) > 0)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Completion Progress",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${program["completionRate"]}%",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      LinearProgressIndicator(
                        value: (program["completionRate"] as num) / 100,
                        backgroundColor: disabledColor,
                        color: primaryColor,
                      ),
                    ],
                  ),

                // Actions
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {
                          ss("View program details: ${program["title"]}");
                        },
                      ),
                    ),
                    QButton(
                      label: "Manage",
                      size: bs.sm,
                      onPressed: () {
                        ss("Manage program: ${program["title"]}");
                      },
                    ),
                  ],
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildRequestsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Action Buttons
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "New Request",
                  icon: Icons.add,
                  onPressed: () {
                    ss("Create training request clicked");
                  },
                ),
              ),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: () {
                  ss("Filter requests clicked");
                },
              ),
            ],
          ),

          // Search
          QTextField(
            label: "Search requests",
            value: searchQuery,
            hint: "Enter employee name or training",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),

          // Training Requests
          ...trainingRequests.map((request) => Container(
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
                // Header
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: _getStatusColor("${request["status"]}").withAlpha(20),
                      child: Text(
                        "${request["employee"]}".split(" ").map((e) => e[0]).join("").toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: _getStatusColor("${request["status"]}"),
                        ),
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
                                  "${request["employee"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getStatusColor("${request["status"]}").withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${request["status"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: _getStatusColor("${request["status"]}"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${request["position"]} • ${request["department"]}",
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

                // Training Details
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(5),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: primaryColor.withAlpha(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Text(
                        "Requested Training",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${request["requestedTraining"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${request["justification"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),

                // Request Details
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.flag, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "Priority: ",
                                style: TextStyle(fontSize: 14, color: disabledBoldColor),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getPriorityColor("${request["priority"]}").withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${request["priority"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: _getPriorityColor("${request["priority"]}"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.attach_money, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "Est. Cost: \$${((request["estimatedCost"] as int).toDouble()).currency}",
                                style: TextStyle(fontSize: 14, color: disabledBoldColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "Manager: ${request["manager"]}",
                              style: TextStyle(fontSize: 14, color: disabledBoldColor),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${DateTime.parse("${request["requestDate"]}").dMMMy}",
                              style: TextStyle(fontSize: 14, color: disabledBoldColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                // Actions
                if (request["status"] == "Pending" || request["status"] == "Under Review")
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Approve",
                          size: bs.sm,
                          onPressed: () {
                            ss("Approve request for ${request["employee"]}");
                          },
                        ),
                      ),
                      QButton(
                        label: "Reject",
                        size: bs.sm,
                        onPressed: () {
                          se("Reject request for ${request["employee"]}");
                        },
                      ),
                    ],
                  )
                else
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "View Details",
                      size: bs.sm,
                      onPressed: () {
                        ss("View request details for ${request["employee"]}");
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
      title: "Training Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Programs", icon: Icon(Icons.school)),
        Tab(text: "Requests", icon: Icon(Icons.request_page)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildProgramsTab(),
        _buildRequestsTab(),
      ],
    );
  }
}
