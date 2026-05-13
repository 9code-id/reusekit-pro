import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaTaskAssignmentView extends StatefulWidget {
  const HhaTaskAssignmentView({super.key});

  @override
  State<HhaTaskAssignmentView> createState() => _HhaTaskAssignmentViewState();
}

class _HhaTaskAssignmentViewState extends State<HhaTaskAssignmentView> {
  String selectedStatus = "All";
  String selectedPriority = "All";
  String selectedDepartment = "All";
  
  List<String> statusOptions = ["All", "Pending", "In Progress", "Completed", "Overdue"];
  List<String> priorityOptions = ["All", "High", "Medium", "Low"];
  List<String> departmentOptions = ["All", "Housekeeping", "Maintenance", "Reception", "Kitchen", "Security"];

  List<Map<String, dynamic>> tasks = [
    {
      "id": 1,
      "title": "Clean Room 205",
      "description": "Deep clean guest room after checkout",
      "assignedTo": "Maria Santos",
      "assignedBy": "Sarah Johnson",
      "department": "Housekeeping",
      "priority": "High",
      "status": "In Progress",
      "dueDate": "2024-01-15T14:00:00",
      "estimatedHours": 2,
      "completedHours": 1,
      "location": "Floor 2, Room 205",
      "notes": "Guest reported broken lamp",
      "checklist": [
        {"item": "Vacuum carpets", "completed": true},
        {"item": "Change bed linens", "completed": true},
        {"item": "Clean bathroom", "completed": false},
        {"item": "Replace lamp", "completed": false},
      ],
    },
    {
      "id": 2,
      "title": "Fix HVAC Unit",
      "description": "Repair air conditioning unit in conference room",
      "assignedTo": "John Martinez",
      "assignedBy": "Mike Wilson",
      "department": "Maintenance",
      "priority": "Medium",
      "status": "Pending",
      "dueDate": "2024-01-16T10:00:00",
      "estimatedHours": 4,
      "completedHours": 0,
      "location": "Conference Room A",
      "notes": "Unit making strange noise",
      "checklist": [
        {"item": "Inspect unit", "completed": false},
        {"item": "Check filters", "completed": false},
        {"item": "Test controls", "completed": false},
        {"item": "Document repair", "completed": false},
      ],
    },
    {
      "id": 3,
      "title": "Prepare Welcome Package",
      "description": "Prepare welcome packages for VIP guests",
      "assignedTo": "Emma Davis",
      "assignedBy": "Lisa Chen",
      "department": "Reception",
      "priority": "Low",
      "status": "Completed",
      "dueDate": "2024-01-14T16:00:00",
      "estimatedHours": 1,
      "completedHours": 1,
      "location": "Front Desk",
      "notes": "Include local attraction brochures",
      "checklist": [
        {"item": "Gather brochures", "completed": true},
        {"item": "Pack amenities", "completed": true},
        {"item": "Write welcome note", "completed": true},
        {"item": "Deliver to room", "completed": true},
      ],
    },
    {
      "id": 4,
      "title": "Kitchen Deep Clean",
      "description": "Monthly deep cleaning of kitchen equipment",
      "assignedTo": "Carlos Rodriguez",
      "assignedBy": "Anna Lee",
      "department": "Kitchen",
      "priority": "High",
      "status": "Overdue",
      "dueDate": "2024-01-13T18:00:00",
      "estimatedHours": 6,
      "completedHours": 2,
      "location": "Main Kitchen",
      "notes": "Include oven and fryer deep clean",
      "checklist": [
        {"item": "Clean ovens", "completed": true},
        {"item": "Sanitize surfaces", "completed": true},
        {"item": "Clean fryers", "completed": false},
        {"item": "Organize storage", "completed": false},
        {"item": "Update cleaning log", "completed": false},
      ],
    },
  ];

