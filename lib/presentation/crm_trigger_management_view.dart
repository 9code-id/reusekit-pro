import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmTriggerManagementView extends StatefulWidget {
  const CrmTriggerManagementView({super.key});

  @override
  State<CrmTriggerManagementView> createState() => _CrmTriggerManagementViewState();
}

class _CrmTriggerManagementViewState extends State<CrmTriggerManagementView> {
  String selectedTriggerType = "All";
  String selectedStatus = "All";
  String searchQuery = "";
  String triggerName = "";
  String triggerDescription = "";
  String eventType = "Contact Created";
  String conditionField = "Lead Source";
  String conditionOperator = "equals";
  String conditionValue = "";
  bool isActive = true;

  List<Map<String, dynamic>> triggerTypes = [
    {"label": "All", "value": "All"},
    {"label": "Contact Event", "value": "Contact Event"},
    {"label": "Deal Event", "value": "Deal Event"},
    {"label": "Email Event", "value": "Email Event"},
    {"label": "Time-based", "value": "Time-based"},
    {"label": "Form Event", "value": "Form Event"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Inactive", "value": "Inactive"},
  ];

  List<Map<String, dynamic>> eventTypes = [
    {"label": "Contact Created", "value": "Contact Created"},
    {"label": "Contact Updated", "value": "Contact Updated"},
    {"label": "Deal Created", "value": "Deal Created"},
    {"label": "Deal Stage Changed", "value": "Deal Stage Changed"},
    {"label": "Email Opened", "value": "Email Opened"},
    {"label": "Email Clicked", "value": "Email Clicked"},
    {"label": "Form Submitted", "value": "Form Submitted"},
    {"label": "Date/Time", "value": "Date/Time"},
  ];

  List<Map<String, dynamic>> conditionFields = [
    {"label": "Lead Source", "value": "Lead Source"},
    {"label": "Contact Type", "value": "Contact Type"},
    {"label": "Industry", "value": "Industry"},
    {"label": "Company Size", "value": "Company Size"},
    {"label": "Email Domain", "value": "Email Domain"},
    {"label": "Deal Value", "value": "Deal Value"},
    {"label": "Deal Stage", "value": "Deal Stage"},
  ];

  List<Map<String, dynamic>> operators = [
    {"label": "equals", "value": "equals"},
    {"label": "not equals", "value": "not equals"},
    {"label": "contains", "value": "contains"},
    {"label": "starts with", "value": "starts with"},
    {"label": "greater than", "value": "greater than"},
    {"label": "less than", "value": "less than"},
  ];

  List<Map<String, dynamic>> triggers = [
    {
      "id": "TRG001",
      "name": "New Website Lead",
      "type": "Contact Event",
      "event": "Contact Created",
      "status": "Active",
      "conditions": 2,
      "executions": 1245,
      "success_rate": 98.2,
      "last_triggered": "2024-06-18 14:30",
      "created_date": "2024-01-15",
    },
    {
      "id": "TRG002",
      "name": "Deal Won Celebration",
      "type": "Deal Event",
      "event": "Deal Stage Changed",
      "status": "Active",
      "conditions": 1,
      "executions": 87,
      "success_rate": 100.0,
      "last_triggered": "2024-06-18 11:15",
      "created_date": "2024-02-20",
    },
    {
      "id": "TRG003",
      "name": "Email Engagement Follow-up",
      "type": "Email Event",
      "event": "Email Opened",
      "status": "Active",
      "conditions": 3,
      "executions": 567,
      "success_rate": 89.5,
      "last_triggered": "2024-06-18 16:45",
      "created_date": "2024-03-10",
    },
    {
      "id": "TRG004",
      "name": "Weekly Newsletter",
      "type": "Time-based",
      "event": "Date/Time",
      "status": "Active",
      "conditions": 0,
      "executions": 24,
      "success_rate": 95.8,
      "last_triggered": "2024-06-17 09:00",
      "created_date": "2024-04-01",
    },
    {
      "id": "TRG005",
      "name": "Demo Request Handler",
      "type": "Form Event",
      "event": "Form Submitted",
      "status": "Inactive",
      "conditions": 1,
      "executions": 0,
      "success_rate": 0.0,
      "last_triggered": "Never",
      "created_date": "2024-06-15",
    },
  ];

  List<Map<String, dynamic>> recentExecutions = [
    {
      "trigger_name": "New Website Lead",
      "contact": "John Smith",
      "status": "Success",
      "action": "Send Welcome Email",
      "execution_time": "2024-06-18 14:30:15",
      "duration": "0.8s",
    },
    {
      "trigger_name": "Deal Won Celebration",
      "contact": "Sarah Johnson",
      "status": "Success",
      "action": "Create Follow-up Task",
      "execution_time": "2024-06-18 11:15:42",
      "duration": "1.2s",
    },
    {
      "trigger_name": "Email Engagement Follow-up",
      "contact": "Mike Davis",
      "status": "Failed",
      "action": "Update Contact Score",
      "execution_time": "2024-06-18 16:45:23",
      "duration": "0.5s",
    },
    {
      "trigger_name": "New Website Lead",
      "contact": "Emily Wilson",
      "status": "Success",
      "action": "Add to Lead List",
      "execution_time": "2024-06-18 13:22:11",
      "duration": "0.6s",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trigger Management"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _showCreateTriggerDialog(),
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filters
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search triggers...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: QDropdownField(
                    label: "Type",
                    items: triggerTypes,
                    value: selectedTriggerType,
                    onChanged: (value, label) {
                      selectedTriggerType = value;
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

            // Trigger Overview Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildMetricCard("Total Triggers", "15", Icons.flash_on, primaryColor),
                _buildMetricCard("Active Triggers", "12", Icons.play_circle, successColor),
                _buildMetricCard("Executions Today", "89", Icons.trending_up, infoColor),
                _buildMetricCard("Success Rate", "94.2%", Icons.check_circle, warningColor),
              ],
            ),

            // Trigger List
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        Icon(Icons.flash_on, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "Triggers",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Create Trigger",
                          size: bs.sm,
                          onPressed: () => _showCreateTriggerDialog(),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1),
                  ...triggers.map((trigger) => _buildTriggerItem(trigger)),
                ],
              ),
            ),

