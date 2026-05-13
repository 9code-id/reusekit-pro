import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmTransferTrackingView extends StatefulWidget {
  const IwmTransferTrackingView({super.key});

  @override
  State<IwmTransferTrackingView> createState() => _IwmTransferTrackingViewState();
}

class _IwmTransferTrackingViewState extends State<IwmTransferTrackingView> {
  int selectedTab = 0;
  String selectedTransfer = "all";
  String selectedStatus = "all";
  String selectedWarehouse = "all";

  List<Map<String, dynamic>> transferFilters = [
    {"label": "All Transfers", "value": "all"},
    {"label": "Inter-Warehouse", "value": "inter"},
    {"label": "Inbound", "value": "inbound"},
    {"label": "Outbound", "value": "outbound"},
  ];

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All Status", "value": "all"},
    {"label": "In Transit", "value": "transit"},
    {"label": "Pending", "value": "pending"},
    {"label": "Delivered", "value": "delivered"},
    {"label": "Delayed", "value": "delayed"},
  ];

  List<Map<String, dynamic>> warehouseFilters = [
    {"label": "All Warehouses", "value": "all"},
    {"label": "Main Warehouse", "value": "main"},
    {"label": "Distribution Center", "value": "dist"},
    {"label": "Regional Hub", "value": "regional"},
  ];

  List<Map<String, dynamic>> trackingSummary = [
    {
      "title": "Active Transfers",
      "value": 24,
      "subtitle": "Currently tracking",
      "icon": Icons.local_shipping,
      "color": primaryColor
    },
    {
      "title": "In Transit",
      "value": 18,
      "subtitle": "On the move",
      "icon": Icons.directions_car,
      "color": infoColor
    },
    {
      "title": "Delivered Today",
      "value": 12,
      "subtitle": "Successfully delivered",
      "icon": Icons.check_circle,
      "color": successColor
    },
    {
      "title": "Delayed",
      "value": 3,
      "subtitle": "Behind schedule",
      "icon": Icons.warning,
      "color": dangerColor
    },
  ];

  List<Map<String, dynamic>> activeTransfers = [
    {
      "id": "TRK-001",
      "origin": "Main Warehouse",
      "destination": "Distribution Center",
      "items": 45,
      "status": "In Transit",
      "progress": 0.65,
      "estimatedArrival": "2024-01-16 14:30",
      "carrier": "FastLogistics",
      "trackingNumber": "FL123456789",
      "priority": "High",
      "value": 15750.0,
      "distance": "25.4 km",
      "currentLocation": "Highway A1, Exit 5"
    },
    {
      "id": "TRK-002",
      "origin": "Regional Hub",
      "destination": "Store #23",
      "items": 28,
      "status": "Pending Pickup",
      "progress": 0.10,
      "estimatedArrival": "2024-01-17 10:00",
      "carrier": "QuickTransport",
      "trackingNumber": "QT987654321",
      "priority": "Medium",
      "value": 8940.0,
      "distance": "18.7 km",
      "currentLocation": "Regional Hub Loading Bay"
    },
    {
      "id": "TRK-003",
      "origin": "Distribution Center",
      "destination": "Customer Direct",
      "items": 12,
      "status": "Out for Delivery",
      "progress": 0.85,
      "estimatedArrival": "2024-01-16 16:00",
      "carrier": "ExpressDelivery",
      "trackingNumber": "ED456789123",
      "priority": "Urgent",
      "value": 3240.0,
      "distance": "12.1 km",
      "currentLocation": "Downtown Area"
    },
  ];

  List<Map<String, dynamic>> trackingHistory = [
    {
      "transferId": "TRK-001",
      "timestamp": "2024-01-16 13:45",
      "location": "Highway A1, Exit 5",
      "status": "In Transit",
      "description": "Package is on highway, making good time",
      "driver": "John Smith"
    },
    {
      "transferId": "TRK-001",
      "timestamp": "2024-01-16 12:30",
      "location": "Distribution Hub B",
      "status": "Departed",
      "description": "Left distribution hub, heading to destination",
      "driver": "John Smith"
    },
    {
      "transferId": "TRK-002",
      "timestamp": "2024-01-16 11:00",
      "location": "Regional Hub",
      "status": "Ready for Pickup",
      "description": "Package ready, awaiting carrier pickup",
      "driver": "Not Assigned"
    },
  ];

  List<Map<String, dynamic>> deliveryMetrics = [
    {
      "metric": "On-Time Delivery",
      "value": 94.5,
      "target": 95.0,
      "trend": "up",
      "unit": "%"
    },
    {
      "metric": "Average Transit Time",
      "value": 2.3,
      "target": 2.0,
      "trend": "down",
      "unit": "days"
    },
    {
      "metric": "Cost per Shipment",
      "value": 24.50,
      "target": 25.00,
      "trend": "up",
      "unit": "\$"
    },
    {
      "metric": "Customer Satisfaction",
      "value": 4.8,
      "target": 4.5,
      "trend": "up",
      "unit": "/5"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Transfer Tracking",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Active Transfers", icon: Icon(Icons.local_shipping)),
        Tab(text: "Tracking History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildActiveTransfersTab(),
        _buildTrackingHistoryTab(),
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
          _buildTrackingSummary(),
          _buildDeliveryMetrics(),
          _buildRecentUpdates(),
        ],
      ),
    );
  }

  Widget _buildActiveTransfersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTransferFilters(),
          _buildActiveTransfersList(),
        ],
      ),
    );
  }

  Widget _buildTrackingHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHistoryFilters(),
          _buildTrackingHistoryList(),
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
                  label: "Transfer Type",
                  items: transferFilters,
                  value: selectedTransfer,
                  onChanged: (value, label) {
                    selectedTransfer = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusFilters,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Warehouse",
            items: warehouseFilters,
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
              label: "Filter Transfers",
              items: transferFilters,
              value: selectedTransfer,
              onChanged: (value, label) {
                selectedTransfer = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.refresh,
            label: "Refresh",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryFilters() {
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
              label: "Time Range",
              items: [
                {"label": "Last 24 Hours", "value": "24h"},
                {"label": "Last 7 Days", "value": "7d"},
                {"label": "Last 30 Days", "value": "30d"},
              ],
              value: "24h",
              onChanged: (value, label) {
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.download,
            label: "Export",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Tracking Summary",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: trackingSummary.map((summary) => _buildSummaryCard(summary)).toList(),
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
            "${summary["value"]}",
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

  Widget _buildDeliveryMetrics() {
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
          ...deliveryMetrics.map((metric) => _buildMetricItem(metric)),
        ],
      ),
    );
  }

  Widget _buildMetricItem(Map<String, dynamic> metric) {
    Color trendColor = metric["trend"] == "up" ? successColor : dangerColor;
    IconData trendIcon = metric["trend"] == "up" ? Icons.trending_up : Icons.trending_down;
    
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${metric["metric"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${metric["value"]}${metric["unit"]}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "/ ${metric["target"]}${metric["unit"]}",
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
          Icon(
            trendIcon,
            color: trendColor,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildRecentUpdates() {
    List<Map<String, dynamic>> recentUpdates = trackingHistory.take(3).toList();
    
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
            "Recent Updates",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...recentUpdates.map((update) => _buildUpdateItem(update)),
        ],
      ),
    );
  }

  Widget _buildUpdateItem(Map<String, dynamic> update) {
    Color statusColor = _getStatusColor(update["status"]);
    
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
                      "${update["transferId"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${update["timestamp"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${update["status"]} • ${update["location"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "${update["description"]}",
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

  Widget _buildActiveTransfersList() {
    return Column(
      spacing: spSm,
      children: activeTransfers.map((transfer) => _buildTransferCard(transfer)).toList(),
    );
  }

  Widget _buildTransferCard(Map<String, dynamic> transfer) {
    Color statusColor = _getStatusColor(transfer["status"]);
    Color priorityColor = _getPriorityColor(transfer["priority"]);
    
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
                      "${transfer["id"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${transfer["origin"]} → ${transfer["destination"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: priorityColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${transfer["priority"]}",
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
                      "${transfer["status"]}",
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 4,
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: transfer["progress"],
              child: Container(
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: disabledBoldColor,
                size: 16,
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
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Items: ${transfer["items"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Value: \$${((transfer["value"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
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
                    "ETA: ${transfer["estimatedArrival"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${transfer["distance"]}",
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
                "Tracking: ${transfer["trackingNumber"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: infoColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
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

  Widget _buildTrackingHistoryList() {
    return Column(
      spacing: spSm,
      children: trackingHistory.map((history) => _buildHistoryCard(history)).toList(),
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> history) {
    Color statusColor = _getStatusColor(history["status"]);
    
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
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Text(
                      "${history["transferId"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${history["timestamp"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: statusColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${history["status"]}",
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                    ),
                  ),
                ),
                Text(
                  "${history["location"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "${history["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                if (history["driver"] != "Not Assigned")
                  Text(
                    "Driver: ${history["driver"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
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
      case 'in transit':
      case 'out for delivery':
        return infoColor;
      case 'delivered':
      case 'departed':
        return successColor;
      case 'delayed':
        return dangerColor;
      case 'pending pickup':
      case 'ready for pickup':
        return warningColor;
      default:
        return primaryColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'urgent':
        return dangerColor;
      case 'high':
        return warningColor;
      case 'medium':
        return infoColor;
      case 'low':
        return successColor;
      default:
        return primaryColor;
    }
  }
}
