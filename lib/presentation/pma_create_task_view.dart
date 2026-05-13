import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaCreateTaskView extends StatefulWidget {
  const PmaCreateTaskView({super.key});

  @override
  State<PmaCreateTaskView> createState() => _PmaCreateTaskViewState();
}

class _PmaCreateTaskViewState extends State<PmaCreateTaskView> {
  final formKey = GlobalKey<FormState>();
  
  String taskTitle = "";
  String taskDescription = "";
  String selectedProject = "Project Alpha";
  String selectedAssignee = "John Smith";
  String selectedPriority = "Medium";
  String selectedStatus = "To Do";
  String selectedCategory = "Development";
  DateTime selectedDueDate = DateTime.now().add(Duration(days: 7));
  TimeOfDay selectedDueTime = TimeOfDay(hour: 17, minute: 0);
  double estimatedHours = 8.0;
  List<String> taskTags = [];
  List<String> attachments = [];
  bool notifyAssignee = true;
  bool addToCalendar = false;
  bool billableTask = false;
  
  List<Map<String, dynamic>> projects = [
    {"label": "Project Alpha", "value": "Project Alpha"},
    {"label": "Project Beta", "value": "Project Beta"},
    {"label": "Project Gamma", "value": "Project Gamma"},
    {"label": "Project Delta", "value": "Project Delta"},
  ];
  
  List<Map<String, dynamic>> assignees = [
    {"label": "John Smith", "value": "John Smith"},
    {"label": "Sarah Johnson", "value": "Sarah Johnson"},
    {"label": "Mike Wilson", "value": "Mike Wilson"},
    {"label": "Emma Davis", "value": "Emma Davis"},
    {"label": "David Brown", "value": "David Brown"},
  ];
  
  List<Map<String, dynamic>> priorities = [
    {"label": "Low", "value": "Low"},
    {"label": "Medium", "value": "Medium"},
    {"label": "High", "value": "High"},
    {"label": "Critical", "value": "Critical"},
  ];
  
