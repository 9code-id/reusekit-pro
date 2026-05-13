import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmDashboardView extends StatefulWidget {
  const FsmDashboardView({super.key});

  @override
  State<FsmDashboardView> createState() => _FsmDashboardViewState();
}

class _FsmDashboardViewState extends State<FsmDashboardView> {
  String selectedField = "all";
  String selectedCrop = "all";
  
  List<Map<String, dynamic>> fieldOptions = [
    {"label": "All Fields", "value": "all"},
    {"label": "North Field", "value": "north"},
    {"label": "South Field", "value": "south"},
    {"label": "East Field", "value": "east"},
    {"label": "West Field", "value": "west"},
  ];
  
  List<Map<String, dynamic>> cropOptions = [
    {"label": "All Crops", "value": "all"},
    {"label": "Corn", "value": "corn"},
    {"label": "Wheat", "value": "wheat"},
    {"label": "Soybeans", "value": "soybeans"},
    {"label": "Rice", "value": "rice"},
  ];
  
  List<Map<String, dynamic>> dashboardCards = [
    {
      "title": "Total Fields",
      "value": 12,
      "subtitle": "Active Fields",
      "icon": Icons.landscape,
      "color": primaryColor,
      "trend": "+2 this month"
    },
    {
      "title": "Active Crops",
      "value": 8,
      "subtitle": "Different Varieties",
      "icon": Icons.grass,
      "color": successColor,
      "trend": "Seasonal rotation"
    },
    {
      "title": "Irrigation Status",
      "value": 95,
      "subtitle": "% Operational",
      "icon": Icons.water_drop,
      "color": infoColor,
      "trend": "All systems green"
    },
    {
      "title": "Weather Alert",
      "value": 3,
      "subtitle": "Active Warnings",
      "icon": Icons.cloud,
      "color": warningColor,
      "trend": "Rain expected"
    },
  ];
  
  List<Map<String, dynamic>> recentActivities = [
    {
      "title": "Irrigation System Activated",
      "field": "North Field - Corn",
      "time": "2 hours ago",
      "icon": Icons.water_drop,
      "color": infoColor,
      "status": "Completed"
    },
    {
      "title": "Pest Control Treatment",
      "field": "South Field - Wheat",
      "time": "5 hours ago",
      "icon": Icons.bug_report,
      "color": warningColor,
      "status": "In Progress"
    },
    {
      "title": "Soil Testing Completed",
      "field": "East Field - Soybeans",
      "time": "1 day ago",
      "icon": Icons.science,
      "color": successColor,
      "status": "Completed"
    },
    {
      "title": "Harvest Preparation",
      "field": "West Field - Rice",
      "time": "2 days ago",
      "icon": Icons.agriculture,
      "color": primaryColor,
      "status": "Scheduled"
    },
  ];
  
  List<Map<String, dynamic>> upcomingTasks = [
    {
      "task": "Fertilizer Application",
      "field": "North Field",
      "crop": "Corn",
      "priority": "High",
      "dueDate": "2024-01-16",
      "assignedTo": "John Farmer",
      "progress": 0.0
    },
    {
      "task": "Weed Control Inspection",
      "field": "South Field",
      "crop": "Wheat",
      "priority": "Medium",
      "dueDate": "2024-01-17",
      "assignedTo": "Sarah Green",
      "progress": 0.3
    },
    {
      "task": "Equipment Maintenance",
      "field": "Equipment Shed",
      "crop": "All",
      "priority": "Low",
      "dueDate": "2024-01-20",
      "assignedTo": "Mike Tools",
      "progress": 0.8
    },
  ];
  
