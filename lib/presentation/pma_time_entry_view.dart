import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaTimeEntryView extends StatefulWidget {
  const PmaTimeEntryView({super.key});

  @override
  State<PmaTimeEntryView> createState() => _PmaTimeEntryViewState();
}

class _PmaTimeEntryViewState extends State<PmaTimeEntryView> {
  final formKey = GlobalKey<FormState>();
  
  String selectedProject = "";
  String selectedTask = "";
  String selectedDate = DateTime.now().toString().substring(0, 10);
  String startTime = "";
  String endTime = "";
  String description = "";
  bool isBillable = true;
  
  List<Map<String, dynamic>> projectOptions = [
    {"label": "E-commerce Platform", "value": "E-commerce Platform"},
    {"label": "Mobile App Development", "value": "Mobile App Development"},
    {"label": "Website Redesign", "value": "Website Redesign"},
    {"label": "API Integration", "value": "API Integration"},
    {"label": "Database Migration", "value": "Database Migration"},
    {"label": "Internal Tools", "value": "Internal Tools"},
  ];
  
  List<Map<String, dynamic>> taskOptions = [
    {"label": "Frontend Development", "value": "Frontend Development"},
    {"label": "Backend Development", "value": "Backend Development"},
    {"label": "UI/UX Design", "value": "UI/UX Design"},
    {"label": "Code Review", "value": "Code Review"},
    {"label": "Testing", "value": "Testing"},
    {"label": "Documentation", "value": "Documentation"},
    {"label": "Client Meeting", "value": "Client Meeting"},
    {"label": "Team Meeting", "value": "Team Meeting"},
    {"label": "Bug Fixing", "value": "Bug Fixing"},
    {"label": "Research", "value": "Research"},
  ];
  
