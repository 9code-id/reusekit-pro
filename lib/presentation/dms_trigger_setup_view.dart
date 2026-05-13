import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsTriggerSetupView extends StatefulWidget {
  const DmsTriggerSetupView({super.key});

  @override
  State<DmsTriggerSetupView> createState() => _DmsTriggerSetupViewState();
}

class _DmsTriggerSetupViewState extends State<DmsTriggerSetupView> {
  final formKey = GlobalKey<FormState>();
  
  String triggerName = "";
  String triggerDescription = "";
  String triggerType = "Document Upload";
  String condition = "Any Document";
  String actionType = "Send Notification";
  String notificationEmail = "";
  String webhookUrl = "";
  bool isActive = true;
  String priority = "Medium";
  String department = "All";
  
  final List<Map<String, dynamic>> triggerTypes = [
    {"label": "Document Upload", "value": "Document Upload"},
    {"label": "Document Update", "value": "Document Update"},
    {"label": "Document Delete", "value": "Document Delete"},
    {"label": "User Login", "value": "User Login"},
    {"label": "Workflow Complete", "value": "Workflow Complete"},
    {"label": "Schedule Based", "value": "Schedule Based"},
    {"label": "File Size Threshold", "value": "File Size Threshold"},
    {"label": "Permission Change", "value": "Permission Change"},
  ];

  final List<Map<String, dynamic>> conditions = [
    {"label": "Any Document", "value": "Any Document"},
    {"label": "PDF Files Only", "value": "PDF Files Only"},
    {"label": "Images Only", "value": "Images Only"},
    {"label": "Documents > 10MB", "value": "Documents > 10MB"},
    {"label": "Specific Folder", "value": "Specific Folder"},
    {"label": "Tagged Documents", "value": "Tagged Documents"},
    {"label": "Confidential Documents", "value": "Confidential Documents"},
  ];

  final List<Map<String, dynamic>> actionTypes = [
    {"label": "Send Notification", "value": "Send Notification"},
    {"label": "Send Email", "value": "Send Email"},
    {"label": "Call Webhook", "value": "Call Webhook"},
    {"label": "Create Task", "value": "Create Task"},
    {"label": "Move Document", "value": "Move Document"},
    {"label": "Apply Tag", "value": "Apply Tag"},
    {"label": "Generate Report", "value": "Generate Report"},
    {"label": "Backup Document", "value": "Backup Document"},
  ];

  final List<Map<String, dynamic>> priorities = [
    {"label": "Low", "value": "Low"},
    {"label": "Medium", "value": "Medium"},
    {"label": "High", "value": "High"},
    {"label": "Critical", "value": "Critical"},
  ];

  final List<Map<String, dynamic>> departments = [
    {"label": "All", "value": "All"},
    {"label": "Finance", "value": "Finance"},
    {"label": "HR", "value": "HR"},
    {"label": "Legal", "value": "Legal"},
    {"label": "IT", "value": "IT"},
    {"label": "Operations", "value": "Operations"},
  ];

