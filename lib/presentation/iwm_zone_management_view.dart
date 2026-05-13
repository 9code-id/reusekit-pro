import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmZoneManagementView extends StatefulWidget {
  const IwmZoneManagementView({super.key});

  @override
  State<IwmZoneManagementView> createState() => _IwmZoneManagementViewState();
}

class _IwmZoneManagementViewState extends State<IwmZoneManagementView> {
  int selectedTab = 0;
  String selectedWarehouse = "WH001";
  String selectedZoneFilter = "all";
  String searchQuery = "";

  List<Map<String, dynamic>> warehouses = [
    {"label": "Main Distribution Center (WH001)", "value": "WH001"},
    {"label": "Secondary Warehouse (WH002)", "value": "WH002"},
    {"label": "Cold Storage Facility (WH003)", "value": "WH003"},
  ];

  List<Map<String, dynamic>> zoneFilters = [
    {"label": "All Zones", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Maintenance", "value": "maintenance"},
    {"label": "Inactive", "value": "inactive"},
    {"label": "High Utilization", "value": "high_util"},
  ];

  List<Map<String, dynamic>> zones = [
    {
      "id": "A",
      "name": "Zone A",
      "category": "Electronics",
      "status": "Active",
      "manager": "John Smith",
      "totalCapacity": 15000,
      "usedCapacity": 12000,
      "availableCapacity": 3000,
      "aisles": 6,
      "shelves": 72,
      "bins": 288,
      "activeItems": 1250,
      "totalItems": 1450,
      "temperature": "22°C",
      "humidity": "45%",
      "lastInspection": "2024-01-10",
      "safetyCompliance": 98,
      "efficiency": 85,
      "turnoverRate": 75,
      "pickingAccuracy": 99.2,
      "averagePickTime": "3.5 min"
    },
    {
      "id": "B",
      "name": "Zone B",
      "category": "Clothing",
      "status": "Active",
      "manager": "Sarah Davis",
      "totalCapacity": 18000,
      "usedCapacity": 14500,
      "availableCapacity": 3500,
      "aisles": 5,
      "shelves": 60,
      "bins": 240,
      "activeItems": 2100,
      "totalItems": 2300,
      "temperature": "21°C",
      "humidity": "50%",
      "lastInspection": "2024-01-08",
      "safetyCompliance": 95,
      "efficiency": 78,
      "turnoverRate": 82,
      "pickingAccuracy": 98.8,
      "averagePickTime": "4.2 min"
    },
    {
      "id": "C",
      "name": "Zone C",
      "category": "Home & Garden",
      "status": "Active",
      "manager": "Mike Johnson",
      "totalCapacity": 20000,
      "usedCapacity": 8500,
      "availableCapacity": 11500,
      "aisles": 8,
      "shelves": 96,
      "bins": 384,
      "activeItems": 850,
      "totalItems": 1200,
      "temperature": "23°C",
      "humidity": "48%",
      "lastInspection": "2024-01-12",
      "safetyCompliance": 92,
      "efficiency": 62,
      "turnoverRate": 45,
      "pickingAccuracy": 97.5,
      "averagePickTime": "5.8 min"
    },
    {
      "id": "D",
      "name": "Zone D",
      "category": "Sports",
      "status": "Maintenance",
      "manager": "Lisa Chen",
      "totalCapacity": 12000,
      "usedCapacity": 9000,
      "availableCapacity": 3000,
      "aisles": 4,
      "shelves": 48,
      "bins": 192,
      "activeItems": 750,
      "totalItems": 900,
      "temperature": "22°C",
      "humidity": "46%",
      "lastInspection": "2024-01-05",
      "safetyCompliance": 88,
      "efficiency": 70,
      "turnoverRate": 65,
      "pickingAccuracy": 96.8,
      "averagePickTime": "4.5 min"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Zone Management",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Zones", icon: Icon(Icons.grid_view)),
        Tab(text: "Performance", icon: Icon(Icons.analytics)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildZonesTab(),
        _buildPerformanceTab(),
        _buildSettingsTab(),
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
          _buildOverviewFilters(),
          _buildZoneStats(),
          _buildCapacityOverview(),
          _buildRecentActivities(),
        ],
      ),
    );
  }

  Widget _buildZonesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildZoneFilters(),
          _buildZonesList(),
        ],
      ),
    );
  }

  Widget _buildPerformanceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPerformanceMetrics(),
          _buildEfficiencyAnalysis(),
          _buildComplianceStatus(),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildZoneConfiguration(),
          _buildAlertSettings(),
          _buildMaintenanceSchedule(),
        ],
      ),
    );
  }

  Widget _buildOverviewFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: QDropdownField(
              label: "Select Warehouse",
              items: warehouses,
              value: selectedWarehouse,
              onChanged: (value, label) {
                selectedWarehouse = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.add,
            label: "Add Zone",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildZoneStats() {
    List<Map<String, dynamic>> stats = [
      {
        "title": "Total Zones",
        "value": zones.length,
        "subtitle": "Configured",
        "icon": Icons.grid_view,
        "color": primaryColor
      },
      {
        "title": "Active Zones",
        "value": zones.where((z) => z["status"] == "Active").length,
        "subtitle": "Operational",
        "icon": Icons.check_circle,
        "color": successColor
      },
      {
        "title": "Avg Utilization",
        "value": "${_calculateAverageUtilization().toStringAsFixed(1)}%",
        "subtitle": "Capacity Used",
        "icon": Icons.storage,
        "color": warningColor
      },
      {
        "title": "Maintenance",
        "value": zones.where((z) => z["status"] == "Maintenance").length,
        "subtitle": "Under Service",
        "icon": Icons.build,
        "color": dangerColor
      },
    ];

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: stats.map((stat) => _buildStatCard(stat)).toList(),
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
            "${stat["value"]}",
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

  Widget _buildCapacityOverview() {
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
            "Capacity Overview by Zone",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...zones.map((zone) => _buildCapacityBar(zone)),
        ],
      ),
    );
  }

  Widget _buildCapacityBar(Map<String, dynamic> zone) {
    double utilizationPercent = ((zone["usedCapacity"] as int) / (zone["totalCapacity"] as int)) * 100;
    Color statusColor = _getStatusColor(zone["status"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: statusColor.withAlpha(30)),
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Zone ${zone["id"]} - ${zone["category"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${utilizationPercent.toStringAsFixed(1)}%",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
            ],
          ),
          LinearProgressIndicator(
            value: utilizationPercent / 100,
            backgroundColor: disabledOutlineBorderColor,
            valueColor: AlwaysStoppedAnimation<Color>(statusColor),
          ),
          Row(
            children: [
              Text(
                "Used: ${((zone["usedCapacity"] as int) / 1000).toStringAsFixed(1)}K sq ft",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Available: ${((zone["availableCapacity"] as int) / 1000).toStringAsFixed(1)}K sq ft",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivities() {
    List<Map<String, dynamic>> activities = [
      {"action": "Zone Reconfigured", "zone": "Zone C", "description": "Shelf layout optimized for better accessibility", "time": "2 hours ago"},
      {"action": "Maintenance Completed", "zone": "Zone D", "description": "Safety inspection and equipment check", "time": "4 hours ago"},
      {"action": "Capacity Expanded", "zone": "Zone A", "description": "Added 2 new aisles with 24 shelves", "time": "1 day ago"},
      {"action": "Temperature Alert", "zone": "Zone B", "description": "Climate control system adjusted", "time": "2 days ago"},
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
            "Recent Zone Activities",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...activities.map((activity) => _buildActivityItem(activity)),
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
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: _getActionColor(activity["action"]),
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
                      "${activity["action"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${activity["time"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${activity["zone"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: _getActionColor(activity["action"]),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "${activity["description"]}",
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

  Widget _buildZoneFilters() {
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
                  label: "Search Zones",
                  value: searchQuery,
                  hint: "Search by zone name or category",
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
                  label: "Filter Status",
                  items: zoneFilters,
                  value: selectedZoneFilter,
                  onChanged: (value, label) {
                    selectedZoneFilter = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.tune,
                label: "Advanced",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildZonesList() {
    List<Map<String, dynamic>> filteredZones = zones.where((zone) {
      bool matchesSearch = searchQuery.isEmpty ||
        zone["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        zone["category"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesFilter = selectedZoneFilter == "all" ||
        (selectedZoneFilter == "active" && zone["status"] == "Active") ||
        (selectedZoneFilter == "maintenance" && zone["status"] == "Maintenance") ||
        (selectedZoneFilter == "inactive" && zone["status"] == "Inactive") ||
        (selectedZoneFilter == "high_util" && ((zone["usedCapacity"] as int) / (zone["totalCapacity"] as int)) > 0.8);
      
      return matchesSearch && matchesFilter;
    }).toList();

    return Column(
      spacing: spSm,
      children: filteredZones.map((zone) => _buildZoneCard(zone)).toList(),
    );
  }

  Widget _buildZoneCard(Map<String, dynamic> zone) {
    double utilizationPercent = ((zone["usedCapacity"] as int) / (zone["totalCapacity"] as int)) * 100;
    Color statusColor = _getStatusColor(zone["status"]);
    
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
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Center(
                  child: Text(
                    "${zone["id"]}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${zone["name"]} - ${zone["category"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Manager: ${zone["manager"]}",
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
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${zone["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildZoneMetric("Capacity", "${((zone["totalCapacity"] as int) / 1000).toStringAsFixed(1)}K sq ft", "${utilizationPercent.toStringAsFixed(1)}% Used"),
              _buildZoneMetric("Structure", "${zone["aisles"]} Aisles", "${zone["shelves"]} Shelves • ${zone["bins"]} Bins"),
              _buildZoneMetric("Items", "${zone["activeItems"]} Active", "${zone["totalItems"]} Total Items"),
              _buildZoneMetric("Environment", "${zone["temperature"]}", "${zone["humidity"]} Humidity"),
            ],
          ),
          LinearProgressIndicator(
            value: utilizationPercent / 100,
            backgroundColor: disabledOutlineBorderColor,
            valueColor: AlwaysStoppedAnimation<Color>(statusColor),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Configure",
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

  Widget _buildZoneMetric(String title, String value, String subtitle) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 10,
              color: disabledColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceMetrics() {
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
            "Zone Performance Metrics",
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
              _buildPerformanceCard("Average Efficiency", "${_calculateAverageEfficiency().toStringAsFixed(1)}%", successColor, Icons.trending_up),
              _buildPerformanceCard("Turnover Rate", "${_calculateAverageTurnover().toStringAsFixed(1)}%", warningColor, Icons.sync),
              _buildPerformanceCard("Picking Accuracy", "${_calculateAverageAccuracy().toStringAsFixed(1)}%", primaryColor, Icons.check_circle),
              _buildPerformanceCard("Avg Pick Time", "${_calculateAveragePickTime().toStringAsFixed(1)} min", infoColor, Icons.timer),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(icon, color: color, size: 24),
          Text(
            value,
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

  Widget _buildEfficiencyAnalysis() {
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
            "Efficiency Analysis by Zone",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...zones.map((zone) => _buildEfficiencyBar(zone)),
        ],
      ),
    );
  }

  Widget _buildEfficiencyBar(Map<String, dynamic> zone) {
    double efficiency = (zone["efficiency"] as int).toDouble();
    Color efficiencyColor = efficiency >= 80 ? successColor : efficiency >= 60 ? warningColor : dangerColor;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: efficiencyColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: efficiencyColor.withAlpha(30)),
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Zone ${zone["id"]} - ${zone["category"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${efficiency.toStringAsFixed(0)}%",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: efficiencyColor,
                ),
              ),
            ],
          ),
          LinearProgressIndicator(
            value: efficiency / 100,
            backgroundColor: disabledOutlineBorderColor,
            valueColor: AlwaysStoppedAnimation<Color>(efficiencyColor),
          ),
          Row(
            children: [
              Text(
                "Pick Time: ${zone["averagePickTime"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Accuracy: ${zone["pickingAccuracy"]}%",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComplianceStatus() {
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
            "Safety Compliance Status",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...zones.map((zone) => _buildComplianceItem(zone)),
        ],
      ),
    );
  }

  Widget _buildComplianceItem(Map<String, dynamic> zone) {
    double compliance = (zone["safetyCompliance"] as int).toDouble();
    Color complianceColor = compliance >= 95 ? successColor : compliance >= 90 ? warningColor : dangerColor;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: complianceColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: complianceColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: complianceColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Text(
                "${zone["id"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: complianceColor,
                ),
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${zone["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Last Inspection: ${zone["lastInspection"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${compliance.toStringAsFixed(0)}%",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: complianceColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildZoneConfiguration() {
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
            "Zone Configuration",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Auto-optimize layouts",
                "value": true,
                "checked": true,
              }
            ],
            value: [{"label": "Auto-optimize layouts", "value": true, "checked": true}],
            onChanged: (values, ids) {},
          ),
          QSwitch(
            items: [
              {
                "label": "Temperature monitoring",
                "value": true,
                "checked": true,
              }
            ],
            value: [{"label": "Temperature monitoring", "value": true, "checked": true}],
            onChanged: (values, ids) {},
          ),
          QSwitch(
            items: [
              {
                "label": "Automated reporting",
                "value": true,
                "checked": false,
              }
            ],
            value: [],
            onChanged: (values, ids) {},
          ),
        ],
      ),
    );
  }

  Widget _buildAlertSettings() {
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
            "Alert Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "High Utilization Threshold (%)",
                  value: "85",
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Low Efficiency Threshold (%)",
                  value: "60",
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          QButton(
            label: "Update Alert Settings",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildMaintenanceSchedule() {
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
            "Maintenance Schedule",
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
                  label: "Inspection Frequency",
                  items: [
                    {"label": "Weekly", "value": "weekly"},
                    {"label": "Bi-weekly", "value": "biweekly"},
                    {"label": "Monthly", "value": "monthly"},
                    {"label": "Quarterly", "value": "quarterly"},
                  ],
                  value: "monthly",
                  onChanged: (value, label) {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Schedule Now",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  double _calculateAverageUtilization() {
    if (zones.isEmpty) return 0;
    double total = 0;
    for (var zone in zones) {
      total += ((zone["usedCapacity"] as int) / (zone["totalCapacity"] as int)) * 100;
    }
    return total / zones.length;
  }

  double _calculateAverageEfficiency() {
    if (zones.isEmpty) return 0;
    double total = zones.fold(0, (sum, zone) => sum + (zone["efficiency"] as int));
    return total / zones.length;
  }

  double _calculateAverageTurnover() {
    if (zones.isEmpty) return 0;
    double total = zones.fold(0, (sum, zone) => sum + (zone["turnoverRate"] as int));
    return total / zones.length;
  }

  double _calculateAverageAccuracy() {
    if (zones.isEmpty) return 0;
    double total = zones.fold(0, (sum, zone) => sum + (zone["pickingAccuracy"] as double));
    return total / zones.length;
  }

  double _calculateAveragePickTime() {
    if (zones.isEmpty) return 0;
    double total = zones.fold(0, (sum, zone) => sum + double.parse(zone["averagePickTime"].toString().replaceAll(' min', '')));
    return total / zones.length;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "active":
        return successColor;
      case "maintenance":
        return warningColor;
      case "inactive":
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  Color _getActionColor(String action) {
    switch (action.toLowerCase()) {
      case "zone reconfigured":
        return infoColor;
      case "maintenance completed":
        return successColor;
      case "capacity expanded":
        return primaryColor;
      case "temperature alert":
        return warningColor;
      default:
        return primaryColor;
    }
  }
}