  List<Map<String, dynamic>> recentEntries = [
    {
      "id": 1,
      "project": "E-commerce Platform",
      "task": "Frontend Development",
      "date": "2025-06-19",
      "startTime": "09:00",
      "endTime": "12:30",
      "duration": "3h 30m",
      "description": "Implemented product listing page with filters and pagination",
      "billable": true
    },
    {
      "id": 2,
      "project": "Mobile App Development",
      "task": "UI/UX Design",
      "date": "2025-06-19",
      "startTime": "13:30",
      "endTime": "15:00",
      "duration": "1h 30m",
      "description": "Created wireframes for user profile screen",
      "billable": true
    },
    {
      "id": 3,
      "project": "Website Redesign",
      "task": "Client Meeting",
      "date": "2025-06-19",
      "startTime": "15:30",
      "endTime": "16:30",
      "duration": "1h 00m",
      "description": "Discussed project requirements and timeline with client",
      "billable": false
    },
    {
      "id": 4,
      "project": "API Integration",
      "task": "Backend Development",
      "date": "2025-06-18",
      "startTime": "10:00",
      "endTime": "11:30",
      "duration": "1h 30m",
      "description": "Implemented user authentication endpoints",
      "billable": true
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time Entry"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveEntry,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              _buildTimeEntryForm(),
              _buildQuickActions(),
              _buildRecentEntries(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeEntryForm() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "New Time Entry",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          // Project and Task Selection
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Project",
                  items: projectOptions,
                  value: selectedProject,
                  validator: Validator.required,
                  onChanged: (value, label) {
                    selectedProject = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Task",
                  items: taskOptions,
                  value: selectedTask,
                  validator: Validator.required,
                  onChanged: (value, label) {
                    selectedTask = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          // Date Selection
          QDatePicker(
            label: "Date",
            value: DateTime.parse(selectedDate),
            validator: Validator.required,
            onChanged: (value) {
              selectedDate = value.toString().substring(0, 10);
              setState(() {});
            },
          ),
          
          // Time Selection
          Row(
            children: [
              Expanded(
                child: QTimePicker(
                  label: "Start Time",
                  value: startTime.isNotEmpty ? startTime.timeOfDay : null,
                  validator: (value) {
                    if (value == null) return "Start time is required";
                    return null;
                  },
                  onChanged: (value) {
                    startTime = value?.kkmm ?? "";
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTimePicker(
                  label: "End Time",
                  value: endTime.isNotEmpty ? endTime.timeOfDay : null,
                  validator: (value) {
                    if (value == null) return "End time is required";
                    return null;
                  },
                  onChanged: (value) {
                    endTime = value?.kkmm ?? "";
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          // Duration Display
          if (startTime.isNotEmpty && endTime.isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Duration: ${_calculateDuration()}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          
          // Description
          QMemoField(
            label: "Description",
            value: description,
            hint: "Describe what you worked on...",
            validator: Validator.required,
            onChanged: (value) {
              description = value;
              setState(() {});
            },
          ),
          
          // Billable Toggle
          QSwitch(
            label: "Billable",
            items: [
              {
                "label": "This time is billable",
                "value": true,
                "checked": isBillable,
              }
            ],
            value: [
              if (isBillable)
                {
                  "label": "This time is billable",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              isBillable = values.isNotEmpty;
              setState(() {});
            },
          ),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Save Entry",
                  size: bs.md,
                  onPressed: _saveEntry,
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Clear",
                color: disabledBoldColor,
                size: bs.md,
                onPressed: _clearForm,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
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
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildQuickActionCard(
                  "Copy Last Entry",
                  "Duplicate previous time entry",
                  Icons.copy,
                  primaryColor,
                  () => _copyLastEntry(),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildQuickActionCard(
                  "Start Timer",
                  "Begin tracking time now",
                  Icons.play_arrow,
                  successColor,
                  () => _startTimer(),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildQuickActionCard(
                  "Templates",
                  "Use saved templates",
                  Icons.bookmark,
                  infoColor,
                  () => _showTemplates(),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildQuickActionCard(
                  "Bulk Entry",
                  "Add multiple entries",
                  Icons.add_box,
                  warningColor,
                  () => _bulkEntry(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(String title, String subtitle, IconData icon, Color color, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: color.withAlpha(50)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spXs,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentEntries() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Recent Entries",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "View All",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ...recentEntries.map((entry) => _buildRecentEntryItem(entry)).toList(),
        ],
      ),
    );
  }

  Widget _buildRecentEntryItem(Map<String, dynamic> entry) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 50,
            decoration: BoxDecoration(
              color: entry["billable"] ? successColor : disabledColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${entry["project"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      "${entry["duration"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${entry["task"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${entry["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 12,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${entry["date"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(
                      Icons.access_time,
                      size: 12,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${entry["startTime"]} - ${entry["endTime"]}",
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
          SizedBox(width: spSm),
          Column(
            children: [
              GestureDetector(
                onTap: () => _duplicateEntry(entry),
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Icon(
                    Icons.copy,
                    size: 16,
                    color: primaryColor,
                  ),
                ),
              ),
              SizedBox(height: spXs),
              GestureDetector(
                onTap: () => _editEntry(entry),
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Icon(
                    Icons.edit,
                    size: 16,
                    color: warningColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _calculateDuration() {
    if (startTime.isEmpty || endTime.isEmpty) return "0h 0m";
    
    try {
      TimeOfDay start = startTime.timeOfDay;
      TimeOfDay end = endTime.timeOfDay;
      
      int startMinutes = start.hour * 60 + start.minute;
      int endMinutes = end.hour * 60 + end.minute;
      
      int totalMinutes = endMinutes - startMinutes;
      if (totalMinutes < 0) totalMinutes += 24 * 60; // Handle overnight
      
      int hours = totalMinutes ~/ 60;
      int minutes = totalMinutes % 60;
      
      return "${hours}h ${minutes}m";
    } catch (e) {
      return "0h 0m";
    }
  }

  void _saveEntry() {
    if (formKey.currentState!.validate()) {
      ss("Time entry saved successfully");
      _clearForm();
    }
  }

  void _clearForm() {
    selectedProject = "";
    selectedTask = "";
    selectedDate = DateTime.now().toString().substring(0, 10);
    startTime = "";
    endTime = "";
    description = "";
    isBillable = true;
    setState(() {});
  }

  void _copyLastEntry() {
    if (recentEntries.isNotEmpty) {
      final lastEntry = recentEntries.first;
      selectedProject = lastEntry["project"];
      selectedTask = lastEntry["task"];
      description = lastEntry["description"];
      isBillable = lastEntry["billable"];
      setState(() {});
      si("Last entry copied to form");
    }
  }

  void _duplicateEntry(Map<String, dynamic> entry) {
    selectedProject = entry["project"];
    selectedTask = entry["task"];
    description = entry["description"];
    isBillable = entry["billable"];
    setState(() {});
    si("Entry duplicated to form");
  }

  void _editEntry(Map<String, dynamic> entry) {
    selectedProject = entry["project"];
    selectedTask = entry["task"];
    selectedDate = entry["date"];
    startTime = entry["startTime"];
    endTime = entry["endTime"];
    description = entry["description"];
    isBillable = entry["billable"];
    setState(() {});
    si("Entry loaded for editing");
  }

  void _startTimer() {
    si("Timer started with current project and task");
  }

  void _showTemplates() {
    si("Templates feature coming soon");
  }

  void _bulkEntry() {
    si("Bulk entry feature coming soon");
  }
}
