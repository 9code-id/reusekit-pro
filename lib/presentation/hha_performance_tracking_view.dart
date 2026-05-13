import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaPerformanceTrackingView extends StatefulWidget {
  const HhaPerformanceTrackingView({super.key});

  @override
  State<HhaPerformanceTrackingView> createState() => _HhaPerformanceTrackingViewState();
}

class _HhaPerformanceTrackingViewState extends State<HhaPerformanceTrackingView> {
  int currentTab = 0;
  String searchQuery = "";
  String departmentFilter = "all";
  String periodFilter = "current_month";

  List<Map<String, dynamic>> performanceData = [
    {
      "id": "PERF001",
      "employeeId": "EMP001",
      "employeeName": "John Smith",
      "department": "front_desk",
      "position": "Receptionist",
      "reviewPeriod": "2024-01",
      "overallScore": 88.5,
      "customerSatisfaction": 92.0,
      "punctuality": 95.0,
      "productivity": 85.0,
      "teamwork": 90.0,
      "communication": 87.0,
      "problemSolving": 83.0,
      "attendance": 98.0,
      "goalsAchieved": 7,
      "totalGoals": 10,
      "feedback": "Excellent customer service skills. Needs improvement in problem-solving scenarios.",
      "strengths": ["Customer service", "Punctuality", "Team collaboration"],
      "areasForImprovement": ["Problem solving", "Technical skills"],
      "status": "reviewed",
      "reviewDate": "2024-01-15",
      "nextReviewDate": "2024-04-15",
    },
    {
      "id": "PERF002",
      "employeeId": "EMP002",
      "employeeName": "Sarah Johnson",
      "department": "housekeeping",
      "position": "Housekeeper",
      "reviewPeriod": "2024-01",
      "overallScore": 92.3,
      "customerSatisfaction": 94.0,
      "punctuality": 88.0,
      "productivity": 96.0,
      "teamwork": 91.0,
      "communication": 89.0,
      "problemSolving": 90.0,
      "attendance": 85.0,
      "goalsAchieved": 9,
      "totalGoals": 10,
      "feedback": "Outstanding performance in all areas. Occasionally late but work quality is exceptional.",
      "strengths": ["Quality work", "Productivity", "Customer satisfaction"],
      "areasForImprovement": ["Punctuality", "Attendance"],
      "status": "reviewed",
      "reviewDate": "2024-01-12",
      "nextReviewDate": "2024-04-12",
    },
    {
      "id": "PERF003",
      "employeeId": "EMP003",
      "employeeName": "Maria Garcia",
      "department": "kitchen",
      "position": "Chef",
      "reviewPeriod": "2024-01",
      "overallScore": 95.7,
      "customerSatisfaction": 98.0,
      "punctuality": 92.0,
      "productivity": 97.0,
      "teamwork": 94.0,
      "communication": 96.0,
      "problemSolving": 98.0,
      "attendance": 94.0,
      "goalsAchieved": 10,
      "totalGoals": 10,
      "feedback": "Exceptional performance across all metrics. Natural leader in the kitchen.",
      "strengths": ["Leadership", "Culinary skills", "Problem solving", "Customer satisfaction"],
      "areasForImprovement": ["None significant"],
      "status": "reviewed",
      "reviewDate": "2024-01-10",
      "nextReviewDate": "2024-04-10",
    },
    {
      "id": "PERF004",
      "employeeId": "EMP004",
      "employeeName": "Mike Johnson",
      "department": "security",
      "position": "Security Guard",
      "reviewPeriod": "2024-01",
      "overallScore": 78.2,
      "customerSatisfaction": 80.0,
      "punctuality": 85.0,
      "productivity": 75.0,
      "teamwork": 70.0,
      "communication": 82.0,
      "problemSolving": 78.0,
      "attendance": 90.0,
      "goalsAchieved": 6,
      "totalGoals": 10,
      "feedback": "Adequate performance. Needs improvement in teamwork and productivity.",
      "strengths": ["Reliability", "Communication"],
      "areasForImprovement": ["Teamwork", "Productivity", "Initiative"],
      "status": "pending",
      "reviewDate": "",
      "nextReviewDate": "2024-01-20",
    },
    {
      "id": "PERF005",
      "employeeId": "EMP005",
      "employeeName": "David Wilson",
      "department": "maintenance",
      "position": "Maintenance Tech",
      "reviewPeriod": "2024-01",
      "overallScore": 86.8,
      "customerSatisfaction": 88.0,
      "punctuality": 90.0,
      "productivity": 92.0,
      "teamwork": 85.0,
      "communication": 80.0,
      "problemSolving": 95.0,
      "attendance": 88.0,
      "goalsAchieved": 8,
      "totalGoals": 10,
      "feedback": "Strong technical skills and problem-solving abilities. Could improve communication.",
      "strengths": ["Technical expertise", "Problem solving", "Productivity"],
      "areasForImprovement": ["Communication", "Documentation"],
      "status": "in_progress",
      "reviewDate": "",
      "nextReviewDate": "2024-01-25",
    },
  ];

