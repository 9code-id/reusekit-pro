import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmTaskTimeTrackingView extends StatefulWidget {
  const TpmTaskTimeTrackingView({super.key});

  @override
  State<TpmTaskTimeTrackingView> createState() => _TpmTaskTimeTrackingViewState();
}

class _TpmTaskTimeTrackingViewState extends State<TpmTaskTimeTrackingView> {
  String selectedTask = "";
  String selectedUser = "";
  DateTime selectedDate = DateTime.now();
  String currentTimer = "";
  bool isTimerRunning = false;
  Duration currentDuration = Duration.zero;
  int currentTab = 0;

  List<Map<String, dynamic>> timeEntries = [
    {
      "id": 1,
      "taskId": "TSK-001",
      "taskTitle": "Database Design",
      "userId": "user1",
      "userName": "Michael Chen",
      "userAvatar": "https://picsum.photos/100/100?random=1&keyword=man",
      "date": "2024-12-19",
      "startTime": "09:00",
      "endTime": "12:30",
      "duration": 210, // minutes
      "description": "Designed user table schema and relationships",
      "isApproved": true,
      "category": "Development",
      "billable": true,
      "projectId": "PRJ-001"
    },
    {
      "id": 2,
      "taskId": "DSN-001",
      "taskTitle": "UI Mockups",
      "userId": "user2",
      "userName": "Emma Wilson",
      "userAvatar": "https://picsum.photos/100/100?random=2&keyword=woman",
      "date": "2024-12-19",
      "startTime": "14:00",
      "endTime": "17:15",
      "duration": 195, // minutes
      "description": "Created wireframes for dashboard and navigation",
      "isApproved": false,
      "category": "Design",
      "billable": true,
      "projectId": "PRJ-001"
    },
    {
      "id": 3,
      "taskId": "TSK-002",
      "taskTitle": "API Development",
      "userId": "user1",
      "userName": "Michael Chen",
      "userAvatar": "https://picsum.photos/100/100?random=1&keyword=man",
      "date": "2024-12-18",
      "startTime": "10:30",
      "endTime": "15:45",
      "duration": 315, // minutes
      "description": "Implemented user authentication endpoints",
      "isApproved": true,
      "category": "Development",
      "billable": true,
      "projectId": "PRJ-001"
    },
    {
      "id": 4,
      "taskId": "TST-001",
      "taskTitle": "Integration Testing",
      "userId": "user3",
      "userName": "David Rodriguez",
      "userAvatar": "https://picsum.photos/100/100?random=3&keyword=man",
      "date": "2024-12-18",
      "startTime": "08:00",
      "endTime": "11:30",
      "duration": 210, // minutes
      "description": "Performed integration tests for API endpoints",
      "isApproved": true,
      "category": "Testing",
      "billable": true,
      "projectId": "PRJ-001"
    },
    {
      "id": 5,
      "taskId": "DOC-001",
      "taskTitle": "Documentation",
      "userId": "user4",
      "userName": "Lisa Park",
      "userAvatar": "https://picsum.photos/100/100?random=4&keyword=woman",
      "date": "2024-12-17",
      "startTime": "13:00",
      "endTime": "16:00",
      "duration": 180, // minutes
      "description": "Updated API documentation and user guide",
      "isApproved": false,
      "category": "Documentation",
      "billable": false,
      "projectId": "PRJ-001"
    }
  ];

  List<Map<String, dynamic>> tasks = [
    {"label": "All Tasks", "value": ""},
    {"label": "Database Design", "value": "TSK-001"},
    {"label": "UI Mockups", "value": "DSN-001"},
    {"label": "API Development", "value": "TSK-002"},
    {"label": "Integration Testing", "value": "TST-001"},
    {"label": "Documentation", "value": "DOC-001"}
  ];

  List<Map<String, dynamic>> users = [
    {"label": "All Users", "value": ""},
    {"label": "Michael Chen", "value": "user1"},
    {"label": "Emma Wilson", "value": "user2"},
    {"label": "David Rodriguez", "value": "user3"},
    {"label": "Lisa Park", "value": "user4"}
  ];

  List<Map<String, dynamic>> get filteredTimeEntries {
    return timeEntries.where((entry) {
      bool matchesTask = selectedTask.isEmpty || entry["taskId"] == selectedTask;
      bool matchesUser = selectedUser.isEmpty || entry["userId"] == selectedUser;
      bool matchesDate = entry["date"] == "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
      
      return matchesTask && matchesUser && matchesDate;
    }).toList();
  }

