import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmWarehouseDetailView extends StatefulWidget {
  const IwmWarehouseDetailView({super.key});

  @override
  State<IwmWarehouseDetailView> createState() => _IwmWarehouseDetailViewState();
}

class _IwmWarehouseDetailViewState extends State<IwmWarehouseDetailView> {
  int selectedTab = 0;

  Map<String, dynamic> warehouse = {
    "id": "WH001",
    "name": "Main Distribution Center",
    "address": "1234 Industrial Blvd, Commerce City, CO 80022",
    "totalCapacity": 125000,
    "usedCapacity": 78500,
    "status": "Active",
    "manager": "John Smith",
    "phone": "+1 (555) 123-4567",
    "email": "john.smith@company.com",
    "establishedDate": "2020-01-15",
    "zones": 8,
    "aisles": 24,
    "shelves": 480,
    "bins": 3840,
    "temperature": "22°C",
    "humidity": "45%",
    "lastInspection": "2024-01-10"
  };

  List<Map<String, dynamic>> warehouseStats = [
    {
      "title": "Total Capacity",
      "value": "125K",
      "subtitle": "sq ft",
      "icon": Icons.warehouse,
      "color": primaryColor
    },
    {
      "title": "Used Space",
      "value": "78.5K",
      "subtitle": "62.8% Utilized",
      "icon": Icons.storage,
      "color": successColor
    },
    {
      "title": "Available",
      "value": "46.5K",
      "subtitle": "37.2% Free",
      "icon": Icons.space_dashboard,
      "color": warningColor
    },
    {
      "title": "Active Zones",
      "value": "8",
      "subtitle": "All Operational",
      "icon": Icons.grid_view,
      "color": infoColor
    },
  ];

  List<Map<String, dynamic>> recentActivities = [
    {"action": "Inventory Received", "item": "Electronics - Batch #2401", "quantity": 150, "time": "2 hours ago", "operator": "Mike Johnson"},
    {"action": "Stock Moved", "item": "Zone A to Zone C", "quantity": 75, "time": "4 hours ago", "operator": "Sarah Davis"},
    {"action": "Inspection Completed", "item": "Zone B - Safety Check", "quantity": 0, "time": "6 hours ago", "operator": "Tom Wilson"},
    {"action": "Shipment Prepared", "item": "Order #ORD-2024-0115", "quantity": 200, "time": "8 hours ago", "operator": "Lisa Chen"},
  ];

