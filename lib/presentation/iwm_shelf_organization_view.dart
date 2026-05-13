import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmShelfOrganizationView extends StatefulWidget {
  const IwmShelfOrganizationView({super.key});

  @override
  State<IwmShelfOrganizationView> createState() => _IwmShelfOrganizationViewState();
}

class _IwmShelfOrganizationViewState extends State<IwmShelfOrganizationView> {
  int selectedTab = 0;
  String selectedWarehouse = "WH001";
  String selectedZone = "A";
  String selectedAisle = "01";
  String organizationFilter = "all";

  List<Map<String, dynamic>> warehouses = [
    {"label": "Main Distribution Center (WH001)", "value": "WH001"},
    {"label": "Secondary Warehouse (WH002)", "value": "WH002"},
    {"label": "Cold Storage Facility (WH003)", "value": "WH003"},
  ];

  List<Map<String, dynamic>> zones = [
    {"label": "Zone A - Electronics", "value": "A"},
    {"label": "Zone B - Clothing", "value": "B"},
    {"label": "Zone C - Home & Garden", "value": "C"},
    {"label": "Zone D - Sports", "value": "D"},
  ];

  List<Map<String, dynamic>> aisles = [
    {"label": "Aisle 01", "value": "01"},
    {"label": "Aisle 02", "value": "02"},
    {"label": "Aisle 03", "value": "03"},
    {"label": "Aisle 04", "value": "04"},
    {"label": "Aisle 05", "value": "05"},
    {"label": "Aisle 06", "value": "06"},
  ];

  List<Map<String, dynamic>> organizationTypes = [
    {"label": "All Shelves", "value": "all"},
    {"label": "Standard Shelves", "value": "standard"},
    {"label": "High-Density", "value": "high_density"},
    {"label": "Climate Controlled", "value": "climate"},
    {"label": "Security Shelves", "value": "security"},
  ];

  List<Map<String, dynamic>> shelves = [
    {
      "id": "A01-S01",
      "shelfNumber": "01",
      "type": "Standard",
      "level": "Ground",
      "capacity": 200,
      "occupied": 180,
      "height": "2.5m",
      "width": "1.5m",
      "depth": "0.8m",
      "weight_limit": "500kg",
      "bins": 8,
      "occupiedBins": 7,
      "categories": ["Electronics", "Accessories"],
      "temperature": "22°C",
      "humidity": "45%",
      "lastRestocked": "2024-01-15 14:30",
      "accessibility": "Standard",
      "safety_rating": "A",
      "items": [
        {"sku": "ELEC-001", "name": "Samsung Galaxy S24", "quantity": 45, "bin": "01"},
        {"sku": "ELEC-002", "name": "iPhone 15 Pro", "quantity": 35, "bin": "02"},
        {"sku": "ELEC-003", "name": "iPad Air", "quantity": 25, "bin": "03"},
      ]
    },
    {
      "id": "A01-S02",
      "shelfNumber": "02",
      "type": "High-Density",
      "level": "Upper",
      "capacity": 150,
      "occupied": 120,
      "height": "3.0m",
      "width": "1.2m",
      "depth": "0.6m",
      "weight_limit": "300kg",
      "bins": 6,
      "occupiedBins": 5,
      "categories": ["Small Electronics"],
      "temperature": "22°C",
      "humidity": "45%",
      "lastRestocked": "2024-01-14 11:15",
      "accessibility": "Forklift Required",
      "safety_rating": "B",
      "items": [
        {"sku": "ELEC-004", "name": "AirPods Pro", "quantity": 60, "bin": "01"},
        {"sku": "ELEC-005", "name": "Apple Watch", "quantity": 40, "bin": "02"},
        {"sku": "ELEC-006", "name": "Phone Cases", "quantity": 20, "bin": "03"},
      ]
    },
    {
      "id": "A01-S03",
      "shelfNumber": "03",
      "type": "Standard",
      "level": "Ground",
      "capacity": 250,
      "occupied": 100,
      "height": "2.5m",
      "width": "2.0m",
      "depth": "0.8m",
      "weight_limit": "600kg",
      "bins": 10,
      "occupiedBins": 4,
      "categories": ["Computing"],
      "temperature": "21°C",
      "humidity": "42%",
      "lastRestocked": "2024-01-13 16:45",
      "accessibility": "Standard",
      "safety_rating": "A",
      "items": [
        {"sku": "COMP-001", "name": "MacBook Pro", "quantity": 15, "bin": "01"},
        {"sku": "COMP-002", "name": "Dell Laptop", "quantity": 25, "bin": "02"},
      ]
    },
    {
      "id": "A01-S04",
      "shelfNumber": "04",
      "type": "Security",
      "level": "Ground",
      "capacity": 100,
      "occupied": 95,
      "height": "2.0m",
      "width": "1.0m",
      "depth": "0.5m",
      "weight_limit": "200kg",
      "bins": 4,
      "occupiedBins": 4,
      "categories": ["High-Value Electronics"],
      "temperature": "20°C",
      "humidity": "40%",
      "lastRestocked": "2024-01-15 09:00",
      "accessibility": "Restricted",
      "safety_rating": "A+",
      "items": [
        {"sku": "HVAL-001", "name": "MacBook Pro Max", "quantity": 10, "bin": "01"},
        {"sku": "HVAL-002", "name": "Professional Camera", "quantity": 5, "bin": "02"},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Shelf Organization",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.shelves)),
        Tab(text: "Layout", icon: Icon(Icons.view_module)),
        Tab(text: "Optimization", icon: Icon(Icons.tune)),
        Tab(text: "Reports", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildLayoutTab(),
        _buildOptimizationTab(),
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
          _buildNavigationFilters(),
          _buildShelfStats(),
          _buildShelfList(),
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
          _buildShelfLayoutView(),
          _buildLayoutLegend(),
        ],
      ),
    );
  }

