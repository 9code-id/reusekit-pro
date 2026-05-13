import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmFollowUpRemindersView extends StatefulWidget {
  const CrmFollowUpRemindersView({super.key});

  @override
  State<CrmFollowUpRemindersView> createState() => _CrmFollowUpRemindersViewState();
}

class _CrmFollowUpRemindersViewState extends State<CrmFollowUpRemindersView> {
  final formKey = GlobalKey<FormState>();
  String reminderTitle = "";
  String reminderDescription = "";
  String selectedContact = "John Smith";
  String selectedDeal = "Enterprise Software Sale";
  String selectedPriority = "High";
  String reminderDate = "2024-12-20";
  String reminderTime = "10:00";
  String selectedType = "Follow-up Call";
  String searchQuery = "";
  bool showOverdueOnly = false;

  List<Map<String, dynamic>> contactOptions = [
    {"label": "John Smith", "value": "john_smith"},
    {"label": "Sarah Johnson", "value": "sarah_johnson"},
    {"label": "Michael Chen", "value": "michael_chen"},
    {"label": "Emily Rodriguez", "value": "emily_rodriguez"},
  ];

  List<Map<String, dynamic>> dealOptions = [
    {"label": "Enterprise Software Sale", "value": "enterprise_sale"},
    {"label": "Marketing Automation Deal", "value": "marketing_deal"},
    {"label": "CRM Implementation", "value": "crm_implementation"},
    {"label": "Consulting Services", "value": "consulting_services"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "Low", "value": "low"},
    {"label": "Medium", "value": "medium"},
    {"label": "High", "value": "high"},
    {"label": "Urgent", "value": "urgent"},
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "Follow-up Call", "value": "call"},
    {"label": "Send Email", "value": "email"},
    {"label": "Schedule Meeting", "value": "meeting"},
    {"label": "Send Proposal", "value": "proposal"},
    {"label": "Demo Presentation", "value": "demo"},
  ];

  List<Map<String, dynamic>> reminders = [
    {
      "id": "1",
      "title": "Follow-up with John Smith",
      "description": "Discuss pricing options for enterprise package",
      "contact": "John Smith",
      "deal": "Enterprise Software Sale",
      "type": "Follow-up Call",
      "priority": "High",
      "dueDate": "2024-12-19",
      "dueTime": "14:00",
      "status": "overdue",
      "avatar": "https://picsum.photos/100/100?random=1",
    },
    {
      "id": "2",
      "title": "Send demo video to Sarah",
      "description": "Share product demo and implementation timeline",
      "contact": "Sarah Johnson",
      "deal": "Marketing Automation Deal",
      "type": "Send Email",
      "priority": "Medium",
      "dueDate": "2024-12-20",
      "dueTime": "10:30",
      "status": "pending",
      "avatar": "https://picsum.photos/100/100?random=2",
    },
    {
      "id": "3",
      "title": "Schedule technical meeting",
      "description": "Discuss integration requirements with IT team",
      "contact": "Michael Chen",
      "deal": "CRM Implementation",
      "type": "Schedule Meeting",
      "priority": "High",
      "dueDate": "2024-12-21",
      "dueTime": "15:00",
      "status": "pending",
      "avatar": "https://picsum.photos/100/100?random=3",
    },
    {
      "id": "4",
      "title": "Submit final proposal",
      "description": "Send customized proposal with pricing breakdown",
      "contact": "Emily Rodriguez",
      "deal": "Consulting Services",
      "type": "Send Proposal",
      "priority": "Urgent",
      "dueDate": "2024-12-22",
      "dueTime": "09:00",
      "status": "pending",
      "avatar": "https://picsum.photos/100/100?random=4",
    },
  ];

  int currentTab = 0;

  List<Map<String, dynamic>> get filteredReminders {
    return reminders.where((reminder) {
      bool matchesSearch = searchQuery.isEmpty ||
          (reminder["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (reminder["contact"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = !showOverdueOnly || reminder["status"] == "overdue";
      
      return matchesSearch && matchesStatus;
    }).toList();
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Low":
        return infoColor;
      case "Medium":
        return warningColor;
      case "High":
        return dangerColor;
      case "Urgent":
        return Colors.red.shade700;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "overdue":
        return dangerColor;
      case "pending":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "Follow-up Call":
        return Icons.phone;
      case "Send Email":
        return Icons.email;
      case "Schedule Meeting":
        return Icons.event;
      case "Send Proposal":
        return Icons.description;
      case "Demo Presentation":
        return Icons.play_circle;
      default:
        return Icons.task;
    }
  }

  void _markAsCompleted(String id) {
    int index = reminders.indexWhere((r) => r["id"] == id);
    if (index != -1) {
      reminders[index]["status"] = "completed";
      setState(() {});
      ss("Reminder marked as completed");
    }
  }

  void _createReminder() {
    if (formKey.currentState!.validate()) {
      ss("Follow-up reminder created successfully");
      back();
    }
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: primaryColor.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.task, color: primaryColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Total Reminders",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "156",
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
                    color: dangerColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: dangerColor.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.warning, color: dangerColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Overdue",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "12",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
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
                    color: warningColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: warningColor.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.schedule, color: warningColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Due Today",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "8",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
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
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: successColor.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.check_circle, color: successColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Completed",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "89%",
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
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.insights, color: infoColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Quick Stats",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "68%",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "On-time Rate",
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
                        children: [
                          Text(
                            "4.2",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                          Text(
                            "Avg. Days",
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
                        children: [
                          Text(
                            "23",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "This Week",
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRemindersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search Reminders",
                  value: searchQuery,
                  hint: "Search by title or contact",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  currentTab = 2;
                  setState(() {});
                },
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Show Overdue Only",
                      "value": true,
                      "checked": showOverdueOnly,
                    }
                  ],
                  value: [
                    if (showOverdueOnly)
                      {
                        "label": "Show Overdue Only",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    showOverdueOnly = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Follow-up Reminders (${filteredReminders.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Column(
                  spacing: spSm,
                  children: filteredReminders.map((reminder) {
                    return Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                        border: reminder["status"] == "overdue"
                            ? Border.all(color: dangerColor.withAlpha(50), width: 2)
                            : null,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusLg),
                                  image: DecorationImage(
                                    image: NetworkImage("${reminder["avatar"]}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${reminder["title"]}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spSm,
                                            vertical: spXs,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _getPriorityColor(reminder["priority"] as String).withAlpha(10),
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                          child: Text(
                                            "${reminder["priority"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: _getPriorityColor(reminder["priority"] as String),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${reminder["description"]}",
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
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Icon(
                                _getTypeIcon(reminder["type"] as String),
                                size: 16,
                                color: infoColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${reminder["type"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: infoColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${reminder["contact"]} • ${reminder["deal"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.schedule,
                                    size: 16,
                                    color: _getStatusColor(reminder["status"] as String),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${reminder["dueDate"]} at ${reminder["dueTime"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: _getStatusColor(reminder["status"] as String),
                                    ),
                                  ),
                                ],
                              ),
                              if (reminder["status"] != "completed")
                                QButton(
                                  label: "Complete",
                                  size: bs.sm,
                                  onPressed: () => _markAsCompleted(reminder["id"] as String),
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
          ),
        ],
      ),
    );
  }

  Widget _buildCreateTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Form(
        key: formKey,
        child: Column(
          spacing: spMd,
          children: [
            QTextField(
              label: "Reminder Title",
              value: reminderTitle,
              hint: "Enter reminder title",
              validator: Validator.required,
              onChanged: (value) {
                reminderTitle = value;
                setState(() {});
              },
            ),
            QMemoField(
              label: "Description",
              value: reminderDescription,
              hint: "Enter reminder description...",
              onChanged: (value) {
                reminderDescription = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Contact",
              items: contactOptions,
              value: selectedContact,
              onChanged: (value, label) {
                selectedContact = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Related Deal",
              items: dealOptions,
              value: selectedDeal,
              onChanged: (value, label) {
                selectedDeal = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Reminder Type",
              items: typeOptions,
              value: selectedType,
              onChanged: (value, label) {
                selectedType = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Priority",
              items: priorityOptions,
              value: selectedPriority,
              onChanged: (value, label) {
                selectedPriority = value;
                setState(() {});
              },
            ),
            Row(
              children: [
                Expanded(
                  child: QDatePicker(
                    label: "Due Date",
                    value: DateTime.parse(reminderDate),
                    onChanged: (value) {
                      reminderDate = value.toString().split(' ')[0];
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QTimePicker(
                    label: "Due Time",
                    value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 $reminderTime:00")),
                    onChanged: (value) {
                      reminderTime = value!.kkmm;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: warningColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.notifications, color: warningColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Reminder Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "You will receive notifications for this reminder 1 hour before the due time, and it will appear in your daily task list.",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Create Reminder",
                size: bs.md,
                onPressed: _createReminder,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Follow-up Reminders",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Reminders", icon: Icon(Icons.notifications)),
        Tab(text: "Create", icon: Icon(Icons.add)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildRemindersTab(),
        _buildCreateTab(),
      ],
      onInit: (tabController) {},
    );
  }
}
