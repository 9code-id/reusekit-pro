import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaUnloadingView extends StatefulWidget {
  const LtaUnloadingView({super.key});

  @override
  State<LtaUnloadingView> createState() => _LtaUnloadingViewState();
}

class _LtaUnloadingViewState extends State<LtaUnloadingView> {
  bool loading = true;
  String searchQuery = "";
  String selectedStatus = "All Status";
  String selectedPriority = "All Priorities";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All Status"},
    {"label": "Pending", "value": "Pending"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Delayed", "value": "Delayed"},
    {"label": "Issues", "value": "Issues"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All Priorities", "value": "All Priorities"},
    {"label": "Urgent", "value": "Urgent"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> unloadingTasks = [
    {
      "id": "unload_001",
      "truckLicense": "ABC-1234",
      "driverName": "John Smith",
      "arrivalTime": "2024-03-15T08:30:00Z",
      "startTime": "2024-03-15T09:00:00Z",
      "estimatedCompletion": "2024-03-15T12:00:00Z",
      "actualCompletion": "",
      "status": "In Progress",
      "priority": "High",
      "dockAssigned": "Dock A1",
      "cargoType": "Electronics",
      "totalPackages": 125,
      "unloadedPackages": 78,
      "weight": 2.5,
      "unloadedWeight": 1.6,
      "damagedItems": 2,
      "specialHandling": true,
      "temperatureControlled": false,
      "hazardousMaterials": false,
      "workersAssigned": ["Worker-001", "Worker-002", "Worker-003"],
      "equipmentUsed": ["Forklift-A", "Pallet Jack-1"],
      "issues": [],
      "notes": "Fragile electronics - extra care required",
      "qualityChecked": 65,
      "lastUpdate": "2024-03-15T11:30:00Z",
    },
    {
      "id": "unload_002",
      "truckLicense": "XYZ-5678",
      "driverName": "Mike Johnson",
      "arrivalTime": "2024-03-15T07:45:00Z",
      "startTime": "2024-03-15T08:15:00Z",
      "estimatedCompletion": "2024-03-15T11:30:00Z",
      "actualCompletion": "2024-03-15T11:45:00Z",
      "status": "Completed",
      "priority": "Medium",
      "dockAssigned": "Dock B1",
      "cargoType": "Automotive Parts",
      "totalPackages": 89,
      "unloadedPackages": 89,
      "weight": 3.2,
      "unloadedWeight": 3.2,
      "damagedItems": 0,
      "specialHandling": false,
      "temperatureControlled": false,
      "hazardousMaterials": false,
      "workersAssigned": ["Worker-004", "Worker-005"],
      "equipmentUsed": ["Forklift-B", "Crane-1"],
      "issues": [],
      "notes": "Heavy parts - used crane for larger items",
      "qualityChecked": 89,
      "lastUpdate": "2024-03-15T11:45:00Z",
    },
    {
      "id": "unload_003",
      "truckLicense": "DEF-9012",
      "driverName": "Sarah Wilson",
      "arrivalTime": "2024-03-15T09:15:00Z",
      "startTime": "",
      "estimatedCompletion": "2024-03-15T13:00:00Z",
      "actualCompletion": "",
      "status": "Pending",
      "priority": "Urgent",
      "dockAssigned": "Dock C1",
      "cargoType": "Pharmaceuticals",
      "totalPackages": 67,
      "unloadedPackages": 0,
      "weight": 1.8,
      "unloadedWeight": 0.0,
      "damagedItems": 0,
      "specialHandling": true,
      "temperatureControlled": true,
      "hazardousMaterials": false,
      "workersAssigned": ["Worker-006", "Worker-007"],
      "equipmentUsed": ["Temperature-Cart-1"],
      "issues": [],
      "notes": "Temperature sensitive pharmaceuticals - maintain cold chain",
      "qualityChecked": 0,
      "lastUpdate": "2024-03-15T09:15:00Z",
    },
    {
      "id": "unload_004",
      "truckLicense": "GHI-3456",
      "driverName": "David Brown",
      "arrivalTime": "2024-03-15T10:30:00Z",
      "startTime": "2024-03-15T11:00:00Z",
      "estimatedCompletion": "2024-03-15T14:30:00Z",
      "actualCompletion": "",
      "status": "Delayed",
      "priority": "High",
      "dockAssigned": "Dock A2",
      "cargoType": "Chemicals",
      "totalPackages": 45,
      "unloadedPackages": 12,
      "weight": 2.1,
      "unloadedWeight": 0.5,
      "damagedItems": 1,
      "specialHandling": true,
      "temperatureControlled": false,
      "hazardousMaterials": true,
      "workersAssigned": ["Worker-008", "Worker-009"],
      "equipmentUsed": ["Hazmat-Cart-1", "Forklift-C"],
      "issues": ["Equipment malfunction", "Safety protocol delay"],
      "notes": "Hazardous chemicals require special handling procedures",
      "qualityChecked": 11,
      "lastUpdate": "2024-03-15T12:00:00Z",
    },
    {
      "id": "unload_005",
      "truckLicense": "JKL-7890",
      "driverName": "Lisa Garcia",
      "arrivalTime": "2024-03-15T11:45:00Z",
      "startTime": "2024-03-15T12:15:00Z",
      "estimatedCompletion": "2024-03-15T15:00:00Z",
      "actualCompletion": "",
      "status": "Issues",
      "priority": "Medium",
      "dockAssigned": "Dock B2",
      "cargoType": "Food Products",
      "totalPackages": 156,
      "unloadedPackages": 34,
      "weight": 4.2,
      "unloadedWeight": 0.9,
      "damagedItems": 5,
      "specialHandling": false,
      "temperatureControlled": true,
      "hazardousMaterials": false,
      "workersAssigned": ["Worker-010", "Worker-011", "Worker-012"],
      "equipmentUsed": ["Refrigerated-Cart-1", "Pallet Jack-2"],
      "issues": ["Damaged packaging", "Temperature fluctuation"],
      "notes": "Some packages damaged during transport - quality inspection required",
      "qualityChecked": 29,
      "lastUpdate": "2024-03-15T12:45:00Z",
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadUnloadingData();
  }

  void _loadUnloadingData() async {
    await Future.delayed(Duration(seconds: 1));
    loading = false;
    setState(() {});
  }

  List<Map<String, dynamic>> get filteredTasks {
    return unloadingTasks.where((task) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${task["truckLicense"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${task["driverName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${task["cargoType"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${task["dockAssigned"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All Status" || 
          task["status"] == selectedStatus;
      
      bool matchesPriority = selectedPriority == "All Priorities" || 
          task["priority"] == selectedPriority;
      
      return matchesSearch && matchesStatus && matchesPriority;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return warningColor;
      case "In Progress":
        return primaryColor;
      case "Completed":
        return successColor;
      case "Delayed":
        return Colors.orange;
      case "Issues":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "Pending":
        return Icons.schedule;
      case "In Progress":
        return Icons.inventory;
      case "Completed":
        return Icons.check_circle;
      case "Delayed":
        return Icons.warning;
      case "Issues":
        return Icons.error;
      default:
        return Icons.help;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Urgent":
        return dangerColor;
      case "High":
        return Colors.orange;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  String _formatDuration(String startTimeStr, String endTimeStr) {
    if (startTimeStr.isEmpty || endTimeStr.isEmpty) return "N/A";
    
    DateTime startTime = DateTime.parse(startTimeStr);
    DateTime endTime = DateTime.parse(endTimeStr);
    Duration duration = endTime.difference(startTime);
    
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    
    return "${hours}h ${minutes}m";
  }

  Widget _buildSummaryCards() {
    List<Map<String, dynamic>> displayTasks = filteredTasks;
    int pendingTasks = displayTasks.where((t) => t["status"] == "Pending").length;
    int inProgressTasks = displayTasks.where((t) => t["status"] == "In Progress").length;
    int completedTasks = displayTasks.where((t) => t["status"] == "Completed").length;
    int delayedTasks = displayTasks.where((t) => t["status"] == "Delayed").length;
    int issueTasks = displayTasks.where((t) => t["status"] == "Issues").length;

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildSummaryCard("Pending", pendingTasks, warningColor, Icons.schedule),
        _buildSummaryCard("In Progress", inProgressTasks, primaryColor, Icons.inventory),
        _buildSummaryCard("Completed", completedTasks, successColor, Icons.check_circle),
        _buildSummaryCard("Delayed", delayedTasks, Colors.orange, Icons.warning),
        _buildSummaryCard("Issues", issueTasks, dangerColor, Icons.error),
      ],
    );
  }

  Widget _buildSummaryCard(String title, int count, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "$count",
              style: TextStyle(
                fontSize: fsH3,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnloadingCard(Map<String, dynamic> task) {
    String status = "${task["status"]}";
    double progress = (task["unloadedPackages"] as num) / (task["totalPackages"] as num);
    bool hasIssues = (task["issues"] as List).isNotEmpty;
    bool isCompleted = status == "Completed";
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            color: _getStatusColor(status),
            width: 4,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                _getStatusIcon(status),
                color: _getStatusColor(status),
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "${task["truckLicense"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getStatusColor(status).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 10,
                    color: _getStatusColor(status),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getPriorityColor("${task["priority"]}").withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${task["priority"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: _getPriorityColor("${task["priority"]}"),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Spacer(),
              if (hasIssues)
                Icon(
                  Icons.warning,
                  color: dangerColor,
                  size: 16,
                ),
            ],
          ),
          SizedBox(height: spSm),

          // Driver and Dock Info
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, size: 14, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Text(
                          "${task["driverName"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 14, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Text(
                          "${task["dockAssigned"]}",
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.inventory, size: 14, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Text(
                          "${task["cargoType"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.scale, size: 14, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Text(
                          "${(task["weight"] as num).toStringAsFixed(1)}T",
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
          ),
          SizedBox(height: spSm),

          // Special Handling Indicators
          if (task["specialHandling"] == true || task["temperatureControlled"] == true || task["hazardousMaterials"] == true)
            Column(
              children: [
                Wrap(
                  spacing: spXs,
                  children: [
                    if (task["specialHandling"] == true)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                        decoration: BoxDecoration(
                          color: warningColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Special Handling",
                          style: TextStyle(
                            fontSize: 9,
                            color: warningColor,
                          ),
                        ),
                      ),
                    if (task["temperatureControlled"] == true)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                        decoration: BoxDecoration(
                          color: infoColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Temperature Controlled",
                          style: TextStyle(
                            fontSize: 9,
                            color: infoColor,
                          ),
                        ),
                      ),
                    if (task["hazardousMaterials"] == true)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                        decoration: BoxDecoration(
                          color: dangerColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Hazardous",
                          style: TextStyle(
                            fontSize: 9,
                            color: dangerColor,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: spSm),
              ],
            ),

          // Progress Information
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Packages: ${task["unloadedPackages"]}/${task["totalPackages"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey.withValues(alpha: 0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isCompleted ? successColor : primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spMd),
              Column(
                children: [
                  Text(
                    "${(progress * 100).toInt()}%",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isCompleted ? successColor : primaryColor,
                    ),
                  ),
                  if ((task["damagedItems"] as num) > 0)
                    Text(
                      "${task["damagedItems"]} damaged",
                      style: TextStyle(
                        fontSize: 10,
                        color: dangerColor,
                      ),
                    ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),

          // Issues (if any)
          if (hasIssues) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: dangerColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.error, size: 12, color: dangerColor),
                      SizedBox(width: 4),
                      Text(
                        "Issues:",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  ...(task["issues"] as List).map((issue) {
                    return Text(
                      "• $issue",
                      style: TextStyle(
                        fontSize: 10,
                        color: dangerColor,
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            SizedBox(height: spSm),
          ],

          // Notes
          if ("${task["notes"]}".isNotEmpty) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(Icons.note, size: 12, color: disabledBoldColor),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      "${task["notes"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spSm),
          ],

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: status == "Pending" ? "Start Unloading" : 
                         status == "In Progress" ? "Update Progress" :
                         status == "Completed" ? "View Details" : "Resolve Issues",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Unloading Management"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    List<Map<String, dynamic>> displayTasks = filteredTasks;

    return Scaffold(
      appBar: AppBar(
        title: Text("Unloading Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filters
            QTextField(
              label: "Search unloading tasks...",
              value: searchQuery,
              hint: "Search by truck, driver, cargo type, or dock",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
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

            // Summary Cards
            _buildSummaryCards(),

            // Results Summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${displayTasks.length} unloading tasks found",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Unloading Tasks List
            if (displayTasks.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.inventory,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No unloading tasks found",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your filters or check back later",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              Column(
                children: displayTasks.map((task) => _buildUnloadingCard(task)).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