  List<Map<String, dynamic>> weatherData = [
    {"day": "Mon", "temp": 24, "humidity": 65, "condition": "sunny"},
    {"day": "Tue", "temp": 22, "humidity": 70, "condition": "cloudy"},
    {"day": "Wed", "temp": 18, "humidity": 85, "condition": "rainy"},
    {"day": "Thu", "temp": 26, "humidity": 60, "condition": "sunny"},
    {"day": "Fri", "temp": 23, "humidity": 68, "condition": "partly_cloudy"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Farm Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              si("3 new notifications");
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              //navigateTo FsmSettingsView
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildQuickFilters(),
            _buildDashboardCards(),
            _buildWeatherWidget(),
            _buildQuickActions(),
            _buildRecentActivities(),
            _buildUpcomingTasks(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickFilters() {
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
            "Quick Filters",
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
                  label: "Field",
                  items: fieldOptions,
                  value: selectedField,
                  onChanged: (value, label) {
                    selectedField = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Crop",
                  items: cropOptions,
                  value: selectedCrop,
                  onChanged: (value, label) {
                    selectedCrop = value;
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

  Widget _buildDashboardCards() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: dashboardCards.map((card) => _buildDashboardCard(card)).toList(),
    );
  }

  Widget _buildDashboardCard(Map<String, dynamic> card) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (card["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  card["icon"],
                  color: card["color"],
                  size: 24,
                ),
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
            "${card["value"]}",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${card["title"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            "${card["subtitle"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: spXs),
            child: Text(
              "${card["trend"]}",
              style: TextStyle(
                fontSize: 11,
                color: successColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherWidget() {
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
                "Weather Forecast",
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
                  si("Weather data refreshed");
                },
              ),
            ],
          ),
          QHorizontalScroll(
            children: weatherData.map((weather) => _buildWeatherCard(weather)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherCard(Map<String, dynamic> weather) {
    IconData weatherIcon = _getWeatherIcon(weather["condition"]);
    
    return Container(
      width: 100,
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(right: spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Text(
            "${weather["day"]}",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Icon(
            weatherIcon,
            color: primaryColor,
            size: 24,
          ),
          Text(
            "${weather["temp"]}°C",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${weather["humidity"]}%",
            style: TextStyle(
              fontSize: 10,
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
      {"title": "View Fields", "icon": Icons.landscape, "color": successColor},
      {"title": "Equipment", "icon": Icons.agriculture, "color": infoColor},
      {"title": "Reports", "icon": Icons.analytics, "color": warningColor},
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

  Widget _buildRecentActivities() {
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
                "Recent Activities",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "View All",
                size: bs.sm,
                onPressed: () {
                  //navigateTo FsmActivitiesView
                },
              ),
            ],
          ),
          ...recentActivities.map((activity) => _buildActivityItem(activity)),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(3),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: (activity["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              activity["icon"],
              color: activity["color"],
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${activity["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${activity["field"]}",
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getStatusColor(activity["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${activity["status"]}",
                  style: TextStyle(
                    color: _getStatusColor(activity["status"]),
                    fontSize: 10,
                  ),
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${activity["time"]}",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledColor,
                ),
              ),
            ],
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
          Row(
            children: [
              Text(
                "Upcoming Tasks",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Manage Tasks",
                size: bs.sm,
                onPressed: () {
                  //navigateTo FsmTasksView
                },
              ),
            ],
          ),
          ...upcomingTasks.map((task) => _buildTaskItem(task)),
        ],
      ),
    );
  }

  Widget _buildTaskItem(Map<String, dynamic> task) {
    Color priorityColor = _getPriorityColor(task["priority"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 30,
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
                    Text(
                      "${task["task"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${task["field"]} - ${task["crop"]}",
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
                  color: priorityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${task["priority"]}",
                  style: TextStyle(
                    color: priorityColor,
                    fontSize: 10,
                  ),
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
                          Icons.person,
                          size: 12,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${task["assignedTo"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Due: ${task["dueDate"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: warningColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    LinearProgressIndicator(
                      value: task["progress"],
                      backgroundColor: disabledOutlineBorderColor,
                      valueColor: AlwaysStoppedAnimation<Color>(successColor),
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

  IconData _getWeatherIcon(String condition) {
    switch (condition) {
      case "sunny":
        return Icons.wb_sunny;
      case "cloudy":
        return Icons.cloud;
      case "rainy":
        return Icons.grain;
      case "partly_cloudy":
        return Icons.wb_cloudy;
      default:
        return Icons.wb_sunny;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "completed":
        return successColor;
      case "in progress":
        return warningColor;
      case "scheduled":
        return infoColor;
      default:
        return primaryColor;
    }
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
}
