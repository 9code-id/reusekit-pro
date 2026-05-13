import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmTicketResolutionView extends StatefulWidget {
  const CrmTicketResolutionView({super.key});

  @override
  State<CrmTicketResolutionView> createState() => _CrmTicketResolutionViewState();
}

class _CrmTicketResolutionViewState extends State<CrmTicketResolutionView> {
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedResolutionType = "all";
  String selectedPriority = "all";
  String resolutionTitle = "";
  String resolutionDescription = "";
  String selectedCategory = "";
  String knowledgeBaseEntry = "";
  List<String> attachments = [];
  bool createKnowledgeBase = false;
  bool notifyCustomer = true;
  bool markAsResolved = true;

  final List<Map<String, dynamic>> resolutionTemplates = [
    {
      "id": "1",
      "title": "Password Reset Complete",
      "category": "Account Issues",
      "description": "Password has been successfully reset. Customer can now log in with the new credentials.",
      "steps": [
        "Verified customer identity",
        "Reset password in system",
        "Sent new credentials via secure channel",
        "Confirmed successful login"
      ],
      "estimatedTime": "15 minutes",
      "usageCount": 245
    },
    {
      "id": "2", 
      "title": "Software Bug Fixed",
      "category": "Technical Issues",
      "description": "Bug has been identified and resolved in the latest software update.",
      "steps": [
        "Reproduced the issue",
        "Identified root cause",
        "Implemented fix",
        "Tested solution",
        "Deployed update"
      ],
      "estimatedTime": "2 hours",
      "usageCount": 89
    },
    {
      "id": "3",
      "title": "Billing Inquiry Resolved",
      "category": "Billing",
      "description": "Billing discrepancy has been reviewed and corrected.",
      "steps": [
        "Reviewed billing history",
        "Identified discrepancy",
        "Applied correction",
        "Processed refund if applicable",
        "Updated customer account"
      ],
      "estimatedTime": "30 minutes", 
      "usageCount": 156
    }
  ];

  final List<Map<String, dynamic>> pendingTickets = [
    {
      "id": "TCK-2024-001",
      "title": "Unable to access account dashboard",
      "customer": "John Smith",
      "priority": "High",
      "status": "In Progress",
      "assignedAgent": "Sarah Wilson",
      "timeSpent": "2h 15m",
      "category": "Account Issues",
      "createdAt": "2024-03-15 09:30",
      "lastUpdated": "2024-03-15 14:45",
      "description": "Customer reports unable to log into dashboard after password reset",
      "progress": 75
    },
    {
      "id": "TCK-2024-002",
      "title": "Payment processing error",
      "customer": "Emily Johnson",
      "priority": "Critical",
      "status": "In Progress",
      "assignedAgent": "Mike Brown",
      "timeSpent": "1h 30m",
      "category": "Billing",
      "createdAt": "2024-03-15 10:15",
      "lastUpdated": "2024-03-15 15:20",
      "description": "Transaction fails at checkout with error code 500",
      "progress": 60
    },
    {
      "id": "TCK-2024-003",
      "title": "Feature request for mobile app",
      "customer": "Robert Davis",
      "priority": "Medium",
      "status": "Under Review",
      "assignedAgent": "Lisa Chen",
      "timeSpent": "45m",
      "category": "Feature Request",
      "createdAt": "2024-03-15 11:00",
      "lastUpdated": "2024-03-15 13:30",
      "description": "Request for dark mode in mobile application",
      "progress": 25
    }
  ];

  final List<Map<String, dynamic>> resolutionCategories = [
    {"label": "Account Issues", "value": "account"},
    {"label": "Technical Issues", "value": "technical"},
    {"label": "Billing", "value": "billing"},
    {"label": "Feature Request", "value": "feature"},
    {"label": "Other", "value": "other"}
  ];

