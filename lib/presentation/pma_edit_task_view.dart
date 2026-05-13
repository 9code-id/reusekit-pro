import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaEditTaskView extends StatefulWidget {
  const PmaEditTaskView({super.key});

  @override
  State<PmaEditTaskView> createState() => _PmaEditTaskViewState();
}

class _PmaEditTaskViewState extends State<PmaEditTaskView> {
  final formKey = GlobalKey<FormState>();
  
  String taskTitle = "Redesign Mobile App Interface";
  String taskDescription = "Create new UI/UX design for the mobile application including wireframes, mockups, and interactive prototypes";
  String selectedProject = "mobile_app";
  String selectedAssignee = "john_doe";
  String selectedPriority = "high";
  String selectedStatus = "in_progress";
  DateTime? startDate = DateTime.now();
  DateTime? dueDate = DateTime.now().add(Duration(days: 7));
  String estimatedHours = "40";
  List<String> selectedTags = ["design", "mobile"];
  List<String> attachments = [];
  bool isActive = true;

  List<Map<String, dynamic>> projectItems = [
    {"label": "Mobile App Redesign", "value": "mobile_app"},
    {"label": "Website Development", "value": "website_dev"},
    {"label": "Marketing Campaign", "value": "marketing"},
    {"label": "Product Launch", "value": "product_launch"},
  ];

  List<Map<String, dynamic>> assigneeItems = [
    {"label": "John Doe (UI/UX Designer)", "value": "john_doe"},
    {"label": "Sarah Smith (Frontend Developer)", "value": "sarah_smith"},
    {"label": "Mike Johnson (Backend Developer)", "value": "mike_johnson"},
    {"label": "Lisa Brown (Project Manager)", "value": "lisa_brown"},
  ];

  List<Map<String, dynamic>> priorityItems = [
    {"label": "Low", "value": "low"},
    {"label": "Medium", "value": "medium"},
    {"label": "High", "value": "high"},
    {"label": "Critical", "value": "critical"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "To Do", "value": "todo"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Review", "value": "review"},
    {"label": "Done", "value": "done"},
    {"label": "Blocked", "value": "blocked"},
  ];

  List<Map<String, dynamic>> tagItems = [
    {"label": "Design", "value": "design"},
    {"label": "Development", "value": "development"},
    {"label": "Mobile", "value": "mobile"},
    {"label": "Web", "value": "web"},
    {"label": "Frontend", "value": "frontend"},
    {"label": "Backend", "value": "backend"},
    {"label": "Testing", "value": "testing"},
    {"label": "Bug Fix", "value": "bug"},
  ];

  Color _getPriorityColor(String priority) {
    switch (priority) {
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
    switch (status) {
      case 'todo':
        return disabledBoldColor;
      case 'in_progress':
        return infoColor;
      case 'review':
        return warningColor;
      case 'done':
        return successColor;
      case 'blocked':
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  void _saveTask() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      await Future.delayed(Duration(seconds: 2));
      hideLoading();
      ss("Task updated successfully");
      back();
    }
  }

  void _deleteTask() async {
    bool isConfirmed = await confirm("Are you sure you want to delete this task?");
    if (isConfirmed) {
      showLoading();
      await Future.delayed(Duration(seconds: 1));
      hideLoading();
      ss("Task deleted successfully");
      back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Task"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _deleteTask,
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with current status
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
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getStatusColor(selectedStatus).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            statusItems.firstWhere((item) => item["value"] == selectedStatus)["label"],
                            style: TextStyle(
                              color: _getStatusColor(selectedStatus),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getPriorityColor(selectedPriority).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            priorityItems.firstWhere((item) => item["value"] == selectedPriority)["label"],
                            style: TextStyle(
                              color: _getPriorityColor(selectedPriority),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Task #12345",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Last updated: 2 hours ago by John Doe",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              // Basic Information
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Basic Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QTextField(
                      label: "Task Title",
                      value: taskTitle,
                      validator: Validator.required,
                      onChanged: (value) {
                        taskTitle = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Description",
                      value: taskDescription,
                      hint: "Describe the task in detail...",
                      validator: Validator.required,
                      onChanged: (value) {
                        taskDescription = value;
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Project",
                      items: projectItems,
                      value: selectedProject,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        selectedProject = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Assignment & Priority
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Assignment & Priority",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QDropdownField(
                      label: "Assignee",
                      items: assigneeItems,
                      value: selectedAssignee,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        selectedAssignee = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Priority",
                            items: priorityItems,
                            value: selectedPriority,
                            validator: Validator.required,
                            onChanged: (value, label) {
                              selectedPriority = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: QDropdownField(
                            label: "Status",
                            items: statusItems,
                            value: selectedStatus,
                            validator: Validator.required,
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

              // Timeline
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Timeline",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QDatePicker(
                            label: "Start Date",
                            value: startDate!,
                            onChanged: (value) {
                              startDate = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: QDatePicker(
                            label: "Due Date",
                            value: dueDate!,
                            onChanged: (value) {
                              dueDate = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QNumberField(
                      label: "Estimated Hours",
                      value: estimatedHours,
                      validator: Validator.required,
                      onChanged: (value) {
                        estimatedHours = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Additional Settings
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Additional Settings",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Active Task",
                          "value": true,
                          "checked": isActive,
                        }
                      ],
                      value: [
                        if (isActive)
                          {"label": "Active Task", "value": true, "checked": true}
                      ],
                      onChanged: (values, ids) {
                        setState(() {
                          isActive = values.isNotEmpty;
                        });
                      },
                    ),
                    QAttachmentPicker(
                      label: "Attachments",
                      value: attachments,
                      hint: "Add files related to this task",
                      onChanged: (value) {
                        attachments = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Progress Tracking
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Progress Tracking",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Progress",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Container(
                                height: 8,
                                decoration: BoxDecoration(
                                  color: disabledColor,
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: FractionallySizedBox(
                                  widthFactor: 0.65,
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(radiusLg),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "65% Complete",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spLg),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Time Spent",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "26h / 40h",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "14h remaining",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Cancel",
                      color: disabledBoldColor,
                      size: bs.md,
                      onPressed: () {
                        back();
                      },
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    flex: 2,
                    child: QButton(
                      label: "Save Changes",
                      size: bs.md,
                      onPressed: _saveTask,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
