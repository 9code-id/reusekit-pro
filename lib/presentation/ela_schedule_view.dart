import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaScheduleView extends StatefulWidget {
  const ElaScheduleView({super.key});

  @override
  State<ElaScheduleView> createState() => _ElaScheduleViewState();
}

class _ElaScheduleViewState extends State<ElaScheduleView> {
  DateTime selectedDate = DateTime.now();
  String selectedFilter = "All";
  
  final List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Classes", "value": "Classes"},
    {"label": "Labs", "value": "Labs"},
    {"label": "Assignments", "value": "Assignments"},
    {"label": "Exams", "value": "Exams"},
  ];

  final List<Map<String, dynamic>> scheduleData = [
    {
      "title": "Mathematics II",
      "type": "Classes",
      "time": "08:00 - 09:30",
      "location": "Room A-201",
      "instructor": "Dr. Sarah Johnson",
      "subject": "MATH102",
      "color": primaryColor,
      "status": "ongoing",
      "description": "Advanced Calculus and Linear Algebra",
    },
    {
      "title": "Physics Lab",
      "type": "Labs",
      "time": "10:00 - 12:00",
      "location": "Physics Lab B",
      "instructor": "Prof. Michael Chen",
      "subject": "PHYS201",
      "color": infoColor,
      "status": "upcoming",
      "description": "Electromagnetic Field Experiments",
    },
    {
      "title": "Research Paper",
      "type": "Assignments",
      "time": "Due 23:59",
      "location": "Online Submission",
      "instructor": "Dr. Emily Davis",
      "subject": "ENG301",
      "color": warningColor,
      "status": "pending",
      "description": "Analysis of Modern Literature Trends",
    },
    {
      "title": "Chemistry",
      "type": "Classes",
      "time": "14:00 - 15:30",
      "location": "Room C-105",
      "instructor": "Dr. Robert Wilson",
      "subject": "CHEM101",
      "color": successColor,
      "status": "upcoming",
      "description": "Organic Chemistry Fundamentals",
    },
    {
      "title": "Midterm Exam",
      "type": "Exams",
      "time": "16:00 - 18:00",
      "location": "Exam Hall A",
      "instructor": "Dr. Sarah Johnson",
      "subject": "MATH102",
      "color": dangerColor,
      "status": "upcoming",
      "description": "Comprehensive Mathematics Assessment",
    },
    {
      "title": "Computer Science Lab",
      "type": "Labs",
      "time": "19:00 - 21:00",
      "location": "Computer Lab 1",
      "instructor": "Prof. Alex Kumar",
      "subject": "CS201",
      "color": infoColor,
      "status": "upcoming",
      "description": "Data Structures Implementation",
    },
  ];

  List<Map<String, dynamic>> get filteredSchedule {
    if (selectedFilter == "All") return scheduleData;
    return scheduleData.where((item) => item["type"] == selectedFilter).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "ongoing": return successColor;
      case "upcoming": return infoColor;
      case "pending": return warningColor;
      case "completed": return disabledBoldColor;
      default: return disabledBoldColor;
    }
  }

  IconData getTypeIcon(String type) {
    switch (type) {
      case "Classes": return Icons.school;
      case "Labs": return Icons.science;
      case "Assignments": return Icons.assignment;
      case "Exams": return Icons.quiz;
      default: return Icons.event;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schedule"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              // Navigate to calendar view
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Add new schedule item
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Header
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(Icons.today, color: primaryColor, size: 20),
                  SizedBox(width: spXs),
                  Text(
                    "${selectedDate.dMMMy}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "- ${_getDayName(selectedDate)}",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      // Show date picker
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "Change Date",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Schedule Summary
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today's Overview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 120,
                    children: [
                      _buildSummaryCard("Total", "${scheduleData.length}", Icons.event, primaryColor),
                      _buildSummaryCard("Classes", "${scheduleData.where((item) => item["type"] == "Classes").length}", Icons.school, successColor),
                      _buildSummaryCard("Labs", "${scheduleData.where((item) => item["type"] == "Labs").length}", Icons.science, infoColor),
                      _buildSummaryCard("Pending", "${scheduleData.where((item) => item["status"] == "pending").length}", Icons.pending, warningColor),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Filter Options
            Text(
              "Filter by Type",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            QCategoryPicker(
              items: filterOptions,
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Schedule List
            Text(
              "Schedule Items (${filteredSchedule.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            if (filteredSchedule.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXl),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledColor),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.event_busy,
                      size: 48,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No ${selectedFilter.toLowerCase()} found",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try selecting a different filter or add new items",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredSchedule.map((item) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: item["color"],
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Main Content
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header Row
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: (item["color"] as Color).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Icon(
                                    getTypeIcon(item["type"]),
                                    color: item["color"],
                                    size: 20,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${item["title"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${item["subject"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: getStatusColor(item["status"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXxs),
                                  ),
                                  child: Text(
                                    "${item["status"]}".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: getStatusColor(item["status"]),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Time and Location
                            Row(
                              children: [
                                Icon(Icons.access_time, color: disabledBoldColor, size: 16),
                                SizedBox(width: spXs),
                                Text(
                                  "${item["time"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Icon(Icons.location_on, color: disabledBoldColor, size: 16),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${item["location"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Instructor
                            Row(
                              children: [
                                Icon(Icons.person, color: disabledBoldColor, size: 16),
                                SizedBox(width: spXs),
                                Text(
                                  "${item["instructor"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Description
                            Text(
                              "${item["description"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Action Buttons
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(10),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(radiusSm),
                            bottomRight: Radius.circular(radiusSm),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // View details
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.visibility, color: infoColor, size: 16),
                                        SizedBox(width: spXxs),
                                        Text(
                                          "View",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: infoColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: spMd),
                                  GestureDetector(
                                    onTap: () {
                                      // Edit item
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.edit, color: warningColor, size: 16),
                                        SizedBox(width: spXxs),
                                        Text(
                                          "Edit",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: warningColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (item["type"] == "Assignments") ...[
                                    SizedBox(width: spMd),
                                    GestureDetector(
                                      onTap: () {
                                        // Submit assignment
                                      },
                                      child: Row(
                                        children: [
                                          Icon(Icons.upload, color: successColor, size: 16),
                                          SizedBox(width: spXxs),
                                          Text(
                                            "Submit",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: successColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Set reminder
                              },
                              child: Icon(Icons.notifications, color: disabledBoldColor, size: 18),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            
            SizedBox(height: spXl),
            
            // Quick Actions
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 140,
                    children: [
                      _buildQuickActionCard("Add Class", Icons.school, primaryColor),
                      _buildQuickActionCard("Add Assignment", Icons.assignment, warningColor),
                      _buildQuickActionCard("Add Exam", Icons.quiz, dangerColor),
                      _buildQuickActionCard("View Calendar", Icons.calendar_today, infoColor),
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

  Widget _buildSummaryCard(String label, String count, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spXs),
          Text(
            count,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXxs),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(String label, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        // Handle quick action
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusXs),
          border: Border.all(color: color.withAlpha(30)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            SizedBox(height: spXs),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getDayName(DateTime date) {
    List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return days[date.weekday - 1];
  }
}
