import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmDailyScheduleView extends StatefulWidget {
  const FsmDailyScheduleView({super.key});

  @override
  State<FsmDailyScheduleView> createState() => _FsmDailyScheduleViewState();
}

class _FsmDailyScheduleViewState extends State<FsmDailyScheduleView> {
  int currentTab = 0;
  DateTime selectedDate = DateTime.now();
  String selectedPriority = "all";
  String selectedStatus = "all";
  
  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All Priorities", "value": "all"},
    {"label": "High Priority", "value": "high"},
    {"label": "Medium Priority", "value": "medium"},
    {"label": "Low Priority", "value": "low"},
  ];
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Pending", "value": "pending"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Completed", "value": "completed"},
    {"label": "Overdue", "value": "overdue"},
  ];
  
  List<Map<String, dynamic>> dailyTasks = [
    {
      "id": "TSK001",
      "title": "Morning Field Inspection",
      "description": "Check irrigation systems and crop health in North Field",
      "field": "North Field",
      "crop": "Corn",
      "priority": "High",
      "status": "Pending",
      "assigned_to": "John Farmer",
      "start_time": "07:00",
      "end_time": "08:30",
      "duration": 90,
      "category": "Inspection",
      "equipment": ["Tablet", "Moisture Meter"],
      "notes": "Focus on sections A1-A5",
      "weather_dependent": true,
      "completion_percentage": 0.0
    },
    {
      "id": "TSK002",
      "title": "Fertilizer Application",
      "description": "Apply nitrogen fertilizer to wheat crops in South Field",
      "field": "South Field",
      "crop": "Wheat",
      "priority": "High",
      "status": "In Progress",
      "assigned_to": "Mike Tools",
      "start_time": "09:00",
      "end_time": "12:00",
      "duration": 180,
      "category": "Fertilization",
      "equipment": ["Spreader", "Fertilizer", "Safety Gear"],
      "notes": "Weather conditions favorable",
      "weather_dependent": true,
      "completion_percentage": 0.4
    },
    {
      "id": "TSK003",
      "title": "Equipment Maintenance",
      "description": "Routine maintenance of irrigation pumps and controllers",
      "field": "Equipment Shed",
      "crop": "All",
      "priority": "Medium",
      "status": "Pending",
      "assigned_to": "Sarah Green",
      "start_time": "13:00",
      "end_time": "15:00",
      "duration": 120,
      "category": "Maintenance",
      "equipment": ["Tool Kit", "Spare Parts", "Lubricants"],
      "notes": "Check pump pressure and electrical connections",
      "weather_dependent": false,
      "completion_percentage": 0.0
    },
    {
      "id": "TSK004",
      "title": "Pest Control Spray",
      "description": "Apply organic pest control solution to soybeans",
      "field": "East Field",
      "crop": "Soybeans",
      "priority": "Medium",
      "status": "Completed",
      "assigned_to": "John Farmer",
      "start_time": "15:30",
      "end_time": "17:00",
      "duration": 90,
      "category": "Pest Control",
      "equipment": ["Sprayer", "Organic Solution", "PPE"],
      "notes": "Applied to affected areas only",
      "weather_dependent": true,
      "completion_percentage": 1.0
    },
    {
      "id": "TSK005",
      "title": "Harvest Preparation",
      "description": "Prepare harvesting equipment and storage areas",
      "field": "West Field",
      "crop": "Rice",
      "priority": "Low",
      "status": "Pending",
      "assigned_to": "Mike Tools",
      "start_time": "17:30",
      "end_time": "18:30",
      "duration": 60,
      "category": "Preparation",
      "equipment": ["Combine Harvester", "Storage Bins"],
      "notes": "Check combine harvester functionality",
      "weather_dependent": false,
      "completion_percentage": 0.0
    },
  ];
  
  List<Map<String, dynamic>> upcomingTasks = [
    {
      "date": "2024-01-16",
      "tasks": [
        {"title": "Soil Testing", "time": "08:00", "field": "North Field"},
        {"title": "Weed Control", "time": "10:00", "field": "South Field"},
        {"title": "Water Quality Check", "time": "14:00", "field": "All Fields"},
      ]
    },
    {
      "date": "2024-01-17",
      "tasks": [
        {"title": "Seed Planting", "time": "07:00", "field": "East Field"},
        {"title": "Equipment Calibration", "time": "11:00", "field": "Equipment Shed"},
        {"title": "Progress Review", "time": "16:00", "field": "Office"},
      ]
    },
    {
      "date": "2024-01-18",
      "tasks": [
        {"title": "Harvest Operations", "time": "06:00", "field": "West Field"},
        {"title": "Quality Inspection", "time": "13:00", "field": "Storage"},
        {"title": "Report Generation", "time": "17:00", "field": "Office"},
      ]
    },
  ];
  
  List<Map<String, dynamic>> taskCategories = [
    {"name": "Inspection", "count": 3, "color": infoColor},
    {"name": "Fertilization", "count": 2, "color": successColor},
    {"name": "Maintenance", "count": 4, "color": warningColor},
    {"name": "Pest Control", "count": 1, "color": dangerColor},
    {"name": "Preparation", "count": 2, "color": primaryColor},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Daily Schedule",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Today", icon: Icon(Icons.today)),
        Tab(text: "Schedule", icon: Icon(Icons.schedule)),
        Tab(text: "Calendar", icon: Icon(Icons.calendar_month)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildTodayTab(),
        _buildScheduleTab(),
        _buildCalendarTab(),
        _buildAnalyticsTab(),
      ],
      onInit: (tabController) {},
    );
  }

  Widget _buildTodayTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDailyOverview(),
          _buildQuickActions(),
          _buildTaskFilters(),
          _buildTodayTasksList(),
        ],
      ),
    );
  }

  Widget _buildScheduleTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDateSelector(),
          _buildScheduleTimeline(),
          _buildTaskManagement(),
        ],
      ),
    );
  }

  Widget _buildCalendarTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCalendarView(),
          _buildUpcomingTasks(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTaskAnalytics(),
          _buildProductivityMetrics(),
          _buildCategoryBreakdown(),
        ],
      ),
    );
  }

  Widget _buildDailyOverview() {
    int totalTasks = dailyTasks.length;
    int completedTasks = dailyTasks.where((task) => task["status"] == "Completed").length;
    int inProgressTasks = dailyTasks.where((task) => task["status"] == "In Progress").length;
    int pendingTasks = dailyTasks.where((task) => task["status"] == "Pending").length;
    
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Text(
                "Today's Overview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildOverviewCard("Total Tasks", "$totalTasks", "Scheduled", primaryColor, Icons.assignment),
              _buildOverviewCard("Completed", "$completedTasks", "Finished", successColor, Icons.check_circle),
              _buildOverviewCard("In Progress", "$inProgressTasks", "Active", warningColor, Icons.play_circle),
              _buildOverviewCard("Pending", "$pendingTasks", "Waiting", infoColor, Icons.pending),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, String subtitle, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              Spacer(),
              Icon(
                Icons.trending_up,
                color: successColor,
                size: 16,
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
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
    );
  }

  Widget _buildQuickActions() {
    List<Map<String, dynamic>> quickActions = [
      {"title": "Add Task", "icon": Icons.add_task, "color": primaryColor},
      {"title": "Start Timer", "icon": Icons.play_arrow, "color": successColor},
      {"title": "Mark Complete", "icon": Icons.done, "color": infoColor},
      {"title": "View Reports", "icon": Icons.analytics, "color": warningColor},
    ];

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
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
          Row(
            children: quickActions.map((action) => Expanded(
              child: Container(
                margin: EdgeInsets.only(right: spXs),
                child: QButton(
                  icon: action["icon"],
                  label: "${action["title"]}",
                  size: bs.sm,
                  onPressed: () {
                    si("${action["title"]} action selected");
                  },
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Filter Tasks",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
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
                  label: "Status",
                  items: statusOptions,
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
    );
  }

  Widget _buildTodayTasksList() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Text(
                "Today's Tasks",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.refresh,
                size: bs.sm,
                onPressed: () {
                  si("Task list refreshed");
                },
              ),
            ],
          ),
          ...dailyTasks.map((task) => _buildTaskCard(task)),
        ],
      ),
    );
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
    Color priorityColor = _getPriorityColor(task["priority"]);
    Color statusColor = _getStatusColor(task["status"]);
    double progress = task["completion_percentage"];
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 40,
                decoration: BoxDecoration(
                  color: priorityColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${task["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${task["status"]}",
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 10,
                            ),
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
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 12,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${task["field"]} - ${task["crop"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.access_time,
                          size: 12,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${task["start_time"]} - ${task["end_time"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 12,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${task["assigned_to"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: priorityColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${task["priority"]} Priority",
                            style: TextStyle(
                              color: priorityColor,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (progress > 0)
            Column(
              children: [
                SizedBox(height: spXs),
                Row(
                  children: [
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Progress: ${(progress * 100).toInt()}%",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${task["duration"]} min",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          LinearProgressIndicator(
                            value: progress,
                            backgroundColor: disabledOutlineBorderColor,
                            valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          Row(
            children: [
              SizedBox(width: 16),
              Expanded(
                child: Row(
                  children: [
                    if (task["weather_dependent"] == true)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.cloud,
                              size: 10,
                              color: infoColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Weather Dependent",
                              style: TextStyle(
                                color: infoColor,
                                fontSize: 9,
                              ),
                            ),
                          ],
                        ),
                      ),
                    Spacer(),
                    if (task["status"] != "Completed")
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          QButton(
                            icon: Icons.play_arrow,
                            size: bs.sm,
                            onPressed: () {
                              si("Starting task: ${task["title"]}");
                            },
                          ),
                          SizedBox(width: spXs),
                          QButton(
                            icon: Icons.check,
                            size: bs.sm,
                            onPressed: () {
                              si("Marking task as complete: ${task["title"]}");
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Date",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDatePicker(
            label: "Schedule Date",
            value: selectedDate,
            onChanged: (value) {
              selectedDate = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleTimeline() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Text(
                "Daily Timeline",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.add,
                label: "Add Task",
                size: bs.sm,
                onPressed: () {
                  //navigateTo FsmAddTaskView
                },
              ),
            ],
          ),
          Container(
            height: 400,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.schedule,
                    size: 48,
                    color: disabledBoldColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Daily Schedule Timeline",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Visual timeline of scheduled tasks and activities",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskManagement() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Task Management",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  icon: Icons.edit,
                  label: "Edit Tasks",
                  size: bs.sm,
                  onPressed: () {
                    si("Opening task editor");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  icon: Icons.copy,
                  label: "Duplicate Schedule",
                  size: bs.sm,
                  onPressed: () {
                    si("Duplicating schedule");
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  icon: Icons.download,
                  label: "Export Schedule",
                  size: bs.sm,
                  onPressed: () {
                    si("Exporting schedule");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  icon: Icons.share,
                  label: "Share Schedule",
                  size: bs.sm,
                  onPressed: () {
                    si("Sharing schedule");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarView() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Monthly Calendar",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_month,
                    size: 48,
                    color: disabledBoldColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Calendar View",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Monthly view with task scheduling and planning",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingTasks() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Upcoming Tasks",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...upcomingTasks.map((dayData) => _buildUpcomingDay(dayData)),
        ],
      ),
    );
  }

  Widget _buildUpcomingDay(Map<String, dynamic> dayData) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(3),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${dayData["date"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...((dayData["tasks"] as List).map((task) => _buildUpcomingTaskItem(task))).toList(),
        ],
      ),
    );
  }

  Widget _buildUpcomingTaskItem(Map<String, dynamic> task) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 30,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${task["title"]}",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Row(
                children: [
                  Text(
                    "${task["time"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "•",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledColor,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "${task["field"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTaskAnalytics() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Task Analytics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.pie_chart,
                    size: 48,
                    color: disabledBoldColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Task Completion Analytics",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Visual breakdown of task completion rates",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductivityMetrics() {
    List<Map<String, dynamic>> metrics = [
      {"title": "Avg Completion Time", "value": "2.5 hrs", "trend": "+15%", "color": successColor},
      {"title": "Task Efficiency", "value": "87%", "trend": "+8%", "color": primaryColor},
      {"title": "On-Time Completion", "value": "92%", "trend": "+3%", "color": infoColor},
      {"title": "Resource Utilization", "value": "76%", "trend": "-2%", "color": warningColor},
    ];

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Productivity Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: metrics.map((metric) => _buildMetricCard(metric)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(Map<String, dynamic> metric) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: (metric["color"] as Color).withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: (metric["color"] as Color).withAlpha(30)),
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${metric["title"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "${metric["value"]}",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: metric["color"],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
            decoration: BoxDecoration(
              color: (metric["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${metric["trend"]}",
              style: TextStyle(
                color: metric["color"],
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryBreakdown() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Task Categories",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...taskCategories.map((category) => _buildCategoryItem(category)),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(Map<String, dynamic> category) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: (category["color"] as Color).withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: (category["color"] as Color).withAlpha(30)),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 30,
            decoration: BoxDecoration(
              color: category["color"],
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              "${category["name"]}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: (category["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${category["count"]} tasks",
              style: TextStyle(
                color: category["color"],
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return primaryColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "completed":
        return successColor;
      case "in progress":
        return warningColor;
      case "pending":
        return infoColor;
      case "overdue":
        return dangerColor;
      default:
        return primaryColor;
    }
  }
}
