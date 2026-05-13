import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaTrainingRecordsView extends StatefulWidget {
  const HhaTrainingRecordsView({super.key});

  @override
  State<HhaTrainingRecordsView> createState() => _HhaTrainingRecordsViewState();
}

class _HhaTrainingRecordsViewState extends State<HhaTrainingRecordsView> {
  int selectedTab = 0;
  String selectedDepartment = "All";
  String selectedStatus = "All";
  String selectedTrainingType = "All";
  
  List<Map<String, dynamic>> departmentOptions = [
    {"label": "All", "value": "All"},
    {"label": "Front Desk", "value": "Front Desk"},
    {"label": "Housekeeping", "value": "Housekeeping"},
    {"label": "Maintenance", "value": "Maintenance"},
    {"label": "Food & Beverage", "value": "Food & Beverage"},
    {"label": "Security", "value": "Security"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Not Started", "value": "Not Started"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Expired", "value": "Expired"},
  ];

  List<Map<String, dynamic>> trainingTypeOptions = [
    {"label": "All", "value": "All"},
    {"label": "Safety Training", "value": "Safety Training"},
    {"label": "Customer Service", "value": "Customer Service"},
    {"label": "Technical Skills", "value": "Technical Skills"},
    {"label": "Compliance", "value": "Compliance"},
  ];

  List<Map<String, dynamic>> trainingStats = [
    {
      "title": "Total Employees",
      "value": 45,
      "icon": Icons.people,
      "color": primaryColor,
    },
    {
      "title": "Completed",
      "value": 38,
      "icon": Icons.check_circle,
      "color": successColor,
    },
    {
      "title": "In Progress",
      "value": 5,
      "icon": Icons.hourglass_empty,
      "color": warningColor,
    },
    {
      "title": "Compliance Rate",
      "value": 92,
      "icon": Icons.shield,
      "color": infoColor,
      "percentage": true,
    },
  ];

  List<Map<String, dynamic>> employeeTraining = [
    {
      "employeeId": "EMP001",
      "employeeName": "John Smith",
      "department": "Front Desk",
      "position": "Receptionist",
      "trainingProgram": "Customer Service Excellence",
      "trainingType": "Customer Service",
      "status": "Completed",
      "startDate": "2024-01-10",
      "completionDate": "2024-01-15",
      "expiryDate": "2025-01-15",
      "score": 95,
      "certificate": "CS-2024-001",
      "instructor": "Sarah Wilson",
      "duration": "8 hours",
    },
    {
      "employeeId": "EMP002",
      "employeeName": "Sarah Johnson",
      "department": "Housekeeping",
      "position": "Housekeeper",
      "trainingProgram": "Safety & Hygiene Standards",
      "trainingType": "Safety Training",
      "status": "In Progress",
      "startDate": "2024-01-12",
      "completionDate": null,
      "expiryDate": null,
      "score": null,
      "certificate": null,
      "instructor": "Mike Davis",
      "duration": "12 hours",
    },
    {
      "employeeId": "EMP003",
      "employeeName": "Mike Davis",
      "department": "Maintenance",
      "position": "Technician",
      "trainingProgram": "Equipment Maintenance",
      "trainingType": "Technical Skills",
      "status": "Completed",
      "startDate": "2024-01-05",
      "completionDate": "2024-01-12",
      "expiryDate": "2025-01-12",
      "score": 88,
      "certificate": "TS-2024-003",
      "instructor": "Robert Brown",
      "duration": "16 hours",
    },
    {
      "employeeId": "EMP004",
      "employeeName": "Emma Wilson",
      "department": "Food & Beverage",
      "position": "Server",
      "trainingProgram": "Food Safety Certification",
      "trainingType": "Compliance",
      "status": "Expired",
      "startDate": "2023-06-01",
      "completionDate": "2023-06-05",
      "expiryDate": "2024-06-05",
      "score": 92,
      "certificate": "FC-2023-004",
      "instructor": "Lisa Garcia",
      "duration": "6 hours",
    },
    {
      "employeeId": "EMP005",
      "employeeName": "Robert Brown",
      "department": "Security",
      "position": "Security Guard",
      "trainingProgram": "Emergency Response",
      "trainingType": "Safety Training",
      "status": "Not Started",
      "startDate": null,
      "completionDate": null,
      "expiryDate": null,
      "score": null,
      "certificate": null,
      "instructor": "Tom Anderson",
      "duration": "10 hours",
    },
  ];

