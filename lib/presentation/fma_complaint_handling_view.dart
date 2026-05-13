import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaComplaintHandlingView extends StatefulWidget {
  const FmaComplaintHandlingView({super.key});

  @override
  State<FmaComplaintHandlingView> createState() => _FmaComplaintHandlingViewState();
}

class _FmaComplaintHandlingViewState extends State<FmaComplaintHandlingView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedSeverity = "all";
  String selectedStatus = "all";

  List<Map<String, dynamic>> complaints = [
    {
      "id": "CMP001",
      "customer": "Michael Johnson",
      "subject": "Food Poisoning Incident",
      "severity": "Critical",
      "status": "Under Investigation",
      "date": "2024-06-19 08:30",
      "category": "Health & Safety",
      "description": "Customer reported food poisoning after eating chicken meal",
      "priority_score": 95,
      "expected_resolution": "24 hours",
      "assigned_to": "Health & Safety Team",
      "contact_method": "Phone",
      "compensation_requested": true,
      "follow_up_required": true
    },
    {
      "id": "CMP002",
      "customer": "Sarah Williams",
      "subject": "Rude Staff Behavior",
      "severity": "High",
      "status": "In Review",
      "date": "2024-06-19 12:15",
      "category": "Service",
      "description": "Customer experienced unprofessional behavior from delivery staff",
      "priority_score": 80,
      "expected_resolution": "48 hours",
      "assigned_to": "HR Department",
      "contact_method": "Email",
      "compensation_requested": false,
      "follow_up_required": true
    },
    {
      "id": "CMP003",
      "customer": "David Chen",
      "subject": "Wrong Order Delivered",
      "severity": "Medium",
      "status": "Resolved",
      "date": "2024-06-18 19:45",
      "category": "Order Fulfillment",
      "description": "Customer received completely different order than requested",
      "priority_score": 65,
      "expected_resolution": "4 hours",
      "assigned_to": "Operations Team",
      "contact_method": "Chat",
      "compensation_requested": true,
      "follow_up_required": false
    },
    {
      "id": "CMP004",
      "customer": "Lisa Rodriguez",
      "subject": "Late Delivery Issue",
      "severity": "Low",
      "status": "Acknowledged",
      "date": "2024-06-19 16:30",
      "category": "Delivery",
      "description": "Order arrived 2 hours late without notification",
      "priority_score": 45,
      "expected_resolution": "8 hours",
      "assigned_to": "Delivery Team",
      "contact_method": "SMS",
      "compensation_requested": false,
      "follow_up_required": true
    },
  ];

  List<Map<String, dynamic>> severityItems = [
    {"label": "All Severity", "value": "all"},
    {"label": "Critical", "value": "Critical"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "all"},
    {"label": "New", "value": "New"},
    {"label": "Acknowledged", "value": "Acknowledged"},
    {"label": "Under Investigation", "value": "Under Investigation"},
    {"label": "In Review", "value": "In Review"},
    {"label": "Resolved", "value": "Resolved"},
    {"label": "Closed", "value": "Closed"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Complaint Handling",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Active", icon: Icon(Icons.warning)),
        Tab(text: "Dashboard", icon: Icon(Icons.dashboard)),
        Tab(text: "Process", icon: Icon(Icons.assignment)),
      ],
      tabChildren: [
        _buildComplaintsTab(),
        _buildDashboardTab(),
        _buildProcessTab(),
      ],
    );
  }

  Widget _buildComplaintsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildComplaintsList(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search complaints...",
                value: searchQuery,
                hint: "Search by customer, subject, or complaint ID",
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
          spacing: spSm,
          children: [
            Expanded(
              child: QDropdownField(
                label: "Severity",
                items: severityItems,
                value: selectedSeverity,
                onChanged: (value, label) {
                  selectedSeverity = value;
                  setState(() {});
                },
              ),
            ),
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
          ],
        ),
      ],
    );
  }

  Widget _buildComplaintsList() {
    return Column(
      spacing: spSm,
      children: complaints.map((complaint) => _buildComplaintCard(complaint)).toList(),
    );
  }

  Widget _buildComplaintCard(Map<String, dynamic> complaint) {
    Color severityColor = _getSeverityColor("${complaint["severity"]}");
    Color statusColor = _getStatusColor("${complaint["status"]}");
    int priorityScore = complaint["priority_score"] as int;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: severityColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${complaint["id"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Row(
                spacing: spXs,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: severityColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${complaint["severity"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: severityColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${complaint["status"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            "${complaint["subject"]}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "${complaint["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${complaint["customer"]}",
                style: TextStyle(fontSize: 14, color: disabledBoldColor),
              ),
              Spacer(),
              Icon(Icons.category, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${complaint["category"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.schedule, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "ETA: ${complaint["expected_resolution"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getPriorityScoreColor(priorityScore).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "Score: $priorityScore",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getPriorityScoreColor(priorityScore),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.assignment_ind, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${complaint["assigned_to"]}",
                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                ),
              ),
              if (complaint["compensation_requested"] as bool)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "Compensation",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: warningColor,
                    ),
                  ),
                ),
            ],
          ),
          if (complaint["follow_up_required"] as bool)
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(Icons.follow_the_signs, size: 16, color: infoColor),
                  SizedBox(width: spXs),
                  Text(
                    "Follow-up required",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Take Action",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              QButton(
                icon: Icons.phone,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildMetricCard("Total Complaints", "142", Icons.warning, dangerColor),
              _buildMetricCard("Critical Issues", "8", Icons.priority_high, dangerColor),
              _buildMetricCard("Avg Resolution", "6.2h", Icons.schedule, warningColor),
              _buildMetricCard("Satisfaction", "92%", Icons.thumb_up, successColor),
            ],
          ),
          Container(
            width: double.infinity,
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
                Text(
                  "Complaint Categories",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildCategoryProgress("Health & Safety", 35, dangerColor),
                _buildCategoryProgress("Service Quality", 28, warningColor),
                _buildCategoryProgress("Order Issues", 22, infoColor),
                _buildCategoryProgress("Delivery Problems", 15, primaryColor),
              ],
            ),
          ),
          Container(
            width: double.infinity,
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
                Text(
                  "Resolution Timeline",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildTimelineItem("< 4 hours", 45, successColor),
                _buildTimelineItem("4-24 hours", 32, warningColor),
                _buildTimelineItem("1-3 days", 18, infoColor),
                _buildTimelineItem("> 3 days", 5, dangerColor),
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH3,
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
    );
  }

  Widget _buildCategoryProgress(String category, int percentage, Color color) {
    return Column(
      spacing: spXs,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(category, style: TextStyle(fontSize: 14)),
            Text("$percentage%", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          ],
        ),
        Container(
          height: 6,
          decoration: BoxDecoration(
            color: disabledColor,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: percentage / 100,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineItem(String timeframe, int percentage, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(timeframe, style: TextStyle(fontSize: 14)),
        ),
        Text(
          "$percentage%",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildProcessTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
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
                Text(
                  "Complaint Resolution Process",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildProcessStep(1, "Receive & Log", "Complaint received and logged in system", true),
                _buildProcessStep(2, "Acknowledge", "Customer notified within 2 hours", true),
                _buildProcessStep(3, "Investigate", "Gather facts and evidence", false),
                _buildProcessStep(4, "Analyze", "Determine root cause and responsibility", false),
                _buildProcessStep(5, "Resolve", "Implement solution and notify customer", false),
                _buildProcessStep(6, "Follow-up", "Ensure customer satisfaction", false),
              ],
            ),
          ),
          Container(
            width: double.infinity,
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
                Text(
                  "Escalation Matrix",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildEscalationLevel("Level 1", "Customer Service Rep", "0-2 hours", successColor),
                _buildEscalationLevel("Level 2", "Team Supervisor", "2-8 hours", warningColor),
                _buildEscalationLevel("Level 3", "Department Manager", "8-24 hours", infoColor),
                _buildEscalationLevel("Level 4", "Regional Director", "24+ hours", dangerColor),
              ],
            ),
          ),
          Container(
            width: double.infinity,
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
                Text(
                  "Standard Response Times",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildResponseTime("Critical", "1 hour", "24 hours", dangerColor),
                _buildResponseTime("High", "4 hours", "48 hours", warningColor),
                _buildResponseTime("Medium", "8 hours", "72 hours", infoColor),
                _buildResponseTime("Low", "24 hours", "1 week", successColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessStep(int step, String title, String description, bool completed) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: completed ? successColor : disabledColor,
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Center(
            child: completed
                ? Icon(Icons.check, color: Colors.white, size: 16)
                : Text(
                    "$step",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEscalationLevel(String level, String role, String timeframe, Color color) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        border: Border.all(color: color.withAlpha(50)),
        borderRadius: BorderRadius.circular(radiusXs),
        color: color.withAlpha(10),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  level,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  role,
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  timeframe,
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
    );
  }

  Widget _buildResponseTime(String severity, String acknowledge, String resolve, Color color) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              severity,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Acknowledge: $acknowledge",
                  style: TextStyle(fontSize: 13),
                ),
                Text(
                  "Resolve: $resolve",
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return primaryColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "New":
        return dangerColor;
      case "Acknowledged":
        return warningColor;
      case "Under Investigation":
        return infoColor;
      case "In Review":
        return primaryColor;
      case "Resolved":
        return successColor;
      case "Closed":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  Color _getPriorityScoreColor(int score) {
    if (score >= 90) return dangerColor;
    if (score >= 70) return warningColor;
    if (score >= 50) return infoColor;
    return successColor;
  }
}