  List<Map<String, dynamic>> goals = [
    {
      "id": "GOAL001",
      "employeeId": "EMP001",
      "title": "Improve Guest Check-in Time",
      "description": "Reduce average check-in time to under 3 minutes",
      "targetValue": 3.0,
      "currentValue": 4.2,
      "unit": "minutes",
      "deadline": "2024-03-31",
      "status": "in_progress",
      "progress": 65.0,
    },
    {
      "id": "GOAL002",
      "employeeId": "EMP001",
      "title": "Customer Satisfaction Score",
      "description": "Maintain customer satisfaction above 90%",
      "targetValue": 90.0,
      "currentValue": 92.0,
      "unit": "%",
      "deadline": "2024-06-30",
      "status": "achieved",
      "progress": 100.0,
    },
    {
      "id": "GOAL003",
      "employeeId": "EMP002",
      "title": "Room Cleaning Efficiency",
      "description": "Clean 12 rooms per day with quality standards",
      "targetValue": 12.0,
      "currentValue": 11.5,
      "unit": "rooms",
      "deadline": "2024-02-29",
      "status": "in_progress",
      "progress": 85.0,
    },
    {
      "id": "GOAL004",
      "employeeId": "EMP003",
      "title": "Menu Innovation",
      "description": "Introduce 5 new seasonal dishes",
      "targetValue": 5.0,
      "currentValue": 5.0,
      "unit": "dishes",
      "deadline": "2024-02-15",
      "status": "achieved",
      "progress": 100.0,
    },
  ];

  List<Map<String, dynamic>> departmentItems = [
    {"label": "All Departments", "value": "all"},
    {"label": "Front Desk", "value": "front_desk"},
    {"label": "Housekeeping", "value": "housekeeping"},
    {"label": "Kitchen", "value": "kitchen"},
    {"label": "Security", "value": "security"},
    {"label": "Maintenance", "value": "maintenance"},
  ];

  List<Map<String, dynamic>> periodItems = [
    {"label": "Current Month", "value": "current_month"},
    {"label": "Last Month", "value": "last_month"},
    {"label": "Current Quarter", "value": "current_quarter"},
    {"label": "Last Quarter", "value": "last_quarter"},
    {"label": "Year to Date", "value": "ytd"},
  ];

  // Performance form fields
  String selectedEmployeeId = "";
  double customerSatisfactionScore = 0.0;
  double punctualityScore = 0.0;
  double productivityScore = 0.0;
  double teamworkScore = 0.0;
  double communicationScore = 0.0;
  double problemSolvingScore = 0.0;
  double attendanceScore = 0.0;
  String performanceFeedback = "";
  String performanceStrengths = "";
  String performanceAreas = "";

