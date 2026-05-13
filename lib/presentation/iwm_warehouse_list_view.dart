import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmWarehouseListView extends StatefulWidget {
  const IwmWarehouseListView({super.key});

  @override
  State<IwmWarehouseListView> createState() => _IwmWarehouseListViewState();
}

class _IwmWarehouseListViewState extends State<IwmWarehouseListView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedType = "all";
  
  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Inactive", "value": "inactive"},
    {"label": "Maintenance", "value": "maintenance"},
    {"label": "Full Capacity", "value": "full"},
  ];
  
  List<Map<String, dynamic>> typeItems = [
    {"label": "All Types", "value": "all"},
    {"label": "Main Warehouse", "value": "main"},
    {"label": "Distribution Center", "value": "distribution"},
    {"label": "Cold Storage", "value": "cold"},
    {"label": "Retail Store", "value": "retail"},
  ];
  
  List<Map<String, dynamic>> warehouseStats = [
    {
      "title": "Total Warehouses",
      "value": 12,
      "subtitle": "Across 4 Cities",
      "icon": Icons.warehouse,
      "color": primaryColor
    },
    {
      "title": "Active",
      "value": 10,
      "subtitle": "83% Operational",
      "icon": Icons.check_circle,
      "color": successColor
    },
    {
      "title": "Total Capacity",
      "value": "125K",
      "subtitle": "Items Storage",
      "icon": Icons.inventory,
      "color": infoColor
    },
    {
      "title": "Utilization",
      "value": "87%",
      "subtitle": "Average Usage",
      "icon": Icons.trending_up,
      "color": warningColor
    },
  ];
  
  List<Map<String, dynamic>> warehouses = [
    {
      "id": "wh001",
      "name": "Main Warehouse A",
      "code": "MWA-001",
      "type": "Main Warehouse",
      "location": "Industrial District, North",
      "address": "123 Industrial Ave, North City",
      "manager": "Sarah Johnson",
      "phone": "+1-555-0101",
      "email": "sarah.j@company.com",
      "capacity": 10000,
      "currentStock": 8750,
      "zones": 4,
      "area": 15000,
      "status": "Active",
      "temperature": 22.5,
      "humidity": 45,
      "lastInspection": "2024-01-15",
      "nextInspection": "2024-04-15",
      "openingHours": "6:00 AM - 10:00 PM",
      "specialFeatures": ["Climate Control", "Security System", "Loading Docks"]
    },
    {
      "id": "wh002",
      "name": "Distribution Center B",
      "code": "DCB-002",
      "type": "Distribution Center",
      "location": "Logistics Hub, Central",
      "address": "456 Logistics Blvd, Central City",
      "manager": "Mike Wilson",
      "phone": "+1-555-0102",
      "email": "mike.w@company.com",
      "capacity": 15000,
      "currentStock": 13500,
      "zones": 6,
      "area": 20000,
      "status": "Active",
      "temperature": 21.0,
      "humidity": 50,
      "lastInspection": "2024-01-10",
      "nextInspection": "2024-04-10",
      "openingHours": "24/7",
      "specialFeatures": ["Automated Sorting", "Cross Docking", "Express Lane"]
    },
    {
      "id": "wh003",
      "name": "Cold Storage C",
      "code": "CSC-003",
      "type": "Cold Storage",
      "location": "Food District, South",
      "address": "789 Cold Ave, South City",
      "manager": "Lisa Brown",
      "phone": "+1-555-0103",
      "email": "lisa.b@company.com",
      "capacity": 5000,
      "currentStock": 4200,
      "zones": 3,
      "area": 8000,
      "status": "Active",
      "temperature": 4.0,
      "humidity": 85,
      "lastInspection": "2024-01-20",
      "nextInspection": "2024-02-20",
      "openingHours": "5:00 AM - 11:00 PM",
      "specialFeatures": ["Temperature Control", "Humidity Control", "Emergency Backup"]
    },
    {
      "id": "wh004",
      "name": "Retail Store D",
      "code": "RSD-004",
      "type": "Retail Store",
      "location": "Shopping Mall, East",
      "address": "321 Mall St, East City",
      "manager": "John Doe",
      "phone": "+1-555-0104",
      "email": "john.d@company.com",
      "capacity": 2000,
      "currentStock": 1800,
      "zones": 2,
      "area": 3000,
      "status": "Active",
      "temperature": 23.0,
      "humidity": 40,
      "lastInspection": "2024-01-12",
      "nextInspection": "2024-07-12",
      "openingHours": "9:00 AM - 9:00 PM",
      "specialFeatures": ["Customer Access", "Point of Sale", "Display Areas"]
    },
    {
      "id": "wh005",
      "name": "Warehouse E",
      "code": "WHE-005",
      "type": "Main Warehouse",
      "location": "Industrial Park, West",
      "address": "555 Industrial Rd, West City",
      "manager": "Emma Davis",
      "phone": "+1-555-0105",
      "email": "emma.d@company.com",
      "capacity": 8000,
      "currentStock": 8000,
      "zones": 3,
      "area": 12000,
      "status": "Full Capacity",
      "temperature": 22.0,
      "humidity": 48,
      "lastInspection": "2024-01-08",
      "nextInspection": "2024-04-08",
      "openingHours": "6:00 AM - 8:00 PM",
      "specialFeatures": ["Overflow Storage", "Bulk Items", "Heavy Machinery"]
    },
    {
      "id": "wh006",
      "name": "Maintenance Warehouse F",
      "code": "MWF-006",
      "type": "Main Warehouse",
      "location": "Service Center, North",
      "address": "888 Service Dr, North City",
      "manager": "Tom Anderson",
      "phone": "+1-555-0106",
      "email": "tom.a@company.com",
      "capacity": 3000,
      "currentStock": 1500,
      "zones": 2,
      "area": 5000,
      "status": "Maintenance",
      "temperature": 20.0,
      "humidity": 55,
      "lastInspection": "2024-01-05",
      "nextInspection": "2024-02-05",
      "openingHours": "Closed for Maintenance",
      "specialFeatures": ["Under Renovation", "HVAC Upgrade", "Security Enhancement"]
    },
  ];
  
  List<Map<String, dynamic>> recentActivities = [
    {"warehouse": "Main Warehouse A", "action": "Stock Received", "quantity": 500, "timestamp": "2024-01-22 10:30"},
    {"warehouse": "Distribution Center B", "action": "Items Dispatched", "quantity": 750, "timestamp": "2024-01-22 11:15"},
    {"warehouse": "Cold Storage C", "action": "Temperature Alert", "quantity": 0, "timestamp": "2024-01-22 12:00"},
    {"warehouse": "Retail Store D", "action": "Inventory Count", "quantity": 200, "timestamp": "2024-01-22 09:45"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Warehouse Directory",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Warehouses", icon: Icon(Icons.warehouse)),
        Tab(text: "Map View", icon: Icon(Icons.map)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildWarehousesTab(),
        _buildMapViewTab(),
        _buildAnalyticsTab(),
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
          _buildQuickActions(),
          _buildWarehouseStats(),
          _buildStatusDistribution(),
          _buildRecentActivitiesList(),
        ],
      ),
    );
  }

  Widget _buildWarehousesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchFilters(),
          _buildWarehousesList(),
        ],
      ),
    );
  }

  Widget _buildMapViewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMapControls(),
          _buildWarehouseMap(),
          _buildMapLegend(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAnalyticsFilters(),
          _buildPerformanceChart(),
          _buildUtilizationMetrics(),
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
          Row(
            children: [
              Expanded(
                child: QButton(
                  icon: Icons.add,
                  label: "Add Warehouse",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  icon: Icons.sync,
                  label: "Sync All",
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

  Widget _buildWarehouseStats() {
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

  Widget _buildStatusDistribution() {
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
            "Status Distribution",
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
                    Icons.pie_chart,
                    size: 48,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Warehouse Status Chart",
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
                  "${activity["warehouse"]}${(activity["quantity"] as int) > 0 ? ' • ${activity["quantity"]} items' : ''}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${activity["timestamp"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchFilters() {
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
                  label: "Search Warehouses",
                  value: searchQuery,
                  hint: "Enter warehouse name or code...",
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
                  items: statusItems,
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
                  label: "Type",
                  items: typeItems,
                  value: selectedType,
                  onChanged: (value, label) {
                    selectedType = value;
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

  Widget _buildWarehousesList() {
    return Column(
      spacing: spSm,
      children: warehouses.map((warehouse) => _buildWarehouseCard(warehouse)).toList(),
    );
  }

  Widget _buildWarehouseCard(Map<String, dynamic> warehouse) {
    Color statusColor = _getStatusColor(warehouse["status"]);
    double utilizationRate = ((warehouse["currentStock"] as int) / (warehouse["capacity"] as int)) * 100;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: statusColor.withAlpha(50)),
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
                      "${warehouse["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${warehouse["code"]} • ${warehouse["type"]}",
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
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${warehouse["status"]}",
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 16,
                color: primaryColor,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${warehouse["location"]}",
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Manager: ${warehouse["manager"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Capacity: ${warehouse["currentStock"]}/${warehouse["capacity"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Zones: ${warehouse["zones"]} • Area: ${warehouse["area"]} sqft",
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
                      color: _getUtilizationColor(utilizationRate),
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
                "Hours: ${warehouse["openingHours"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: infoColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.visibility,
                label: "View Details",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMapControls() {
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
            "Map Controls",
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
                  icon: Icons.my_location,
                  label: "Center Map",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  icon: Icons.filter_list,
                  label: "Filter",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  icon: Icons.layers,
                  label: "Layers",
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

  Widget _buildWarehouseMap() {
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
            "Warehouse Locations",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 350,
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
                    size: 64,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Interactive Map View",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Warehouse locations across all cities",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledColor,
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

  Widget _buildMapLegend() {
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
            "Map Legend",
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
              _buildLegendItem("Active Warehouse", successColor, Icons.warehouse),
              _buildLegendItem("Full Capacity", warningColor, Icons.warning),
              _buildLegendItem("Under Maintenance", dangerColor, Icons.build),
              _buildLegendItem("Distribution Center", infoColor, Icons.local_shipping),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 16,
        ),
        SizedBox(width: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildAnalyticsFilters() {
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
            "Analytics Filters",
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
                  label: "Time Period",
                  items: [
                    {"label": "Last 7 Days", "value": "7days"},
                    {"label": "Last 30 Days", "value": "30days"},
                    {"label": "Last 3 Months", "value": "3months"},
                    {"label": "Last Year", "value": "year"},
                  ],
                  value: "30days",
                  onChanged: (value, label) {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Metric Type",
                  items: [
                    {"label": "Utilization", "value": "utilization"},
                    {"label": "Throughput", "value": "throughput"},
                    {"label": "Efficiency", "value": "efficiency"},
                    {"label": "Cost Analysis", "value": "cost"},
                  ],
                  value: "utilization",
                  onChanged: (value, label) {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceChart() {
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
            "Performance Trends",
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
                    Icons.trending_up,
                    size: 48,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Performance Analytics Chart",
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

  Widget _buildUtilizationMetrics() {
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
            "Utilization Metrics",
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
              _buildMetricCard("Average Utilization", "87.3%", Icons.pie_chart, primaryColor),
              _buildMetricCard("Peak Utilization", "98.5%", Icons.trending_up, successColor),
              _buildMetricCard("Low Utilization", "45.2%", Icons.trending_down, warningColor),
              _buildMetricCard("Efficiency Score", "92.1%", Icons.speed, infoColor),
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
      case "items dispatched":
        return infoColor;
      case "temperature alert":
        return dangerColor;
      case "inventory count":
        return warningColor;
      default:
        return primaryColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "active":
        return successColor;
      case "inactive":
        return disabledBoldColor;
      case "maintenance":
        return dangerColor;
      case "full capacity":
        return warningColor;
      default:
        return primaryColor;
    }
  }

  Color _getUtilizationColor(double utilization) {
    if (utilization >= 95) return dangerColor;
    if (utilization >= 80) return warningColor;
    if (utilization >= 60) return successColor;
    return infoColor;
  }
}