            // Recent Executions
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        Icon(Icons.history, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "Recent Executions",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "View All",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1),
                  ...recentExecutions.map((execution) => _buildExecutionItem(execution)),
                ],
              ),
            ),

            // Trigger Performance Chart
            Container(
              width: double.infinity,
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
                      Icon(Icons.analytics, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Trigger Performance",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      _buildPerformanceCard("New Website Lead", 1245, 98.2),
                      _buildPerformanceCard("Email Engagement", 567, 89.5),
                      _buildPerformanceCard("Deal Won Celebration", 87, 100.0),
                      _buildPerformanceCard("Weekly Newsletter", 24, 95.8),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
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
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Spacer(),
              Icon(Icons.trending_up, color: successColor, size: 16),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTriggerItem(Map<String, dynamic> trigger) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${trigger["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${trigger["type"]} • ${trigger["event"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: trigger["status"] == "Active" ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${trigger["status"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: trigger["status"] == "Active" ? successColor : dangerColor,
                    ),
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${trigger["executions"]}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${(trigger["success_rate"] as num).toStringAsFixed(1)}%",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: (trigger["success_rate"] as num) >= 95 ? successColor : warningColor,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showTriggerActions(trigger),
              ),
            ],
          ),
          if (trigger["last_triggered"] != "Never")
            Row(
              children: [
                Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Text(
                  "Last triggered: ${trigger["last_triggered"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildExecutionItem(Map<String, dynamic> execution) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: execution["status"] == "Success" ? successColor : dangerColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${execution["trigger_name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${execution["contact"]} • ${execution["action"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: execution["status"] == "Success" ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${execution["status"]}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: execution["status"] == "Success" ? successColor : dangerColor,
                ),
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              "${execution["duration"]}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ),
          SizedBox(width: spSm),
          Text(
            "${execution["execution_time"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceCard(String name, int executions, double successRate) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor.withAlpha(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
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
                      executions.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Executions",
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
                    "${successRate.toStringAsFixed(1)}%",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: successRate >= 95 ? successColor : warningColor,
                    ),
                  ),
                  Text(
                    "Success",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          LinearProgressIndicator(
            value: successRate / 100,
            backgroundColor: disabledOutlineBorderColor,
            valueColor: AlwaysStoppedAnimation<Color>(
              successRate >= 95 ? successColor : warningColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showCreateTriggerDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create New Trigger"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              QTextField(
                label: "Trigger Name",
                value: triggerName,
                onChanged: (value) {
                  triggerName = value;
                  setState(() {});
                },
              ),
              QMemoField(
                label: "Description",
                value: triggerDescription,
                onChanged: (value) {
                  triggerDescription = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Event Type",
                items: eventTypes,
                value: eventType,
                onChanged: (value, label) {
                  eventType = value;
                  setState(() {});
                },
              ),
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Field",
                      items: conditionFields,
                      value: conditionField,
                      onChanged: (value, label) {
                        conditionField = value;
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: QDropdownField(
                      label: "Operator",
                      items: operators,
                      value: conditionOperator,
                      onChanged: (value, label) {
                        conditionOperator = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              QTextField(
                label: "Value",
                value: conditionValue,
                onChanged: (value) {
                  conditionValue = value;
                  setState(() {});
                },
              ),
              QSwitch(
                items: [
                  {
                    "label": "Active",
                    "value": true,
                    "checked": isActive,
                  }
                ],
                value: [if (isActive) {"label": "Active", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  setState(() {
                    isActive = values.isNotEmpty;
                  });
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Create",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Trigger created successfully");
            },
          ),
        ],
      ),
    );
  }

  void _showTriggerActions(Map<String, dynamic> trigger) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Text(
              "${trigger["name"]} Actions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.edit, color: primaryColor),
              title: Text("Edit Trigger"),
              onTap: () {
                Navigator.pop(context);
                _showCreateTriggerDialog();
              },
            ),
            ListTile(
              leading: Icon(Icons.copy, color: infoColor),
              title: Text("Duplicate Trigger"),
              onTap: () {
                Navigator.pop(context);
                ss("Trigger duplicated successfully");
              },
            ),
            ListTile(
              leading: Icon(
                trigger["status"] == "Active" ? Icons.pause : Icons.play_arrow,
                color: trigger["status"] == "Active" ? warningColor : successColor,
              ),
              title: Text(trigger["status"] == "Active" ? "Deactivate" : "Activate"),
              onTap: () {
                Navigator.pop(context);
                ss("Trigger ${trigger["status"] == "Active" ? "deactivated" : "activated"}");
              },
            ),
            ListTile(
              leading: Icon(Icons.analytics, color: infoColor),
              title: Text("View Analytics"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Delete Trigger"),
              onTap: () async {
                Navigator.pop(context);
                bool isConfirmed = await confirm("Are you sure you want to delete this trigger?");
                if (isConfirmed) {
                  se("Trigger deleted successfully");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
