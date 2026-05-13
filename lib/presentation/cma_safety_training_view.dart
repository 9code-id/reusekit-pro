import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaSafetyTrainingView extends StatefulWidget {
  const CmaSafetyTrainingView({super.key});

  @override
  State<CmaSafetyTrainingView> createState() => _CmaSafetyTrainingViewState();
}

class _CmaSafetyTrainingViewState extends State<CmaSafetyTrainingView> {
  int currentTab = 0;
  String selectedEmployee = "";
  String selectedCourse = "";
  String selectedStatus = "";
  String trainingTitle = "";
  String trainingDescription = "";
  String trainingDate = "";
  String trainingDuration = "";
  
  List<Map<String, dynamic>> trainingRecords = [
    {
      "id": "TRN001",
      "employee": "John Smith",
      "course": "Defensive Driving",
      "status": "Completed",
      "startDate": "2025-06-01",
      "completionDate": "2025-06-03",
      "score": 95,
      "duration": "8 hours",
      "instructor": "Mike Johnson",
      "location": "Training Center A",
      "cost": 150.00,
      "certificateNumber": "DEF-2025-001",
      "expiryDate": "2027-06-03",
      "modules": [
        {"name": "Hazard Recognition", "completed": true, "score": 98},
        {"name": "Emergency Procedures", "completed": true, "score": 92},
        {"name": "Vehicle Safety", "completed": true, "score": 95},
      ],
      "requirements": ["Valid CDL", "Clean Driving Record"],
      "materials": ["handbook.pdf", "video_series.mp4", "quiz_results.pdf"]
    },
    {
      "id": "TRN002",
      "employee": "Maria Garcia",
      "course": "Hazmat Handling",
      "status": "In Progress",
      "startDate": "2025-06-15",
      "completionDate": "",
      "score": 0,
      "duration": "12 hours",
      "instructor": "Sarah Williams",
      "location": "Safety Training Facility",
      "cost": 250.00,
      "certificateNumber": "",
      "expiryDate": "",
      "modules": [
        {"name": "Chemical Safety", "completed": true, "score": 88},
        {"name": "Spill Response", "completed": true, "score": 90},
        {"name": "Documentation", "completed": false, "score": 0},
      ],
      "requirements": ["Background Check", "Medical Clearance"],
      "materials": ["hazmat_guide.pdf", "safety_videos.mp4"]
    },
    {
      "id": "TRN003",
      "employee": "David Chen",
      "course": "First Aid & CPR",
      "status": "Scheduled",
      "startDate": "2025-06-25",
      "completionDate": "",
      "score": 0,
      "duration": "6 hours",
      "instructor": "Lisa Anderson",
      "location": "Medical Training Center",
      "cost": 120.00,
      "certificateNumber": "",
      "expiryDate": "",
      "modules": [
        {"name": "Basic First Aid", "completed": false, "score": 0},
        {"name": "CPR Techniques", "completed": false, "score": 0},
        {"name": "Emergency Response", "completed": false, "score": 0},
      ],
      "requirements": ["Medical Form", "Photo ID"],
      "materials": ["first_aid_manual.pdf", "training_kit.zip"]
    },
    {
      "id": "TRN004",
      "employee": "Sarah Johnson",
      "course": "Fleet Safety Management",
      "status": "Overdue",
      "startDate": "2025-05-15",
      "completionDate": "",
      "score": 0,
      "duration": "16 hours",
      "instructor": "Mike Johnson",
      "location": "Corporate Training Room",
      "cost": 300.00,
      "certificateNumber": "",
      "expiryDate": "",
      "modules": [
        {"name": "Safety Policies", "completed": false, "score": 0},
        {"name": "Risk Assessment", "completed": false, "score": 0},
        {"name": "Incident Investigation", "completed": false, "score": 0},
      ],
      "requirements": ["Management Authorization", "Safety Experience"],
      "materials": ["safety_manual.pdf", "case_studies.zip"]
    }
  ];