  List<Map<String, dynamic>> zones = [
    {"id": "A", "name": "Electronics", "capacity": 15000, "used": 12000, "items": 1250, "status": "Active"},
    {"id": "B", "name": "Clothing", "capacity": 18000, "used": 14500, "items": 2100, "status": "Active"},
    {"id": "C", "name": "Home & Garden", "capacity": 20000, "used": 8500, "items": 850, "status": "Active"},
    {"id": "D", "name": "Sports", "capacity": 12000, "used": 9000, "items": 750, "status": "Maintenance"},
    {"id": "E", "name": "Books", "capacity": 15000, "used": 11000, "items": 3200, "status": "Active"},
    {"id": "F", "name": "Automotive", "capacity": 25000, "used": 18000, "items": 650, "status": "Active"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Warehouse Details",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Zones", icon: Icon(Icons.grid_view)),
        Tab(text: "Activities", icon: Icon(Icons.history)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildZonesTab(),
        _buildActivitiesTab(),
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
          _buildWarehouseHeader(),
          _buildStatsGrid(),
          _buildCapacityChart(),
          _buildEnvironmentalConditions(),
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
          _buildZonesSummary(),
          _buildZonesList(),
        ],
      ),
    );
  }

  Widget _buildActivitiesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildActivityFilters(),
          _buildActivitiesList(),
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
          _buildWarehouseSettings(),
          _buildMaintenanceSettings(),
          _buildNotificationSettings(),
        ],
      ),
    );
  }

  Widget _buildWarehouseHeader() {
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
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(
                  Icons.warehouse,
                  color: primaryColor,
                  size: 32,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${warehouse["name"]}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "ID: ${warehouse["id"]}",
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
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${warehouse["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: successColor,
                  ),
                ),
              ),
            ],
          ),
          Divider(color: disabledOutlineBorderColor),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${warehouse["address"]}",
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
                        Icon(Icons.person, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "Manager: ${warehouse["manager"]}",
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
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

  Widget _buildCapacityChart() {
    double utilizationPercent = ((warehouse["usedCapacity"] as int) / (warehouse["totalCapacity"] as int)) * 100;
    
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
            "Capacity Utilization",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${utilizationPercent.toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Space Utilized",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    LinearProgressIndicator(
                      value: utilizationPercent / 100,
                      backgroundColor: disabledOutlineBorderColor,
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${((warehouse["usedCapacity"] as int) / 1000).toStringAsFixed(1)}K",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  Text(
                    "Used",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${(((warehouse["totalCapacity"] as int) - (warehouse["usedCapacity"] as int)) / 1000).toStringAsFixed(1)}K",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: warningColor,
                    ),
                  ),
                  Text(
                    "Available",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEnvironmentalConditions() {
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
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(5),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: primaryColor.withAlpha(30)),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.thermostat, color: primaryColor, size: 24),
                      SizedBox(height: spXs),
                      Text(
                        "${warehouse["temperature"]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Temperature",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(5),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: infoColor.withAlpha(30)),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.water_drop, color: infoColor, size: 24),
                      SizedBox(height: spXs),
                      Text(
                        "${warehouse["humidity"]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Humidity",
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
        ],
      ),
    );
  }

  Widget _buildZonesSummary() {
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
            child: Column(
              children: [
                Text(
                  "${zones.length}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Total Zones",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  "${zones.where((z) => z["status"] == "Active").length}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Active",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  "${zones.where((z) => z["status"] == "Maintenance").length}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Text(
                  "Maintenance",
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

  Widget _buildZonesList() {
    return Column(
      spacing: spSm,
      children: zones.map((zone) => _buildZoneCard(zone)).toList(),
    );
  }

  Widget _buildZoneCard(Map<String, dynamic> zone) {
    double utilizationPercent = ((zone["used"] as int) / (zone["capacity"] as int)) * 100;
    Color statusColor = zone["status"] == "Active" ? successColor : warningColor;
    
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
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Center(
                  child: Text(
                    "${zone["id"]}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${zone["items"]} items stored",
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
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Utilization: ${utilizationPercent.toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: utilizationPercent / 100,
                      backgroundColor: disabledOutlineBorderColor,
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "${((zone["used"] as int) / 1000).toStringAsFixed(1)}K / ${((zone["capacity"] as int) / 1000).toStringAsFixed(1)}K sq ft",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivityFilters() {
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
              label: "Filter Activity",
              items: [
                {"label": "All Activities", "value": "all"},
                {"label": "Inventory", "value": "inventory"},
                {"label": "Movement", "value": "movement"},
                {"label": "Inspection", "value": "inspection"},
              ],
              value: "all",
              onChanged: (value, label) {},
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildActivitiesList() {
    return Column(
      spacing: spSm,
      children: recentActivities.map((activity) => _buildActivityCard(activity)).toList(),
    );
  }

  Widget _buildActivityCard(Map<String, dynamic> activity) {
    Color actionColor = _getActionColor(activity["action"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 50,
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
                Row(
                  children: [
                    Text(
                      "${activity["action"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: actionColor,
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
                  "${activity["item"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    if ((activity["quantity"] as int) > 0)
                      Text(
                        "Qty: ${activity["quantity"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    if ((activity["quantity"] as int) > 0) Text(" • ", style: TextStyle(color: disabledColor)),
                    Text(
                      "by ${activity["operator"]}",
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
        ],
      ),
    );
  }

  Widget _buildWarehouseSettings() {
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
            "Warehouse Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Warehouse Name",
                  value: "${warehouse["name"]}",
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Manager Name",
                  value: "${warehouse["manager"]}",
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Contact Phone",
                  value: "${warehouse["phone"]}",
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          QButton(
            label: "Update Settings",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildMaintenanceSettings() {
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
              Icon(Icons.schedule, color: infoColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Last Inspection: ${warehouse["lastInspection"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Schedule Inspection",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Maintenance Log",
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

  Widget _buildNotificationSettings() {
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
            "Notification Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Low Stock Alerts",
                "value": true,
                "checked": true,
              }
            ],
            value: [{"label": "Low Stock Alerts", "value": true, "checked": true}],
            onChanged: (values, ids) {},
          ),
          QSwitch(
            items: [
              {
                "label": "Capacity Warnings",
                "value": true,
                "checked": true,
              }
            ],
            value: [{"label": "Capacity Warnings", "value": true, "checked": true}],
            onChanged: (values, ids) {},
          ),
          QSwitch(
            items: [
              {
                "label": "Maintenance Reminders",
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

  Color _getActionColor(String action) {
    switch (action.toLowerCase()) {
      case "inventory received":
        return successColor;
      case "stock moved":
        return infoColor;
      case "inspection completed":
        return warningColor;
      case "shipment prepared":
        return primaryColor;
      default:
        return primaryColor;
    }
  }
}
