import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmCreateMilestoneView extends StatefulWidget {
  const TpmCreateMilestoneView({super.key});

  @override
  State<TpmCreateMilestoneView> createState() => _TpmCreateMilestoneViewState();
}

class _TpmCreateMilestoneViewState extends State<TpmCreateMilestoneView> {
  final formKey = GlobalKey<FormState>();
  
  String title = "";
  String description = "";
  String project = "";
  String assignedTo = "";
  String priority = "medium";
  String status = "pending";
  DateTime startDate = DateTime.now();
  DateTime dueDate = DateTime.now().add(Duration(days: 30));
  double budget = 0.0;
  List<String> attachments = [];
  List<Map<String, dynamic>> tasks = [];
  
  bool isEditMode = false;
  String newTaskTitle = "";
  String newTaskDescription = "";
  String newTaskAssignee = "";
  String newTaskPriority = "medium";
  DateTime newTaskDueDate = DateTime.now().add(Duration(days: 7));
  int newTaskEstimatedTime = 8;

  List<Map<String, dynamic>> projectOptions = [
    {"label": "Mobile App Development", "value": "mobile_app"},
    {"label": "Website Redesign", "value": "website_redesign"},
    {"label": "Backend System", "value": "backend_system"},
    {"label": "Documentation Portal", "value": "documentation"},
    {"label": "Marketing Campaign", "value": "marketing"},
  ];

  List<Map<String, dynamic>> teamOptions = [
    {"label": "Development Team", "value": "dev_team"},
    {"label": "Design Team", "value": "design_team"},
    {"label": "QA Team", "value": "qa_team"},
    {"label": "Marketing Team", "value": "marketing_team"},
    {"label": "Management Team", "value": "management_team"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "Low", "value": "low"},
    {"label": "Medium", "value": "medium"},
    {"label": "High", "value": "high"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "Pending", "value": "pending"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Completed", "value": "completed"},
  ];

  List<Map<String, dynamic>> memberOptions = [
    {"label": "Alice Johnson", "value": "alice"},
    {"label": "Bob Smith", "value": "bob"},
    {"label": "Charlie Brown", "value": "charlie"},
    {"label": "Diana Wilson", "value": "diana"},
    {"label": "Eve Davis", "value": "eve"},
  ];

  void _addTask() {
    if (newTaskTitle.isNotEmpty && newTaskDescription.isNotEmpty) {
      setState(() {
        tasks.add({
          "id": tasks.length + 1,
          "title": newTaskTitle,
          "description": newTaskDescription,
          "assignee": newTaskAssignee,
          "priority": newTaskPriority,
          "dueDate": newTaskDueDate.toIso8601String(),
          "estimatedTime": newTaskEstimatedTime,
          "status": "pending",
          "progress": 0,
        });
        
        // Reset task form
        newTaskTitle = "";
        newTaskDescription = "";
        newTaskAssignee = "";
        newTaskPriority = "medium";
        newTaskDueDate = DateTime.now().add(Duration(days: 7));
        newTaskEstimatedTime = 8;
      });
      ss("Task added successfully");
    }
  }

  void _removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
    ss("Task removed");
  }

