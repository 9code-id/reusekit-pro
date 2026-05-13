import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmTrackingNumbersView extends StatefulWidget {
  const IwmTrackingNumbersView({super.key});

  @override
  State<IwmTrackingNumbersView> createState() => _IwmTrackingNumbersViewState();
}

class _IwmTrackingNumbersViewState extends State<IwmTrackingNumbersView> {
  int selectedTab = 0;
  String selectedCarrier = "all";
  String selectedStatus = "all";
  String searchQuery = "";

  List<Map<String, dynamic>> carrierItems = [
    {"label": "All Carriers", "value": "all"},
    {"label": "FedEx", "value": "fedex"},
    {"label": "UPS", "value": "ups"},
    {"label": "DHL", "value": "dhl"},
    {"label": "USPS", "value": "usps"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "all"},
    {"label": "Label Created", "value": "created"},
    {"label": "In Transit", "value": "in_transit"},
    {"label": "Out for Delivery", "value": "out_for_delivery"},
    {"label": "Delivered", "value": "delivered"},
    {"label": "Exception", "value": "exception"},
  ];

  List<Map<String, dynamic>> trackingStats = [
    {
      "title": "Active Shipments",
      "value": 145,
      "subtitle": "In Transit",
      "icon": Icons.local_shipping,
      "color": primaryColor
    },
    {
      "title": "Delivered Today",
      "value": 32,
      "subtitle": "+18% from yesterday",
      "icon": Icons.check_circle,
      "color": successColor
    },
    {
      "title": "Exceptions",
      "value": 3,
      "subtitle": "Need Attention",
      "icon": Icons.warning,
      "color": dangerColor
    },
    {
      "title": "On Time Rate",
      "value": 94.5,
      "subtitle": "Last 7 days",
      "icon": Icons.schedule,
      "color": infoColor
    },
  ];

  List<Map<String, dynamic>> trackingNumbers = [
    {
      "trackingNumber": "1234567890123456",
      "orderId": "ORD-789012",
      "carrier": "FedEx",
      "service": "Ground",
      "status": "In Transit",
      "recipient": "John Smith",
      "destination": "New York, NY",
      "origin": "Los Angeles, CA",
      "shipDate": "2024-01-18",
      "estimatedDelivery": "2024-01-22",
      "lastUpdate": "2024-01-20 10:30",
      "currentLocation": "Memphis, TN",
      "weight": 2.5,
      "cost": 12.45,
      "events": [
        {"date": "2024-01-20 10:30", "location": "Memphis, TN", "status": "In Transit", "description": "Package is in transit"},
        {"date": "2024-01-19 18:45", "location": "Phoenix, AZ", "status": "Departed", "description": "Departed facility"},
        {"date": "2024-01-19 14:20", "location": "Phoenix, AZ", "status": "Arrived", "description": "Arrived at facility"},
        {"date": "2024-01-18 16:00", "location": "Los Angeles, CA", "status": "Picked Up", "description": "Package picked up"},
      ]
    },
    {
      "trackingNumber": "1Z999AA1234567890",
      "orderId": "ORD-789011",
      "carrier": "UPS",
      "service": "Next Day Air",
      "status": "Out for Delivery",
      "recipient": "Sarah Johnson",
      "destination": "Chicago, IL",
      "origin": "Dallas, TX",
      "shipDate": "2024-01-19",
      "estimatedDelivery": "2024-01-20",
      "lastUpdate": "2024-01-20 08:15",
      "currentLocation": "Chicago, IL",
      "weight": 1.8,
      "cost": 24.99,
      "events": [
        {"date": "2024-01-20 08:15", "location": "Chicago, IL", "status": "Out for Delivery", "description": "Out for delivery"},
        {"date": "2024-01-20 05:30", "location": "Chicago, IL", "status": "Arrived", "description": "Arrived at facility"},
        {"date": "2024-01-19 22:15", "location": "Louisville, KY", "status": "Departed", "description": "Departed facility"},
        {"date": "2024-01-19 16:00", "location": "Dallas, TX", "status": "Picked Up", "description": "Package picked up"},
      ]
    },
    {
      "trackingNumber": "DHL123456789",
      "orderId": "ORD-789010",
      "carrier": "DHL",
      "service": "Express",
      "status": "Exception",
      "recipient": "Mike Chen",
      "destination": "Miami, FL",
      "origin": "Atlanta, GA",
      "shipDate": "2024-01-17",
      "estimatedDelivery": "2024-01-19",
      "lastUpdate": "2024-01-19 14:22",
      "currentLocation": "Miami, FL",
      "weight": 3.2,
      "cost": 18.75,
      "events": [
        {"date": "2024-01-19 14:22", "location": "Miami, FL", "status": "Exception", "description": "Delivery exception - recipient not available"},
        {"date": "2024-01-19 09:30", "location": "Miami, FL", "status": "Out for Delivery", "description": "Out for delivery"},
        {"date": "2024-01-18 20:45", "location": "Miami, FL", "status": "Arrived", "description": "Arrived at facility"},
        {"date": "2024-01-17 15:30", "location": "Atlanta, GA", "status": "Picked Up", "description": "Package picked up"},
      ]
    },
  ];

