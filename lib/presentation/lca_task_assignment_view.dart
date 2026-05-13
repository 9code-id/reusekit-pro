import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaTaskAssignmentView extends StatefulWidget {
  const LcaTaskAssignmentView({super.key});

  @override
  State<LcaTaskAssignmentView> createState() => _LcaTaskAssignmentViewState();
}

class _LcaTaskAssignmentViewState extends State<LcaTaskAssignmentView> with TickerProviderStateMixin {
  String searchQuery = "";
  String selectedDepartment = "all";
  String selectedStatus = "all";
  String taskTitle = "";
  String taskDescription = "";
  String selectedAssignee = "";
  String selectedPriority = "medium";
  String selectedCategory = "";
  String dueDate = "";
  String estimatedHours = "";
  bool isCreatingTask = false;
  
  final formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> attorneys = [
    {
      "id": "USR001",
      "name": "Sarah Mitchell",
      "role": "Senior Partner",
      "department": "litigation",
      "current_workload": 8,
      "max_capacity": 12,
      "expertise": ["Corporate Law", "Contract Disputes", "Litigation"],
      "availability": "available",
      "active_cases": 5,
      "pending_tasks": 3,
    },
    {
      "id": "USR002", 
      "name": "Michael Chen",
      "role": "Associate Attorney",
      "department": "corporate",
      "current_workload": 6,
      "max_capacity": 10,
      "expertise": ["Contract Law", "Mergers & Acquisitions", "Corporate Governance"],
      "availability": "busy",
      "active_cases": 3,
      "pending_tasks": 5,
    },
    {
      "id": "USR003",
      "name": "David Rodriguez",
      "role": "Senior Associate",
      "department": "litigation",
      "current_workload": 10,
      "max_capacity": 12,
      "expertise": ["Medical Malpractice", "Personal Injury", "Insurance Defense"],
      "availability": "limited",
      "active_cases": 4,
      "pending_tasks": 6,
    },
    {
      "id": "USR004",
      "name": "Lisa Thompson",
      "role": "Partner",
      "department": "employment",
      "current_workload": 5,
      "max_capacity": 10,
      "expertise": ["Employment Law", "Labor Relations", "HR Compliance"],
      "availability": "available",
      "active_cases": 2,
      "pending_tasks": 2,
    },
    {
      "id": "USR005",
      "name": "Robert Kim",
      "role": "Junior Associate",
      "department": "corporate",
      "current_workload": 4,
      "max_capacity": 8,
      "expertise": ["Contract Review", "Corporate Compliance", "Real Estate"],
      "availability": "available",
      "active_cases": 2,
      "pending_tasks": 1,
    },
  ];

  List<Map<String, dynamic>> assignments = [
    {
      "id": "ASGN001",
      "task_title": "Review Settlement Agreement",
      "assignee_id": "USR001",
      "assignee_name": "Sarah Mitchell",
      "assigned_date": "2024-06-15",
      "due_date": "2024-06-25",
      "priority": "high",
      "status": "accepted",
      "category": "document_review",
      "estimated_hours": 4.5,
      "case_number": "2024-0123",
      "notes": "Client requesting expedited review",
    },
    {
      "id": "ASGN002",
      "task_title": "Prepare Discovery Documents",
      "assignee_id": "USR002",
      "assignee_name": "Michael Chen",
      "assigned_date": "2024-06-16",
      "due_date": "2024-06-28",
      "priority": "medium",
      "status": "pending",
      "category": "discovery",
      "estimated_hours": 6.0,
      "case_number": "2024-0124",
      "notes": "",
    },
    {
      "id": "ASGN003",
      "task_title": "Draft Motion to Dismiss",
      "assignee_id": "USR003",
      "assignee_name": "David Rodriguez",
      "assigned_date": "2024-06-10",
      "due_date": "2024-06-20",
      "priority": "high",
      "status": "completed",
      "category": "motion_filing",
      "estimated_hours": 8.0,
      "case_number": "2024-0125",
      "notes": "Successfully filed with court",
    },
    {
      "id": "ASGN004",
      "task_title": "Client Meeting Preparation",
      "assignee_id": "USR004",
      "assignee_name": "Lisa Thompson",
      "assigned_date": "2024-06-12",
      "due_date": "2024-06-18",
      "priority": "medium",
      "status": "declined",
      "category": "client_communication",
      "estimated_hours": 2.0,
      "case_number": "2024-0126",
      "notes": "Declined due to scheduling conflict",
    },
  ];

