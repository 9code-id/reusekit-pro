import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaAuditChecklistView extends StatefulWidget {
  const HhaAuditChecklistView({super.key});

  @override
  State<HhaAuditChecklistView> createState() => _HhaAuditChecklistViewState();
}

class _HhaAuditChecklistViewState extends State<HhaAuditChecklistView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedPriority = "All";
  String selectedStatus = "All";
  
  List<Map<String, dynamic>> auditCategories = [
    {
      "label": "All Categories",
      "value": "All",
    },
    {
      "label": "Hygiene & Sanitation",
      "value": "hygiene",
    },
    {
      "label": "Safety & Security",
      "value": "safety",
    },
    {
      "label": "Guest Services",
      "value": "services",
    },
    {
      "label": "Maintenance",
      "value": "maintenance",
    },
    {
      "label": "Operations",
      "value": "operations",
    },
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {
      "label": "All Priority",
      "value": "All",
    },
    {
      "label": "Critical",
      "value": "critical",
    },
    {
      "label": "High",
      "value": "high",
    },
    {
      "label": "Medium",
      "value": "medium",
    },
    {
      "label": "Low",
      "value": "low",
    },
  ];

  List<Map<String, dynamic>> statusOptions = [
    {
      "label": "All Status",
      "value": "All",
    },
    {
      "label": "Pending",
      "value": "pending",
    },
    {
      "label": "In Progress",
      "value": "in_progress",
    },
    {
      "label": "Completed",
      "value": "completed",
    },
    {
      "label": "Overdue",
      "value": "overdue",
    },
  ];

  List<Map<String, dynamic>> auditChecklists = [
    {
      "id": "AUD001",
      "title": "Daily Room Cleaning Inspection",
      "description": "Comprehensive inspection of guest room cleanliness and amenities",
      "category": "hygiene",
      "priority": "high",
      "status": "pending",
      "due_date": "2024-12-20",
      "assigned_to": "Maria Santos",
      "total_items": 25,
      "completed_items": 0,
      "progress": 0.0,
      "created_at": "2024-12-15",
      "items": [
        {
          "id": "item_1",
          "title": "Bed linens properly changed and fresh",
          "completed": false,
          "notes": "",
          "critical": true,
        },
        {
          "id": "item_2", 
          "title": "Bathroom thoroughly cleaned and sanitized",
          "completed": false,
          "notes": "",
          "critical": true,
        },
        {
          "id": "item_3",
          "title": "Towels replaced and properly folded",
          "completed": false,
          "notes": "",
          "critical": false,
        },
      ],
    },
    {
      "id": "AUD002",
      "title": "Kitchen Safety & Hygiene Audit",
      "description": "Monthly inspection of kitchen facilities and food safety protocols",
      "category": "safety",
      "priority": "critical",
      "status": "in_progress",
      "due_date": "2024-12-18",
      "assigned_to": "Chef Rodriguez",
      "total_items": 35,
      "completed_items": 22,
      "progress": 0.63,
      "created_at": "2024-12-10",
      "items": [],
    },
    {
      "id": "AUD003",
      "title": "Guest Service Standards Check",
      "description": "Evaluation of front desk and concierge service quality",
      "category": "services",
      "priority": "medium",
      "status": "completed",
      "due_date": "2024-12-15",
      "assigned_to": "Lisa Chen",
      "total_items": 18,
      "completed_items": 18,
      "progress": 1.0,
      "created_at": "2024-12-08",
      "items": [],
    },
    {
      "id": "AUD004",
      "title": "Fire Safety Equipment Inspection",
      "description": "Quarterly check of fire extinguishers, alarms, and evacuation routes",
      "category": "safety",
      "priority": "critical",
      "status": "overdue",
      "due_date": "2024-12-12",
      "assigned_to": "Security Team",
      "total_items": 28,
      "completed_items": 15,
      "progress": 0.54,
      "created_at": "2024-12-01",
      "items": [],
    },
    {
      "id": "AUD005",
      "title": "HVAC System Maintenance Check",
      "description": "Monthly inspection of heating, ventilation, and air conditioning systems",
      "category": "maintenance",
      "priority": "high",
      "status": "pending",
      "due_date": "2024-12-22",
      "assigned_to": "Maintenance Team",
      "total_items": 20,
      "completed_items": 0,
      "progress": 0.0,
      "created_at": "2024-12-14",
      "items": [],
    },
  ];

  List<Map<String, dynamic>> get filteredChecklists {
    return auditChecklists.where((checklist) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${checklist["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${checklist["description"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${checklist["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || checklist["category"] == selectedCategory;
      bool matchesPriority = selectedPriority == "All" || checklist["priority"] == selectedPriority;
      bool matchesStatus = selectedStatus == "All" || checklist["status"] == selectedStatus;
      
      return matchesSearch && matchesCategory && matchesPriority && matchesStatus;
    }).toList();
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "critical":
        return dangerColor;
      case "high":
        return warningColor;
      case "medium":
        return infoColor;
      case "low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "in_progress":
        return infoColor;
      case "pending":
        return warningColor;
      case "overdue":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "in_progress":
        return "In Progress";
      case "overdue":
        return "Overdue";
      default:
        return status.split('_').map((word) => word[0].toUpperCase() + word.substring(1)).join(' ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Audit Checklist"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to create new checklist
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Show filter options
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filters Section
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
                    label: "Search checklists...",
                    value: searchQuery,
                    hint: "Search by ID, title, or description",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: auditCategories,
                          value: selectedCategory,
                          onChanged: (value, label) {
                            selectedCategory = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
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
            ),

            // Statistics Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.assignment,
                          color: primaryColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${auditChecklists.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Checklists",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                          textAlign: TextAlign.center,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.pending_actions,
                          color: warningColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${auditChecklists.where((c) => c["status"] == "pending").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Pending",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                          textAlign: TextAlign.center,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.warning,
                          color: dangerColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${auditChecklists.where((c) => c["status"] == "overdue").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Overdue",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Checklists List
            ...filteredChecklists.map((checklist) {
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
                    // Header
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${checklist["id"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: _getPriorityColor("${checklist["priority"]}").withAlpha(30),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${checklist["priority"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: _getPriorityColor("${checklist["priority"]}"),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${checklist["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getStatusColor("${checklist["status"]}").withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            _getStatusLabel("${checklist["status"]}"),
                            style: TextStyle(
                              fontSize: 12,
                              color: _getStatusColor("${checklist["status"]}"),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Text(
                      "${checklist["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),

                    // Progress Bar
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Progress: ${((checklist["progress"] as double) * 100).toInt()}%",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${checklist["completed_items"]}/${checklist["total_items"]} items",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        LinearProgressIndicator(
                          value: checklist["progress"] as double,
                          backgroundColor: disabledColor,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            (checklist["progress"] as double) == 1.0 
                                ? successColor 
                                : primaryColor,
                          ),
                        ),
                      ],
                    ),

                    // Details Row
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${checklist["assigned_to"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Due: ${DateTime.parse("${checklist["due_date"]}").dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () {
                              // Navigate to checklist details
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.edit,
                          size: bs.sm,
                          onPressed: () {
                            // Navigate to edit checklist
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          onPressed: () {
                            // Show more options
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            if (filteredChecklists.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.assignment,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No checklists found",
                      style: TextStyle(
                        fontSize: fsH6,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search or filter criteria",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create new checklist
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
