import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaChecklistView extends StatefulWidget {
  const LcaChecklistView({super.key});

  @override
  State<LcaChecklistView> createState() => _LcaChecklistViewState();
}

class _LcaChecklistViewState extends State<LcaChecklistView> {
  String selectedTemplate = "litigation";
  String checklistTitle = "Legal Case Preparation";
  String checklistDescription = "";
  
  List<Map<String, dynamic>> templates = [
    {
      "label": "Litigation Checklist",
      "value": "litigation",
    },
    {
      "label": "Contract Review",
      "value": "contract",
    },
    {
      "label": "Due Diligence",
      "value": "due_diligence",
    },
    {
      "label": "Compliance Audit",
      "value": "compliance",
    },
    {
      "label": "Client Intake",
      "value": "intake",
    },
  ];

  List<Map<String, dynamic>> checklistItems = [
    {
      "id": "1",
      "title": "Client Information Verification",
      "description": "Verify client identity and contact details",
      "completed": true,
      "priority": "High",
      "dueDate": "2025-06-20",
      "assignee": "John Smith",
      "category": "Client Management"
    },
    {
      "id": "2", 
      "title": "Document Collection",
      "description": "Gather all relevant case documents and evidence",
      "completed": false,
      "priority": "High",
      "dueDate": "2025-06-22",
      "assignee": "Sarah Johnson",
      "category": "Documentation"
    },
    {
      "id": "3",
      "title": "Legal Research",
      "description": "Research applicable laws and precedent cases",
      "completed": false,
      "priority": "Medium",
      "dueDate": "2025-06-25",
      "assignee": "Mike Wilson",
      "category": "Research"
    },
    {
      "id": "4",
      "title": "Filing Deadlines Review",
      "description": "Check all statutory deadlines and court requirements",
      "completed": true,
      "priority": "Critical",
      "dueDate": "2025-06-21",
      "assignee": "John Smith",
      "category": "Compliance"
    },
    {
      "id": "5",
      "title": "Expert Witness Consultation",
      "description": "Identify and contact potential expert witnesses",
      "completed": false,
      "priority": "Medium",
      "dueDate": "2025-06-28",
      "assignee": "Lisa Brown",
      "category": "Expert Testimony"
    },
    {
      "id": "6",
      "title": "Settlement Analysis",
      "description": "Evaluate potential settlement options and strategies",
      "completed": false,
      "priority": "Low",
      "dueDate": "2025-07-02",
      "assignee": "Mike Wilson",
      "category": "Strategy"
    },
  ];

  String filterPriority = "All";
  String filterStatus = "All";
  String filterAssignee = "All";

  List<Map<String, dynamic>> priorityFilters = [
    {"label": "All Priorities", "value": "All"},
    {"label": "Critical", "value": "Critical"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All Status", "value": "All"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Pending", "value": "Pending"},
  ];

  List<Map<String, dynamic>> assigneeFilters = [
    {"label": "All Assignees", "value": "All"},
    {"label": "John Smith", "value": "John Smith"},
    {"label": "Sarah Johnson", "value": "Sarah Johnson"},
    {"label": "Mike Wilson", "value": "Mike Wilson"},
    {"label": "Lisa Brown", "value": "Lisa Brown"},
  ];

  List<Map<String, dynamic>> get filteredItems {
    return checklistItems.where((item) {
      bool priorityMatch = filterPriority == "All" || item["priority"] == filterPriority;
      bool statusMatch = filterStatus == "All" || 
          (filterStatus == "Completed" && item["completed"]) ||
          (filterStatus == "Pending" && !item["completed"]);
      bool assigneeMatch = filterAssignee == "All" || item["assignee"] == filterAssignee;
      
      return priorityMatch && statusMatch && assigneeMatch;
    }).toList();
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  void _toggleItemCompletion(String itemId) {
    setState(() {
      final index = checklistItems.indexWhere((item) => item["id"] == itemId);
      if (index != -1) {
        checklistItems[index]["completed"] = !checklistItems[index]["completed"];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Legal Checklist"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add new checklist item
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Checklist Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.checklist,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          checklistTitle,
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Template",
                    items: templates,
                    value: selectedTemplate,
                    onChanged: (value, label) {
                      selectedTemplate = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Progress Overview
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Progress Overview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${checklistItems.where((item) => item["completed"]).length}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Completed",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${checklistItems.where((item) => !item["completed"]).length}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Pending",
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
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${((checklistItems.where((item) => item["completed"]).length / checklistItems.length) * 100).round()}%",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Complete",
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
                ],
              ),
            ),

            // Filters
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Filters",
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
                          label: "Priority",
                          items: priorityFilters,
                          value: filterPriority,
                          onChanged: (value, label) {
                            filterPriority = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: statusFilters,
                          value: filterStatus,
                          onChanged: (value, label) {
                            filterStatus = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Assignee",
                    items: assigneeFilters,
                    value: filterAssignee,
                    onChanged: (value, label) {
                      filterAssignee = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Checklist Items
            Text(
              "Checklist Items (${filteredItems.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...filteredItems.map((item) {
              return Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getPriorityColor("${item["priority"]}"),
                    ),
                  ),
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => _toggleItemCompletion("${item["id"]}"),
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: item["completed"] ? successColor : Colors.transparent,
                              border: Border.all(
                                color: item["completed"] ? successColor : disabledBoldColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: item["completed"]
                                ? Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 16,
                                  )
                                : null,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${item["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: item["completed"] ? disabledBoldColor : primaryColor,
                              decoration: item["completed"] ? TextDecoration.lineThrough : null,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getPriorityColor("${item["priority"]}").withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${item["priority"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: _getPriorityColor("${item["priority"]}"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (item["description"] != null && item["description"].toString().isNotEmpty)
                      Text(
                        "${item["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${item["assignee"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${DateTime.parse(item["dueDate"] as String).dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${item["category"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: infoColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            // Action Buttons
            Container(
              width: double.infinity,
              child: Column(
                spacing: spSm,
                children: [
                  QButton(
                    label: "Add New Item",
                    icon: Icons.add,
                    size: bs.md,
                    onPressed: () {
                      // Add new checklist item
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Export",
                          icon: Icons.download,
                          size: bs.sm,
                          onPressed: () {
                            // Export checklist
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Share",
                          icon: Icons.share,
                          size: bs.sm,
                          onPressed: () {
                            // Share checklist
                          },
                        ),
                      ),
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
}
