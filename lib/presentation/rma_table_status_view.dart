import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaTableStatusView extends StatefulWidget {
  const RmaTableStatusView({super.key});

  @override
  State<RmaTableStatusView> createState() => _RmaTableStatusViewState();
}

class _RmaTableStatusViewState extends State<RmaTableStatusView> {
  String selectedTimeRange = "today";
  String selectedFloor = "all";
  String statusFilter = "all";
  bool autoRefresh = true;

  List<Map<String, dynamic>> timeRanges = [
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "Custom Range", "value": "custom"},
  ];

  List<Map<String, dynamic>> floors = [
    {"label": "All Floors", "value": "all"},
    {"label": "Ground Floor", "value": "ground"},
    {"label": "Second Floor", "value": "second"},
    {"label": "Terrace", "value": "terrace"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Available", "value": "available"},
    {"label": "Occupied", "value": "occupied"},
    {"label": "Reserved", "value": "reserved"},
    {"label": "Cleaning", "value": "cleaning"},
  ];

  List<Map<String, dynamic>> tableStatusData = [
    {
      "id": "table_001",
      "number": "T01",
      "floor": "ground",
      "capacity": 2,
      "currentStatus": "occupied",
      "statusHistory": [
        {
          "status": "available",
          "timestamp": "2024-01-15 17:00:00",
          "duration": 45,
        },
        {
          "status": "occupied",
          "timestamp": "2024-01-15 17:45:00",
          "duration": 95,
          "guests": 2,
          "waiter": "Alice Johnson",
          "orderValue": 45.80,
        },
      ],
      "todayStats": {
        "totalOccupiedTime": 285,
        "totalRevenue": 156.40,
        "totalTurnovers": 3,
        "averageOccupancyTime": 95,
        "peakHours": ["19:00", "20:30"],
      },
      "weeklyUtilization": 78.5,
      "monthlyRevenue": 2150.60,
    },
    {
      "id": "table_002",
      "number": "T02",
      "floor": "ground",
      "capacity": 4,
      "currentStatus": "available",
      "statusHistory": [
        {
          "status": "occupied",
          "timestamp": "2024-01-15 16:30:00",
          "duration": 120,
          "guests": 4,
          "waiter": "Bob Smith",
          "orderValue": 89.50,
        },
        {
          "status": "cleaning",
          "timestamp": "2024-01-15 18:30:00",
          "duration": 15,
        },
        {
          "status": "available",
          "timestamp": "2024-01-15 18:45:00",
          "duration": 135,
        },
      ],
      "todayStats": {
        "totalOccupiedTime": 240,
        "totalRevenue": 189.50,
        "totalTurnovers": 2,
        "averageOccupancyTime": 120,
        "peakHours": ["18:00", "19:30"],
      },
      "weeklyUtilization": 65.2,
      "monthlyRevenue": 1890.30,
    },
    {
      "id": "table_003",
      "number": "T03",
      "floor": "ground",
      "capacity": 6,
      "currentStatus": "reserved",
      "statusHistory": [
        {
          "status": "available",
          "timestamp": "2024-01-15 17:00:00",
          "duration": 180,
        },
        {
          "status": "reserved",
          "timestamp": "2024-01-15 20:00:00",
          "duration": 60,
          "reservedBy": "Sarah Wilson",
          "partySize": 6,
        },
      ],
      "todayStats": {
        "totalOccupiedTime": 200,
        "totalRevenue": 245.75,
        "totalTurnovers": 1,
        "averageOccupancyTime": 200,
        "peakHours": ["20:00"],
      },
      "weeklyUtilization": 82.1,
      "monthlyRevenue": 2890.45,
    },
    {
      "id": "table_004",
      "number": "T04",
      "floor": "second",
      "capacity": 4,
      "currentStatus": "cleaning",
      "statusHistory": [
        {
          "status": "occupied",
          "timestamp": "2024-01-15 18:00:00",
          "duration": 90,
          "guests": 3,
          "waiter": "Carol Davis",
          "orderValue": 67.25,
        },
        {
          "status": "cleaning",
          "timestamp": "2024-01-15 19:30:00",
          "duration": 20,
        },
      ],
      "todayStats": {
        "totalOccupiedTime": 180,
        "totalRevenue": 134.50,
        "totalTurnovers": 2,
        "averageOccupancyTime": 90,
        "peakHours": ["18:00", "19:30"],
      },
      "weeklyUtilization": 71.8,
      "monthlyRevenue": 1675.80,
    },
  ];

  Widget _buildStatusOverview() {
    final totalTables = tableStatusData.length;
    final occupiedTables = tableStatusData.where((t) => t["currentStatus"] == "occupied").length;
    final availableTables = tableStatusData.where((t) => t["currentStatus"] == "available").length;
    final reservedTables = tableStatusData.where((t) => t["currentStatus"] == "reserved").length;
    final cleaningTables = tableStatusData.where((t) => t["currentStatus"] == "cleaning").length;

    final totalRevenue = tableStatusData.fold(0.0, (sum, table) {
      return sum + ((table["todayStats"]["totalRevenue"] as num).toDouble());
    });

    final totalTurnovers = tableStatusData.fold(0, (sum, table) {
      return sum + (table["todayStats"]["totalTurnovers"] as int);
    });

    final averageUtilization = tableStatusData.fold(0.0, (sum, table) {
      return sum + ((table["weeklyUtilization"] as num).toDouble());
    }) / totalTables;

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
              Text(
                "Status Overview",
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
                  color: autoRefresh ? successColor.withAlpha(20) : disabledColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      autoRefresh ? Icons.refresh : Icons.pause,
                      color: autoRefresh ? successColor : disabledBoldColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      autoRefresh ? "Auto Refresh" : "Paused",
                      style: TextStyle(
                        fontSize: 12,
                        color: autoRefresh ? successColor : disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildOverviewCard(
                "Total Tables",
                "$totalTables",
                Icons.table_restaurant,
                primaryColor,
              ),
              _buildOverviewCard(
                "Occupied",
                "$occupiedTables",
                Icons.people,
                dangerColor,
              ),
              _buildOverviewCard(
                "Available",
                "$availableTables",
                Icons.check_circle,
                successColor,
              ),
              _buildOverviewCard(
                "Reserved",
                "$reservedTables",
                Icons.schedule,
                warningColor,
              ),
              _buildOverviewCard(
                "Today Revenue",
                "\$${totalRevenue.currency}",
                Icons.attach_money,
                successColor,
              ),
              _buildOverviewCard(
                "Total Turnovers",
                "$totalTurnovers",
                Icons.repeat,
                infoColor,
              ),
              _buildOverviewCard(
                "Avg Utilization",
                "${averageUtilization.toStringAsFixed(1)}%",
                Icons.analytics,
                primaryColor,
              ),
              _buildOverviewCard(
                "Cleaning",
                "$cleaningTables",
                Icons.cleaning_services,
                infoColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 28,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
                child: QDropdownField(
                  label: "Time Range",
                  items: timeRanges,
                  value: selectedTimeRange,
                  onChanged: (value, label) {
                    selectedTimeRange = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Floor",
                  items: floors,
                  value: selectedFloor,
                  onChanged: (value, label) {
                    selectedFloor = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status Filter",
                  items: statusOptions,
                  value: statusFilter,
                  onChanged: (value, label) {
                    statusFilter = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Auto Refresh",
                      "value": true,
                      "checked": autoRefresh,
                    }
                  ],
                  value: [
                    if (autoRefresh)
                      {
                        "label": "Auto Refresh",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    autoRefresh = values.isNotEmpty;
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

  Widget _buildTableStatusCard(Map<String, dynamic> table) {
    Color statusColor;
    IconData statusIcon;
    String statusText;

    switch (table["currentStatus"]) {
      case "available":
        statusColor = successColor;
        statusIcon = Icons.check_circle;
        statusText = "Available";
        break;
      case "occupied":
        statusColor = dangerColor;
        statusIcon = Icons.people;
        statusText = "Occupied";
        break;
      case "reserved":
        statusColor = warningColor;
        statusIcon = Icons.schedule;
        statusText = "Reserved";
        break;
      case "cleaning":
        statusColor = infoColor;
        statusIcon = Icons.cleaning_services;
        statusText = "Cleaning";
        break;
      default:
        statusColor = disabledColor;
        statusIcon = Icons.help;
        statusText = "Unknown";
    }

    final todayStats = table["todayStats"];
    final currentHistory = (table["statusHistory"] as List).isNotEmpty 
        ? (table["statusHistory"] as List).last
        : null;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  statusIcon,
                  color: statusColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Table ${table["number"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${table["floor"]} floor • Capacity: ${table["capacity"]}",
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
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildStatCard(
                "Total Occupied",
                "${((todayStats["totalOccupiedTime"] as int) / 60).toStringAsFixed(1)}h",
                Icons.access_time,
                primaryColor,
              ),
              _buildStatCard(
                "Revenue",
                "\$${((todayStats["totalRevenue"] as num).toDouble()).currency}",
                Icons.attach_money,
                successColor,
              ),
              _buildStatCard(
                "Turnovers",
                "${todayStats["totalTurnovers"]}",
                Icons.repeat,
                infoColor,
              ),
              _buildStatCard(
                "Avg Duration",
                "${todayStats["averageOccupancyTime"]}m",
                Icons.timer,
                warningColor,
              ),
              _buildStatCard(
                "Weekly Util.",
                "${(table["weeklyUtilization"] as num).toStringAsFixed(1)}%",
                Icons.analytics,
                primaryColor,
              ),
              _buildStatCard(
                "Monthly Rev.",
                "\$${((table["monthlyRevenue"] as num).toDouble()).currency}",
                Icons.trending_up,
                successColor,
              ),
            ],
          ),
          if (currentHistory != null) ...[
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: statusColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Current Status Details",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  if (currentHistory["guests"] != null)
                    Text(
                      "Guests: ${currentHistory["guests"]} • Duration: ${currentHistory["duration"]}m",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  if (currentHistory["waiter"] != null)
                    Text(
                      "Waiter: ${currentHistory["waiter"]}",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  if (currentHistory["orderValue"] != null)
                    Text(
                      "Order Value: \$${((currentHistory["orderValue"] as num).toDouble()).currency}",
                      style: TextStyle(fontSize: 12, color: successColor, fontWeight: FontWeight.w600),
                    ),
                  if (currentHistory["reservedBy"] != null)
                    Text(
                      "Reserved by: ${currentHistory["reservedBy"]}",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                ],
              ),
            ),
          ],
          SizedBox(height: spSm),
          Row(
            children: [
              QButton(
                label: "View History",
                icon: Icons.history,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('RmaTableHistoryView', arguments: table)
                },
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Analytics",
                icon: Icons.analytics,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('RmaTableAnalyticsView', arguments: table)
                },
              ),
              Spacer(),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('RmaTableActionsView', arguments: table)
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 10,
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

  List<Map<String, dynamic>> get filteredTables {
    return tableStatusData.where((table) {
      if (selectedFloor != "all" && table["floor"] != selectedFloor) {
        return false;
      }
      if (statusFilter != "all" && table["currentStatus"] != statusFilter) {
        return false;
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Table Status"),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              //navigateTo('RmaTableLayoutView')
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
              ss("Status refreshed");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildStatusOverview(),
            _buildFilters(),
            Container(
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
                      Text(
                        "Table Status (${filteredTables.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Export Report",
                        icon: Icons.download,
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('RmaExportStatusView')
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  if (filteredTables.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        children: [
                          Icon(
                            Icons.table_restaurant,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No tables found",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Column(
                      children: filteredTables.map((table) => _buildTableStatusCard(table)).toList(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
