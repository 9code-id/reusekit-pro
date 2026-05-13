import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmShippingView extends StatefulWidget {
  const IwmShippingView({super.key});

  @override
  State<IwmShippingView> createState() => _IwmShippingViewState();
}

class _IwmShippingViewState extends State<IwmShippingView> {
  int selectedTab = 0;
  String selectedFilter = "ready";
  String selectedCarrier = "all";
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "Ready to Ship", "value": "ready"},
    {"label": "In Transit", "value": "transit"},
    {"label": "Delivered", "value": "delivered"},
    {"label": "All Shipments", "value": "all"},
  ];
  
  List<Map<String, dynamic>> carrierOptions = [
    {"label": "All Carriers", "value": "all"},
    {"label": "FedEx", "value": "fedex"},
    {"label": "UPS", "value": "ups"},
    {"label": "DHL", "value": "dhl"},
    {"label": "USPS", "value": "usps"},
  ];
  
  List<Map<String, dynamic>> shipments = [
    {
      "shipmentId": "SHP-2024-001",
      "orderId": "ORD-10001",
      "customer": "TechCorp Solutions",
      "carrier": "FedEx",
      "service": "Express",
      "trackingNumber": "1234567890",
      "status": "Ready",
      "destination": "New York, NY",
      "weight": 5.2,
      "dimensions": "30x20x15 cm",
      "value": 2450.00,
      "shipDate": "2024-01-15",
      "deliveryDate": "2024-01-17",
      "packages": 3,
      "items": [
        {"sku": "PROD-001", "name": "Wireless Headphones", "quantity": 2},
        {"sku": "PROD-002", "name": "Smartphone Case", "quantity": 5},
        {"sku": "PROD-003", "name": "USB Cable", "quantity": 3},
      ]
    },
    {
      "shipmentId": "SHP-2024-002",
      "orderId": "ORD-10002",
      "customer": "Digital Innovations",
      "carrier": "UPS",
      "service": "Ground",
      "trackingNumber": "0987654321",
      "status": "Transit",
      "destination": "Los Angeles, CA",
      "weight": 3.8,
      "dimensions": "25x18x12 cm",
      "value": 1875.50,
      "shipDate": "2024-01-14",
      "deliveryDate": "2024-01-18",
      "packages": 2,
      "items": [
        {"sku": "PROD-004", "name": "Bluetooth Speaker", "quantity": 1},
        {"sku": "PROD-005", "name": "Gaming Mouse", "quantity": 3},
      ]
    },
  ];
  
  List<Map<String, dynamic>> shippingMetrics = [
    {
      "title": "Ready to Ship",
      "value": 24,
      "subtitle": "Awaiting Pickup",
      "icon": Icons.local_shipping,
      "color": warningColor
    },
    {
      "title": "In Transit",
      "value": 156,
      "subtitle": "Currently Shipping",
      "icon": Icons.flight_takeoff,
      "color": primaryColor
    },
    {
      "title": "On Time Rate",
      "value": 96.5,
      "subtitle": "Today's Performance",
      "icon": Icons.schedule,
      "color": successColor
    },
    {
      "title": "Total Value",
      "value": 125000,
      "subtitle": "In Transit",
      "icon": Icons.attach_money,
      "color": infoColor
    },
  ];
  
  List<Map<String, dynamic>> recentActivity = [
    {"type": "delivered", "message": "SHP-2024-003 delivered to Chicago, IL", "time": "2 min ago"},
    {"type": "transit", "message": "SHP-2024-004 picked up by FedEx", "time": "15 min ago"},
    {"type": "created", "message": "SHP-2024-005 label created", "time": "1 hour ago"},
    {"type": "delayed", "message": "SHP-2024-001 delivery delayed by weather", "time": "2 hours ago"},
  ];
  
  List<Map<String, dynamic>> carrierPerformance = [
    {"carrier": "FedEx", "onTime": 98.5, "total": 145, "avgDays": 2.1},
    {"carrier": "UPS", "onTime": 96.8, "total": 122, "avgDays": 2.3},
    {"carrier": "DHL", "onTime": 95.2, "total": 98, "avgDays": 2.5},
    {"carrier": "USPS", "onTime": 94.1, "total": 87, "avgDays": 3.2},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Shipping Management",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Shipments", icon: Icon(Icons.local_shipping)),
        Tab(text: "Tracking", icon: Icon(Icons.track_changes)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildShipmentsTab(),
        _buildTrackingTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildShipmentsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilters(),
          _buildShippingMetrics(),
          _buildShipmentsList(),
        ],
      ),
    );
  }

  Widget _buildTrackingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTrackingSearch(),
          _buildRecentActivity(),
          _buildShipmentMap(),
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
          _buildCarrierPerformance(),
          _buildShippingTrends(),
        ],
      ),
    );
  }

  Widget _buildFilters() {
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
              label: "Carrier",
              items: carrierOptions,
              value: selectedCarrier,
              onChanged: (value, label) {
                selectedCarrier = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _showCreateShipmentDialog(),
          ),
        ],
      ),
    );
  }

  Widget _buildShippingMetrics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Shipping Overview",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: shippingMetrics.map((metric) => _buildMetricCard(metric)).toList(),
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
            metric["title"] == "On Time Rate" 
                ? "${metric["value"]}%" 
                : metric["title"] == "Total Value"
                ? "\$${((metric["value"] as num) / 1000).toStringAsFixed(0)}K"
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

  Widget _buildShipmentsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Active Shipments",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...shipments.map((shipment) => _buildShipmentCard(shipment)),
      ],
    );
  }

  Widget _buildShipmentCard(Map<String, dynamic> shipment) {
    Color statusColor = _getStatusColor(shipment["status"]);
    
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
                          "${shipment["shipmentId"]}",
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
                            "${shipment["status"]}",
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${shipment["customer"]} • Order: ${shipment["orderId"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Text(
                          "${shipment["destination"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(Icons.local_shipping, size: 16, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Text(
                          "${shipment["carrier"]} ${shipment["service"]}",
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
                            "Tracking Number",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${shipment["trackingNumber"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Value",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "\$${(shipment["value"] as double).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Packages: ${shipment["packages"]} • Weight: ${shipment["weight"]} kg",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                    Text(
                      "Delivery: ${shipment["deliveryDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
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
              Expanded(
                child: QButton(
                  label: "Track",
                  size: bs.sm,
                  onPressed: () => _showTrackingDialog(shipment),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Details",
                  size: bs.sm,
                  onPressed: () => _showShipmentDetails(shipment),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingSearch() {
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
            "Track Shipment",
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
                  label: "Tracking Number",
                  value: "",
                  hint: "Enter tracking number or shipment ID",
                  onChanged: (value) => setState(() {}),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Track",
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
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
            "Recent Activity",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...recentActivity.map((activity) => _buildActivityItem(activity)),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    Color activityColor = _getActivityColor(activity["type"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: activityColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: activityColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(
              _getActivityIcon(activity["type"]),
              color: activityColor,
              size: 16,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              "${activity["message"]}",
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
              ),
            ),
          ),
          Text(
            "${activity["time"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShipmentMap() {
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
            "Shipment Tracking Map",
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
                    Icons.map,
                    size: 48,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Interactive Tracking Map",
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
          children: shippingMetrics.map((metric) => _buildMetricCard(metric)).toList(),
        ),
      ],
    );
  }

  Widget _buildCarrierPerformance() {
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
            "Carrier Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...carrierPerformance.map((carrier) => _buildCarrierItem(carrier)),
        ],
      ),
    );
  }

  Widget _buildCarrierItem(Map<String, dynamic> carrier) {
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
                  "${carrier["carrier"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${carrier["total"]} shipments",
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
                  "${carrier["onTime"]}%",
                  style: TextStyle(
                    fontSize: 18,
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
              children: [
                Text(
                  "${carrier["avgDays"]}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Avg Days",
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

  Widget _buildShippingTrends() {
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
            "Shipping Trends",
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
                    "Shipping Analytics Chart",
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

  void _showCreateShipmentDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: EdgeInsets.all(spMd),
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              Text(
                "Create Shipment",
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
              QDropdownField(
                label: "Carrier",
                items: carrierOptions.where((c) => c["value"] != "all").toList(),
                value: "fedex",
                onChanged: (value, label) => setState(() {}),
              ),
              QTextField(
                label: "Destination",
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
                        ss("Shipment created successfully");
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

  void _showTrackingDialog(Map<String, dynamic> shipment) {
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
                "Track Shipment",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "${shipment["shipmentId"]} - ${shipment["trackingNumber"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                ),
              ),
              Container(
                height: 200,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(5),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  children: [
                    _buildTrackingStep("Order Processed", true, "Jan 14, 9:00 AM"),
                    _buildTrackingStep("Picked Up", true, "Jan 14, 2:30 PM"),
                    _buildTrackingStep("In Transit", shipment["status"] != "Ready", "Jan 15, 8:00 AM"),
                    _buildTrackingStep("Out for Delivery", false, "Jan 17, 9:00 AM"),
                    _buildTrackingStep("Delivered", false, "Jan 17, 3:00 PM"),
                  ],
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

  Widget _buildTrackingStep(String title, bool completed, String time) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: completed ? successColor : disabledColor,
            shape: BoxShape.circle,
          ),
          child: completed 
            ? Icon(Icons.check, color: Colors.white, size: 12)
            : null,
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: completed ? primaryColor : disabledBoldColor,
              fontWeight: completed ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
        Text(
          time,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  void _showShipmentDetails(Map<String, dynamic> shipment) {
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
                "Shipment Details",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(5),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Shipment ID: ${shipment["shipmentId"]}"),
                    Text("Customer: ${shipment["customer"]}"),
                    Text("Carrier: ${shipment["carrier"]} ${shipment["service"]}"),
                    Text("Destination: ${shipment["destination"]}"),
                    Text("Weight: ${shipment["weight"]} kg"),
                    Text("Dimensions: ${shipment["dimensions"]}"),
                    Text("Value: \$${(shipment["value"] as double).toStringAsFixed(2)}"),
                  ],
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'ready':
        return warningColor;
      case 'transit':
        return primaryColor;
      case 'delivered':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getActivityColor(String type) {
    switch (type) {
      case 'delivered':
        return successColor;
      case 'transit':
        return primaryColor;
      case 'created':
        return infoColor;
      case 'delayed':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getActivityIcon(String type) {
    switch (type) {
      case 'delivered':
        return Icons.check_circle;
      case 'transit':
        return Icons.local_shipping;
      case 'created':
        return Icons.add_circle;
      case 'delayed':
        return Icons.warning;
      default:
        return Icons.info;
    }
  }
}