  List<Map<String, dynamic>> employees = [
    {"label": "John Smith", "value": "john_smith"},
    {"label": "Maria Garcia", "value": "maria_garcia"},
    {"label": "David Chen", "value": "david_chen"},
    {"label": "Sarah Johnson", "value": "sarah_johnson"}
  ];

  List<Map<String, dynamic>> courses = [
    {"label": "Defensive Driving", "value": "defensive_driving"},
    {"label": "Hazmat Handling", "value": "hazmat_handling"},
    {"label": "First Aid & CPR", "value": "first_aid_cpr"},
    {"label": "Fleet Safety Management", "value": "fleet_safety"},
    {"label": "DOT Compliance", "value": "dot_compliance"},
    {"label": "Vehicle Maintenance", "value": "vehicle_maintenance"}
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "Completed", "value": "completed"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Scheduled", "value": "scheduled"},
    {"label": "Overdue", "value": "overdue"}
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Safety Training",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Training Records", icon: Icon(Icons.school)),
        Tab(text: "Schedule Training", icon: Icon(Icons.schedule)),
        Tab(text: "Certificates", icon: Icon(Icons.card_membership)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildTrainingRecordsTab(),
        _buildScheduleTrainingTab(),
        _buildCertificatesTab(),
      ],
      onInit: (tabController) {},
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildTrainingOverviewCards(),
          _buildActiveTraining(),
          _buildUpcomingTraining(),
        ],
      ),
    );
  }

  Widget _buildTrainingOverviewCards() {
    int totalTraining = trainingRecords.length;
    int completedCount = trainingRecords.where((r) => r["status"] == "Completed").length;
    int overdueCount = trainingRecords.where((r) => r["status"] == "Overdue").length;
    double completionRate = (completedCount / totalTraining) * 100;
    double totalCosts = trainingRecords.fold(0.0, (sum, r) => sum + (r["cost"] as double));
    
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildOverviewCard("Total Training", "$totalTraining", Icons.school, primaryColor, "Programs"),
        _buildOverviewCard("Completion Rate", "${completionRate.toStringAsFixed(1)}%", Icons.check_circle, successColor, "$completedCount/$totalTraining"),
        _buildOverviewCard("Overdue", "$overdueCount", Icons.error, dangerColor, overdueCount > 0 ? "Action Required" : "All Current"),
        _buildOverviewCard("Total Investment", "\$${totalCosts.toStringAsFixed(0)}", Icons.attach_money, warningColor, "Training Costs"),
      ],
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color, String subtitle) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
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
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  subtitle,
                  style: TextStyle(
                    color: color,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveTraining() {
    List<Map<String, dynamic>> activeTraining = trainingRecords.where((r) => 
      r["status"] == "In Progress").toList();
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Text(
                "Active Training Sessions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${activeTraining.length} Active",
                  style: TextStyle(
                    color: warningColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          if (activeTraining.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.school, color: infoColor, size: 48),
                    SizedBox(height: spSm),
                    Text(
                      "No active training sessions",
                      style: TextStyle(
                        color: infoColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Schedule new training sessions",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ...activeTraining.map((training) => _buildActiveTrainingItem(training)).toList(),
        ],
      ),
    );
  }

  Widget _buildActiveTrainingItem(Map<String, dynamic> training) {
    List<Map<String, dynamic>> modules = training["modules"] as List<Map<String, dynamic>>;
    int completedModules = modules.where((m) => m["completed"]).length;
    double progress = (completedModules / modules.length) * 100;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 4,
            color: warningColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(Icons.play_circle, color: warningColor, size: 16),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${training["course"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${training["employee"]} • Started ${training["startDate"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${progress.toStringAsFixed(0)}%",
                  style: TextStyle(
                    color: infoColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Icon(Icons.schedule, color: disabledBoldColor, size: 14),
                    SizedBox(width: spXs),
                    Text(
                      "Duration: ${training["duration"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "$completedModules/${modules.length} modules",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                
                Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: progress / 100,
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: warningColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingTraining() {
    List<Map<String, dynamic>> upcomingTraining = trainingRecords.where((r) => 
      r["status"] == "Scheduled").toList();
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Upcoming Training Sessions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ...upcomingTraining.map((training) => Container(
            padding: EdgeInsets.all(spSm),
            margin: EdgeInsets.only(bottom: spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: infoColor.withAlpha(20)),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Icon(Icons.schedule, color: infoColor, size: 16),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${training["course"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${training["employee"]} • ${training["startDate"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${training["duration"]}",
                      style: TextStyle(
                        color: infoColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "\$${(training["cost"] as double).toStringAsFixed(0)}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
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

  Widget _buildTrainingRecordsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildTrainingFilters(),
          _buildTrainingRecordsList(),
        ],
      ),
    );
  }

  Widget _buildTrainingFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Filter Training Records",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Employee",
                  items: employees,
                  value: selectedEmployee,
                  onChanged: (value, label) {
                    selectedEmployee = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Course",
                  items: courses,
                  value: selectedCourse,
                  onChanged: (value, label) {
                    selectedCourse = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          QDropdownField(
            label: "Status",
            items: statusOptions,
            value: selectedStatus,
            onChanged: (value, label) {
              selectedStatus = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTrainingRecordsList() {
    return Column(
      spacing: spSm,
      children: trainingRecords.map((record) => _buildTrainingRecordCard(record)).toList(),
    );
  }

  Widget _buildTrainingRecordCard(Map<String, dynamic> record) {
    Color statusColor = record["status"] == "Completed" ? successColor : 
                       record["status"] == "Overdue" ? dangerColor : 
                       record["status"] == "In Progress" ? warningColor : infoColor;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(Icons.school, color: statusColor, size: 24),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${record["course"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${record["status"]}",
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "ID: ${record["id"]} • ${record["employee"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Icon(Icons.person, color: primaryColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Instructor: ${record["instructor"]}",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.location_on, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${record["location"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Started: ${record["startDate"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    if (record["completionDate"].toString().isNotEmpty)
                      Row(
                        children: [
                          Text(" • ", style: TextStyle(color: disabledBoldColor)),
                          Text(
                            "Completed: ${record["completionDate"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),

          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 120,
            children: [
              _buildTrainingMetric("Duration", "${record["duration"]}", Icons.access_time),
              _buildTrainingMetric("Score", record["score"] > 0 ? "${record["score"]}" : "N/A", Icons.star),
              _buildTrainingMetric("Cost", "\$${(record["cost"] as double).toStringAsFixed(0)}", Icons.attach_money),
              _buildTrainingMetric("Modules", "${(record["modules"] as List).length}", Icons.list),
            ],
          ),

          if ((record["modules"] as List).isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Icon(Icons.list, color: infoColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "Training Modules",
                        style: TextStyle(
                          color: infoColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  ...((record["modules"] as List).map((module) => Padding(
                    padding: EdgeInsets.only(left: spMd),
                    child: Row(
                      children: [
                        Icon(
                          module["completed"] ? Icons.check_circle : Icons.radio_button_unchecked,
                          color: module["completed"] ? successColor : disabledBoldColor,
                          size: 14,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${module["name"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        if (module["completed"] && module["score"] > 0)
                          Text(
                            "${module["score"]}%",
                            style: TextStyle(
                              color: successColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                            ),
                          ),
                      ],
                    ),
                  )).toList()),
                ],
              ),
            ),

          if (record["certificateNumber"].toString().isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.card_membership, color: successColor, size: 16),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Certificate: ${record["certificateNumber"]}",
                      style: TextStyle(
                        color: successColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  if (record["expiryDate"].toString().isNotEmpty)
                    Text(
                      "Expires: ${record["expiryDate"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),

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
                icon: Icons.print,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              if (record["status"] == "In Progress")
                QButton(
                  icon: Icons.play_arrow,
                  size: bs.sm,
                  onPressed: () {},
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrainingMetric(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        children: [
          Icon(icon, color: disabledBoldColor, size: 16),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: primaryColor,
              fontSize: 11,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleTrainingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Schedule New Training",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),

                QTextField(
                  label: "Training Title",
                  value: trainingTitle,
                  hint: "Enter training course title",
                  onChanged: (value) {
                    trainingTitle = value;
                    setState(() {});
                  },
                ),

                QDropdownField(
                  label: "Course Type",
                  items: courses,
                  value: selectedCourse,
                  onChanged: (value, label) {
                    selectedCourse = value;
                    setState(() {});
                  },
                ),

                QDropdownField(
                  label: "Employee",
                  items: employees,
                  value: selectedEmployee,
                  onChanged: (value, label) {
                    selectedEmployee = value;
                    setState(() {});
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: QDatePicker(
                        label: "Training Date",
                        value: trainingDate.isNotEmpty ? DateTime.parse(trainingDate) : DateTime.now(),
                        onChanged: (value) {
                          trainingDate = value.toString().split(' ')[0];
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTextField(
                        label: "Duration",
                        value: trainingDuration,
                        hint: "e.g., 8 hours",
                        onChanged: (value) {
                          trainingDuration = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                QMemoField(
                  label: "Training Description",
                  value: trainingDescription,
                  hint: "Enter training objectives and content description",
                  onChanged: (value) {
                    trainingDescription = value;
                    setState(() {});
                  },
                ),

                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Schedule Training",
                    size: bs.md,
                    onPressed: () {
                      ss("Training session scheduled successfully!");
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificatesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildCertificatesSummary(),
          _buildActiveCertificates(),
          _buildExpiringCertificates(),
        ],
      ),
    );
  }

  Widget _buildCertificatesSummary() {
    List<Map<String, dynamic>> completedTraining = trainingRecords.where((r) => 
      r["status"] == "Completed" && r["certificateNumber"].toString().isNotEmpty).toList();
    
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildSummaryCard("Active Certificates", "${completedTraining.length}", Icons.card_membership, successColor),
        _buildSummaryCard("Expiring Soon", "2", Icons.warning, warningColor),
        _buildSummaryCard("Total Issued", "${completedTraining.length + 3}", Icons.verified, primaryColor),
        _buildSummaryCard("Renewal Rate", "85%", Icons.refresh, infoColor),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(icon, color: color, size: 32),
          ),
          SizedBox(height: spMd),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveCertificates() {
    List<Map<String, dynamic>> activeCertificates = trainingRecords.where((r) => 
      r["status"] == "Completed" && r["certificateNumber"].toString().isNotEmpty).toList();
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Active Certificates",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ...activeCertificates.map((cert) => Container(
            padding: EdgeInsets.all(spSm),
            margin: EdgeInsets.only(bottom: spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: successColor.withAlpha(20)),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Icon(Icons.card_membership, color: successColor, size: 20),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${cert["course"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${cert["employee"]} • ${cert["certificateNumber"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Score: ${cert["score"]}",
                      style: TextStyle(
                        color: successColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    if (cert["expiryDate"].toString().isNotEmpty)
                      Text(
                        "Expires: ${cert["expiryDate"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
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

  Widget _buildExpiringCertificates() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Expiring Certificates",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: warningColor.withAlpha(20)),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Icon(Icons.warning, color: warningColor, size: 16),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Commercial Driver License",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "John Smith • Expires: 2025-07-15",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: "Renew",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: warningColor.withAlpha(20)),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Icon(Icons.warning, color: warningColor, size: 16),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "First Aid Certification",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Maria Garcia • Expires: 2025-08-20",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: "Renew",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
