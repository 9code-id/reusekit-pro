import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmPackingListsView extends StatefulWidget {
  const IwmPackingListsView({super.key});

  @override
  State<IwmPackingListsView> createState() => _IwmPackingListsViewState();
}

class _IwmPackingListsViewState extends State<IwmPackingListsView> {
  int selectedTab = 0;
  String selectedFilter = "pending";
  String selectedPacker = "all";
  String searchQuery = "";
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "Pending Packing", "value": "pending"},
    {"label": "In Progress", "value": "progress"},
    {"label": "Quality Check", "value": "quality"},
    {"label": "Completed", "value": "completed"},
    {"label": "All Lists", "value": "all"},
  ];
  
  List<Map<String, dynamic>> packerOptions = [
    {"label": "All Packers", "value": "all"},
    {"label": "John Smith", "value": "john"},
    {"label": "Sarah Wilson", "value": "sarah"},
    {"label": "Mike Johnson", "value": "mike"},
    {"label": "Lisa Chen", "value": "lisa"},
  ];
  
  List<Map<String, dynamic>> packingLists = [
    {
      "packingId": "PKL-2024-001",
      "orderId": "ORD-10001",
      "customer": "TechCorp Solutions",
      "packer": "John Smith",
      "status": "Pending",
      "priority": "High",
      "startTime": null,
      "estimatedTime": "45 min",
      "totalItems": 15,
      "packedItems": 0,
      "totalPackages": 3,
      "packingMethod": "Standard",
      "specialRequirements": ["Fragile Items", "Express Shipping"],
      "items": [
        {
          "sku": "PROD-001",
          "name": "Wireless Headphones",
          "quantity": 5,
          "weight": 0.5,
          "dimensions": "20x15x8 cm",
          "fragile": true,
          "packed": false,
          "packageNumber": 1
        },
        {
          "sku": "PROD-002", 
          "name": "Smartphone Case",
          "quantity": 10,
          "weight": 0.2,
          "dimensions": "15x10x2 cm",
          "fragile": false,
          "packed": false,
          "packageNumber": 2
        },
        {
          "sku": "PROD-003",
          "name": "USB Cable",
          "quantity": 20,
          "weight": 0.1,
          "dimensions": "20x5x2 cm",
          "fragile": false,
          "packed": false,
          "packageNumber": 3
        },
      ]
    },
    {
      "packingId": "PKL-2024-002",
      "orderId": "ORD-10002",
      "customer": "Digital Innovations",
      "packer": "Sarah Wilson",
      "status": "Progress",
      "priority": "Medium",
      "startTime": "10:30 AM",
      "estimatedTime": "35 min",
      "totalItems": 12,
      "packedItems": 8,
      "totalPackages": 2,
      "packingMethod": "Custom",
      "specialRequirements": ["Gift Wrapping"],
      "items": [
        {
          "sku": "PROD-004",
          "name": "Bluetooth Speaker",
          "quantity": 3,
          "weight": 1.2,
          "dimensions": "30x20x15 cm",
          "fragile": false,
          "packed": true,
          "packageNumber": 1
        },
        {
          "sku": "PROD-005",
          "name": "Gaming Mouse",
          "quantity": 6,
          "weight": 0.3,
          "dimensions": "12x8x5 cm",
          "fragile": false,
          "packed": true,
          "packageNumber": 1
        },
        {
          "sku": "PROD-006",
          "name": "Mechanical Keyboard",
          "quantity": 3,
          "weight": 1.1,
          "dimensions": "45x15x3 cm",
          "fragile": false,
          "packed": false,
          "packageNumber": 2
        },
      ]
    },
  ];
  
  List<Map<String, dynamic>> packingMetrics = [
    {
      "title": "Pending Lists",
      "value": 28,
      "subtitle": "Awaiting Packing",
      "icon": Icons.pending_actions,
      "color": warningColor
    },
    {
      "title": "In Progress",
      "value": 15,
      "subtitle": "Currently Packing",
      "icon": Icons.inventory,
      "color": primaryColor
    },
    {
      "title": "Completed Today",
      "value": 42,
      "subtitle": "Ready for Shipping",
      "icon": Icons.done_all,
      "color": successColor
    },
    {
      "title": "Efficiency Rate",
      "value": 94.5,
      "subtitle": "Today's Performance",
      "icon": Icons.trending_up,
      "color": infoColor
    },
  ];
  
  List<Map<String, dynamic>> packingStations = [
    {
      "stationId": "Station A",
      "packer": "John Smith",
      "status": "Active",
      "currentOrder": "PKL-2024-001",
      "itemsPacked": 12,
      "timeActive": "2.5 hours",
      "efficiency": 96.2
    },
    {
      "stationId": "Station B",
      "packer": "Sarah Wilson",
      "status": "Active",
      "currentOrder": "PKL-2024-003",
      "itemsPacked": 8,
      "timeActive": "1.8 hours",
      "efficiency": 92.1
    },
    {
      "stationId": "Station C",
      "packer": "Available",
      "status": "Idle",
      "currentOrder": null,
      "itemsPacked": 0,
      "timeActive": "0 hours",
      "efficiency": 0
    },
  ];
  
  List<Map<String, dynamic>> qualityChecks = [
    {"orderId": "PKL-2024-004", "checker": "Mike Johnson", "status": "Passed", "items": 18, "time": "11:45 AM"},
    {"orderId": "PKL-2024-005", "checker": "Lisa Chen", "status": "Failed", "items": 12, "time": "11:30 AM", "issue": "Missing item"},
    {"orderId": "PKL-2024-006", "checker": "Mike Johnson", "status": "Passed", "items": 25, "time": "11:15 AM"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Packing Lists",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Packing", icon: Icon(Icons.inventory)),
        Tab(text: "Stations", icon: Icon(Icons.workspaces)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildPackingTab(),
        _buildStationsTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildPackingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFiltersAndSearch(),
          _buildPackingMetrics(),
          _buildPackingLists(),
        ],
      ),
    );
  }

  Widget _buildStationsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStationOverview(),
          _buildActiveStations(),
          _buildQualityCheck(),
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
          _buildPerformanceMetrics(),
          _buildPackerPerformance(),
          _buildPackingTrends(),
        ],
      ),
    );
  }

  Widget _buildFiltersAndSearch() {
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
                  label: "Search Packing Lists",
                  value: searchQuery,
                  hint: "Search by packing ID, order ID, or customer",
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
                  label: "Status Filter",
                  items: filterOptions,
                  value: selectedFilter,
                  onChanged: (value, label) {
                    selectedFilter = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Packer",
                  items: packerOptions,
                  value: selectedPacker,
                  onChanged: (value, label) {
                    selectedPacker = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () => _showCreatePackingListDialog(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPackingMetrics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Packing Overview",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: packingMetrics.map((metric) => _buildMetricCard(metric)).toList(),
        ),
      ],
    );
  }

  Widget _buildMetricCard(Map<String, dynamic> metric) {
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
                  color: (metric["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  metric["icon"],
                  color: metric["color"],
                  size: 20,
                ),
              ),
            ],
          ),
          Text(
            metric["title"] == "Efficiency Rate"
                ? "${metric["value"]}%"
                : "${metric["value"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${metric["title"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            "${metric["subtitle"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPackingLists() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Active Packing Lists",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...packingLists.map((packingList) => _buildPackingListCard(packingList)),
      ],
    );
  }

  Widget _buildPackingListCard(Map<String, dynamic> packingList) {
    Color statusColor = _getStatusColor(packingList["status"]);
    Color priorityColor = _getPriorityColor(packingList["priority"]);
    double progress = (packingList["packedItems"] as int) / (packingList["totalItems"] as int);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
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
                width: 4,
                height: 60,
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
                          "${packingList["packingId"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: priorityColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${packingList["priority"]}",
                            style: TextStyle(
                              color: priorityColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${packingList["status"]}",
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${packingList["customer"]} • Order: ${packingList["orderId"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.person, size: 16, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Text(
                          "Packer: ${packingList["packer"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Text(
                          packingList["startTime"] != null 
                            ? "Started: ${packingList["startTime"]}"
                            : "Est: ${packingList["estimatedTime"]}",
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Progress",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: 4),
                          Container(
                            height: 6,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: progress,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: statusColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "${packingList["packedItems"]}/${packingList["totalItems"]} items packed",
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
                          "Packages",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${packingList["totalPackages"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if ((packingList["specialRequirements"] as List).isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.warning_amber, size: 16, color: warningColor),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "Requirements: ${(packingList["specialRequirements"] as List).join(", ")}",
                            style: TextStyle(
                              fontSize: 12,
                              color: warningColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: packingList["status"] == "Pending" ? "Start" : "Continue",
                  size: bs.sm,
                  onPressed: () => _startPacking(packingList),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Details",
                  size: bs.sm,
                  onPressed: () => _showPackingDetails(packingList),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStationOverview() {
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
            "Station Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildStationMetric("Active Stations", 2, successColor),
              ),
              Expanded(
                child: _buildStationMetric("Idle Stations", 1, warningColor),
              ),
              Expanded(
                child: _buildStationMetric("Total Capacity", 3, primaryColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStationMetric(String title, int count, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Text(
            "$count",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveStations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Packing Stations",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...packingStations.map((station) => _buildStationCard(station)),
      ],
    );
  }

  Widget _buildStationCard(Map<String, dynamic> station) {
    Color statusColor = station["status"] == "Active" ? successColor : warningColor;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
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
                      "${station["stationId"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
                        "${station["status"]}",
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                if (station["status"] == "Active") ...[
                  Text(
                    "Packer: ${station["packer"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Order: ${station["currentOrder"]} • ${station["itemsPacked"]} items packed",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ] else ...[
                  Text(
                    "Available for assignment",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (station["status"] == "Active") ...[
            Column(
              children: [
                Text(
                  "${station["efficiency"]}%",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Efficiency",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildQualityCheck() {
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
            "Quality Checks",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...qualityChecks.map((check) => _buildQualityCheckItem(check)),
        ],
      ),
    );
  }

  Widget _buildQualityCheckItem(Map<String, dynamic> check) {
    Color statusColor = check["status"] == "Passed" ? successColor : dangerColor;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Icon(
            check["status"] == "Passed" ? Icons.check_circle : Icons.error,
            color: statusColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${check["orderId"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${check["time"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Checker: ${check["checker"]} • ${check["items"]} items",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                if (check["issue"] != null)
                  Text(
                    "Issue: ${check["issue"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: dangerColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceMetrics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Performance Overview",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: packingMetrics.map((metric) => _buildMetricCard(metric)).toList(),
        ),
      ],
    );
  }

  Widget _buildPackerPerformance() {
    List<Map<String, dynamic>> packerStats = [
      {"packer": "John Smith", "packed": 125, "efficiency": 96.2, "accuracy": 98.5},
      {"packer": "Sarah Wilson", "packed": 118, "efficiency": 94.8, "accuracy": 97.2},
      {"packer": "Mike Johnson", "packed": 102, "efficiency": 92.1, "accuracy": 99.1},
      {"packer": "Lisa Chen", "packed": 95, "efficiency": 91.5, "accuracy": 96.8},
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
            "Packer Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...packerStats.map((packer) => _buildPackerItem(packer)),
        ],
      ),
    );
  }

  Widget _buildPackerItem(Map<String, dynamic> packer) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(3),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${packer["packer"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${packer["packed"]} items packed",
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
                  "${packer["efficiency"]}%",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Efficiency",
                  style: TextStyle(
                    fontSize: 10,
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
                  "${packer["accuracy"]}%",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Accuracy",
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

  Widget _buildPackingTrends() {
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
            "Packing Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 200,
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
                    "Packing Analytics Chart",
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

  void _showCreatePackingListDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: EdgeInsets.all(spMd),
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              Text(
                "Create Packing List",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QTextField(
                label: "Order ID",
                value: "",
                onChanged: (value) => setState(() {}),
              ),
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Packer",
                      items: packerOptions.where((p) => p["value"] != "all").toList(),
                      value: "john",
                      onChanged: (value, label) => setState(() {}),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Priority",
                      items: [
                        {"label": "High", "value": "high"},
                        {"label": "Medium", "value": "medium"},
                        {"label": "Low", "value": "low"},
                      ],
                      value: "medium",
                      onChanged: (value, label) => setState(() {}),
                    ),
                  ),
                ],
              ),
              QMemoField(
                label: "Special Requirements",
                value: "",
                onChanged: (value) => setState(() {}),
              ),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Cancel",
                      size: bs.sm,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Create",
                      size: bs.sm,
                      onPressed: () {
                        Navigator.pop(context);
                        ss("Packing list created successfully");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _startPacking(Map<String, dynamic> packingList) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              Text(
                packingList["status"] == "Pending" ? "Start Packing" : "Continue Packing",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "${packingList["packingId"]} - ${packingList["customer"]}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: disabledBoldColor,
                ),
              ),
              Text(
                packingList["status"] == "Pending" 
                  ? "This will assign the packing list to a station and begin the packing process."
                  : "Continue with the packing process for this order.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Cancel",
                      size: bs.sm,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: packingList["status"] == "Pending" ? "Start" : "Continue",
                      size: bs.sm,
                      onPressed: () {
                        Navigator.pop(context);
                        ss(packingList["status"] == "Pending" ? "Packing started" : "Packing resumed");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPackingDetails(Map<String, dynamic> packingList) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: EdgeInsets.all(spMd),
          width: 600,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              Text(
                "Packing List Details",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                height: 300,
                child: SingleChildScrollView(
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow("Packing ID", "${packingList["packingId"]}"),
                      _buildDetailRow("Order ID", "${packingList["orderId"]}"),
                      _buildDetailRow("Customer", "${packingList["customer"]}"),
                      _buildDetailRow("Packer", "${packingList["packer"]}"),
                      _buildDetailRow("Status", "${packingList["status"]}"),
                      _buildDetailRow("Priority", "${packingList["priority"]}"),
                      _buildDetailRow("Total Items", "${packingList["totalItems"]}"),
                      _buildDetailRow("Packed Items", "${packingList["packedItems"]}"),
                      _buildDetailRow("Total Packages", "${packingList["totalPackages"]}"),
                      _buildDetailRow("Packing Method", "${packingList["packingMethod"]}"),
                      Text(
                        "Items:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ...(packingList["items"] as List<Map<String, dynamic>>).map((item) =>
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            children: [
                              Icon(
                                (item["packed"] as bool) ? Icons.check_circle : Icons.pending,
                                color: (item["packed"] as bool) ? successColor : warningColor,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${item["name"]} (${item["quantity"]}x)",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              QButton(
                label: "Close",
                size: bs.sm,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            "$label:",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(value),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return warningColor;
      case 'progress':
        return primaryColor;
      case 'quality':
        return infoColor;
      case 'completed':
        return successColor;
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
}