  List<Map<String, dynamic>> get filteredTasks {
    return tasks.where((task) {
      if (selectedStatus != "All" && task["status"] != selectedStatus) return false;
      if (selectedPriority != "All" && task["priority"] != selectedPriority) return false;
      if (selectedDepartment != "All" && task["department"] != selectedDepartment) return false;
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Assignment"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTaskSummary(),
            SizedBox(height: spLg),
            _buildQuickFilters(),
            SizedBox(height: spMd),
            _buildTasksList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateTaskDialog(),
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildTaskSummary() {
    int totalTasks = tasks.length;
    int pendingTasks = tasks.where((task) => task["status"] == "Pending").length;
    int inProgressTasks = tasks.where((task) => task["status"] == "In Progress").length;
    int completedTasks = tasks.where((task) => task["status"] == "Completed").length;
    int overdueTasks = tasks.where((task) => task["status"] == "Overdue").length;

    return Container(
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
              Icon(Icons.assignment, color: primaryColor, size: 28),
              SizedBox(width: spSm),
              Text(
                "Task Overview",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.all(0),
            minItemWidth: 200,
            children: [
              _buildSummaryCard("Total Tasks", totalTasks, Icons.assignment, primaryColor),
              _buildSummaryCard("Pending", pendingTasks, Icons.hourglass_empty, warningColor),
              _buildSummaryCard("In Progress", inProgressTasks, Icons.play_circle, infoColor),
              _buildSummaryCard("Completed", completedTasks, Icons.check_circle, successColor),
              _buildSummaryCard("Overdue", overdueTasks, Icons.error, dangerColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, int count, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(26),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(77)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(height: spXs),
          Text(
            "$count",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Filters",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spXs),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildFilterChip("All", selectedStatus == "All", () {
                selectedStatus = "All";
                setState(() {});
              }),
              _buildFilterChip("Pending", selectedStatus == "Pending", () {
                selectedStatus = "Pending";
                setState(() {});
              }),
              _buildFilterChip("In Progress", selectedStatus == "In Progress", () {
                selectedStatus = "In Progress";
                setState(() {});
              }),
              _buildFilterChip("Overdue", selectedStatus == "Overdue", () {
                selectedStatus = "Overdue";
                setState(() {});
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, VoidCallback onTap) {
    return Container(
      margin: EdgeInsets.only(right: spSm),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
            border: Border.all(
              color: isSelected ? primaryColor : disabledOutlineBorderColor,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTasksList() {
    List<Map<String, dynamic>> displayTasks = filteredTasks;

    if (displayTasks.isEmpty) {
      return Container(
        height: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off, size: 48, color: disabledColor),
              SizedBox(height: spSm),
              Text(
                "No tasks found",
                style: TextStyle(
                  fontSize: fsH6,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "Try adjusting your filters",
                style: TextStyle(
                  color: disabledColor,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tasks (${displayTasks.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ...displayTasks.map((task) => _buildTaskCard(task)).toList(),
      ],
    );
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
    Color statusColor = _getStatusColor(task["status"]);
    Color priorityColor = _getPriorityColor(task["priority"]);
    DateTime dueDate = DateTime.parse(task["dueDate"]);
    bool isOverdue = dueDate.isBefore(DateTime.now()) && task["status"] != "Completed";
    
    List<Map<String, dynamic>> checklist = List<Map<String, dynamic>>.from(task["checklist"]);
    int completedItems = checklist.where((item) => item["completed"] == true).length;
    double progress = checklist.isNotEmpty ? completedItems / checklist.length : 0;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: isOverdue 
          ? Border.all(color: dangerColor.withAlpha(102))
          : null,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${task["status"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: priorityColor.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${task["priority"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: priorityColor,
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${task["department"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${task["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${task["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(Icons.person, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${task["assignedTo"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${task["location"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.schedule, size: 16, color: isOverdue ? dangerColor : disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "Due: ${dueDate.dMMMy} ${TimeOfDay.fromDateTime(dueDate).kkmm}",
                      style: TextStyle(
                        fontSize: 12,
                        color: isOverdue ? dangerColor : disabledBoldColor,
                        fontWeight: isOverdue ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${(task["completedHours"] as int)}/${(task["estimatedHours"] as int)} hrs",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          progress == 1.0 ? successColor : primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${(progress * 100).toInt()}%",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(radiusSm)),
            ),
            child: Row(
              children: [
                QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _showTaskDetails(task),
                ),
                SizedBox(width: spSm),
                if (task["status"] != "Completed") ...[
                  QButton(
                    label: "Update Status",
                    size: bs.sm,
                    onPressed: () => _showUpdateStatusDialog(task),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return warningColor;
      case "In Progress":
        return infoColor;
      case "Completed":
        return successColor;
      case "Overdue":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Tasks"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QDropdownField(
              label: "Status",
              items: statusOptions.map((status) => {
                "label": status,
                "value": status,
              }).toList(),
              value: selectedStatus,
              onChanged: (value, label) {
                selectedStatus = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Priority",
              items: priorityOptions.map((priority) => {
                "label": priority,
                "value": priority,
              }).toList(),
              value: selectedPriority,
              onChanged: (value, label) {
                selectedPriority = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Department",
              items: departmentOptions.map((dept) => {
                "label": dept,
                "value": dept,
              }).toList(),
              value: selectedDepartment,
              onChanged: (value, label) {
                selectedDepartment = value;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Apply",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showTaskDetails(Map<String, dynamic> task) {
    List<Map<String, dynamic>> checklist = List<Map<String, dynamic>>.from(task["checklist"]);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${task["title"]}"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Assigned to: ${task["assignedTo"]}"),
              Text("Department: ${task["department"]}"),
              Text("Priority: ${task["priority"]}"),
              Text("Status: ${task["status"]}"),
              SizedBox(height: spSm),
              Text("Notes:", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("${task["notes"]}"),
              SizedBox(height: spSm),
              Text("Checklist:", style: TextStyle(fontWeight: FontWeight.bold)),
              ...checklist.map((item) => Row(
                children: [
                  Icon(
                    item["completed"] ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: item["completed"] ? successColor : disabledColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${item["item"]}",
                      style: TextStyle(
                        decoration: item["completed"] ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  ),
                ],
              )).toList(),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showUpdateStatusDialog(Map<String, dynamic> task) {
    String newStatus = task["status"];
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Update Task Status"),
        content: QDropdownField(
          label: "Status",
          items: statusOptions.skip(1).map((status) => {
            "label": status,
            "value": status,
          }).toList(),
          value: newStatus,
          onChanged: (value, label) {
            newStatus = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Update",
            size: bs.sm,
            onPressed: () {
              task["status"] = newStatus;
              setState(() {});
              Navigator.pop(context);
              ss("Task status updated successfully");
            },
          ),
        ],
      ),
    );
  }

  void _showCreateTaskDialog() {
    String title = "";
    String description = "";
    String assignedTo = "";
    String department = "Housekeeping";
    String priority = "Medium";
    String location = "";
    String notes = "";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create New Task"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QTextField(
                label: "Task Title",
                value: title,
                onChanged: (value) => title = value,
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Description",
                value: description,
                onChanged: (value) => description = value,
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Assign To",
                value: assignedTo,
                onChanged: (value) => assignedTo = value,
              ),
              SizedBox(height: spSm),
              QDropdownField(
                label: "Department",
                items: departmentOptions.skip(1).map((dept) => {
                  "label": dept,
                  "value": dept,
                }).toList(),
                value: department,
                onChanged: (value, label) => department = value,
              ),
              SizedBox(height: spSm),
              QDropdownField(
                label: "Priority",
                items: priorityOptions.skip(1).map((priority) => {
                  "label": priority,
                  "value": priority,
                }).toList(),
                value: priority,
                onChanged: (value, label) => priority = value,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Create Task",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Task created successfully");
            },
          ),
        ],
      ),
    );
  }
}