  List<Map<String, dynamic>> get filteredPerformance {
    return performanceData.where((performance) {
      bool matchesSearch = performance["employeeName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          performance["employeeId"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          performance["position"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesDepartment = departmentFilter == "all" || performance["department"] == departmentFilter;
      return matchesSearch && matchesDepartment;
    }).toList();
  }

  double get averagePerformanceScore {
    if (filteredPerformance.isEmpty) return 0.0;
    return filteredPerformance.fold(0.0, (sum, perf) => sum + (perf["overallScore"] as double)) / filteredPerformance.length;
  }

  int get highPerformers => filteredPerformance.where((p) => (p["overallScore"] as double) >= 90).length;
  int get averagePerformers => filteredPerformance.where((p) => (p["overallScore"] as double) >= 70 && (p["overallScore"] as double) < 90).length;
  int get lowPerformers => filteredPerformance.where((p) => (p["overallScore"] as double) < 70).length;

  int get completedReviews => filteredPerformance.where((p) => p["status"] == "reviewed").length;
  int get pendingReviews => filteredPerformance.where((p) => p["status"] == "pending").length;

  void _submitPerformanceReview() {
    if (selectedEmployeeId.isNotEmpty && performanceFeedback.isNotEmpty) {
      final overallScore = (customerSatisfactionScore + punctualityScore + productivityScore + 
                          teamworkScore + communicationScore + problemSolvingScore + attendanceScore) / 7;
      
      final newPerformance = {
        "id": "PERF${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}",
        "employeeId": selectedEmployeeId,
        "employeeName": "Selected Employee", // In real app, get from employee list
        "department": "front_desk", // In real app, get from employee list
        "position": "Staff", // In real app, get from employee list
        "reviewPeriod": "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}",
        "overallScore": overallScore,
        "customerSatisfaction": customerSatisfactionScore,
        "punctuality": punctualityScore,
        "productivity": productivityScore,
        "teamwork": teamworkScore,
        "communication": communicationScore,
        "problemSolving": problemSolvingScore,
        "attendance": attendanceScore,
        "goalsAchieved": 0,
        "totalGoals": 0,
        "feedback": performanceFeedback,
        "strengths": performanceStrengths.split(',').map((s) => s.trim()).toList(),
        "areasForImprovement": performanceAreas.split(',').map((s) => s.trim()).toList(),
        "status": "reviewed",
        "reviewDate": DateTime.now().toString().split(' ')[0],
        "nextReviewDate": DateTime.now().add(Duration(days: 90)).toString().split(' ')[0],
      };

      performanceData.add(newPerformance);
      
      // Reset form
      selectedEmployeeId = "";
      customerSatisfactionScore = 0.0;
      punctualityScore = 0.0;
      productivityScore = 0.0;
      teamworkScore = 0.0;
      communicationScore = 0.0;
      problemSolvingScore = 0.0;
      attendanceScore = 0.0;
      performanceFeedback = "";
      performanceStrengths = "";
      performanceAreas = "";
      
      setState(() {});
      ss("Performance review submitted successfully");
    }
  }

  Color _getPerformanceColor(double score) {
    if (score >= 90) return successColor;
    if (score >= 80) return primaryColor;
    if (score >= 70) return warningColor;
    return dangerColor;
  }

  String _getPerformanceLevel(double score) {
    if (score >= 90) return "Excellent";
    if (score >= 80) return "Good";
    if (score >= 70) return "Average";
    return "Needs Improvement";
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Performance Tracking",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Performance Overview", icon: Icon(Icons.trending_up)),
        Tab(text: "Performance Review", icon: Icon(Icons.rate_review)),
        Tab(text: "Goals & Targets", icon: Icon(Icons.flag)),
      ],
      tabChildren: [
        _buildPerformanceOverviewTab(),
        _buildPerformanceReviewTab(),
        _buildGoalsTargetsTab(),
      ],
    );
  }

  Widget _buildPerformanceOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Summary Cards
          Row(
            children: [
              Expanded(
                child: Container(
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
                        "Average Score",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${averagePerformanceScore.toStringAsFixed(1)}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: _getPerformanceColor(averagePerformanceScore),
                        ),
                      ),
                      Text(
                        _getPerformanceLevel(averagePerformanceScore),
                        style: TextStyle(
                          fontSize: 12,
                          color: _getPerformanceColor(averagePerformanceScore),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
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
                        "High Performers",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "$highPerformers",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "90%+ Score",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: Container(
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
                        "Pending Reviews",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "$pendingReviews",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Need Review",
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
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
                        "Completed Reviews",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "$completedReviews",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "This Period",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Filters
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search employees...",
                  value: searchQuery,
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
                onPressed: () {},
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Department",
                  items: departmentItems,
                  value: departmentFilter,
                  onChanged: (value, label) {
                    departmentFilter = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Period",
                  items: periodItems,
                  value: periodFilter,
                  onChanged: (value, label) {
                    periodFilter = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Performance Distribution
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
                  "Performance Distribution",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "$highPerformers",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Excellent",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "90%+",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "$averagePerformers",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Average",
                              style: TextStyle(
                                fontSize: 12,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "70-89%",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "$lowPerformers",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "Low",
                              style: TextStyle(
                                fontSize: 12,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "<70%",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Performance List
          Text(
            "Employee Performance (${filteredPerformance.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: filteredPerformance.length,
            itemBuilder: (context, index) {
              final performance = filteredPerformance[index];
              Color performanceColor = _getPerformanceColor(performance["overallScore"] as double);
              Color statusColor = performance["status"] == "reviewed" ? successColor :
                  performance["status"] == "in_progress" ? warningColor : dangerColor;

              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: performanceColor,
                    ),
                  ),
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
                              Text(
                                "${performance["employeeName"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${performance["position"]} • ${performance["department"]}".replaceAll('_', ' ').toUpperCase(),
                                style: TextStyle(
                                  fontSize: 14,
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
                              "${(performance["overallScore"] as double).toStringAsFixed(1)}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: performanceColor,
                              ),
                            ),
                            Text(
                              _getPerformanceLevel(performance["overallScore"] as double),
                              style: TextStyle(
                                fontSize: 12,
                                color: performanceColor,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: statusColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${performance["status"]}".replaceAll('_', ' ').toUpperCase(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Performance Metrics
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: performanceColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Expanded(child: Text("Customer Satisfaction:", style: TextStyle(fontSize: 12, color: disabledBoldColor))),
                              Text("${(performance["customerSatisfaction"] as double).toStringAsFixed(1)}%", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: Text("Productivity:", style: TextStyle(fontSize: 12, color: disabledBoldColor))),
                              Text("${(performance["productivity"] as double).toStringAsFixed(1)}%", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: Text("Teamwork:", style: TextStyle(fontSize: 12, color: disabledBoldColor))),
                              Text("${(performance["teamwork"] as double).toStringAsFixed(1)}%", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: Text("Goals Achieved:", style: TextStyle(fontSize: 12, color: disabledBoldColor))),
                              Text("${performance["goalsAchieved"]}/${performance["totalGoals"]}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Feedback
                    if (performance["feedback"].toString().isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "Feedback:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "${performance["feedback"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Next Review Date
                    if (performance["nextReviewDate"].toString().isNotEmpty)
                      Text(
                        "Next Review: ${performance["nextReviewDate"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceReviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Performance Review",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
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
              spacing: spMd,
              children: [
                Text(
                  "Employee Selection",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                QDropdownField(
                  label: "Select Employee",
                  items: [
                    {"label": "John Smith - Receptionist", "value": "EMP001"},
                    {"label": "Sarah Johnson - Housekeeper", "value": "EMP002"},
                    {"label": "Maria Garcia - Chef", "value": "EMP003"},
                    {"label": "Mike Johnson - Security Guard", "value": "EMP004"},
                    {"label": "David Wilson - Maintenance Tech", "value": "EMP005"},
                  ],
                  value: selectedEmployeeId.isNotEmpty ? selectedEmployeeId : "EMP001",
                  onChanged: (value, label) {
                    selectedEmployeeId = value;
                    setState(() {});
                  },
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
              spacing: spMd,
              children: [
                Text(
                  "Performance Metrics (0-100)",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Customer Satisfaction",
                        value: customerSatisfactionScore.toString(),
                        onChanged: (value) {
                          customerSatisfactionScore = double.tryParse(value) ?? 0.0;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QNumberField(
                        label: "Punctuality",
                        value: punctualityScore.toString(),
                        onChanged: (value) {
                          punctualityScore = double.tryParse(value) ?? 0.0;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Productivity",
                        value: productivityScore.toString(),
                        onChanged: (value) {
                          productivityScore = double.tryParse(value) ?? 0.0;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QNumberField(
                        label: "Teamwork",
                        value: teamworkScore.toString(),
                        onChanged: (value) {
                          teamworkScore = double.tryParse(value) ?? 0.0;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Communication",
                        value: communicationScore.toString(),
                        onChanged: (value) {
                          communicationScore = double.tryParse(value) ?? 0.0;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QNumberField(
                        label: "Problem Solving",
                        value: problemSolvingScore.toString(),
                        onChanged: (value) {
                          problemSolvingScore = double.tryParse(value) ?? 0.0;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                QNumberField(
                  label: "Attendance",
                  value: attendanceScore.toString(),
                  onChanged: (value) {
                    attendanceScore = double.tryParse(value) ?? 0.0;
                    setState(() {});
                  },
                ),

                // Overall Score Preview
                if (customerSatisfactionScore > 0)
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: primaryColor),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Overall Score",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          "${((customerSatisfactionScore + punctualityScore + productivityScore + teamworkScore + communicationScore + problemSolvingScore + attendanceScore) / 7).toStringAsFixed(1)}",
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
              spacing: spMd,
              children: [
                Text(
                  "Feedback & Comments",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                QMemoField(
                  label: "Overall Feedback",
                  value: performanceFeedback,
                  onChanged: (value) {
                    performanceFeedback = value;
                    setState(() {});
                  },
                ),

                QTextField(
                  label: "Strengths (comma separated)",
                  value: performanceStrengths,
                  onChanged: (value) {
                    performanceStrengths = value;
                    setState(() {});
                  },
                ),

                QTextField(
                  label: "Areas for Improvement (comma separated)",
                  value: performanceAreas,
                  onChanged: (value) {
                    performanceAreas = value;
                    setState(() {});
                  },
                ),

                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Submit Performance Review",
                    size: bs.md,
                    onPressed: _submitPerformanceReview,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalsTargetsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Goals & Targets",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Goals Summary
          Row(
            children: [
              Expanded(
                child: Container(
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
                        "Total Goals",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${goals.length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
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
                        "Achieved",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${goals.where((g) => g["status"] == "achieved").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Goals List
          Text(
            "Employee Goals",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: goals.length,
            itemBuilder: (context, index) {
              final goal = goals[index];
              Color statusColor = goal["status"] == "achieved" ? successColor :
                  goal["status"] == "in_progress" ? warningColor : dangerColor;

              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: statusColor,
                    ),
                  ),
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
                              Text(
                                "${goal["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${goal["description"]}",
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
                            color: statusColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${goal["status"]}".replaceAll('_', ' ').toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Progress Bar
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Progress: ${(goal["progress"] as double).toStringAsFixed(0)}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                            Text(
                              "${goal["currentValue"]} / ${goal["targetValue"]} ${goal["unit"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: (goal["progress"] as double) / 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: statusColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Text(
                      "Deadline: ${goal["deadline"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          // Goal Statistics
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
                  "Goal Achievement Statistics",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Achievement Rate",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${((goals.where((g) => g["status"] == "achieved").length / goals.length) * 100).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: disabledOutlineBorderColor,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "In Progress",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${goals.where((g) => g["status"] == "in_progress").length}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: disabledOutlineBorderColor,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Average Progress",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${(goals.fold(0.0, (sum, goal) => sum + (goal["progress"] as double)) / goals.length).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: fsH5,
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
        ],
      ),
    );
  }
}