  Widget _buildOptimizationTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOptimizationMetrics(),
          _buildOptimizationSuggestions(),
          _buildEfficiencyAnalysis(),
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
          _buildUtilizationReport(),
          _buildPerformanceReport(),
          _buildMaintenanceReport(),
        ],
      ),
    );
  }

  Widget _buildNavigationFilters() {
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
                child: QDropdownField(
                  label: "Warehouse",
                  items: warehouses,
                  value: selectedWarehouse,
                  onChanged: (value, label) {
                    selectedWarehouse = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Zone",
                  items: zones,
                  value: selectedZone,
                  onChanged: (value, label) {
                    selectedZone = value;
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
                  label: "Aisle",
                  items: aisles,
                  value: selectedAisle,
                  onChanged: (value, label) {
                    selectedAisle = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Filter",
                  items: organizationTypes,
                  value: organizationFilter,
                  onChanged: (value, label) {
                    organizationFilter = value;
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

  Widget _buildShelfStats() {
    List<Map<String, dynamic>> stats = [
      {
        "title": "Total Shelves",
        "value": shelves.length,
        "subtitle": "In Aisle",
        "icon": Icons.shelves,
        "color": primaryColor
      },
      {
        "title": "Avg Utilization",
        "value": "${_calculateAverageUtilization().toStringAsFixed(1)}%",
        "subtitle": "Capacity Used",
        "icon": Icons.storage,
        "color": successColor
      },
      {
        "title": "Total Bins",
        "value": _calculateTotalBins(),
        "subtitle": "${_calculateOccupiedBins()} Occupied",
        "icon": Icons.inventory_2,
        "color": warningColor
      },
      {
        "title": "Available Space",
        "value": "${_calculateAvailableCapacity()}",
        "subtitle": "Items Capacity",
        "icon": Icons.space_dashboard,
        "color": infoColor
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

  Widget _buildShelfList() {
    List<Map<String, dynamic>> filteredShelves = shelves.where((shelf) {
      if (organizationFilter == "all") return true;
      return shelf["type"].toString().toLowerCase().replaceAll('-', '_') == organizationFilter.replaceAll('-', '_');
    }).toList();

    return Column(
      spacing: spSm,
      children: filteredShelves.map((shelf) => _buildShelfCard(shelf)).toList(),
    );
  }

  Widget _buildShelfCard(Map<String, dynamic> shelf) {
    double utilizationPercent = ((shelf["occupied"] as int) / (shelf["capacity"] as int)) * 100;
    Color utilizationColor = utilizationPercent >= 90 ? dangerColor : utilizationPercent >= 75 ? warningColor : successColor;
    Color safetyColor = _getSafetyColor(shelf["safety_rating"]);
    
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
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Center(
                  child: Text(
                    "${shelf["shelfNumber"]}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
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
                      "${shelf["id"]} - ${shelf["type"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${shelf["level"]} Level • ${shelf["accessibility"]}",
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
                  color: safetyColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "Safety ${shelf["safety_rating"]}",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: safetyColor,
                  ),
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildShelfMetric("Dimensions", "${shelf["height"]} × ${shelf["width"]} × ${shelf["depth"]}", "Weight Limit: ${shelf["weight_limit"]}"),
              _buildShelfMetric("Capacity", "${shelf["occupied"]}/${shelf["capacity"]} items", "${utilizationPercent.toStringAsFixed(1)}% Full"),
              _buildShelfMetric("Bins", "${shelf["occupiedBins"]}/${shelf["bins"]} used", "Storage Units"),
              _buildShelfMetric("Environment", "${shelf["temperature"]}", "${shelf["humidity"]} Humidity"),
            ],
          ),
          LinearProgressIndicator(
            value: utilizationPercent / 100,
            backgroundColor: disabledOutlineBorderColor,
            valueColor: AlwaysStoppedAnimation<Color>(utilizationColor),
          ),
          if ((shelf["items"] as List).isNotEmpty) ...[
            Container(
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
                  Text(
                    "Stored Items (${(shelf["items"] as List).length})",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  ...(shelf["items"] as List).take(3).map((item) => Row(
                    children: [
                      Text(
                        "Bin ${item["bin"]}: ",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${item["name"]} (${item["quantity"]})",
                          style: TextStyle(
                            fontSize: 11,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  )),
                  if ((shelf["items"] as List).length > 3)
                    Text(
                      "...and ${(shelf["items"] as List).length - 3} more items",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledColor,
                      ),
                    ),
                ],
              ),
            ),
          ],
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Items",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Reorganize",
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

  Widget _buildShelfMetric(String title, String value, String subtitle) {
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
              fontSize: 13,
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

  Widget _buildLayoutControls() {
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
              label: "View Type",
              items: [
                {"label": "Side View", "value": "side"},
                {"label": "Top View", "value": "top"},
                {"label": "3D View", "value": "3d"},
              ],
              value: "side",
              onChanged: (value, label) {},
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.grid_3x3,
            label: "Show Grid",
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.fullscreen,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildShelfLayoutView() {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            child: Text(
              "Aisle $selectedAisle - Shelf Layout",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Stack(
                children: [
                  // Aisle floor
                  Positioned.fill(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 60),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                  // Left shelf row
                  ...shelves.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> shelf = entry.value;
                    return _buildShelfLayoutItem(shelf, 20, 50 + (index * 80), true);
                  }),
                  // Right shelf row
                  ...shelves.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> shelf = entry.value;
                    return _buildShelfLayoutItem(shelf, 280, 50 + (index * 80), false);
                  }),
                  // Aisle label
                  Positioned(
                    top: 20,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Aisle $selectedAisle",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
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

  Widget _buildShelfLayoutItem(Map<String, dynamic> shelf, double left, double top, bool isLeft) {
    double utilizationPercent = ((shelf["occupied"] as int) / (shelf["capacity"] as int)) * 100;
    Color utilizationColor = utilizationPercent >= 90 ? dangerColor : utilizationPercent >= 75 ? warningColor : successColor;
    
    return Positioned(
      left: left,
      top: top,
      child: GestureDetector(
        onTap: () {
          si("Shelf ${shelf["shelfNumber"]}\nType: ${shelf["type"]}\nUtilization: ${utilizationPercent.toStringAsFixed(1)}%");
        },
        child: Container(
          width: 50,
          height: 60,
          decoration: BoxDecoration(
            color: utilizationColor.withAlpha(30),
            border: Border.all(color: utilizationColor, width: 2),
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${shelf["shelfNumber"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: utilizationColor,
                ),
              ),
              Text(
                "${utilizationPercent.toStringAsFixed(0)}%",
                style: TextStyle(
                  fontSize: 8,
                  color: utilizationColor,
                ),
              ),
            ],
          ),
        ),
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
            "Shelf Legend",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Wrap(
            spacing: spSm,
            runSpacing: spXs,
            children: [
              _buildLegendItem("0-74% Full", successColor),
              _buildLegendItem("75-89% Full", warningColor),
              _buildLegendItem("90%+ Full", dangerColor),
              _buildLegendItem("Standard", primaryColor),
              _buildLegendItem("High-Density", infoColor),
              _buildLegendItem("Security", secondaryColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            border: Border.all(color: color, width: 2),
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(width: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildOptimizationMetrics() {
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
            "Optimization Metrics",
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
              _buildOptimizationCard("Space Efficiency", "78.5%", successColor, Icons.storage),
              _buildOptimizationCard("Access Time", "3.2 min", warningColor, Icons.timer),
              _buildOptimizationCard("Safety Score", "92%", primaryColor, Icons.security),
              _buildOptimizationCard("Organization Index", "85%", infoColor, Icons.category),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOptimizationCard(String title, String value, Color color, IconData icon) {
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

  Widget _buildOptimizationSuggestions() {
    List<Map<String, dynamic>> suggestions = [
      {"title": "Reorganize High-Density Shelves", "description": "Shelf A01-S02 access frequency doesn't match current placement", "priority": "High", "impact": "Reduce access time by 15%"},
      {"title": "Balance Load Distribution", "description": "Some shelves are approaching weight limits while others are underutilized", "priority": "Medium", "impact": "Improve safety and capacity"},
      {"title": "Optimize Category Placement", "description": "Frequently accessed items should be at ground level", "priority": "Low", "impact": "Improve picking efficiency"},
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
            "Optimization Suggestions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...suggestions.map((suggestion) => _buildSuggestionCard(suggestion)),
        ],
      ),
    );
  }

  Widget _buildSuggestionCard(Map<String, dynamic> suggestion) {
    Color priorityColor = _getPriorityColor(suggestion["priority"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: priorityColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: priorityColor.withAlpha(30)),
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${suggestion["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: priorityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${suggestion["priority"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: priorityColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${suggestion["description"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "Impact: ${suggestion["impact"]}",
            style: TextStyle(
              fontSize: 11,
              color: successColor,
              fontWeight: FontWeight.w500,
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
            "Efficiency Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 200,
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
                    "Efficiency Analysis Chart",
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

  Widget _buildUtilizationReport() {
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
            "Utilization Report",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...shelves.map((shelf) {
            double utilizationPercent = ((shelf["occupied"] as int) / (shelf["capacity"] as int)) * 100;
            Color utilizationColor = utilizationPercent >= 90 ? dangerColor : utilizationPercent >= 75 ? warningColor : successColor;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: utilizationColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: utilizationColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Text(
                    "Shelf ${shelf["shelfNumber"]}",
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
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: utilizationColor,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildPerformanceReport() {
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
            "Performance Report",
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
                  label: "Export PDF",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Email Report",
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

  Widget _buildMaintenanceReport() {
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
          ...shelves.where((shelf) => shelf["safety_rating"] != "A+").map((shelf) => Container(
            padding: EdgeInsets.all(spSm),
            margin: EdgeInsets.only(bottom: spXs),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: warningColor.withAlpha(30)),
            ),
            child: Row(
              children: [
                Text(
                  "Shelf ${shelf["shelfNumber"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "Safety ${shelf["safety_rating"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: warningColor,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  double _calculateAverageUtilization() {
    if (shelves.isEmpty) return 0;
    double total = 0;
    for (var shelf in shelves) {
      total += ((shelf["occupied"] as int) / (shelf["capacity"] as int)) * 100;
    }
    return total / shelves.length;
  }

  int _calculateTotalBins() {
    return shelves.fold(0, (sum, shelf) => sum + (shelf["bins"] as int));
  }

  int _calculateOccupiedBins() {
    return shelves.fold(0, (sum, shelf) => sum + (shelf["occupiedBins"] as int));
  }

  int _calculateAvailableCapacity() {
    return shelves.fold(0, (sum, shelf) => sum + ((shelf["capacity"] as int) - (shelf["occupied"] as int)));
  }

  Color _getSafetyColor(String rating) {
    switch (rating) {
      case "A+":
        return successColor;
      case "A":
        return primaryColor;
      case "B":
        return warningColor;
      case "C":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return infoColor;
    }
  }
}