  List<Map<String, dynamic>> get filteredAttorneys {
    return attorneys.where((attorney) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${attorney["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          (attorney["expertise"] as List).any((exp) => exp.toLowerCase().contains(searchQuery.toLowerCase()));
      
      bool matchesDepartment = selectedDepartment == "all" || attorney["department"] == selectedDepartment;
      bool matchesStatus = selectedStatus == "all" || attorney["availability"] == selectedStatus;
      
      return matchesSearch && matchesDepartment && matchesStatus;
    }).toList();
  }

  Color _getAvailabilityColor(String availability) {
    switch (availability) {
      case "available":
        return successColor;
      case "busy":
        return warningColor;
      case "limited":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getAssignmentStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "accepted":
        return infoColor;
      case "pending":
        return warningColor;
      case "declined":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  double _getWorkloadPercentage(Map<String, dynamic> attorney) {
    return (attorney["current_workload"] as int) / (attorney["max_capacity"] as int);
  }

  void _showCreateTaskModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: disabledColor.withAlpha(30),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    "Create New Task Assignment",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      QTextField(
                        label: "Task Title",
                        value: taskTitle,
                        validator: Validator.required,
                        onChanged: (value) {
                          taskTitle = value;
                        },
                      ),
                      SizedBox(height: spMd),
                      QMemoField(
                        label: "Task Description",
                        value: taskDescription,
                        validator: Validator.required,
                        onChanged: (value) {
                          taskDescription = value;
                        },
                      ),
                      SizedBox(height: spMd),
                      QDropdownField(
                        label: "Assign To",
                        items: attorneys.map((attorney) => {
                          "label": "${attorney["name"]} (${attorney["role"]})",
                          "value": attorney["id"],
                        }).toList(),
                        value: selectedAssignee,
                        validator: Validator.required,
                        onChanged: (value, label) {
                          selectedAssignee = value;
                        },
                      ),
                      SizedBox(height: spMd),
                      Row(
                        children: [
                          Expanded(
                            child: QDropdownField(
                              label: "Priority",
                              items: [
                                {"label": "High", "value": "high"},
                                {"label": "Medium", "value": "medium"},
                                {"label": "Low", "value": "low"},
                              ],
                              value: selectedPriority,
                              onChanged: (value, label) {
                                selectedPriority = value;
                              },
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: QDropdownField(
                              label: "Category",
                              items: [
                                {"label": "Document Review", "value": "document_review"},
                                {"label": "Discovery", "value": "discovery"},
                                {"label": "Motion Filing", "value": "motion_filing"},
                                {"label": "Client Communication", "value": "client_communication"},
                                {"label": "Research", "value": "research"},
                              ],
                              value: selectedCategory,
                              validator: Validator.required,
                              onChanged: (value, label) {
                                selectedCategory = value;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spMd),
                      Row(
                        children: [
                          Expanded(
                            child: QDatePicker(
                              label: "Due Date",
                              value: dueDate.isNotEmpty ? DateTime.parse(dueDate) : DateTime.now().add(Duration(days: 7)),
                              onChanged: (value) {
                                dueDate = value.toIso8601String().split('T')[0];
                              },
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: QNumberField(
                              label: "Estimated Hours",
                              value: estimatedHours,
                              validator: Validator.required,
                              onChanged: (value) {
                                estimatedHours = value;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spLg),
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Create Assignment",
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              Navigator.pop(context);
                              ss("Task assignment created successfully");
                              // Reset form
                              taskTitle = "";
                              taskDescription = "";
                              selectedAssignee = "";
                              selectedPriority = "medium";
                              selectedCategory = "";
                              dueDate = "";
                              estimatedHours = "";
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
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
      title: "Task Assignment",
      selectedIndex: 0,
      tabs: [
        Tab(text: "Team Overview", icon: Icon(Icons.people)),
        Tab(text: "Assignments", icon: Icon(Icons.assignment)),
      ],
      tabChildren: [
        // Team Overview Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
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
                          Row(
                            children: [
                              Icon(
                                Icons.people,
                                color: primaryColor,
                                size: 24,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Total Attorneys",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "${attorneys.length}",
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
                          Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: successColor,
                                size: 24,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Available",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "${attorneys.where((a) => a["availability"] == "available").length}",
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
              SizedBox(height: spLg),

              // Filters
              Container(
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
                      "Filter Team Members",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    QTextField(
                      label: "Search by name or expertise...",
                      value: searchQuery,
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Department",
                            items: [
                              {"label": "All Departments", "value": "all"},
                              {"label": "Litigation", "value": "litigation"},
                              {"label": "Corporate", "value": "corporate"},
                              {"label": "Employment", "value": "employment"},
                            ],
                            value: selectedDepartment,
                            onChanged: (value, label) {
                              selectedDepartment = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: QDropdownField(
                            label: "Availability",
                            items: [
                              {"label": "All Status", "value": "all"},
                              {"label": "Available", "value": "available"},
                              {"label": "Busy", "value": "busy"},
                              {"label": "Limited", "value": "limited"},
                            ],
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
                ),
              ),
              SizedBox(height: spLg),

              // Team Members List
              Container(
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
                          Text(
                            "Team Members (${filteredAttorneys.length})",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          QButton(
                            label: "Assign Task",
                            size: bs.sm,
                            onPressed: _showCreateTaskModal,
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: filteredAttorneys.length,
                      separatorBuilder: (context, index) => Divider(height: 1),
                      itemBuilder: (context, index) {
                        final attorney = filteredAttorneys[index];
                        final workloadPercentage = _getWorkloadPercentage(attorney);
                        
                        return Container(
                          padding: EdgeInsets.all(spMd),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: primaryColor,
                                  size: 24,
                                ),
                              ),
                              SizedBox(width: spMd),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${attorney["name"]}",
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
                                            color: _getAvailabilityColor("${attorney["availability"]}").withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${attorney["availability"]}".toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: _getAvailabilityColor("${attorney["availability"]}"),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${attorney["role"]} • ${attorney["department"]}".replaceAll("_", " ").toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(height: spSm),
                                    Row(
                                      children: [
                                        Text(
                                          "Workload: ${attorney["current_workload"]}/${attorney["max_capacity"]}h",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        SizedBox(width: spMd),
                                        Text(
                                          "${attorney["active_cases"]} cases • ${attorney["pending_tasks"]} tasks",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spSm),
                                    Container(
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: disabledColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: FractionallySizedBox(
                                        alignment: Alignment.centerLeft,
                                        widthFactor: workloadPercentage,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: workloadPercentage > 0.8 ? dangerColor : 
                                                   workloadPercentage > 0.6 ? warningColor : successColor,
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
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Assignments Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: [
              Container(
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
                      child: Text(
                        "Recent Assignments",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: assignments.length,
                      separatorBuilder: (context, index) => Divider(height: 1),
                      itemBuilder: (context, index) {
                        final assignment = assignments[index];
                        return Container(
                          padding: EdgeInsets.all(spMd),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${assignment["task_title"]}",
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
                                      color: _getAssignmentStatusColor("${assignment["status"]}").withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${assignment["status"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: _getAssignmentStatusColor("${assignment["status"]}"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spSm),
                              Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Assigned to: ${assignment["assignee_name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Due: ${DateTime.parse("${assignment["due_date"]}").dMMMy}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${(assignment["estimated_hours"] as double).toStringAsFixed(1)}h estimated",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledColor,
                                    ),
                                  ),
                                ],
                              ),
                              if ("${assignment["notes"]}".isNotEmpty) ...[
                                SizedBox(height: spSm),
                                Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: disabledColor.withAlpha(10),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.note,
                                        size: 16,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Expanded(
                                        child: Text(
                                          "${assignment["notes"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        );
                      },
                    ),
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
