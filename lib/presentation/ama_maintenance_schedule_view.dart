import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaMaintenanceScheduleView extends StatefulWidget {
  const AmaMaintenanceScheduleView({super.key});

  @override
  State<AmaMaintenanceScheduleView> createState() => _AmaMaintenanceScheduleViewState();
}

class _AmaMaintenanceScheduleViewState extends State<AmaMaintenanceScheduleView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedPriority = "All";
  String selectedStatus = "All";
  bool showFilters = false;

  List<Map<String, dynamic>> maintenanceTasks = [
    {
      "id": "MNT001",
      "machineName": "John Deere 6155R Tractor",
      "machineId": "MAC001",
      "taskType": "Routine Maintenance",
      "description": "Oil change, filter replacement, and general inspection",
      "scheduledDate": "2025-06-20",
      "estimatedDuration": 4,
      "priority": "Medium",
      "status": "Scheduled",
      "assignedTechnician": "Mike Thompson",
      "technicianPhone": "+1 555-0123",
      "cost": 350.00,
      "parts": ["Engine oil", "Oil filter", "Air filter"],
      "lastCompleted": "2025-03-20",
      "nextDue": "2025-09-20",
      "operatingHours": 1245,
      "location": "Workshop Bay 1",
      "icon": Icons.build,
      "urgency": "normal"
    },
    {
      "id": "MNT002",
      "machineName": "Massey Ferguson 8S.265",
      "machineId": "MAC002",
      "taskType": "Repair",
      "description": "Hydraulic system leak repair and pressure testing",
      "scheduledDate": "2025-06-18",
      "estimatedDuration": 6,
      "priority": "High",
      "status": "In Progress",
      "assignedTechnician": "Sarah Wilson",
      "technicianPhone": "+1 555-0456",
      "cost": 850.00,
      "parts": ["Hydraulic hose", "Seals", "Hydraulic fluid"],
      "lastCompleted": "2025-01-15",
      "nextDue": "2025-08-15",
      "operatingHours": 2156,
      "location": "Workshop Bay 2",
      "icon": Icons.handyman,
      "urgency": "high"
    },
    {
      "id": "MNT003",
      "machineName": "Case IH Axial-Flow 7150",
      "machineId": "MAC003",
      "taskType": "Inspection",
      "description": "Pre-harvest season comprehensive inspection",
      "scheduledDate": "2025-06-25",
      "estimatedDuration": 3,
      "priority": "High",
      "status": "Scheduled",
      "assignedTechnician": "Robert Davis",
      "technicianPhone": "+1 555-0789",
      "cost": 200.00,
      "parts": [],
      "lastCompleted": "2025-04-15",
      "nextDue": "2025-07-15",
      "operatingHours": 856,
      "location": "Field Service",
      "icon": Icons.search,
      "urgency": "high"
    },
    {
      "id": "MNT004",
      "machineName": "New Holland T8.435",
      "machineId": "MAC004",
      "taskType": "Preventive Maintenance",
      "description": "Transmission service and cooling system check",
      "scheduledDate": "2025-06-30",
      "estimatedDuration": 5,
      "priority": "Medium",
      "status": "Pending",
      "assignedTechnician": "Alex Johnson",
      "technicianPhone": "+1 555-0321",
      "cost": 650.00,
      "parts": ["Transmission fluid", "Coolant", "Thermostat"],
      "lastCompleted": "2025-03-12",
      "nextDue": "2025-09-12",
      "operatingHours": 3245,
      "location": "Workshop Bay 3",
      "icon": Icons.tune,
      "urgency": "normal"
    },
    {
      "id": "MNT005",
      "machineName": "Kubota M7-172 Premium KVT",
      "machineId": "MAC005",
      "taskType": "Routine Maintenance",
      "description": "Air filter cleaning and engine tune-up",
      "scheduledDate": "2025-07-05",
      "estimatedDuration": 2,
      "priority": "Low",
      "status": "Scheduled",
      "assignedTechnician": "Lisa Garcia",
      "technicianPhone": "+1 555-0654",
      "cost": 180.00,
      "parts": ["Air filter", "Spark plugs"],
      "lastCompleted": "2025-06-01",
      "nextDue": "2025-09-01",
      "operatingHours": 789,
      "location": "Workshop Bay 1",
      "icon": Icons.air,
      "urgency": "low"
    },
    {
      "id": "MNT006",
      "machineName": "Caterpillar D6T Dozer",
      "machineId": "MAC006",
      "taskType": "Major Repair",
      "description": "Engine overhaul and transmission rebuild",
      "scheduledDate": "2025-06-17",
      "estimatedDuration": 48,
      "priority": "Critical",
      "status": "In Progress",
      "assignedTechnician": "Mark Rodriguez",
      "technicianPhone": "+1 555-0987",
      "cost": 12500.00,
      "parts": ["Engine kit", "Transmission parts", "Gaskets"],
      "lastCompleted": "2023-01-10",
      "nextDue": "2025-12-10",
      "operatingHours": 1876,
      "location": "Heavy Equipment Bay",
      "icon": Icons.construction,
      "urgency": "critical"
    }
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All", "value": "All"},
    {"label": "Critical", "value": "Critical"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"}
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Scheduled", "value": "Scheduled"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Completed", "value": "Completed"}
  ];

  List<Map<String, dynamic>> get filteredTasks {
    return maintenanceTasks.where((task) {
      bool matchesSearch = task["machineName"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                        task["description"].toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesPriority = selectedPriority == "All" || task["priority"] == selectedPriority;
      bool matchesStatus = selectedStatus == "All" || task["status"] == selectedStatus;
      return matchesSearch && matchesPriority && matchesStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Maintenance Schedule",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Calendar", icon: Icon(Icons.calendar_month)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildCalendarTab(),
        _buildHistoryTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildMaintenanceStats(),
          _buildTasksList(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search tasks...",
                value: searchQuery,
                hint: "Search by machine or description",
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            QButton(
              icon: showFilters ? Icons.filter_alt : Icons.filter_alt_outlined,
              size: bs.sm,
              onPressed: () {
                showFilters = !showFilters;
                setState(() {});
              },
            ),
          ],
        ),
        if (showFilters) ...[
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
      ],
    );
  }

  Widget _buildMaintenanceStats() {
    int totalTasks = maintenanceTasks.length;
    int inProgress = maintenanceTasks.where((t) => t["status"] == "In Progress").length;
    int overdue = maintenanceTasks.where((t) => DateTime.parse("${t["scheduledDate"]}").isBefore(DateTime.now())).length;
    double totalCost = maintenanceTasks.fold(0.0, (sum, t) => sum + (t["cost"] as double));

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildStatCard("Total Tasks", totalTasks.toString(), Icons.assignment, primaryColor),
        _buildStatCard("In Progress", inProgress.toString(), Icons.pending, warningColor),
        _buildStatCard("Overdue", overdue.toString(), Icons.warning, dangerColor),
        _buildStatCard("Total Cost", "\$${(totalCost / 1000).toStringAsFixed(1)}K", Icons.monetization_on, successColor),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
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
              Icon(icon, color: color, size: 24),
              Spacer(),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTasksList() {
    return Column(
      spacing: spSm,
      children: filteredTasks.map((task) => _buildTaskCard(task)).toList(),
    );
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
    Color priorityColor = _getPriorityColor(task["priority"]);
    Color statusColor = _getStatusColor(task["status"]);
    DateTime scheduledDate = DateTime.parse("${task["scheduledDate"]}");
    bool isOverdue = scheduledDate.isBefore(DateTime.now());

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: isOverdue ? dangerColor : priorityColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                task["icon"] as IconData,
                color: priorityColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${task["machineName"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${task["taskType"]} • ${task["id"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (isOverdue)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  margin: EdgeInsets.only(right: spSm),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "OVERDUE",
                    style: TextStyle(
                      fontSize: 10,
                      color: dangerColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${task["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${task["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildInfoItem("Scheduled", "${scheduledDate.dMMMy}", Icons.schedule),
              _buildInfoItem("Duration", "${task["estimatedDuration"]}h", Icons.timer),
              _buildInfoItem("Technician", "${task["assignedTechnician"]}", Icons.person),
              _buildInfoItem("Location", "${task["location"]}", Icons.location_on),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: priorityColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.priority_high, color: priorityColor, size: 16),
                SizedBox(width: spSm),
                Text(
                  "${task["priority"]} Priority",
                  style: TextStyle(
                    fontSize: 12,
                    color: priorityColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Text(
                  "Cost: \$${(task["cost"] as double).currency}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          if ((task["parts"] as List).isNotEmpty) ...[
            Text(
              "Required Parts:",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: (task["parts"] as List).map((part) => Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusXs),
                  border: Border.all(color: primaryColor.withAlpha(30)),
                ),
                child: Text(
                  "$part",
                  style: TextStyle(
                    fontSize: 11,
                    color: primaryColor,
                  ),
                ),
              )).toList(),
            ),
          ],
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: task["status"] == "Scheduled" ? "Start Task" : "View Details",
                  size: bs.sm,
                  onPressed: () {
                    si("${task["status"] == "Scheduled" ? "Starting" : "Viewing"} task ${task["id"]}");
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.phone,
                size: bs.sm,
                onPressed: () {
                  si("Calling ${task["assignedTechnician"]}");
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  si("More options for task ${task["id"]}");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: disabledBoldColor, size: 16),
        SizedBox(width: spXs),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildCalendarView(),
          _buildTodaysTasks(),
        ],
      ),
    );
  }

  Widget _buildCalendarView() {
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
          Row(
            children: [
              Icon(Icons.calendar_month, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Maintenance Calendar",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "June 2025",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: primaryColor.withAlpha(30)),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_view_month,
                    size: 48,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Calendar View",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Interactive maintenance calendar",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
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

  Widget _buildTodaysTasks() {
    final todaysTasks = maintenanceTasks.where((task) {
      DateTime scheduledDate = DateTime.parse("${task["scheduledDate"]}");
      DateTime today = DateTime.now();
      return scheduledDate.day == today.day && 
             scheduledDate.month == today.month &&
             scheduledDate.year == today.year;
    }).toList();

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
          Row(
            children: [
              Icon(Icons.today, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Today's Tasks",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${todaysTasks.length} tasks",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          if (todaysTasks.isEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 48,
                      color: successColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No tasks scheduled for today",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ...todaysTasks.map((task) => _buildTodayTaskCard(task)).toList(),
        ],
      ),
    );
  }

  Widget _buildTodayTaskCard(Map<String, dynamic> task) {
    Color priorityColor = _getPriorityColor(task["priority"]);
    Color statusColor = _getStatusColor(task["status"]);

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: priorityColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 3,
            color: priorityColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            task["icon"] as IconData,
            color: priorityColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${task["machineName"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${task["taskType"]} • ${task["estimatedDuration"]}h",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${task["status"]}",
              style: TextStyle(
                fontSize: 10,
                color: statusColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    final completedTasks = [
      {
        "id": "MNT007",
        "machineName": "John Deere 6155R Tractor",
        "taskType": "Routine Maintenance",
        "description": "Oil change and filter replacement",
        "completedDate": "2025-05-20",
        "technician": "Mike Thompson",
        "actualDuration": 3.5,
        "cost": 320.00,
        "rating": 5,
        "notes": "Completed successfully, no issues found"
      },
      {
        "id": "MNT008",
        "machineName": "Case IH Axial-Flow 7150",
        "taskType": "Inspection",
        "description": "Pre-season inspection and calibration",
        "completedDate": "2025-04-15",
        "technician": "Robert Davis",
        "actualDuration": 2.5,
        "cost": 180.00,
        "rating": 4,
        "notes": "Minor adjustments needed, all systems operational"
      },
      {
        "id": "MNT009",
        "machineName": "Kubota M7-172 Premium KVT",
        "taskType": "Repair",
        "description": "Tire replacement and wheel alignment",
        "completedDate": "2025-03-10",
        "technician": "Lisa Garcia", 
        "actualDuration": 4.0,
        "cost": 1200.00,
        "rating": 5,
        "notes": "New tires installed, alignment perfect"
      }
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildHistoryStats(completedTasks),
          _buildCompletedTasksList(completedTasks),
        ],
      ),
    );
  }

  Widget _buildHistoryStats(List<Map<String, dynamic>> completedTasks) {
    int totalCompleted = completedTasks.length;
    double totalCost = completedTasks.fold(0.0, (sum, t) => sum + (t["cost"] as double));
    double avgRating = completedTasks.fold(0.0, (sum, t) => sum + (t["rating"] as int)) / totalCompleted;
    double avgDuration = completedTasks.fold(0.0, (sum, t) => sum + (t["actualDuration"] as double)) / totalCompleted;

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildHistoryStatCard("Completed", totalCompleted.toString(), Icons.check_circle, successColor),
        _buildHistoryStatCard("Total Cost", "\$${(totalCost / 1000).toStringAsFixed(1)}K", Icons.monetization_on, primaryColor),
        _buildHistoryStatCard("Avg Rating", "${avgRating.toStringAsFixed(1)}/5", Icons.star, warningColor),
        _buildHistoryStatCard("Avg Duration", "${avgDuration.toStringAsFixed(1)}h", Icons.timer, infoColor),
      ],
    );
  }

  Widget _buildHistoryStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  title,
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
    );
  }

  Widget _buildCompletedTasksList(List<Map<String, dynamic>> completedTasks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Completed Tasks",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...completedTasks.map((task) => _buildCompletedTaskCard(task)).toList(),
      ],
    );
  }

  Widget _buildCompletedTaskCard(Map<String, dynamic> task) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: successColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.check_circle, color: successColor, size: 24),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${task["machineName"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${task["taskType"]} • ${task["id"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: List.generate(5, (index) => Icon(
                  index < (task["rating"] as int) ? Icons.star : Icons.star_border,
                  color: warningColor,
                  size: 16,
                )),
              ),
            ],
          ),
          Text(
            "${task["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildHistoryInfoItem("Completed", "${DateTime.parse("${task["completedDate"]}").dMMMy}", Icons.event),
              _buildHistoryInfoItem("Duration", "${task["actualDuration"]}h", Icons.timer),
              _buildHistoryInfoItem("Technician", "${task["technician"]}", Icons.person),
              _buildHistoryInfoItem("Cost", "\$${(task["cost"] as double).currency}", Icons.monetization_on),
            ],
          ),
          if (task["notes"] != null && (task["notes"] as String).isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.note, color: successColor, size: 16),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${task["notes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHistoryInfoItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: successColor, size: 16),
        SizedBox(width: spXs),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
        return dangerColor;
      case "High":
        return Colors.deepOrange;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Scheduled":
        return infoColor;
      case "In Progress":
        return warningColor;
      case "Pending":
        return primaryColor;
      case "Completed":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }
}
