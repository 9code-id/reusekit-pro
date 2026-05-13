import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmScheduleOptimizationView extends StatefulWidget {
  const FsmScheduleOptimizationView({super.key});

  @override
  State<FsmScheduleOptimizationView> createState() => _FsmScheduleOptimizationViewState();
}

class _FsmScheduleOptimizationViewState extends State<FsmScheduleOptimizationView> {
  List<Map<String, dynamic>> scheduleData = [
    {
      "id": "1",
      "technician": "John Smith",
      "efficiency": 92,
      "hoursWorked": 8.5,
      "jobsCompleted": 4,
      "travelTime": 1.2,
      "utilization": 89,
      "jobs": [
        {"title": "HVAC Repair", "duration": 2.5, "priority": "High", "location": "Downtown", "status": "Completed"},
        {"title": "Electrical Check", "duration": 1.5, "priority": "Medium", "location": "Midtown", "status": "Completed"},
        {"title": "Plumbing Fix", "duration": 3.0, "priority": "High", "location": "Uptown", "status": "Completed"},
        {"title": "Maintenance", "duration": 1.5, "priority": "Low", "location": "Downtown", "status": "Completed"}
      ]
    },
    {
      "id": "2",
      "technician": "Sarah Johnson",
      "efficiency": 87,
      "hoursWorked": 7.8,
      "jobsCompleted": 3,
      "travelTime": 1.8,
      "utilization": 85,
      "jobs": [
        {"title": "System Installation", "duration": 4.0, "priority": "High", "location": "Industrial", "status": "In Progress"},
        {"title": "Safety Inspection", "duration": 2.0, "priority": "Medium", "location": "Commercial", "status": "Completed"},
        {"title": "Repair Work", "duration": 1.8, "priority": "Medium", "location": "Residential", "status": "Scheduled"}
      ]
    },
    {
      "id": "3",
      "technician": "Mike Davis",
      "efficiency": 95,
      "hoursWorked": 8.0,
      "jobsCompleted": 5,
      "travelTime": 0.8,
      "utilization": 94,
      "jobs": [
        {"title": "Emergency Call", "duration": 1.0, "priority": "Critical", "location": "Hospital", "status": "Completed"},
        {"title": "Routine Check", "duration": 1.5, "priority": "Low", "location": "Office", "status": "Completed"},
        {"title": "Installation", "duration": 2.5, "priority": "High", "location": "Factory", "status": "Completed"},
        {"title": "Maintenance", "duration": 2.0, "priority": "Medium", "location": "School", "status": "Completed"},
        {"title": "Repair", "duration": 1.0, "priority": "Medium", "location": "Clinic", "status": "Completed"}
      ]
    }
  ];

  List<Map<String, dynamic>> optimizationSuggestions = [
    {
      "type": "Route Optimization",
      "description": "Reorder Sarah's afternoon jobs to reduce travel time by 25 minutes",
      "impact": "High",
      "savings": "0.4 hours",
      "technician": "Sarah Johnson"
    },
    {
      "type": "Load Balancing",
      "description": "Transfer one job from Mike to John to balance workload",
      "impact": "Medium",
      "savings": "Better utilization",
      "technician": "John Smith"
    },
    {
      "type": "Skill Matching",
      "description": "Assign electrical jobs to Sarah for higher efficiency",
      "impact": "High",
      "savings": "15% efficiency boost",
      "technician": "Sarah Johnson"
    },
    {
      "type": "Time Slot",
      "description": "Move maintenance jobs to off-peak hours for cost savings",
      "impact": "Medium",
      "savings": "12% cost reduction",
      "technician": "All"
    }
  ];

