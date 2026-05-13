import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmInterWarehouseTransferView extends StatefulWidget {
  const IwmInterWarehouseTransferView({super.key});

  @override
  State<IwmInterWarehouseTransferView> createState() => _IwmInterWarehouseTransferViewState();
}

class _IwmInterWarehouseTransferViewState extends State<IwmInterWarehouseTransferView> {
  int selectedTab = 0;
  String selectedRoute = "all";
  String selectedTransportMethod = "all";
  String selectedStatus = "all";
  
  List<Map<String, dynamic>> routes = [
    {"label": "All Routes", "value": "all"},
    {"label": "Main → Distribution", "value": "main_dist"},
    {"label": "Distribution → Regional", "value": "dist_regional"},
    {"label": "Main → Secondary", "value": "main_secondary"},
    {"label": "Secondary → Regional", "value": "secondary_regional"},
  ];
  
  List<Map<String, dynamic>> transportMethods = [
    {"label": "All Methods", "value": "all"},
    {"label": "Company Truck", "value": "truck"},
    {"label": "Third Party", "value": "third_party"},
    {"label": "Express Delivery", "value": "express"},
    {"label": "Air Freight", "value": "air"},
  ];
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Scheduled", "value": "scheduled"},
    {"label": "In Transit", "value": "in_transit"},
    {"label": "Delivered", "value": "delivered"},
    {"label": "Delayed", "value": "delayed"},
    {"label": "Failed", "value": "failed"},
  ];
  
  List<Map<String, dynamic>> transferSummary = [
    {
      "title": "Active Transfers",
      "value": 45,
      "subtitle": "Currently Moving",
      "icon": Icons.local_shipping,
      "color": infoColor
    },
    {
      "title": "On-Time Rate",
      "value": 94.2,
      "subtitle": "% This Month",
      "icon": Icons.schedule,
      "color": successColor
    },
    {
      "title": "Total Distance",
      "value": 2847,
      "subtitle": "Miles This Week",
      "icon": Icons.route,
      "color": primaryColor
    },
    {
      "title": "Cost Savings",
      "value": 15.8,
      "subtitle": "% vs External",
      "icon": Icons.savings,
      "color": warningColor
    },
  ];
  
  List<Map<String, dynamic>> interWarehouseTransfers = [
    {
      "id": "IWT-2024-001",
      "transferOrderId": "TO-2024-001",
      "route": "Main Warehouse → Distribution Center",
      "transportMethod": "Company Truck",
      "vehicle": "TRUCK-001",
      "driver": "David Wilson",
      "status": "In Transit",
      "departureDate": "2024-01-16",
      "departureTime": "08:00",
      "estimatedArrival": "2024-01-18 14:00",
      "actualArrival": null,
      "distance": 145.5,
      "estimatedCost": 320.0,
      "actualCost": null,
      "trackingNumber": "IWT-789456123",
      "items": [
        {"sku": "SKU-001", "name": "Premium Office Chair", "qty": 25},
        {"sku": "SKU-002", "name": "Wireless Mouse", "qty": 50},
        {"sku": "SKU-003", "name": "USB Cable", "qty": 30},
      ],
      "conditions": {
        "temperature": "Ambient",
        "fragile": true,
        "hazardous": false
      },
      "currentLocation": "Highway 101, Mile 85",
      "lastUpdate": "2024-01-17 15:30"
    },
    {
      "id": "IWT-2024-002",
      "transferOrderId": "TO-2024-003",
      "route": "Secondary Warehouse → Main Warehouse",
      "transportMethod": "Third Party",
      "vehicle": "3PL-XYZ-456",
      "driver": "Express Logistics Co.",
      "status": "Delivered",
      "departureDate": "2024-01-12",
      "departureTime": "09:30",
      "estimatedArrival": "2024-01-14 16:00",
      "actualArrival": "2024-01-14 15:45",
      "distance": 78.2,
      "estimatedCost": 180.0,
      "actualCost": 175.0,
      "trackingNumber": "IWT-456789012",
      "items": [
        {"sku": "SKU-009", "name": "Ergonomic Cushion", "qty": 30},
        {"sku": "SKU-010", "name": "Document Holder", "qty": 25},
        {"sku": "SKU-011", "name": "Paper Tray", "qty": 40},
      ],
      "conditions": {
        "temperature": "Ambient",
        "fragile": false,
        "hazardous": false
      },
      "currentLocation": "Main Warehouse - Delivered",
      "lastUpdate": "2024-01-14 15:45"
    },
    {
      "id": "IWT-2024-003",
      "transferOrderId": "TO-2024-005",
      "route": "Distribution Center → Regional Hub",
      "transportMethod": "Express Delivery",
      "vehicle": "EXP-789",
      "driver": "Quick Transport Inc.",
      "status": "Delayed",
      "departureDate": "2024-01-15",
      "departureTime": "07:00",
      "estimatedArrival": "2024-01-17 12:00",
      "actualArrival": null,
      "distance": 210.8,
      "estimatedCost": 450.0,
      "actualCost": null,
      "trackingNumber": "IWT-123456789",
      "items": [
        {"sku": "SKU-015", "name": "Conference Table", "qty": 5},
        {"sku": "SKU-016", "name": "Executive Chair", "qty": 8},
      ],
      "conditions": {
        "temperature": "Controlled",
        "fragile": true,
        "hazardous": false
      },
      "currentLocation": "Service Station - Mechanical Issue",
      "lastUpdate": "2024-01-17 10:15"
    },
  ];
  
  List<Map<String, dynamic>> routeAnalytics = [
    {
      "route": "Main → Distribution",
      "frequency": 25,
      "avgDistance": 145.5,
      "avgTime": "6.5 hours",
      "avgCost": 320.0,
      "onTimeRate": 96.0,
      "popularItems": ["Office Chairs", "Electronics", "Accessories"]
    },
    {
      "route": "Distribution → Regional",
      "frequency": 18,
      "avgDistance": 210.8,
      "avgTime": "8.2 hours",
      "avgCost": 465.0,
      "onTimeRate": 91.7,
      "popularItems": ["Furniture", "Bulk Items", "Seasonal Stock"]
    },
    {
      "route": "Main → Secondary",
      "frequency": 12,
      "avgDistance": 78.2,
      "avgTime": "4.1 hours",
      "avgCost": 180.0,
      "onTimeRate": 98.3,
      "popularItems": ["Small Electronics", "Office Supplies", "Documents"]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Inter-Warehouse Transfer",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Transfers", icon: Icon(Icons.local_shipping)),
        Tab(text: "Routes", icon: Icon(Icons.route)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildTransfersTab(),
        _buildRoutesTab(),
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
          _buildFilters(),
          _buildTransferSummary(),
          _buildLiveTracking(),
          _buildPerformanceMetrics(),
        ],
      ),
    );
  }

  Widget _buildTransfersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTransferFilters(),
          _buildTransfersList(),
        ],
      ),
    );
  }

  Widget _buildRoutesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRouteFilters(),
          _buildRouteAnalyticsList(),
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
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Route",
                  items: routes,
                  value: selectedRoute,
                  onChanged: (value, label) {
                    selectedRoute = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Transport Method",
                  items: transportMethods,
                  value: selectedTransportMethod,
                  onChanged: (value, label) {
                    selectedTransportMethod = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Status",
            items: statusOptions,
            value: selectedStatus,
            onChanged: (value, label) {
              selectedStatus = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTransferFilters() {
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
          QButton(
            icon: Icons.map,
            label: "Live Map",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildRouteFilters() {
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
              label: "Route",
              items: routes,
              value: selectedRoute,
              onChanged: (value, label) {
                selectedRoute = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.analytics,
            label: "Analytics",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildTransferSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Transfer Summary",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: transferSummary.map((summary) => _buildSummaryCard(summary)).toList(),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(Map<String, dynamic> summary) {
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
                  color: (summary["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  summary["icon"],
                  color: summary["color"],
                  size: 20,
                ),
              ),
            ],
          ),
          Text(
            summary["value"] is double ? "${(summary["value"] as double).toStringAsFixed(1)}" : "${summary["value"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${summary["title"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            "${summary["subtitle"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveTracking() {
    List<Map<String, dynamic>> activeTransfers = interWarehouseTransfers
        .where((transfer) => transfer["status"] == "In Transit")
        .toList();

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
                "Live Tracking",
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
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${activeTransfers.length} Active",
                  style: TextStyle(
                    color: successColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          ...activeTransfers.map((transfer) => _buildLiveTrackingItem(transfer)),
          if (activeTransfers.isEmpty)
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Center(
                child: Text(
                  "No active transfers",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLiveTrackingItem(Map<String, dynamic> transfer) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: successColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: successColor.withAlpha(30)),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.local_shipping,
                  color: successColor,
                  size: 16,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${transfer["id"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${transfer["route"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "${transfer["estimatedArrival"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: successColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 14,
                color: infoColor,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${transfer["currentLocation"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Text(
                "Updated: ${transfer["lastUpdate"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledColor,
                ),
              ),
            ],
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
                    Icons.analytics,
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

  Widget _buildTransfersList() {
    return Column(
      spacing: spSm,
      children: interWarehouseTransfers.map((transfer) => _buildTransferCard(transfer)).toList(),
    );
  }

  Widget _buildTransferCard(Map<String, dynamic> transfer) {
    Color statusColor = _getStatusColor(transfer["status"]);
    
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
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  _getStatusIcon(transfer["status"]),
                  color: statusColor,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${transfer["id"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${transfer["route"]}",
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
                  "${transfer["status"]}",
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
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
                      "Vehicle: ${transfer["vehicle"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Driver: ${transfer["driver"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Method: ${transfer["transportMethod"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Tracking: ${transfer["trackingNumber"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${(transfer["distance"] as double).toStringAsFixed(1)} miles",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "\$${((transfer["estimatedCost"] as double).toDouble()).currency}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  if (transfer["actualCost"] != null)
                    Text(
                      "Actual: \$${((transfer["actualCost"] as double).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Items (${(transfer["items"] as List).length}):",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                ...(transfer["items"] as List).take(2).map((item) => Text(
                  "• ${item["name"]}: ${item["qty"]} units",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                )),
                if ((transfer["items"] as List).length > 2)
                  Text(
                    "+ ${(transfer["items"] as List).length - 2} more items",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Departed: ${transfer["departureDate"]} ${transfer["departureTime"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Expected: ${transfer["estimatedArrival"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    if (transfer["actualArrival"] != null)
                      Text(
                        "Delivered: ${transfer["actualArrival"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
                ),
              ),
              QButton(
                label: "Track",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRouteAnalyticsList() {
    return Column(
      spacing: spSm,
      children: routeAnalytics.map((route) => _buildRouteAnalyticsCard(route)).toList(),
    );
  }

  Widget _buildRouteAnalyticsCard(Map<String, dynamic> route) {
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
                child: Text(
                  "${route["route"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${route["frequency"]} transfers",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildRouteMetric("Average Distance", "${(route["avgDistance"] as double).toStringAsFixed(1)} miles", Icons.route),
              _buildRouteMetric("Average Time", "${route["avgTime"]}", Icons.schedule),
              _buildRouteMetric("Average Cost", "\$${((route["avgCost"] as double).toDouble()).currency}", Icons.attach_money),
              _buildRouteMetric("On-Time Rate", "${(route["onTimeRate"] as double).toStringAsFixed(1)}%", Icons.check_circle),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Popular Items:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  (route["popularItems"] as List).join(", "),
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Spacer(),
              QButton(
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

  Widget _buildRouteMetric(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(3),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: primaryColor,
          ),
          SizedBox(width: spXs),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'scheduled':
        return infoColor;
      case 'in transit':
        return warningColor;
      case 'delivered':
        return successColor;
      case 'delayed':
        return dangerColor;
      case 'failed':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'scheduled':
        return Icons.schedule;
      case 'in transit':
        return Icons.local_shipping;
      case 'delivered':
        return Icons.check_circle;
      case 'delayed':
        return Icons.warning;
      case 'failed':
        return Icons.error;
      default:
        return Icons.help_outline;
    }
  }
}
