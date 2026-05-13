import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmWarehouseManagementView extends StatefulWidget {
  const IwmWarehouseManagementView({super.key});

  @override
  State<IwmWarehouseManagementView> createState() => _IwmWarehouseManagementViewState();
}

class _IwmWarehouseManagementViewState extends State<IwmWarehouseManagementView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedWarehouse = "wh001";
  String selectedZone = "all";
  
  List<Map<String, dynamic>> warehouseItems = [
    {"label": "Warehouse A", "value": "wh001"},
    {"label": "Warehouse B", "value": "wh002"},
    {"label": "Warehouse C", "value": "wh003"},
    {"label": "Distribution Center", "value": "wh004"},
  ];
  
  List<Map<String, dynamic>> zoneItems = [
    {"label": "All Zones", "value": "all"},
    {"label": "Zone A", "value": "zone_a"},
    {"label": "Zone B", "value": "zone_b"},
    {"label": "Zone C", "value": "zone_c"},
    {"label": "Cold Storage", "value": "cold"},
  ];
  
  Map<String, dynamic> warehouseData = {
    "name": "Warehouse A",
    "code": "WH001",
    "location": "Industrial District, North",
    "manager": "Sarah Johnson",
    "totalArea": 15000,
    "usedArea": 12500,
    "availableArea": 2500,
    "capacity": 10000,
    "currentStock": 8750,
    "zones": 4,
    "aisles": 24,
    "shelves": 480,
    "temperature": 22.5,
    "humidity": 45,
    "status": "Active"
  };
  
  List<Map<String, dynamic>> warehouseStats = [
    {
      "title": "Total Capacity",
      "value": "10K",
      "subtitle": "Items",
      "icon": Icons.warehouse,
      "color": primaryColor
    },
    {
      "title": "Current Stock",
      "value": "8.75K",
      "subtitle": "87% Full",
      "icon": Icons.inventory,
      "color": successColor
    },
    {
      "title": "Available Space",
      "value": "2.5K",
      "subtitle": "Items",
      "icon": Icons.space_bar,
      "color": infoColor
    },
    {
      "title": "Zones Active",
      "value": "4",
      "subtitle": "All Operational",
      "icon": Icons.view_module,
      "color": warningColor
    },
  ];
  
  List<Map<String, dynamic>> zones = [
    {
      "id": "zone_a",
      "name": "Zone A",
      "type": "General Storage",
      "capacity": 2500,
      "currentStock": 2100,
      "aisles": 6,
      "shelves": 120,
      "temperature": 22.5,
      "humidity": 45,
      "status": "Active",
      "manager": "John Doe",
      "lastUpdated": "2024-01-22 10:30"
    },
    {
      "id": "zone_b",
      "name": "Zone B",
      "type": "Electronics",
      "capacity": 3000,
      "currentStock": 2850,
      "aisles": 8,
      "shelves": 160,
      "temperature": 20.0,
      "humidity": 40,
      "status": "Active",
      "manager": "Jane Smith",
      "lastUpdated": "2024-01-22 11:15"
    },
    {
      "id": "zone_c",
      "name": "Zone C",
      "type": "Clothing",
      "capacity": 2000,
      "currentStock": 1800,
      "aisles": 5,
      "shelves": 100,
      "temperature": 23.0,
      "humidity": 50,
      "status": "Active",
      "manager": "Mike Wilson",
      "lastUpdated": "2024-01-22 09:45"
    },
    {
      "id": "cold",
      "name": "Cold Storage",
      "type": "Temperature Controlled",
      "capacity": 2500,
      "currentStock": 2000,
      "aisles": 5,
      "shelves": 100,
      "temperature": 4.0,
      "humidity": 85,
      "status": "Active",
      "manager": "Lisa Brown",
      "lastUpdated": "2024-01-22 12:00"
    },
  ];
  
  List<Map<String, dynamic>> recentActivities = [
    {"action": "Stock Received", "zone": "Zone A", "quantity": 150, "product": "Electronics", "time": "10:30 AM"},
    {"action": "Items Moved", "zone": "Zone C", "quantity": 75, "product": "Clothing", "time": "11:15 AM"},
    {"action": "Inventory Check", "zone": "Cold Storage", "quantity": 200, "product": "Food Items", "time": "12:00 PM"},
    {"action": "Stock Dispatched", "zone": "Zone B", "quantity": 100, "product": "Gadgets", "time": "01:30 PM"},
  ];
  
  List<Map<String, dynamic>> maintenanceAlerts = [
    {"area": "Aisle 12", "issue": "Lighting", "priority": "Medium", "reported": "2024-01-22"},
    {"area": "Zone C", "issue": "HVAC", "priority": "High", "reported": "2024-01-21"},
    {"area": "Cold Storage", "issue": "Temperature", "priority": "Critical", "reported": "2024-01-20"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Warehouse Management",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Zones", icon: Icon(Icons.view_module)),
        Tab(text: "Layout", icon: Icon(Icons.map)),
        Tab(text: "Reports", icon: Icon(Icons.assessment)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildZonesTab(),
        _buildLayoutTab(),
        _buildReportsTab(),
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
          _buildWarehouseSelector(),
          _buildWarehouseInfo(),
          _buildQuickStats(),
          _buildEnvironmentalData(),
          _buildRecentActivitiesList(),
          _buildMaintenanceAlerts(),
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

  Widget _buildLayoutTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLayoutControls(),
          _buildWarehouseLayout(),
          _buildLayoutLegend(),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReportOptions(),
          _buildUtilizationChart(),
          _buildPerformanceMetrics(),
        ],
      ),
    );
  }

  Widget _buildWarehouseSelector() {
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
            "Select Warehouse",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Warehouse",
            items: warehouseItems,
            value: selectedWarehouse,
            onChanged: (value, label) {
              selectedWarehouse = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWarehouseInfo() {
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${warehouseData["name"]}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Code: ${warehouseData["code"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${warehouseData["status"]}",
                  style: TextStyle(
                    color: successColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${warehouseData["location"]}",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.person,
                size: 16,
                color: primaryColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Manager: ${warehouseData["manager"]}",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Warehouse Statistics",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: warehouseStats.map((stat) => _buildStatCard(stat)).toList(),
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

  Widget _buildEnvironmentalData() {
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
            "Environmental Conditions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildEnvironmentalCard(
                  "Temperature",
                  "${warehouseData["temperature"]}°C",
                  Icons.thermostat,
                  successColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildEnvironmentalCard(
                  "Humidity",
                  "${warehouseData["humidity"]}%",
                  Icons.water_drop,
                  infoColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEnvironmentalCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          SizedBox(width: spSm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivitiesList() {
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
            "Recent Activities",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...recentActivities.map((activity) => _buildActivityItem(activity)),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    Color actionColor = _getActionColor(activity["action"]);
    
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
              color: actionColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${activity["action"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: actionColor,
                  ),
                ),
                Text(
                  "${activity["zone"]} • ${activity["quantity"]} ${activity["product"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${activity["time"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaintenanceAlerts() {
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
                "Maintenance Alerts",
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
                  color: dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${maintenanceAlerts.length}",
                  style: TextStyle(
                    color: dangerColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          ...maintenanceAlerts.map((alert) => _buildMaintenanceAlert(alert)),
        ],
      ),
    );
  }

  Widget _buildMaintenanceAlert(Map<String, dynamic> alert) {
    Color priorityColor = _getPriorityColor(alert["priority"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: priorityColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: priorityColor.withAlpha(50)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning,
            color: priorityColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${alert["area"]} - ${alert["issue"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Reported: ${alert["reported"]}",
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
              "${alert["priority"]}",
              style: TextStyle(
                color: priorityColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
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
                  hint: "Enter zone name...",
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
          QDropdownField(
            label: "Zone Type",
            items: zoneItems,
            value: selectedZone,
            onChanged: (value, label) {
              selectedZone = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildZonesList() {
    return Column(
      spacing: spSm,
      children: zones.map((zone) => _buildZoneCard(zone)).toList(),
    );
  }

  Widget _buildZoneCard(Map<String, dynamic> zone) {
    double utilizationRate = ((zone["currentStock"] as int) / (zone["capacity"] as int)) * 100;
    Color utilizationColor = utilizationRate > 90 ? dangerColor : utilizationRate > 70 ? warningColor : successColor;
    
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${zone["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${zone["type"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${zone["status"]}",
                  style: TextStyle(
                    color: successColor,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Capacity: ${zone["currentStock"]}/${zone["capacity"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Aisles: ${zone["aisles"]} • Shelves: ${zone["shelves"]}",
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
                    "${utilizationRate.toStringAsFixed(1)}%",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: utilizationColor,
                    ),
                  ),
                  Text(
                    "Utilization",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Temp: ${zone["temperature"]}°C • Humidity: ${zone["humidity"]}%",
                style: TextStyle(
                  fontSize: 12,
                  color: infoColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.settings,
                label: "Manage",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLayoutControls() {
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
            "Layout Controls",
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
                  icon: Icons.zoom_in,
                  label: "Zoom In",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  icon: Icons.zoom_out,
                  label: "Zoom Out",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  icon: Icons.refresh,
                  label: "Reset",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWarehouseLayout() {
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
            "Warehouse Layout",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 300,
            width: double.infinity,
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
                    Icons.map,
                    size: 48,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Interactive Warehouse Layout",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
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

  Widget _buildLayoutLegend() {
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
            "Legend",
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
              _buildLegendItem("Available", successColor),
              _buildLegendItem("Occupied", warningColor),
              _buildLegendItem("Maintenance", dangerColor),
              _buildLegendItem("Restricted", disabledBoldColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(width: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildReportOptions() {
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
            "Report Options",
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
              _buildReportOption("Utilization Report", Icons.bar_chart, "Space usage analysis"),
              _buildReportOption("Activity Report", Icons.timeline, "Daily operations summary"),
              _buildReportOption("Maintenance Report", Icons.build, "Maintenance schedule"),
              _buildReportOption("Efficiency Report", Icons.trending_up, "Performance metrics"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReportOption(String title, IconData icon, String description) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 24,
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
            description,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Generate",
              size: bs.sm,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUtilizationChart() {
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
            "Utilization Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 250,
            width: double.infinity,
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
                    Icons.analytics,
                    size: 48,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Utilization Chart",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
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
            "Performance Metrics",
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
              _buildMetricCard("Avg Processing Time", "2.5 hrs", Icons.timer, infoColor),
              _buildMetricCard("Order Accuracy", "98.7%", Icons.check_circle, successColor),
              _buildMetricCard("Space Efficiency", "87.5%", Icons.space_bar, warningColor),
              _buildMetricCard("Daily Throughput", "1,245", Icons.local_shipping, primaryColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
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
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getActionColor(String action) {
    switch (action.toLowerCase()) {
      case "stock received":
        return successColor;
      case "items moved":
        return infoColor;
      case "inventory check":
        return warningColor;
      case "stock dispatched":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case "critical":
        return dangerColor;
      case "high":
        return warningColor;
      case "medium":
        return infoColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }
}