  void _saveMilestone() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      ss(isEditMode ? "Milestone updated successfully" : "Milestone created successfully");
      back();
    }
  }

  String getPriorityText(String priority) {
    switch (priority) {
      case "high":
        return "High";
      case "medium":
        return "Medium";
      case "low":
        return "Low";
      default:
        return "Medium";
    }
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return infoColor;
      default:
        return warningColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? "Edit Milestone" : "Create Milestone"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveMilestone,
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Basic Information
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
                      "Basic Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QTextField(
                      label: "Milestone Title",
                      value: title,
                      hint: "Enter milestone title",
                      validator: Validator.required,
                      onChanged: (value) {
                        title = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Description",
                      value: description,
                      hint: "Describe the milestone objectives and requirements",
                      validator: Validator.required,
                      onChanged: (value) {
                        description = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Project",
                            items: projectOptions,
                            value: project,
                            validator: Validator.required,
                            onChanged: (value, label) {
                              project = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Assigned To",
                            items: teamOptions,
                            value: assignedTo,
                            validator: Validator.required,
                            onChanged: (value, label) {
                              assignedTo = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Priority",
                            items: priorityOptions,
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
                            label: "Status",
                            items: statusOptions,
                            value: status,
                            onChanged: (value, label) {
                              status = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Timeline and Budget
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
                      "Timeline & Budget",
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
                            value: startDate,
                            onChanged: (value) {
                              startDate = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDatePicker(
                            label: "Due Date",
                            value: dueDate,
                            onChanged: (value) {
                              dueDate = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QNumberField(
                      label: "Budget (\$)",
                      value: budget.toString(),
                      hint: "Enter milestone budget",
                      validator: Validator.required,
                      onChanged: (value) {
                        budget = double.tryParse("$value") ?? 0.0;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Attachments
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
                      "Attachments",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QAttachmentPicker(
                      label: "Project Files",
                      value: attachments,
                      hint: "Attach relevant documents, images, or files",
                      onChanged: (value) {
                        attachments = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Tasks Section
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
                        Text(
                          "Tasks (${tasks.length})",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Add Task",
                          size: bs.sm,
                          icon: Icons.add,
                          onPressed: () {
                            _showAddTaskDialog();
                          },
                        ),
                      ],
                    ),
                    
                    // Tasks List
                    if (tasks.isNotEmpty)
                      ...tasks.asMap().entries.map((entry) {
                        int index = entry.key;
                        Map<String, dynamic> task = entry.value;
                        
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border(
                              left: BorderSide(
                                width: 3,
                                color: getPriorityColor(task["priority"]),
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${task["title"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: getPriorityColor(task["priority"]).withAlpha(30),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      getPriorityText(task["priority"]),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: getPriorityColor(task["priority"]),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  GestureDetector(
                                    onTap: () => _removeTask(index),
                                    child: Icon(
                                      Icons.delete,
                                      size: 18,
                                      color: dangerColor,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${task["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${task["assignee"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.schedule,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${task["estimatedTime"]}h",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    
                    if (tasks.isEmpty)
                      Container(
                        padding: EdgeInsets.all(spLg),
                        child: Column(
                          children: [
                            Icon(
                              Icons.task_alt,
                              size: 48,
                              color: disabledColor,
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "No tasks added yet",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Add tasks to break down this milestone",
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
              ),

              // Action Buttons
              Container(
                width: double.infinity,
                child: QButton(
                  label: isEditMode ? "Update Milestone" : "Create Milestone",
                  size: bs.md,
                  onPressed: _saveMilestone,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: EdgeInsets.all(spMd),
          constraints: BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              Text(
                "Add New Task",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QTextField(
                label: "Task Title",
                value: newTaskTitle,
                hint: "Enter task title",
                onChanged: (value) {
                  newTaskTitle = value;
                  setState(() {});
                },
              ),
              QMemoField(
                label: "Description",
                value: newTaskDescription,
                hint: "Describe the task",
                onChanged: (value) {
                  newTaskDescription = value;
                  setState(() {});
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Assignee",
                      items: memberOptions,
                      value: newTaskAssignee,
                      onChanged: (value, label) {
                        newTaskAssignee = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Priority",
                      items: priorityOptions,
                      value: newTaskPriority,
                      onChanged: (value, label) {
                        newTaskPriority = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: QDatePicker(
                      label: "Due Date",
                      value: newTaskDueDate,
                      onChanged: (value) {
                        newTaskDueDate = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QNumberField(
                      label: "Estimated Hours",
                      value: newTaskEstimatedTime.toString(),
                      onChanged: (value) {
                        newTaskEstimatedTime = int.tryParse("$value") ?? 8;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Cancel",
                      size: bs.sm,
                      onPressed: () => back(),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Add Task",
                      size: bs.sm,
                      onPressed: () {
                        _addTask();
                        back();
                      },
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
