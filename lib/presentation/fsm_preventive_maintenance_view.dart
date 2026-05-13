import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmPreventiveMaintenanceView extends StatefulWidget {
  const FsmPreventiveMaintenanceView({super.key});

  @override
  State<FsmPreventiveMaintenanceView> createState() => _FsmPreventiveMaintenanceViewState();
}

class _FsmPreventiveMaintenanceViewState extends State<FsmPreventiveMaintenanceView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedPriority = "all";
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Scheduled", "value": "scheduled"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Completed", "value": "completed"},
    {"label": "Overdue", "value": "overdue"},
  ];
  
  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All Priority", "value": "all"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];
  
  List<Map<String, dynamic>> maintenanceSchedules = [
    {
      "id": "PM001",
      "title": "HVAC System Inspection",
      "customer": "TechCorp Inc",
      "location": "Building A - Floor 12",
      "equipment": "Central Air Conditioning Unit",
      "scheduled_date": "2024-01-15",
      "scheduled_time": "09:00",
      "technician": "John Smith",
      "priority": "high",
      "status": "scheduled",
      "duration": 2.5,
      "description": "Quarterly inspection and maintenance of HVAC system including filter replacement and coil cleaning",
      "last_maintenance": "2023-10-15",
      "next_due": "2024-04-15",
    },
    {
      "id": "PM002", 
      "title": "Elevator Safety Check",
      "customer": "Metro Plaza",
      "location": "Main Building - All Floors",
      "equipment": "Passenger Elevator #1",
      "scheduled_date": "2024-01-16",
      "scheduled_time": "14:00",
      "technician": "Sarah Johnson",
      "priority": "high",
      "status": "in_progress",
      "duration": 3.0,
      "description": "Monthly safety inspection and testing of elevator systems",
      "last_maintenance": "2023-12-16",
      "next_due": "2024-02-16",
    },
    {
      "id": "PM003",
      "title": "Fire Safety System Test",
      "customer": "SafeTech Solutions",
      "location": "Warehouse Complex",
      "equipment": "Fire Suppression System",
      "scheduled_date": "2024-01-14",
      "scheduled_time": "08:30",
      "technician": "Mike Wilson", 
      "priority": "medium",
      "status": "completed",
      "duration": 1.5,
      "description": "Bi-annual testing of fire alarm and suppression systems",
      "last_maintenance": "2024-01-14",
      "next_due": "2024-07-14",
    },
  ];

  List<Map<String, dynamic>> get filteredSchedules {
    return maintenanceSchedules.where((schedule) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${schedule["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${schedule["customer"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${schedule["equipment"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "all" || schedule["status"] == selectedStatus;
      bool matchesPriority = selectedPriority == "all" || schedule["priority"] == selectedPriority;
      
      return matchesSearch && matchesStatus && matchesPriority;
    }).toList();
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

  Color _getStatusColor(String status) {
    switch (status) {
      case "scheduled":
        return infoColor;
      case "in_progress":
        return warningColor;
      case "completed":
        return successColor;
      case "overdue":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildScheduleCard(Map<String, dynamic> schedule) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getPriorityColor("${schedule["priority"]}"),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${schedule["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${schedule["customer"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor("${schedule["status"]}").withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  "${schedule["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: _getStatusColor("${schedule["status"]}"),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${schedule["location"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(
                Icons.build,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${schedule["equipment"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 16,
                      color: primaryColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${schedule["scheduled_date"]} at ${schedule["scheduled_time"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${(schedule["duration"] as num).toStringAsFixed(1)}h",
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
                    Icon(
                      Icons.person,
                      size: 16,
                      color: primaryColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${schedule["technician"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getPriorityColor("${schedule["priority"]}").withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "${schedule["priority"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: _getPriorityColor("${schedule["priority"]}"),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to detail view
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Start Work",
                  size: bs.sm,
                  onPressed: () {
                    // Start maintenance work
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Maintenance Overview",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Total Scheduled", "24", Icons.schedule, infoColor),
              _buildStatCard("In Progress", "6", Icons.build, warningColor),
              _buildStatCard("Completed Today", "3", Icons.check_circle, successColor),
              _buildStatCard("Overdue", "2", Icons.warning, dangerColor),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            "Recent Activity",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...filteredSchedules.take(3).map((schedule) => _buildScheduleCard(schedule)),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleTab() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Search schedules...",
                      value: searchQuery,
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Row(
                children: [
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
                  SizedBox(width: spSm),
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
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            itemCount: filteredSchedules.length,
            itemBuilder: (context, index) {
              return _buildScheduleCard(filteredSchedules[index]);
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Preventive Maintenance",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Schedule", icon: Icon(Icons.schedule)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildScheduleTab(),
      ],
      onInit: (tabController) {},
    );
  }
}