  List<Map<String, dynamic>> trainingPrograms = [
    {
      "id": "TP001",
      "name": "Customer Service Excellence",
      "type": "Customer Service",
      "duration": "8 hours",
      "instructor": "Sarah Wilson",
      "capacity": 20,
      "enrolled": 15,
      "completionRate": 95,
      "description": "Comprehensive customer service training covering communication skills, problem-solving, and guest satisfaction.",
      "requirements": ["Basic English", "6 months experience"],
      "nextSession": "2024-02-01",
    },
    {
      "id": "TP002",
      "name": "Safety & Hygiene Standards",
      "type": "Safety Training",
      "duration": "12 hours",
      "instructor": "Mike Davis",
      "capacity": 25,
      "enrolled": 18,
      "completionRate": 88,
      "description": "Essential safety protocols and hygiene standards for hospitality industry.",
      "requirements": ["None"],
      "nextSession": "2024-01-25",
    },
    {
      "id": "TP003",
      "name": "Equipment Maintenance",
      "type": "Technical Skills",
      "duration": "16 hours",
      "instructor": "Robert Brown",
      "capacity": 10,
      "enrolled": 8,
      "completionRate": 92,
      "description": "Technical training for hotel equipment maintenance and troubleshooting.",
      "requirements": ["Technical background", "1 year experience"],
      "nextSession": "2024-02-10",
    },
    {
      "id": "TP004",
      "name": "Food Safety Certification",
      "type": "Compliance",
      "duration": "6 hours",
      "instructor": "Lisa Garcia",
      "capacity": 30,
      "enrolled": 22,
      "completionRate": 98,
      "description": "Food safety certification required for all F&B staff.",
      "requirements": ["F&B department"],
      "nextSession": "2024-01-30",
    },
  ];

  List<Map<String, dynamic>> get filteredTraining {
    return employeeTraining.where((training) {
      bool departmentMatch = selectedDepartment == "All" || training["department"] == selectedDepartment;
      bool statusMatch = selectedStatus == "All" || training["status"] == selectedStatus;
      bool typeMatch = selectedTrainingType == "All" || training["trainingType"] == selectedTrainingType;
      return departmentMatch && statusMatch && typeMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Training Records",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Records", icon: Icon(Icons.assignment)),
        Tab(text: "Programs", icon: Icon(Icons.school)),
        Tab(text: "Reports", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildRecordsTab(),
        _buildProgramsTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildRecordsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Stats Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: trainingStats.map((stat) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      stat["icon"] as IconData,
                      color: stat["color"] as Color,
                      size: 28,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      stat["percentage"] == true 
                          ? "${stat["value"]}%"
                          : "${stat["value"]}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${stat["title"]}",
                      textAlign: TextAlign.center,
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
          
          // Filters
          Row(
            spacing: spSm,
            children: [
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
            ],
          ),
          
          QDropdownField(
            label: "Training Type",
            items: trainingTypeOptions,
            value: selectedTrainingType,
            onChanged: (value, label) {
              selectedTrainingType = value;
              setState(() {});
            },
          ),
          
          // Training Records
          Row(
            children: [
              Text(
                "Training Records",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${filteredTraining.length} records",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          
          Column(
            spacing: spSm,
            children: filteredTraining.map((training) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getStatusColor(training["status"] as String),
                    ),
                  ),
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
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${training["employeeId"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${training["department"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${training["employeeName"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${training["position"]}",
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
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(training["status"] as String).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${training["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor(training["status"] as String),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "${training["trainingProgram"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "Type: ${training["trainingType"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spMd),
                              Text(
                                "Duration: ${training["duration"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Instructor: ${training["instructor"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    if (training["status"] == "Completed")
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Score: ${training["score"]}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Text(
                                  "Certificate: ${training["certificate"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Completed: ${training["completionDate"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Text(
                                  "Expires: ${training["expiryDate"]}",
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
                    
                    if (training["status"] == "Expired")
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.warning,
                              color: dangerColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Training expired on ${training["expiryDate"]} - Renewal required",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    
                    Row(
                      spacing: spSm,
                      children: [
                        if (training["status"] == "Not Started")
                          Expanded(
                            child: QButton(
                              label: "Start Training",
                              size: bs.sm,
                              onPressed: () {
                                ss("Starting training for ${training["employeeName"]}");
                              },
                            ),
                          ),
                        if (training["status"] == "Expired")
                          Expanded(
                            child: QButton(
                              label: "Renew Training",
                              size: bs.sm,
                              onPressed: () {
                                ss("Renewing training for ${training["employeeName"]}");
                              },
                            ),
                          ),
                        if (training["certificate"] != null)
                          QButton(
                            icon: Icons.download,
                            size: bs.sm,
                            onPressed: () {
                              ss("Downloading certificate ${training["certificate"]}");
                            },
                          ),
                        QButton(
                          icon: Icons.visibility,
                          size: bs.sm,
                          onPressed: () {
                            ss("Viewing training details for ${training["employeeName"]}");
                          },
                        ),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          onPressed: () {
                            ss("More options for ${training["employeeName"]}");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildProgramsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Training Programs",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: trainingPrograms.map((program) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
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
                                "${program["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${program["type"]}",
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
                      "${program["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Duration: ${program["duration"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${program["completionRate"]}% completion rate",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Instructor: ${program["instructor"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Enrolled: ${program["enrolled"]}/${program["capacity"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Next Session: ${program["nextSession"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Enroll Employee",
                        size: bs.sm,
                        onPressed: () {
                          ss("Enrolling employee in ${program["name"]}");
                        },
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Training Reports",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Training Metrics",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: [
                    _buildMetricCard("Average Score", "91%", Icons.grade, successColor),
                    _buildMetricCard("Training Hours", "450", Icons.schedule, infoColor),
                    _buildMetricCard("Certificates Issued", "38", Icons.card_membership, primaryColor),
                    _buildMetricCard("Renewal Due", "5", Icons.warning, dangerColor),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
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

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "In Progress":
        return warningColor;
      case "Not Started":
        return infoColor;
      case "Expired":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