  bool showOptimizationDialog = false;
  Map<String, dynamic>? selectedSuggestion;
  String selectedFilter = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schedule Optimization"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Schedule optimization refreshed");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildOptimizationSummary(),
            _buildFilterSection(),
            _buildTechnicianPerformance(),
            _buildOptimizationSuggestions(),
            if (showOptimizationDialog) _buildOptimizationDialog(),
          ],
        ),
      ),
    );
  }

  Widget _buildOptimizationSummary() {
    double avgEfficiency = scheduleData.fold(0.0, (sum, tech) => sum + (tech["efficiency"] as int)) / scheduleData.length;
    double totalHours = scheduleData.fold(0.0, (sum, tech) => sum + (tech["hoursWorked"] as double));
    int totalJobs = scheduleData.fold(0, (sum, tech) => sum + (tech["jobsCompleted"] as int));
    double avgUtilization = scheduleData.fold(0.0, (sum, tech) => sum + (tech["utilization"] as int)) / scheduleData.length;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Optimization Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            spacing: spSm,
            children: [
              _buildSummaryCard("Avg Efficiency", "${avgEfficiency.toStringAsFixed(1)}%", successColor),
              _buildSummaryCard("Total Hours", "${totalHours.toStringAsFixed(1)}h", infoColor),
              _buildSummaryCard("Jobs Completed", "$totalJobs", warningColor),
              _buildSummaryCard("Utilization", "${avgUtilization.toStringAsFixed(1)}%", primaryColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: color.withAlpha(30)),
        ),
        child: Column(
          spacing: spXs,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
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
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Icon(Icons.filter_list, color: primaryColor),
          SizedBox(width: spSm),
          Text(
            "Filter:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: QDropdownField(
              label: "Performance Filter",
              items: [
                {"label": "All Technicians", "value": "All"},
                {"label": "High Performers", "value": "High"},
                {"label": "Need Improvement", "value": "Low"},
                {"label": "Optimization Potential", "value": "Potential"},
              ],
              value: selectedFilter,
              onChanged: (value, label) {
                selectedFilter = value;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechnicianPerformance() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Technician Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spSm,
            children: scheduleData.map((techData) => _buildTechnicianCard(techData)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTechnicianCard(Map<String, dynamic> techData) {
    int efficiency = techData["efficiency"] as int;
    double utilization = (techData["utilization"] as int).toDouble();
    
    Color efficiencyColor = efficiency >= 90 ? successColor :
                           efficiency >= 80 ? warningColor : dangerColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 4,
            color: efficiencyColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${techData["technician"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${techData["jobsCompleted"]} jobs • ${(techData["hoursWorked"] as double).toStringAsFixed(1)}h worked",
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
                spacing: spXs,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: efficiencyColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${efficiency}% Efficiency",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: efficiencyColor,
                      ),
                    ),
                  ),
                  Text(
                    "Travel: ${(techData["travelTime"] as double).toStringAsFixed(1)}h",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Utilization Progress Bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spXs,
            children: [
              Row(
                children: [
                  Text(
                    "Utilization: ${utilization.toStringAsFixed(0)}%",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    utilization >= 90 ? "Optimal" : utilization >= 75 ? "Good" : "Can Improve",
                    style: TextStyle(
                      fontSize: 12,
                      color: utilization >= 90 ? successColor : utilization >= 75 ? warningColor : dangerColor,
                    ),
                  ),
                ],
              ),
              LinearProgressIndicator(
                value: utilization / 100,
                backgroundColor: disabledColor,
                valueColor: AlwaysStoppedAnimation<Color>(
                  utilization >= 90 ? successColor : utilization >= 75 ? warningColor : dangerColor
                ),
              ),
            ],
          ),
          // Job Details
          ExpansionTile(
            title: Text(
              "Job Details (${(techData["jobs"] as List).length})",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            children: [
              Column(
                spacing: spXs,
                children: (techData["jobs"] as List<Map<String, dynamic>>).map((job) => 
                  _buildJobRow(job)).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildJobRow(Map<String, dynamic> job) {
    Color statusColor = job["status"] == "Completed" ? successColor :
                       job["status"] == "In Progress" ? infoColor : warningColor;

    Color priorityColor = job["priority"] == "Critical" ? dangerColor :
                         job["priority"] == "High" ? warningColor :
                         job["priority"] == "Medium" ? infoColor : successColor;

    return Container(
      padding: EdgeInsets.all(spXs),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2,
              children: [
                Text(
                  "${job["title"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${job["location"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${job["duration"]}h",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
            decoration: BoxDecoration(
              color: priorityColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${job["priority"]}",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: priorityColor,
              ),
            ),
          ),
          SizedBox(width: spXs),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${job["status"]}",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptimizationSuggestions() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Text(
                "Optimization Suggestions",
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
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${optimizationSuggestions.length} suggestions",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: warningColor,
                  ),
                ),
              ),
            ],
          ),
          Column(
            spacing: spSm,
            children: optimizationSuggestions.map((suggestion) => 
              _buildSuggestionCard(suggestion)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionCard(Map<String, dynamic> suggestion) {
    Color impactColor = suggestion["impact"] == "High" ? dangerColor :
                       suggestion["impact"] == "Medium" ? warningColor : successColor;

    return GestureDetector(
      onTap: () {
        selectedSuggestion = suggestion;
        showOptimizationDialog = true;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border(
            left: BorderSide(
              width: 4,
              color: impactColor,
            ),
          ),
        ),
        child: Column(
          spacing: spSm,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "${suggestion["type"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${suggestion["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Affects: ${suggestion["technician"]}",
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
                  spacing: spXs,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: impactColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${suggestion["impact"]} Impact",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: impactColor,
                        ),
                      ),
                    ),
                    Text(
                      "Saves: ${suggestion["savings"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Spacer(),
                GestureDetector(
                  onTap: () {
                    selectedSuggestion = suggestion;
                    showOptimizationDialog = true;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "Apply",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptimizationDialog() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Text(
                "Apply Optimization",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  showOptimizationDialog = false;
                  selectedSuggestion = null;
                  setState(() {});
                },
                child: Icon(Icons.close, color: disabledBoldColor),
              ),
            ],
          ),
          if (selectedSuggestion != null) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Text(
                    "${selectedSuggestion!["type"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${selectedSuggestion!["description"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Expected Savings: ",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${selectedSuggestion!["savings"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            QMemoField(
              label: "Additional Notes",
              value: "",
              onChanged: (value) {},
            ),
          ],
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Cancel",
                  color: disabledBoldColor,
                  size: bs.sm,
                  onPressed: () {
                    showOptimizationDialog = false;
                    selectedSuggestion = null;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Apply Changes",
                  size: bs.sm,
                  onPressed: () {
                    ss("Optimization applied successfully");
                    showOptimizationDialog = false;
                    selectedSuggestion = null;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
