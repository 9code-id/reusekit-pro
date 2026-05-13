import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmPutawayProcessView extends StatefulWidget {
  const IwmPutawayProcessView({super.key});

  @override
  State<IwmPutawayProcessView> createState() => _IwmPutawayProcessViewState();
}

class _IwmPutawayProcessViewState extends State<IwmPutawayProcessView> {
  int selectedTab = 0;
  String selectedStatus = "all";
  String selectedZone = "all";
  String searchQuery = "";
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Pending", "value": "pending"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Completed", "value": "completed"},
    {"label": "On Hold", "value": "on_hold"},
    {"label": "Cancelled", "value": "cancelled"},
  ];
  
  List<Map<String, dynamic>> zoneOptions = [
    {"label": "All Zones", "value": "all"},
    {"label": "Zone A", "value": "zone_a"},
    {"label": "Zone B", "value": "zone_b"},
    {"label": "Zone C", "value": "zone_c"},
    {"label": "High Rack", "value": "high_rack"},
    {"label": "Floor Storage", "value": "floor"},
  ];
  
  List<Map<String, dynamic>> putawayTasks = [
    {
      "id": "PA-2024-0001",
      "receiptId": "GR-2024-0001",
      "itemCode": "ITM-001",
      "itemName": "Industrial Bearing",
      "quantity": 100,
      "putawayQty": 85,
      "sourceLocation": "RECEIVING-01",
      "targetLocation": "A-01-02-03",
      "zone": "Zone A",
      "status": "In Progress",
      "priority": "High",
      "assignedTo": "John Smith",
      "startTime": "2024-01-15 09:00 AM",
      "estimatedTime": 45,
      "actualTime": 30,
      "equipment": "Forklift-001",
      "notes": "Heavy items - use forklift"
    },
    {
      "id": "PA-2024-0002",
      "receiptId": "GR-2024-0002",
      "itemCode": "ITM-002",
      "itemName": "Electronic Component",
      "quantity": 500,
      "putawayQty": 0,
      "sourceLocation": "RECEIVING-02",
      "targetLocation": "B-02-01-05",
      "zone": "Zone B",
      "status": "Pending",
      "priority": "Medium",
      "assignedTo": "",
      "startTime": "",
      "estimatedTime": 20,
      "actualTime": 0,
      "equipment": "Hand Truck",
      "notes": "Temperature sensitive - handle carefully"
    },
    {
      "id": "PA-2024-0003",
      "receiptId": "GR-2024-0003",
      "itemCode": "ITM-003",
      "itemName": "Steel Plate",
      "quantity": 25,
      "putawayQty": 25,
      "sourceLocation": "RECEIVING-03",
      "targetLocation": "C-03-01-01",
      "zone": "Zone C",
      "status": "Completed",
      "priority": "Low",
      "assignedTo": "Mike Davis",
      "startTime": "2024-01-14 02:00 PM",
      "estimatedTime": 60,
      "actualTime": 55,
      "equipment": "Crane",
      "notes": "Completed successfully"
    },
    {
      "id": "PA-2024-0004",
      "receiptId": "GR-2024-0004",
      "itemCode": "ITM-004",
      "itemName": "Plastic Housing",
      "quantity": 200,
      "putawayQty": 120,
      "sourceLocation": "RECEIVING-01",
      "targetLocation": "A-02-03-01",
      "zone": "Zone A",
      "status": "On Hold",
      "priority": "High",
      "assignedTo": "Lisa Wang",
      "startTime": "2024-01-15 11:00 AM",
      "estimatedTime": 35,
      "actualTime": 25,
      "equipment": "Pallet Jack",
      "notes": "On hold - location full, finding alternative"
    },
  ];
  
  List<Map<String, dynamic>> workers = [
    {
      "name": "John Smith",
      "status": "Active",
      "currentTask": "PA-2024-0001",
      "completedToday": 5,
      "efficiency": 95.0,
      "equipment": "Forklift-001"
    },
    {
      "name": "Sarah Johnson",
      "status": "Available",
      "currentTask": "",
      "completedToday": 8,
      "efficiency": 98.5,
      "equipment": ""
    },
    {
      "name": "Mike Davis",
      "status": "Break",
      "currentTask": "",
      "completedToday": 6,
      "efficiency": 92.0,
      "equipment": "Crane"
    },
    {
      "name": "Lisa Wang",
      "status": "Active",
      "currentTask": "PA-2024-0004",
      "completedToday": 4,
      "efficiency": 89.5,
      "equipment": "Pallet Jack"
    },
  ];
  
  List<Map<String, dynamic>> summaryStats = [
    {
      "title": "Total Tasks",
      "value": 248,
      "subtitle": "This Month",
      "icon": Icons.assignment,
      "color": primaryColor
    },
    {
      "title": "Pending",
      "value": 15,
      "subtitle": "Need Assignment",
      "icon": Icons.pending_actions,
      "color": warningColor
    },
    {
      "title": "In Progress",
      "value": 8,
      "subtitle": "Being Processed",
      "icon": Icons.hourglass_empty,
      "color": infoColor
    },
    {
      "title": "Completion Rate",
      "value": 94.2,
      "subtitle": "This Week",
      "icon": Icons.check_circle,
      "color": successColor,
      "isPercentage": true
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Putaway Process",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Tasks", icon: Icon(Icons.assignment)),
        Tab(text: "Workers", icon: Icon(Icons.people)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildTasksTab(),
        _buildWorkersTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryStats(),
          _buildQuickActions(),
          _buildActiveTasks(),
          _buildZoneStatus(),
        ],
      ),
    );
  }

  Widget _buildTasksTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilters(),
          _buildTasksList(),
        ],
      ),
    );
  }

  Widget _buildWorkersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWorkerStats(),
          _buildWorkersList(),
        ],
      ),
    );
  }

  Widget _buildSummaryStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Putaway Summary",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: summaryStats.map((stat) => _buildStatCard(stat)).toList(),
        ),
      ],
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
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
                  color: (stat["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  stat["icon"],
                  color: stat["color"],
                  size: 20,
                ),
              ),
            ],
          ),
          Text(
            stat["isPercentage"] == true 
                ? "${(stat["value"] as double).toStringAsFixed(1)}%"
                : "${stat["value"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${stat["title"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            "${stat["subtitle"]}",
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
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildActionCard("Create Task", Icons.add_task, "New putaway task"),
              _buildActionCard("Assign Worker", Icons.person_add, "Assign to worker"),
              _buildActionCard("Print Labels", Icons.print, "Location labels"),
              _buildActionCard("Scan Barcode", Icons.qr_code_scanner, "Scan item code"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(String title, IconData icon, String description) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(icon, size: 32, color: primaryColor),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Open",
              size: bs.sm,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveTasks() {
    List<Map<String, dynamic>> activeTasks = putawayTasks.where((task) => 
      task["status"] == "In Progress").toList();
    
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
                "Active Tasks",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${activeTasks.length} active",
                  style: TextStyle(
                    color: infoColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          ...activeTasks.map((task) => _buildTaskCard(task)),
        ],
      ),
    );
  }

  Widget _buildZoneStatus() {
    List<Map<String, dynamic>> zones = [
      {"name": "Zone A", "utilization": 85.5, "capacity": 1000, "available": 145},
      {"name": "Zone B", "utilization": 72.3, "capacity": 800, "available": 221},
      {"name": "Zone C", "utilization": 91.2, "capacity": 1200, "available": 106},
      {"name": "High Rack", "utilization": 68.7, "capacity": 500, "available": 157},
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
            "Zone Status",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...zones.map((zone) => _buildZoneCard(zone)),
        ],
      ),
    );
  }

  Widget _buildZoneCard(Map<String, dynamic> zone) {
    double utilization = zone["utilization"] as double;
    Color utilizationColor = utilization > 90 
        ? dangerColor 
        : utilization > 75 
            ? warningColor 
            : successColor;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(3),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Row(
            children: [
              Text(
                "${zone["name"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: utilizationColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${utilization.toStringAsFixed(1)}%",
                  style: TextStyle(
                    color: utilizationColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: utilization / 100,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(utilizationColor),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Capacity: ${zone["capacity"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Available: ${zone["available"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search Tasks",
                  value: searchQuery,
                  hint: "Task ID, Item Code, Location...",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
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
                  label: "Zone",
                  items: zoneOptions,
                  value: selectedZone,
                  onChanged: (value, label) {
                    selectedZone = value;
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

  Widget _buildTasksList() {
    return Column(
      spacing: spSm,
      children: putawayTasks.map((task) => _buildTaskCard(task)).toList(),
    );
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
    Color statusColor = _getStatusColor(task["status"]);
    Color priorityColor = _getPriorityColor(task["priority"]);
    double progress = (task["putawayQty"] as int) / (task["quantity"] as int);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${task["id"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${task["itemCode"]} - ${task["itemName"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                spacing: spXs,
                children: [
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
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
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
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "From: ${task["sourceLocation"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                    Icon(Icons.arrow_forward, size: 16, color: disabledBoldColor),
                    Expanded(
                      child: Text(
                        "To: ${task["targetLocation"]}",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Zone: ${task["zone"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                    Text(
                      "Equipment: ${task["equipment"]}",
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
          if (progress > 0) ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Progress",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${task["putawayQty"]}/${task["quantity"]} items",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                ),
              ],
            ),
          ],
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if ((task["assignedTo"] as String).isNotEmpty)
                      Text(
                        "Assigned: ${task["assignedTo"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    Text(
                      "Est. Time: ${task["estimatedTime"]} min",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    if ((task["actualTime"] as int) > 0)
                      Text(
                        "Actual: ${task["actualTime"]} min",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
              ),
              QButton(
                label: "Manage",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          if ((task["notes"] as String).isNotEmpty) ...[
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Row(
                children: [
                  Icon(Icons.notes, size: 16, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${task["notes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildWorkerStats() {
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
            "Worker Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildWorkerStatCard("Active Workers", workers.where((w) => w["status"] == "Active").length, primaryColor),
              _buildWorkerStatCard("Available", workers.where((w) => w["status"] == "Available").length, successColor),
              _buildWorkerStatCard("On Break", workers.where((w) => w["status"] == "Break").length, warningColor),
              _buildWorkerStatCard("Avg Efficiency", ((workers.map((w) => w["efficiency"] as double).reduce((a, b) => a + b)) / workers.length), infoColor, isPercentage: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWorkerStatCard(String title, dynamic value, Color color, {bool isPercentage = false}) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Text(
            isPercentage 
                ? "${(value as double).toStringAsFixed(1)}%"
                : "${value}",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkersList() {
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
            "Worker Status",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...workers.map((worker) => _buildWorkerCard(worker)),
        ],
      ),
    );
  }

  Widget _buildWorkerCard(Map<String, dynamic> worker) {
    Color statusColor = _getWorkerStatusColor(worker["status"]);
    
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
            width: 4,
            height: 50,
            decoration: BoxDecoration(
              color: statusColor,
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
                      "${worker["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
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
                        "${worker["status"]}",
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                if ((worker["currentTask"] as String).isNotEmpty)
                  Text(
                    "Current: ${worker["currentTask"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                Row(
                  children: [
                    Text(
                      "Today: ${worker["completedToday"]} tasks",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Efficiency: ${(worker["efficiency"] as double).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                if ((worker["equipment"] as String).isNotEmpty)
                  Text(
                    "Equipment: ${worker["equipment"]}",
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return warningColor;
      case 'in progress':
        return infoColor;
      case 'completed':
        return successColor;
      case 'on hold':
        return primaryColor;
      case 'cancelled':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getWorkerStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return successColor;
      case 'available':
        return infoColor;
      case 'break':
        return warningColor;
      case 'offline':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
