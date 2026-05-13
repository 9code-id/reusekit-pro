import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaLoadingDockView extends StatefulWidget {
  const LtaLoadingDockView({super.key});

  @override
  State<LtaLoadingDockView> createState() => _LtaLoadingDockViewState();
}

class _LtaLoadingDockViewState extends State<LtaLoadingDockView> {
  bool loading = true;
  String searchQuery = "";
  String selectedStatus = "All Status";
  String selectedDock = "All Docks";
  int currentTab = 0;

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All Status"},
    {"label": "Available", "value": "Available"},
    {"label": "Occupied", "value": "Occupied"},
    {"label": "Under Maintenance", "value": "Under Maintenance"},
    {"label": "Reserved", "value": "Reserved"},
  ];

  List<Map<String, dynamic>> dockOptions = [
    {"label": "All Docks", "value": "All Docks"},
    {"label": "Dock A1", "value": "Dock A1"},
    {"label": "Dock A2", "value": "Dock A2"},
    {"label": "Dock B1", "value": "Dock B1"},
    {"label": "Dock B2", "value": "Dock B2"},
    {"label": "Dock C1", "value": "Dock C1"},
  ];

  List<Map<String, dynamic>> loadingDocks = [
    {
      "id": "dock_001",
      "name": "Dock A1",
      "status": "Occupied",
      "truckLicense": "ABC-1234",
      "driverName": "John Smith",
      "arrivalTime": "2024-03-15T08:30:00Z",
      "estimatedCompletion": "2024-03-15T12:00:00Z",
      "loadingProgress": 75,
      "cargoType": "Electronics",
      "priority": "High",
      "packages": 125,
      "weight": 2.5,
      "capacity": 100,
      "utilization": 75,
      "nextScheduled": "2024-03-15T13:00:00Z",
      "equipmentNeeded": ["Forklift", "Pallet Jack"],
      "specialInstructions": "Fragile items - handle with care",
    },
    {
      "id": "dock_002",
      "name": "Dock A2",
      "status": "Available",
      "truckLicense": "",
      "driverName": "",
      "arrivalTime": "",
      "estimatedCompletion": "",
      "loadingProgress": 0,
      "cargoType": "",
      "priority": "",
      "packages": 0,
      "weight": 0.0,
      "capacity": 100,
      "utilization": 0,
      "nextScheduled": "2024-03-15T14:30:00Z",
      "equipmentNeeded": ["Forklift"],
      "specialInstructions": "",
    },
    {
      "id": "dock_003",
      "name": "Dock B1",
      "status": "Reserved",
      "truckLicense": "XYZ-5678",
      "driverName": "Mike Johnson",
      "arrivalTime": "2024-03-15T13:00:00Z",
      "estimatedCompletion": "2024-03-15T16:30:00Z",
      "loadingProgress": 0,
      "cargoType": "Automotive Parts",
      "priority": "Medium",
      "packages": 89,
      "weight": 3.2,
      "capacity": 100,
      "utilization": 0,
      "nextScheduled": "2024-03-15T13:00:00Z",
      "equipmentNeeded": ["Forklift", "Crane"],
      "specialInstructions": "Heavy lifting required",
    },
    {
      "id": "dock_004",
      "name": "Dock B2",
      "status": "Under Maintenance",
      "truckLicense": "",
      "driverName": "",
      "arrivalTime": "",
      "estimatedCompletion": "",
      "loadingProgress": 0,
      "cargoType": "",
      "priority": "",
      "packages": 0,
      "weight": 0.0,
      "capacity": 100,
      "utilization": 0,
      "nextScheduled": "2024-03-16T08:00:00Z",
      "equipmentNeeded": [],
      "specialInstructions": "Hydraulic system repair in progress",
    },
    {
      "id": "dock_005",
      "name": "Dock C1",
      "status": "Occupied",
      "truckLicense": "DEF-9012",
      "driverName": "Sarah Wilson",
      "arrivalTime": "2024-03-15T09:15:00Z",
      "estimatedCompletion": "2024-03-15T11:45:00Z",
      "loadingProgress": 45,
      "cargoType": "Pharmaceuticals",
      "priority": "Urgent",
      "packages": 67,
      "weight": 1.8,
      "capacity": 100,
      "utilization": 45,
      "nextScheduled": "2024-03-15T12:30:00Z",
      "equipmentNeeded": ["Temperature Control"],
      "specialInstructions": "Temperature sensitive - maintain cold chain",
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadDockData();
  }

  void _loadDockData() async {
    await Future.delayed(Duration(seconds: 1));
    loading = false;
    setState(() {});
  }

  List<Map<String, dynamic>> get filteredDocks {
    return loadingDocks.where((dock) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${dock["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${dock["truckLicense"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${dock["driverName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${dock["cargoType"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All Status" || 
          dock["status"] == selectedStatus;
      
      bool matchesDock = selectedDock == "All Docks" || 
          dock["name"] == selectedDock;
      
      return matchesSearch && matchesStatus && matchesDock;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Available":
        return successColor;
      case "Occupied":
        return primaryColor;
      case "Under Maintenance":
        return dangerColor;
      case "Reserved":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "Available":
        return Icons.check_circle;
      case "Occupied":
        return Icons.local_shipping;
      case "Under Maintenance":
        return Icons.build;
      case "Reserved":
        return Icons.schedule;
      default:
        return Icons.help;
    }
  }

  String _getPriorityColor(String priority) {
    switch (priority) {
      case "Urgent":
        return "red";
      case "High":
        return "orange";
      case "Medium":
        return "yellow";
      case "Low":
        return "green";
      default:
        return "gray";
    }
  }

  Widget _buildDockOverview() {
    List<Map<String, dynamic>> displayDocks = filteredDocks;
    int availableDocks = displayDocks.where((d) => d["status"] == "Available").length;
    int occupiedDocks = displayDocks.where((d) => d["status"] == "Occupied").length;
    int maintenanceDocks = displayDocks.where((d) => d["status"] == "Under Maintenance").length;
    int reservedDocks = displayDocks.where((d) => d["status"] == "Reserved").length;

    return Column(
      spacing: spMd,
      children: [
        // Status Overview Cards
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: [
            _buildStatusCard("Available", availableDocks, successColor, Icons.check_circle),
            _buildStatusCard("Occupied", occupiedDocks, primaryColor, Icons.local_shipping),
            _buildStatusCard("Reserved", reservedDocks, warningColor, Icons.schedule),
            _buildStatusCard("Maintenance", maintenanceDocks, dangerColor, Icons.build),
          ],
        ),

        // Dock List
        Column(
          children: displayDocks.map((dock) => _buildDockCard(dock)).toList(),
        ),
      ],
    );
  }

  Widget _buildStatusCard(String title, int count, Color color, IconData icon) {
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

  Widget _buildDockCard(Map<String, dynamic> dock) {
    String status = "${dock["status"]}";
    bool isOccupied = status == "Occupied";
    bool isReserved = status == "Reserved";
    
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
                "${dock["name"]}",
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
              Spacer(),
              if (isOccupied || isReserved)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getPriorityColor("${dock["priority"]}") == "red" ? dangerColor.withValues(alpha: 0.1) :
                           _getPriorityColor("${dock["priority"]}") == "orange" ? warningColor.withValues(alpha: 0.1) :
                           _getPriorityColor("${dock["priority"]}") == "yellow" ? Colors.yellow.withValues(alpha: 0.1) :
                           successColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${dock["priority"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: _getPriorityColor("${dock["priority"]}") == "red" ? dangerColor :
                             _getPriorityColor("${dock["priority"]}") == "orange" ? warningColor :
                             _getPriorityColor("${dock["priority"]}") == "yellow" ? Colors.orange :
                             successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: spSm),

          if (isOccupied || isReserved) ...[
            // Truck and Driver Info
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.local_shipping, size: 14, color: disabledBoldColor),
                          SizedBox(width: 4),
                          Text(
                            "${dock["truckLicense"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(Icons.person, size: 14, color: disabledBoldColor),
                          SizedBox(width: 4),
                          Text(
                            "${dock["driverName"]}",
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
                            "${dock["cargoType"]}",
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
                            "${(dock["weight"] as num).toStringAsFixed(1)}T",
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

            if (isOccupied) ...[
              // Loading Progress
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Loading Progress",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${dock["loadingProgress"]}%",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  LinearProgressIndicator(
                    value: (dock["loadingProgress"] as num) / 100,
                    backgroundColor: Colors.grey.withValues(alpha: 0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                ],
              ),
              SizedBox(height: spSm),
            ],

            // Equipment and Instructions
            if ((dock["equipmentNeeded"] as List).isNotEmpty) ...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Equipment Needed:",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: 2),
                  Wrap(
                    spacing: spXs,
                    children: (dock["equipmentNeeded"] as List).map((equipment) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                        decoration: BoxDecoration(
                          color: infoColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "$equipment",
                          style: TextStyle(
                            fontSize: 9,
                            color: infoColor,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: spSm),
            ],

            if ("${dock["specialInstructions"]}".isNotEmpty) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: warningColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning, size: 12, color: warningColor),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        "${dock["specialInstructions"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: warningColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spSm),
            ],
          ],

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: status == "Available" ? "Assign Truck" : 
                         status == "Occupied" ? "View Details" :
                         status == "Reserved" ? "Modify" : "Schedule Maintenance",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
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

  Widget _buildScheduleView() {
    return Column(
      spacing: spMd,
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Today's Schedule",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              ...loadingDocks.where((dock) => "${dock["nextScheduled"]}".isNotEmpty).map((dock) {
                DateTime scheduledTime = DateTime.parse("${dock["nextScheduled"]}");
                return Container(
                  margin: EdgeInsets.only(bottom: spXs),
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "${scheduledTime.hour.toString().padLeft(2, '0')}:${scheduledTime.minute.toString().padLeft(2, '0')}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${dock["name"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      if ("${dock["truckLicense"]}".isNotEmpty)
                        Text(
                          "${dock["truckLicense"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Loading Dock Management"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return QTabBar(
      title: "Loading Dock Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Dock Overview", icon: Icon(Icons.warehouse)),
        Tab(text: "Schedule", icon: Icon(Icons.schedule)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Search and Filters
              QTextField(
                label: "Search docks...",
                value: searchQuery,
                hint: "Search by dock name, truck, driver, or cargo",
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
                      label: "Dock",
                      items: dockOptions,
                      value: selectedDock,
                      onChanged: (value, label) {
                        selectedDock = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              _buildDockOverview(),
            ],
          ),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildScheduleView(),
        ),
      ],
    );
  }
}