  final List<Map<String, dynamic>> existingTriggers = [
    {
      "id": "tr_001",
      "name": "Invoice Upload Alert",
      "type": "Document Upload",
      "condition": "PDF Files Only",
      "action": "Send Email",
      "status": "Active",
      "department": "Finance",
      "priority": "High",
      "triggerCount": 45,
      "lastTriggered": "2024-06-19 10:30",
    },
    {
      "id": "tr_002", 
      "name": "Large File Monitor",
      "type": "File Size Threshold",
      "condition": "Documents > 10MB",
      "action": "Send Notification",
      "status": "Active",
      "department": "IT",
      "priority": "Medium",
      "triggerCount": 12,
      "lastTriggered": "2024-06-19 09:15",
    },
    {
      "id": "tr_003",
      "name": "Confidential Doc Access",
      "type": "Permission Change",
      "condition": "Confidential Documents",
      "action": "Generate Report",
      "status": "Paused",
      "department": "Legal",
      "priority": "Critical",
      "triggerCount": 8,
      "lastTriggered": "2024-06-18 16:45",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trigger Setup"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              _showHelp();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Create New Trigger Form
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Create New Trigger",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    QTextField(
                      label: "Trigger Name",
                      value: triggerName,
                      validator: Validator.required,
                      onChanged: (value) {
                        triggerName = value;
                        setState(() {});
                      },
                    ),
                    
                    QMemoField(
                      label: "Description",
                      value: triggerDescription,
                      hint: "Describe what this trigger does...",
                      onChanged: (value) {
                        triggerDescription = value;
                        setState(() {});
                      },
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Trigger Type",
                            items: triggerTypes,
                            value: triggerType,
                            onChanged: (value, label) {
                              triggerType = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Condition",
                            items: conditions,
                            value: condition,
                            onChanged: (value, label) {
                              condition = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    QDropdownField(
                      label: "Action Type",
                      items: actionTypes,
                      value: actionType,
                      onChanged: (value, label) {
                        actionType = value;
                        setState(() {});
                      },
                    ),
                    
                    // Conditional Fields based on Action Type
                    if (actionType == "Send Email")
                      QTextField(
                        label: "Notification Email",
                        value: notificationEmail,
                        validator: Validator.email,
                        onChanged: (value) {
                          notificationEmail = value;
                          setState(() {});
                        },
                      ),
                    
                    if (actionType == "Call Webhook")
                      QTextField(
                        label: "Webhook URL",
                        value: webhookUrl,
                        validator: Validator.required,
                        onChanged: (value) {
                          webhookUrl = value;
                          setState(() {});
                        },
                      ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Priority",
                            items: priorities,
                            value: priority,
                            onChanged: (value, label) {
                              priority = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Department",
                            items: departments,
                            value: department,
                            onChanged: (value, label) {
                              department = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    QSwitch(
                      label: "Trigger Status",
                      items: [
                        {
                          "label": "Active",
                          "value": true,
                          "checked": isActive,
                        }
                      ],
                      value: [if (isActive) {"label": "Active", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        isActive = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Test Trigger",
                            size: bs.sm,
                            onPressed: () {
                              _testTrigger();
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Save Trigger",
                            size: bs.sm,
                            onPressed: () {
                              _saveTrigger();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: spMd),

            // Existing Triggers
            Text(
              "Existing Triggers",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...existingTriggers.map((trigger) {
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
                      color: _getPriorityColor(trigger["priority"] as String),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${trigger["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${trigger["type"]} → ${trigger["action"]}",
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
                            color: trigger["status"] == "Active" ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${trigger["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: trigger["status"] == "Active" ? successColor : warningColor,
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
                                "Condition: ${trigger["condition"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Department: ${trigger["department"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Triggered: ${trigger["triggerCount"]}×",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Last: ${trigger["lastTriggered"]}",
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
                    SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getPriorityColor(trigger["priority"] as String).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${trigger["priority"]} Priority",
                            style: TextStyle(
                              fontSize: 12,
                              color: _getPriorityColor(trigger["priority"] as String),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Spacer(),
                        QButton(
                          icon: Icons.edit,
                          size: bs.sm,
                          onPressed: () {
                            _editTrigger(trigger);
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: trigger["status"] == "Active" ? Icons.pause : Icons.play_arrow,
                          size: bs.sm,
                          onPressed: () {
                            _toggleTriggerStatus(trigger["id"] as String);
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.delete,
                          size: bs.sm,
                          onPressed: () {
                            _deleteTrigger(trigger["id"] as String);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return primaryColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  void _testTrigger() {
    if (formKey.currentState!.validate()) {
      showLoading();
      // Simulate API call
      Future.delayed(Duration(seconds: 2), () {
        hideLoading();
        ss("Trigger test completed successfully");
      });
    }
  }

  void _saveTrigger() {
    if (formKey.currentState!.validate()) {
      showLoading();
      // Simulate API call
      Future.delayed(Duration(seconds: 1), () {
        hideLoading();
        ss("Trigger saved successfully");
        _resetForm();
      });
    }
  }

  void _resetForm() {
    triggerName = "";
    triggerDescription = "";
    triggerType = "Document Upload";
    condition = "Any Document";
    actionType = "Send Notification";
    notificationEmail = "";
    webhookUrl = "";
    isActive = true;
    priority = "Medium";
    department = "All";
    setState(() {});
  }

  void _editTrigger(Map<String, dynamic> trigger) {
    triggerName = trigger["name"];
    triggerType = trigger["type"];
    condition = trigger["condition"];
    actionType = trigger["action"];
    priority = trigger["priority"];
    department = trigger["department"];
    isActive = trigger["status"] == "Active";
    setState(() {});
    si("Trigger loaded for editing");
  }

  void _toggleTriggerStatus(String triggerId) {
    final triggerIndex = existingTriggers.indexWhere((trigger) => trigger["id"] == triggerId);
    if (triggerIndex != -1) {
      final currentStatus = existingTriggers[triggerIndex]["status"];
      existingTriggers[triggerIndex]["status"] = currentStatus == "Active" ? "Paused" : "Active";
      setState(() {});
      ss("Trigger status updated");
    }
  }

  void _deleteTrigger(String triggerId) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this trigger?");
    if (isConfirmed) {
      existingTriggers.removeWhere((trigger) => trigger["id"] == triggerId);
      setState(() {});
      ss("Trigger deleted successfully");
    }
  }

  void _showHelp() {
    si("Help documentation would be shown here");
  }
}