  List<Map<String, dynamic>> bulkOperations = [
    {
      "type": "Bulk Track",
      "description": "Track multiple packages at once",
      "icon": Icons.track_changes,
      "color": primaryColor
    },
    {
      "type": "Export Data",
      "description": "Export tracking data to CSV",
      "icon": Icons.download,
      "color": infoColor
    },
    {
      "type": "Send Updates",
      "description": "Send tracking updates to customers",
      "icon": Icons.email,
      "color": successColor
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Tracking Numbers",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Tracking", icon: Icon(Icons.track_changes)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Bulk Actions", icon: Icon(Icons.list_alt)),
      ],
      tabChildren: [
        _buildTrackingTab(),
        _buildAnalyticsTab(),
        _buildBulkActionsTab(),
      ],
    );
  }

  Widget _buildTrackingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchAndFilters(),
          _buildQuickStats(),
          _buildTrackingList(),
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
          _buildTrackingStats(),
          _buildDeliveryPerformance(),
          _buildCarrierComparison(),
        ],
      ),
    );
  }

  Widget _buildBulkActionsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBulkOperationsList(),
          _buildBulkTrackingForm(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
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
          QTextField(
            label: "Search tracking numbers",
            value: searchQuery,
            hint: "Enter tracking number or order ID",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Carrier",
                  items: carrierItems,
                  value: selectedCarrier,
                  onChanged: (value, label) {
                    selectedCarrier = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: trackingStats.map((stat) => _buildStatCard(stat)).toList(),
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
            stat["title"] == "On Time Rate"
                ? "${stat["value"]}%"
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

  Widget _buildTrackingList() {
    return Column(
      spacing: spSm,
      children: trackingNumbers.map((tracking) => _buildTrackingCard(tracking)).toList(),
    );
  }

  Widget _buildTrackingCard(Map<String, dynamic> tracking) {
    Color statusColor = _getStatusColor(tracking["status"]);
    
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
                      "${tracking["trackingNumber"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Order: ${tracking["orderId"]}",
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
                  "${tracking["status"]}",
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
                Icons.local_shipping,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${tracking["carrier"]} ${tracking["service"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "\$${(tracking["cost"] as double).toStringAsFixed(2)}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.person, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${tracking["recipient"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${tracking["origin"]} → ${tracking["destination"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "Est. Delivery: ${tracking["estimatedDelivery"]}",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                "Last update: ${tracking["lastUpdate"]}",
                style: TextStyle(
                  color: disabledColor,
                  fontSize: 12,
                ),
              ),
              Spacer(),
              QButton(
                label: "Details",
                icon: Icons.info,
                size: bs.sm,
                onPressed: () => _showTrackingDetails(tracking),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Tracking Analytics",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: trackingStats.map((stat) => _buildStatCard(stat)).toList(),
        ),
      ],
    );
  }

  Widget _buildDeliveryPerformance() {
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
            "Delivery Performance",
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
                    "Performance Chart",
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

  Widget _buildCarrierComparison() {
    List<Map<String, dynamic>> carrierPerformance = [
      {"carrier": "FedEx", "onTime": 96.5, "avgDays": 2.3, "packages": 450},
      {"carrier": "UPS", "onTime": 94.2, "avgDays": 2.5, "packages": 325},
      {"carrier": "DHL", "onTime": 89.8, "avgDays": 3.1, "packages": 125},
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
            "Carrier Performance Comparison",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...carrierPerformance.map((carrier) => _buildCarrierPerformanceCard(carrier)),
        ],
      ),
    );
  }

  Widget _buildCarrierPerformanceCard(Map<String, dynamic> carrier) {
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
          Expanded(
            child: Text(
              "${carrier["carrier"]}",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${(carrier["onTime"] as double).toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "On Time",
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${(carrier["avgDays"] as double).toStringAsFixed(1)} days",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Avg Transit",
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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${carrier["packages"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                Text(
                  "Packages",
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

  Widget _buildBulkOperationsList() {
    return Column(
      spacing: spSm,
      children: bulkOperations.map((operation) => _buildBulkOperationCard(operation)).toList(),
    );
  }

  Widget _buildBulkOperationCard(Map<String, dynamic> operation) {
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
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: (operation["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              operation["icon"],
              color: operation["color"],
              size: 24,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${operation["type"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${operation["description"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.arrow_forward,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildBulkTrackingForm() {
    String bulkTrackingNumbers = "";
    
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
            "Bulk Tracking Lookup",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QMemoField(
            label: "Tracking Numbers",
            value: bulkTrackingNumbers,
            hint: "Enter tracking numbers separated by commas or new lines",
            onChanged: (value) {
              bulkTrackingNumbers = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Track All",
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Import CSV",
                icon: Icons.upload_file,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showTrackingDetails(Map<String, dynamic> tracking) {
    // Show detailed tracking information with timeline
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return successColor;
      case 'in transit':
      case 'out for delivery':
        return infoColor;
      case 'exception':
        return dangerColor;
      case 'created':
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }
}