  List<Map<String, dynamic>> statuses = [
    {"label": "To Do", "value": "To Do"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Review", "value": "Review"},
    {"label": "Done", "value": "Done"},
  ];
  
  List<Map<String, dynamic>> categories = [
    {"label": "Development", "value": "Development"},
    {"label": "Design", "value": "Design"},
    {"label": "Testing", "value": "Testing"},
    {"label": "Documentation", "value": "Documentation"},
    {"label": "Meeting", "value": "Meeting"},
    {"label": "Bug Fix", "value": "Bug Fix"},
  ];
  
  List<Map<String, dynamic>> availableTags = [
    {"label": "Frontend", "value": "Frontend", "checked": false},
    {"label": "Backend", "value": "Backend", "checked": false},
    {"label": "API", "value": "API", "checked": false},
    {"label": "Database", "value": "Database", "checked": false},
    {"label": "UI/UX", "value": "UI/UX", "checked": false},
    {"label": "Mobile", "value": "Mobile", "checked": false},
    {"label": "Security", "value": "Security", "checked": false},
    {"label": "Performance", "value": "Performance", "checked": false},
  ];

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical": return dangerColor;
      case "High": return warningColor;
      case "Medium": return infoColor;
      case "Low": return successColor;
      default: return disabledColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "To Do": return disabledColor;
      case "In Progress": return infoColor;
      case "Review": return warningColor;
      case "Done": return successColor;
      default: return disabledColor;
    }
  }

  void _createTask() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      ss("Task created successfully!");
      back();
    }
  }

  void _saveDraft() async {
    showLoading();
    
    // Simulate saving draft
    await Future.delayed(Duration(seconds: 1));
    
    hideLoading();
    si("Task saved as draft");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Task"),
        actions: [
          TextButton(
            onPressed: _saveDraft,
            child: Text(
              "Save Draft",
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Task Basic Information
              Container(
                padding: EdgeInsets.all(spMd),
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
                        Icon(
                          Icons.task_alt,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Task Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    QTextField(
                      label: "Task Title",
                      value: taskTitle,
                      hint: "Enter task title",
                      validator: Validator.required,
                      onChanged: (value) {
                        taskTitle = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Task Description",
                      value: taskDescription,
                      hint: "Describe the task details, requirements, and acceptance criteria",
                      validator: Validator.required,
                      onChanged: (value) {
                        taskDescription = value;
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Project",
                      items: projects,
                      value: selectedProject,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        selectedProject = value;
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Category",
                      items: categories,
                      value: selectedCategory,
                      onChanged: (value, label) {
                        selectedCategory = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Task Assignment
              Container(
                padding: EdgeInsets.all(spMd),
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
                        Icon(
                          Icons.person_add,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Assignment & Priority",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    QDropdownField(
                      label: "Assigned To",
                      items: assignees,
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
                            items: priorities,
                            value: selectedPriority,
                            onChanged: (value, label) {
                              selectedPriority = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Status",
                            items: statuses,
                            value: selectedStatus,
                            onChanged: (value, label) {
                              selectedStatus = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    // Priority and Status Preview
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: _getPriorityColor(selectedPriority).withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: Border.all(
                              color: _getPriorityColor(selectedPriority),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: _getPriorityColor(selectedPriority),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                selectedPriority,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _getPriorityColor(selectedPriority),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(selectedStatus).withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: Border.all(
                              color: _getStatusColor(selectedStatus),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: _getStatusColor(selectedStatus),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                selectedStatus,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _getStatusColor(selectedStatus),
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

              // Schedule & Timeline
              Container(
                padding: EdgeInsets.all(spMd),
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
                        Icon(
                          Icons.schedule,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Schedule & Timeline",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: QDatePicker(
                            label: "Due Date",
                            value: selectedDueDate,
                            onChanged: (value) {
                              selectedDueDate = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTimePicker(
                            label: "Due Time",
                            value: selectedDueTime,
                            onChanged: (value) {
                              selectedDueTime = value!;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QNumberField(
                      label: "Estimated Hours",
                      value: estimatedHours.toString(),
                      hint: "Enter estimated time in hours",
                      onChanged: (value) {
                        estimatedHours = double.tryParse(value) ?? 0.0;
                        setState(() {});
                      },
                    ),
                    // Timeline Preview
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: primaryColor.withAlpha(76),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: primaryColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "Due: ${selectedDueDate.dMMMy} at ${selectedDueTime.kkmm} • Est. ${estimatedHours.toStringAsFixed(1)}h",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Tags & Labels
              Container(
                padding: EdgeInsets.all(spMd),
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
                        Icon(
                          Icons.label,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Tags & Labels",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    QSwitch(
                      label: "Select Tags",
                      items: availableTags,
                      value: availableTags.where((tag) => tag["checked"] == true).toList(),
                      onChanged: (values, ids) {
                        for (var tag in availableTags) {
                          tag["checked"] = values.any((v) => v["value"] == tag["value"]);
                        }
                        taskTags = values.map((v) => v["value"] as String).toList();
                        setState(() {});
                      },
                    ),
                    if (taskTags.isNotEmpty) ...[
                      SizedBox(height: spXs),
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: taskTags.map((tag) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: secondaryColor.withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusLg),
                              border: Border.all(
                                color: secondaryColor,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              tag,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: secondaryColor,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ],
                ),
              ),

              // Attachments
              Container(
                padding: EdgeInsets.all(spMd),
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
                        Icon(
                          Icons.attach_file,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Attachments",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    QAttachmentPicker(
                      label: "Task Attachments",
                      value: attachments,
                      hint: "Add relevant files, documents, or images",
                      maxAttachments: 10,
                      allowedTypes: ['image', 'document', 'video', 'audio'],
                      onChanged: (value) {
                        attachments = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Task Options
              Container(
                padding: EdgeInsets.all(spMd),
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
                        Icon(
                          Icons.settings,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Task Options",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Switch(
                                value: notifyAssignee,
                                onChanged: (value) {
                                  notifyAssignee = value;
                                  setState(() {});
                                },
                                activeColor: primaryColor,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "Notify Assignee",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Switch(
                                value: addToCalendar,
                                onChanged: (value) {
                                  addToCalendar = value;
                                  setState(() {});
                                },
                                activeColor: primaryColor,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "Add to Calendar",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Switch(
                                value: billableTask,
                                onChanged: (value) {
                                  billableTask = value;
                                  setState(() {});
                                },
                                activeColor: primaryColor,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "Billable Task",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
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

              // Action Buttons
              Container(
                width: double.infinity,
                child: Column(
                  spacing: spSm,
                  children: [
                    QButton(
                      label: "Create Task",
                      size: bs.md,
                      onPressed: _createTask,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Save as Template",
                            color: secondaryColor,
                            size: bs.sm,
                            onPressed: () {
                              si("Task saved as template");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Cancel",
                            color: disabledColor,
                            size: bs.sm,
                            onPressed: () {
                              back();
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
      ),
    );
  }
}