  final List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Under Review", "value": "under_review"},
    {"label": "Pending", "value": "pending"}
  ];

  final List<Map<String, dynamic>> resolutionTypeOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "Fixed", "value": "fixed"},
    {"label": "Workaround", "value": "workaround"},
    {"label": "No Issue", "value": "no_issue"},
    {"label": "Duplicate", "value": "duplicate"}
  ];

  final List<Map<String, dynamic>> priorityOptions = [
    {"label": "All Priorities", "value": "all"},
    {"label": "Critical", "value": "critical"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"}
  ];

  List<Map<String, dynamic>> get filteredTickets {
    return pendingTickets.where((ticket) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${ticket["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${ticket["customer"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${ticket["id"]}".toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesStatus = selectedStatus == "all" ||
          "${ticket["status"]}".toLowerCase().replaceAll(" ", "_") == selectedStatus;

      bool matchesPriority = selectedPriority == "all" ||
          "${ticket["priority"]}".toLowerCase() == selectedPriority;

      return matchesSearch && matchesStatus && matchesPriority;
    }).toList();
  }

  List<Map<String, dynamic>> get filteredTemplates {
    return resolutionTemplates.where((template) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${template["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${template["category"]}".toLowerCase().contains(searchQuery.toLowerCase());

      return matchesSearch;
    }).toList();
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'critical':
        return dangerColor;
      case 'high':
        return warningColor;
      case 'medium':
        return infoColor;
      case 'low':
        return successColor;
      default:
        return disabledColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'in progress':
        return infoColor;
      case 'under review':
        return warningColor;
      case 'pending':
        return disabledBoldColor;
      default:
        return disabledColor;
    }
  }

  void _showResolutionDialog(Map<String, dynamic> ticket) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusMd),
                    topRight: Radius.circular(radiusMd),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Resolve Ticket: ${ticket["id"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spMd,
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: infoColor.withAlpha(50)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "Ticket Information",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "${ticket["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Customer: ${ticket["customer"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "${ticket["description"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QTextField(
                        label: "Resolution Title",
                        value: resolutionTitle,
                        hint: "Brief title for the resolution",
                        validator: Validator.required,
                        onChanged: (value) {
                          resolutionTitle = value;
                          setState(() {});
                        },
                      ),
                      QDropdownField(
                        label: "Resolution Category",
                        items: resolutionCategories,
                        value: selectedCategory,
                        onChanged: (value, label) {
                          selectedCategory = value;
                          setState(() {});
                        },
                      ),
                      QMemoField(
                        label: "Resolution Description",
                        value: resolutionDescription,
                        hint: "Detailed explanation of how the issue was resolved",
                        maxLines: 4,
                        validator: Validator.required,
                        onChanged: (value) {
                          resolutionDescription = value;
                          setState(() {});
                        },
                      ),
                      QMemoField(
                        label: "Knowledge Base Entry (Optional)",
                        value: knowledgeBaseEntry,
                        hint: "Additional information for knowledge base",
                        maxLines: 3,
                        onChanged: (value) {
                          knowledgeBaseEntry = value;
                          setState(() {});
                        },
                      ),
                      QAttachmentPicker(
                        label: "Attachments",
                        value: attachments,
                        hint: "Attach relevant files or screenshots",
                        onChanged: (value) {
                          attachments = value;
                          setState(() {});
                        },
                      ),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Text(
                              "Options",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            QSwitch(
                              items: [
                                {
                                  "label": "Create Knowledge Base Entry",
                                  "value": true,
                                  "checked": createKnowledgeBase,
                                }
                              ],
                              value: [
                                if (createKnowledgeBase)
                                  {
                                    "label": "Create Knowledge Base Entry",
                                    "value": true,
                                    "checked": true
                                  }
                              ],
                              onChanged: (values, ids) {
                                createKnowledgeBase = values.isNotEmpty;
                                setState(() {});
                              },
                            ),
                            QSwitch(
                              items: [
                                {
                                  "label": "Notify Customer via Email",
                                  "value": true,
                                  "checked": notifyCustomer,
                                }
                              ],
                              value: [
                                if (notifyCustomer)
                                  {
                                    "label": "Notify Customer via Email",
                                    "value": true,
                                    "checked": true
                                  }
                              ],
                              onChanged: (values, ids) {
                                notifyCustomer = values.isNotEmpty;
                                setState(() {});
                              },
                            ),
                            QSwitch(
                              items: [
                                {
                                  "label": "Mark Ticket as Resolved",
                                  "value": true,
                                  "checked": markAsResolved,
                                }
                              ],
                              value: [
                                if (markAsResolved)
                                  {
                                    "label": "Mark Ticket as Resolved",
                                    "value": true,
                                    "checked": true
                                  }
                              ],
                              onChanged: (values, ids) {
                                markAsResolved = values.isNotEmpty;
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: disabledOutlineBorderColor),
                  ),
                ),
                child: Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Cancel",
                        color: disabledColor,
                        size: bs.md,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Resolve Ticket",
                        size: bs.md,
                        onPressed: () {
                          Navigator.pop(context);
                          ss("Ticket resolved successfully");
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTemplateDialog(Map<String, dynamic> template) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusMd),
                    topRight: Radius.circular(radiusMd),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${template["title"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spMd,
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: successColor.withAlpha(50)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Category: ${template["category"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: successColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "Used ${template["usageCount"]} times",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: infoColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Estimated Time: ${template["estimatedTime"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Text(
                            "Description",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${template["description"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Text(
                            "Resolution Steps",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ...List.generate((template["steps"] as List).length, (index) {
                            String step = (template["steps"] as List)[index];
                            return Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.grey.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spSm,
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(radiusXxs),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${index + 1}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      step,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: disabledOutlineBorderColor),
                  ),
                ),
                child: Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Cancel",
                        color: disabledColor,
                        size: bs.md,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Use Template",
                        size: bs.md,
                        onPressed: () {
                          resolutionTitle = "${template["title"]}";
                          resolutionDescription = "${template["description"]}";
                          Navigator.pop(context);
                          setState(() {});
                          ss("Template applied successfully");
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Ticket Resolution",
      selectedIndex: 0,
      tabs: [
        Tab(text: "Pending Tickets", icon: Icon(Icons.pending_actions)),
        Tab(text: "Resolution Templates", icon: Icon(Icons.library_books)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        // Pending Tickets Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    QTextField(
                      label: "Search Tickets",
                      value: searchQuery,
                      hint: "Search by ticket ID, title, or customer",
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      spacing: spSm,
                      children: [
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
                        Expanded(
                          child: QDropdownField(
                            label: "Priority",
                            items: priorityOptions,
                            value: selectedPriority,
                            onChanged: (value, label) {
                              selectedPriority = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.pending_actions,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Pending Resolution (${filteredTickets.length})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              ...filteredTickets.map((ticket) {
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
                        color: _getPriorityColor("${ticket["priority"]}"),
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
                              spacing: spXs,
                              children: [
                                Text(
                                  "${ticket["id"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${ticket["title"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Customer: ${ticket["customer"]}",
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
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: _getPriorityColor("${ticket["priority"]}").withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${ticket["priority"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: _getPriorityColor("${ticket["priority"]}"),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor("${ticket["status"]}").withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${ticket["status"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: _getStatusColor("${ticket["status"]}"),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: disabledBoldColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Assigned to: ${ticket["assignedAgent"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.access_time,
                                  color: disabledBoldColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Time Spent: ${ticket["timeSpent"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Progress: ${ticket["progress"]}%",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${ticket["progress"]}%",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
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
                                    widthFactor: (ticket["progress"] as int) / 100,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
                              color: infoColor,
                              size: bs.sm,
                              onPressed: () {
                                si("Viewing ticket details");
                              },
                            ),
                          ),
                          Expanded(
                            child: QButton(
                              label: "Resolve Ticket",
                              size: bs.sm,
                              onPressed: () => _showResolutionDialog(ticket),
                            ),
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
        // Resolution Templates Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: QTextField(
                  label: "Search Templates",
                  value: searchQuery,
                  hint: "Search by title or category",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.library_books,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Resolution Templates (${filteredTemplates.length})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  QButton(
                    label: "Create Template",
                    icon: Icons.add,
                    size: bs.sm,
                    onPressed: () {
                      si("Creating new resolution template");
                    },
                  ),
                ],
              ),
              ...filteredTemplates.map((template) {
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
                                  "${template["title"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: successColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${template["category"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: successColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Icon(
                                      Icons.access_time,
                                      color: disabledBoldColor,
                                      size: 14,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${template["estimatedTime"]}",
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
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "Used ${template["usageCount"]} times",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${template["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Row(
                        spacing: spSm,
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Template",
                              color: infoColor,
                              size: bs.sm,
                              onPressed: () => _showTemplateDialog(template),
                            ),
                          ),
                          Expanded(
                            child: QButton(
                              label: "Use Template",
                              size: bs.sm,
                              onPressed: () => _showTemplateDialog(template),
                            ),
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
        // Analytics Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Resolution Analytics",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ResponsiveGridView(
                padding: EdgeInsets.all(spSm),
                minItemWidth: 200,
                children: [
                  Container(
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
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.check_circle,
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
                                    "Resolved Today",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "24",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "+15% from yesterday",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
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
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.access_time,
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
                                    "Avg Resolution Time",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "2.4 hrs",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: infoColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "-20 min from last week",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
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
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: warningColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.pending,
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
                                    "Pending Resolution",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "12",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: warningColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "2 are overdue",
                          style: TextStyle(
                            fontSize: 12,
                            color: dangerColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
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
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.star,
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
                                    "Customer Satisfaction",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "4.8/5",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Based on 156 reviews",
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
              Container(
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
                      "Top Resolution Categories",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ...List.generate(4, (index) {
                      List<String> categories = ["Account Issues", "Technical Issues", "Billing", "Feature Requests"];
                      List<int> counts = [45, 32, 28, 15];
                      List<Color> colors = [successColor, warningColor, infoColor, primaryColor];
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: colors[index].withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: colors[index],
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                categories[index],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              "${counts[index]} resolved",
                              style: TextStyle(
                                fontSize: 12,
                                color: colors[index],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
