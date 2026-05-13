import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaCreateMilestoneView extends StatefulWidget {
  const PmaCreateMilestoneView({super.key});

  @override
  State<PmaCreateMilestoneView> createState() => _PmaCreateMilestoneViewState();
}

class _PmaCreateMilestoneViewState extends State<PmaCreateMilestoneView> {
  final formKey = GlobalKey<FormState>();
  
  String milestoneTitle = "";
  String milestoneDescription = "";
  String selectedProject = "";
  String selectedPriority = "medium";
  String selectedAssignee = "";
  DateTime startDate = DateTime.now();
  DateTime dueDate = DateTime.now().add(Duration(days: 30));
  double estimatedBudget = 0.0;
  int estimatedHours = 0;
  String deliverables = "";
  String successCriteria = "";
  
  List<Map<String, dynamic>> tasks = [];
  List<Map<String, dynamic>> dependencies = [];
  List<String> tags = [];
  String newTag = "";
  
  List<Map<String, dynamic>> projectOptions = [
    {"label": "E-commerce Platform", "value": "ecommerce"},
    {"label": "Mobile App Development", "value": "mobile"},
    {"label": "Website Redesign", "value": "website"},
    {"label": "CRM System", "value": "crm"},
    {"label": "Data Analytics Dashboard", "value": "analytics"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  List<Map<String, dynamic>> assigneeOptions = [
    {"label": "Sarah Johnson", "value": "sarah.johnson"},
    {"label": "Michael Chen", "value": "michael.chen"},
    {"label": "Emma Davis", "value": "emma.davis"},
    {"label": "David Wilson", "value": "david.wilson"},
    {"label": "Alex Thompson", "value": "alex.thompson"},
    {"label": "Lisa Rodriguez", "value": "lisa.rodriguez"},
  ];

  List<Map<String, dynamic>> availableDependencies = [
    {"label": "Design System Complete", "value": "design_system"},
    {"label": "API Development", "value": "api_dev"},
    {"label": "Database Setup", "value": "database"},
    {"label": "Security Audit", "value": "security"},
    {"label": "Infrastructure Setup", "value": "infrastructure"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Milestone"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveDraft,
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
              _buildBasicInfoSection(),
              _buildProjectAndAssignmentSection(),
              _buildTimelineAndBudgetSection(),
              _buildTasksSection(),
              _buildDependenciesSection(),
              _buildDeliverablesSection(),
              _buildTagsSection(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBasicInfoSection() {
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
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.flag,
                  color: primaryColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "Basic Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Milestone Title",
            value: milestoneTitle,
            hint: "Enter a clear and descriptive title",
            validator: Validator.required,
            onChanged: (value) {
              milestoneTitle = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Description",
            value: milestoneDescription,
            hint: "Describe the milestone objectives and scope...",
            validator: Validator.required,
            onChanged: (value) {
              milestoneDescription = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProjectAndAssignmentSection() {
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
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.business,
                  color: infoColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "Project & Assignment",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Project",
            items: projectOptions,
            value: selectedProject,
            validator: Validator.required,
            onChanged: (value, label) {
              selectedProject = value;
              setState(() {});
            },
          ),
          Row(
            children: [
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
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Assignee",
                  items: assigneeOptions,
                  value: selectedAssignee,
                  validator: Validator.required,
                  onChanged: (value, label) {
                    selectedAssignee = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineAndBudgetSection() {
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
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.schedule,
                  color: successColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "Timeline & Budget",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
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
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Estimated Budget (\$)",
                  value: estimatedBudget.toString(),
                  onChanged: (value) {
                    estimatedBudget = double.tryParse(value) ?? 0.0;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Estimated Hours",
                  value: estimatedHours.toString(),
                  onChanged: (value) {
                    estimatedHours = int.tryParse(value) ?? 0;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTasksSection() {
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
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.task_alt,
                  color: warningColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Tasks (${tasks.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              QButton(
                label: "Add Task",
                icon: Icons.add,
                size: bs.sm,
                onPressed: _addTask,
              ),
            ],
          ),
          if (tasks.isEmpty) ...[
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
                    "Break down your milestone into smaller tasks",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            ...tasks.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> task = entry.value;
              return _buildTaskItem(task, index);
            }).toList(),
          ],
        ],
      ),
    );
  }

  Widget _buildTaskItem(Map<String, dynamic> task, int index) {
    Color priorityColor = _getPriorityColor(task["priority"]);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${task["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: priorityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: priorityColor),
                ),
                child: Text(
                  "${task["priority"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: priorityColor,
                  ),
                ),
              ),
              SizedBox(width: spXs),
              GestureDetector(
                onTap: () => _removeTask(index),
                child: Icon(
                  Icons.close,
                  size: 20,
                  color: dangerColor,
                ),
              ),
            ],
          ),
          if (task["description"] != null && (task["description"] as String).isNotEmpty) ...[
            Text(
              "${task["description"]}",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
          Row(
            children: [
              Text(
                "Assignee: ${task["assignedTo"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "Est. Hours: ${task["estimatedHours"]}h",
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

  Widget _buildDependenciesSection() {
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
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: secondaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.account_tree,
                  color: secondaryColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Dependencies (${dependencies.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              QButton(
                label: "Add Dependency",
                icon: Icons.add,
                size: bs.sm,
                onPressed: _showDependencySelector,
              ),
            ],
          ),
          if (dependencies.isEmpty) ...[
            Container(
              padding: EdgeInsets.all(spMd),
              child: Text(
                "No dependencies added. Dependencies help track prerequisite milestones.",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ] else ...[
            ...dependencies.map((dependency) => _buildDependencyItem(dependency)).toList(),
          ],
        ],
      ),
    );
  }

  Widget _buildDependencyItem(Map<String, dynamic> dependency) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: secondaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: secondaryColor.withAlpha(100)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.link,
            color: secondaryColor,
            size: 16,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              "${dependency["title"]}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => _removeDependency(dependency),
            child: Icon(
              Icons.close,
              size: 16,
              color: dangerColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliverablesSection() {
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
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.assignment,
                  color: dangerColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "Deliverables & Success Criteria",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          QMemoField(
            label: "Deliverables",
            value: deliverables,
            hint: "List the expected deliverables and outputs...",
            onChanged: (value) {
              deliverables = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Success Criteria",
            value: successCriteria,
            hint: "Define what success looks like for this milestone...",
            onChanged: (value) {
              successCriteria = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTagsSection() {
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
          Text(
            "Tags",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Add Tag",
                  value: newTag,
                  hint: "Enter a tag and press Add",
                  onChanged: (value) {
                    newTag = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Add",
                size: bs.sm,
                onPressed: _addTag,
              ),
            ],
          ),
          if (tags.isNotEmpty) ...[
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: tags.map((tag) => _buildTagChip(tag)).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTagChip(String tag) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            tag,
            style: TextStyle(
              fontSize: 12,
              color: primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: spXs),
          GestureDetector(
            onTap: () => _removeTag(tag),
            child: Icon(
              Icons.close,
              size: 16,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Create Milestone",
            icon: Icons.flag,
            onPressed: _createMilestone,
          ),
        ),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Save as Draft",
            icon: Icons.drafts,
            onPressed: _saveDraft,
          ),
        ),
      ],
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  void _addTask() {
    _showTaskDialog();
  }

  void _showTaskDialog() {
    String taskTitle = "";
    String taskDescription = "";
    String taskPriority = "medium";
    String taskAssignee = "";
    int taskHours = 8;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Task"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              QTextField(
                label: "Task Title",
                value: taskTitle,
                onChanged: (value) => taskTitle = value,
              ),
              QMemoField(
                label: "Description",
                value: taskDescription,
                onChanged: (value) => taskDescription = value,
              ),
              QDropdownField(
                label: "Priority",
                items: priorityOptions,
                value: taskPriority,
                onChanged: (value, label) => taskPriority = value,
              ),
              QDropdownField(
                label: "Assignee",
                items: assigneeOptions,
                value: taskAssignee,
                onChanged: (value, label) => taskAssignee = value,
              ),
              QNumberField(
                label: "Estimated Hours",
                value: taskHours.toString(),
                onChanged: (value) => taskHours = int.tryParse(value) ?? 8,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (taskTitle.isNotEmpty) {
                setState(() {
                  tasks.add({
                    "title": taskTitle,
                    "description": taskDescription,
                    "priority": taskPriority,
                    "assignedTo": taskAssignee.isNotEmpty ? taskAssignee : "Unassigned",
                    "estimatedHours": taskHours,
                  });
                });
                Navigator.pop(context);
                ss("Task added successfully");
              }
            },
            child: Text("Add Task"),
          ),
        ],
      ),
    );
  }

  void _removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
    ss("Task removed");
  }

  void _showDependencySelector() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Dependency"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: availableDependencies.map((dep) {
            bool isAlreadyAdded = dependencies.any((d) => d["value"] == dep["value"]);
            return ListTile(
              title: Text("${dep["label"]}"),
              trailing: isAlreadyAdded 
                ? Icon(Icons.check, color: successColor)
                : Icon(Icons.add),
              onTap: isAlreadyAdded ? null : () {
                setState(() {
                  dependencies.add({
                    "title": dep["label"],
                    "value": dep["value"],
                  });
                });
                Navigator.pop(context);
                ss("Dependency added");
              },
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  void _removeDependency(Map<String, dynamic> dependency) {
    setState(() {
      dependencies.remove(dependency);
    });
    ss("Dependency removed");
  }

  void _addTag() {
    if (newTag.isNotEmpty && !tags.contains(newTag)) {
      setState(() {
        tags.add(newTag);
        newTag = "";
      });
      ss("Tag added");
    }
  }

  void _removeTag(String tag) {
    setState(() {
      tags.remove(tag);
    });
  }

  void _createMilestone() {
    if (formKey.currentState!.validate()) {
      if (selectedProject.isEmpty) {
        se("Please select a project");
        return;
      }
      if (selectedAssignee.isEmpty) {
        se("Please assign the milestone to someone");
        return;
      }
      
      ss("Milestone created successfully!");
      Navigator.pop(context);
    }
  }

  void _saveDraft() {
    si("Milestone saved as draft");
  }
}