  String _formatDuration(int minutes) {
    int hours = minutes ~/ 60;
    int mins = minutes % 60;
    return "${hours}h ${mins}m";
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Development":
        return primaryColor;
      case "Design":
        return secondaryColor;
      case "Testing":
        return warningColor;
      case "Documentation":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  int get totalMinutesToday {
    return filteredTimeEntries.fold(0, (sum, entry) => sum + (entry["duration"] as int));
  }

  int get billableMinutesToday {
    return filteredTimeEntries
        .where((entry) => entry["billable"] as bool)
        .fold(0, (sum, entry) => sum + (entry["duration"] as int));
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Time Tracking",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Timer", icon: Icon(Icons.timer)),
        Tab(text: "Time Logs", icon: Icon(Icons.access_time)),
        Tab(text: "Reports", icon: Icon(Icons.bar_chart)),
      ],
      tabChildren: [
        _buildTimerTab(),
        _buildTimeLogsTab(),
        _buildReportsTab(),
      ],
      onInit: (tabController) {},
    );
  }

  Widget _buildTimerTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(200)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              children: [
                Icon(
                  isTimerRunning ? Icons.timer : Icons.timer_outlined,
                  color: Colors.white,
                  size: 48,
                ),
                SizedBox(height: spSm),
                Text(
                  _formatDuration(currentDuration.inMinutes),
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  isTimerRunning ? "Timer Running" : "Timer Stopped",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
              ],
            ),
          ),

          if (currentTimer.isNotEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: successColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(Icons.task_alt, color: successColor, size: 20),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Working on: $currentTimer",
                      style: TextStyle(
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          QDropdownField(
            label: "Select Task",
            items: tasks.where((task) => task["value"] != "").toList(),
            value: currentTimer,
            onChanged: (value, label) {
              currentTimer = value;
              setState(() {});
            },
          ),

          Row(
            children: [
              Expanded(
                child: Container(
                  child: QButton(
                    label: isTimerRunning ? "Stop Timer" : "Start Timer",
                    icon: isTimerRunning ? Icons.stop : Icons.play_arrow,
                    onPressed: currentTimer.isNotEmpty ? () => _toggleTimer() : null,
                  ),
                ),
              ),
              if (isTimerRunning) ...[
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.pause,
                  size: bs.sm,
                  onPressed: () => _pauseTimer(),
                ),
              ],
            ],
          ),

          if (currentDuration.inMinutes > 0)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Text(
                    "Save Time Entry",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QTextField(
                    label: "Description",
                    value: "",
                    onChanged: (value) {},
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Billable",
                              "value": true,
                              "checked": true,
                            }
                          ],
                          value: [{"label": "Billable", "value": true, "checked": true}],
                          onChanged: (values, ids) {},
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Save Entry",
                      onPressed: () => _saveTimeEntry(),
                    ),
                  ),
                ],
              ),
            ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Today's Summary",
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
                            "Total Time",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            _formatDuration(totalMinutesToday),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Billable Time",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            _formatDuration(billableMinutesToday),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: successColor,
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
        ],
      ),
    );
  }

  Widget _buildTimeLogsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Task",
                  items: tasks,
                  value: selectedTask,
                  onChanged: (value, label) {
                    selectedTask = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "User",
                  items: users,
                  value: selectedUser,
                  onChanged: (value, label) {
                    selectedUser = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          QDatePicker(
            label: "Date",
            value: selectedDate,
            onChanged: (value) {
              selectedDate = value;
              setState(() {});
            },
          ),

          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryColor, primaryColor.withAlpha(200)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.access_time, color: Colors.white, size: 24),
                      SizedBox(height: spXs),
                      Text(
                        "Total Hours",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                      Text(
                        _formatDuration(totalMinutesToday),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
                    gradient: LinearGradient(
                      colors: [successColor, successColor.withAlpha(200)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.attach_money, color: Colors.white, size: 24),
                      SizedBox(height: spXs),
                      Text(
                        "Billable Hours",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                      Text(
                        _formatDuration(billableMinutesToday),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          if (filteredTimeEntries.isEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.schedule,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No time entries found",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Start tracking time or adjust your filters",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledColor,
                    ),
                  ),
                ],
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredTimeEntries.length,
              itemBuilder: (context, index) {
                final entry = filteredTimeEntries[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        color: _getCategoryColor("${entry["category"]}"),
                        width: 4,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage("${entry["userAvatar"]}"),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${entry["taskTitle"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${entry["userName"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                _formatDuration(entry["duration"] as int),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${entry["startTime"]} - ${entry["endTime"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      if ((entry["description"] as String).isNotEmpty)
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: disabledColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${entry["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),

                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getCategoryColor("${entry["category"]}").withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${entry["category"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: _getCategoryColor("${entry["category"]}"),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          if (entry["billable"] as bool)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "Billable",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          Spacer(),
                          if (entry["isApproved"] as bool)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.check_circle, size: 12, color: successColor),
                                  SizedBox(width: 2),
                                  Text(
                                    "Approved",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          else
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                              decoration: BoxDecoration(
                                color: warningColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.pending, size: 12, color: warningColor),
                                  SizedBox(width: 2),
                                  Text(
                                    "Pending",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: warningColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),

                      Row(
                        children: [
                          QButton(
                            icon: Icons.edit,
                            size: bs.sm,
                            onPressed: () => _editTimeEntry(entry),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.delete,
                            size: bs.sm,
                            onPressed: () => _deleteTimeEntry(entry),
                          ),
                          Spacer(),
                          if (!(entry["isApproved"] as bool))
                            QButton(
                              label: "Approve",
                              size: bs.sm,
                              onPressed: () => _approveTimeEntry(entry),
                            ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.bar_chart, color: infoColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Time tracking reports and analytics",
                    style: TextStyle(
                      color: infoColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryColor, primaryColor.withAlpha(200)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.schedule, color: Colors.white, size: 24),
                      SizedBox(height: spXs),
                      Text(
                        "This Week",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                      Text(
                        "28h 30m",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
                    gradient: LinearGradient(
                      colors: [successColor, successColor.withAlpha(200)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.attach_money, color: Colors.white, size: 24),
                      SizedBox(height: spXs),
                      Text(
                        "Billable",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                      Text(
                        "22h 15m",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Time by Category",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildCategoryChart("Development", 12.5, primaryColor),
                _buildCategoryChart("Design", 8.0, secondaryColor),
                _buildCategoryChart("Testing", 5.5, warningColor),
                _buildCategoryChart("Documentation", 2.5, infoColor),
              ],
            ),
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Top Performers",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildPerformerRow("Michael Chen", 18.5, "https://picsum.photos/100/100?random=1&keyword=man"),
                _buildPerformerRow("Emma Wilson", 15.2, "https://picsum.photos/100/100?random=2&keyword=woman"),
                _buildPerformerRow("David Rodriguez", 12.8, "https://picsum.photos/100/100?random=3&keyword=man"),
                _buildPerformerRow("Lisa Park", 9.5, "https://picsum.photos/100/100?random=4&keyword=woman"),
              ],
            ),
          ),

          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Export Report",
                  icon: Icons.file_download,
                  onPressed: () => _exportReport(),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.refresh,
                size: bs.sm,
                onPressed: () => _refreshReports(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChart(String category, double hours, Color color) {
    double maxHours = 15.0; // Maximum for chart scaling
    double percentage = hours / maxHours;
    
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            category,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ),
        Text(
          "${hours}h",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          flex: 2,
          child: Container(
            height: 8,
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: percentage,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPerformerRow(String name, double hours, String avatar) {
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundImage: NetworkImage(avatar),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            name,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ),
        Text(
          "${hours}h",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  void _toggleTimer() {
    isTimerRunning = !isTimerRunning;
    if (isTimerRunning) {
      // Start timer logic here
      ss("Timer started for $currentTimer");
    } else {
      // Stop timer logic here
      ss("Timer stopped");
    }
    setState(() {});
  }

  void _pauseTimer() {
    isTimerRunning = false;
    ss("Timer paused");
    setState(() {});
  }

  void _saveTimeEntry() {
    // Implementation for saving time entry
    ss("Time entry saved successfully");
    currentDuration = Duration.zero;
    setState(() {});
  }

  void _editTimeEntry(Map<String, dynamic> entry) {
    // Implementation for editing time entry
  }

  void _deleteTimeEntry(Map<String, dynamic> entry) {
    // Implementation for deleting time entry
  }

  void _approveTimeEntry(Map<String, dynamic> entry) {
    entry["isApproved"] = true;
    ss("Time entry approved");
    setState(() {});
  }

  void _exportReport() {
    // Implementation for exporting report
    ss("Report exported successfully");
  }

  void _refreshReports() {
    // Implementation for refreshing reports
    ss("Reports refreshed");
  }
}
