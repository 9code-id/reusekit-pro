import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsDeliveryTrackingView extends StatefulWidget {
  const RfsDeliveryTrackingView({super.key});

  @override
  State<RfsDeliveryTrackingView> createState() => _RfsDeliveryTrackingViewState();
}

class _RfsDeliveryTrackingViewState extends State<RfsDeliveryTrackingView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "All";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Preparing", "value": "Preparing"},
    {"label": "Shipped", "value": "Shipped"},
    {"label": "In Transit", "value": "In Transit"},
    {"label": "Out for Delivery", "value": "Out for Delivery"},
    {"label": "Delivered", "value": "Delivered"},
    {"label": "Delayed", "value": "Delayed"},
  ];

  List<Map<String, dynamic>> deliveries = [
    {
      "id": "DEL-2024-001",
      "orderId": "PO-2024-001",
      "supplier": "Fresh Valley Produce",
      "driver": "Mike Johnson",
      "driverPhone": "+1 (555) 123-9876",
      "vehicleNumber": "TRK-001",
      "status": "Out for Delivery",
      "scheduledDate": "2024-12-20",
      "scheduledTime": "09:00",
      "actualDate": null,
      "actualTime": null,
      "estimatedArrival": "2024-12-20T10:30:00",
      "items": [
        {"name": "Tomatoes", "quantity": 50, "unit": "lbs"},
        {"name": "Lettuce", "quantity": 30, "unit": "heads"},
        {"name": "Onions", "quantity": 25, "unit": "lbs"},
      ],
      "totalValue": 2450.00,
      "priority": "High",
      "deliveryNotes": "Fragile items - handle with care",
      "trackingSteps": [
        {"status": "Order Placed", "timestamp": "2024-12-18T08:00:00", "completed": true},
        {"status": "Order Confirmed", "timestamp": "2024-12-18T08:30:00", "completed": true},
        {"status": "Preparing", "timestamp": "2024-12-19T14:00:00", "completed": true},
        {"status": "Shipped", "timestamp": "2024-12-20T06:00:00", "completed": true},
        {"status": "In Transit", "timestamp": "2024-12-20T08:00:00", "completed": true},
        {"status": "Out for Delivery", "timestamp": "2024-12-20T09:00:00", "completed": true},
        {"status": "Delivered", "timestamp": null, "completed": false},
      ],
    },
    {
      "id": "DEL-2024-002",
      "orderId": "PO-2024-002",
      "supplier": "Premium Dairy Co",
      "driver": "Sarah Williams",
      "driverPhone": "+1 (555) 456-7890",
      "vehicleNumber": "TRK-002",
      "status": "Delivered",
      "scheduledDate": "2024-12-19",
      "scheduledTime": "07:00",
      "actualDate": "2024-12-19",
      "actualTime": "07:15",
      "estimatedArrival": null,
      "items": [
        {"name": "Whole Milk", "quantity": 20, "unit": "gallons"},
        {"name": "Cheddar Cheese", "quantity": 15, "unit": "lbs"},
        {"name": "Butter", "quantity": 10, "unit": "lbs"},
      ],
      "totalValue": 890.50,
      "priority": "Medium",
      "deliveryNotes": "Refrigerated delivery - maintain cold chain",
      "trackingSteps": [
        {"status": "Order Placed", "timestamp": "2024-12-17T10:00:00", "completed": true},
        {"status": "Order Confirmed", "timestamp": "2024-12-17T10:30:00", "completed": true},
        {"status": "Preparing", "timestamp": "2024-12-18T16:00:00", "completed": true},
        {"status": "Shipped", "timestamp": "2024-12-19T05:00:00", "completed": true},
        {"status": "In Transit", "timestamp": "2024-12-19T06:00:00", "completed": true},
        {"status": "Out for Delivery", "timestamp": "2024-12-19T06:30:00", "completed": true},
        {"status": "Delivered", "timestamp": "2024-12-19T07:15:00", "completed": true},
      ],
    },
    {
      "id": "DEL-2024-003",
      "orderId": "PO-2024-003",
      "supplier": "Ocean Fresh Seafood",
      "driver": "Carlos Rodriguez",
      "driverPhone": "+1 (555) 789-0123",
      "vehicleNumber": "TRK-003",
      "status": "Delayed",
      "scheduledDate": "2024-12-21",
      "scheduledTime": "11:00",
      "actualDate": null,
      "actualTime": null,
      "estimatedArrival": "2024-12-21T14:30:00",
      "items": [
        {"name": "Atlantic Salmon", "quantity": 20, "unit": "lbs"},
        {"name": "Shrimp", "quantity": 15, "unit": "lbs"},
        {"name": "Tuna", "quantity": 12, "unit": "lbs"},
      ],
      "totalValue": 1250.00,
      "priority": "Urgent",
      "deliveryNotes": "Temperature-controlled delivery required",
      "delayReason": "Traffic congestion on highway",
      "trackingSteps": [
        {"status": "Order Placed", "timestamp": "2024-12-16T14:00:00", "completed": true},
        {"status": "Order Confirmed", "timestamp": "2024-12-16T14:30:00", "completed": true},
        {"status": "Preparing", "timestamp": "2024-12-20T18:00:00", "completed": true},
        {"status": "Shipped", "timestamp": "2024-12-21T07:00:00", "completed": true},
        {"status": "In Transit", "timestamp": "2024-12-21T09:00:00", "completed": true},
        {"status": "Out for Delivery", "timestamp": null, "completed": false},
        {"status": "Delivered", "timestamp": null, "completed": false},
      ],
    },
    {
      "id": "DEL-2024-004",
      "orderId": "PO-2024-004",
      "supplier": "Mountain Beverages",
      "driver": "Jennifer Davis",
      "driverPhone": "+1 (555) 321-6547",
      "vehicleNumber": "TRK-004",
      "status": "In Transit",
      "scheduledDate": "2024-12-18",
      "scheduledTime": "13:00",
      "actualDate": null,
      "actualTime": null,
      "estimatedArrival": "2024-12-18T15:20:00",
      "items": [
        {"name": "Soft Drinks", "quantity": 48, "unit": "cans"},
        {"name": "Orange Juice", "quantity": 24, "unit": "bottles"},
        {"name": "Coffee Beans", "quantity": 10, "unit": "lbs"},
      ],
      "totalValue": 456.75,
      "priority": "Low",
      "deliveryNotes": "Standard delivery",
      "trackingSteps": [
        {"status": "Order Placed", "timestamp": "2024-12-15T12:00:00", "completed": true},
        {"status": "Order Confirmed", "timestamp": "2024-12-15T12:30:00", "completed": true},
        {"status": "Preparing", "timestamp": "2024-12-17T20:00:00", "completed": true},
        {"status": "Shipped", "timestamp": "2024-12-18T10:00:00", "completed": true},
        {"status": "In Transit", "timestamp": "2024-12-18T12:00:00", "completed": true},
        {"status": "Out for Delivery", "timestamp": null, "completed": false},
        {"status": "Delivered", "timestamp": null, "completed": false},
      ],
    },
  ];

  List<Map<String, dynamic>> get filteredDeliveries {
    return deliveries.where((delivery) {
      bool matchesSearch = "${delivery["id"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${delivery["orderId"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${delivery["supplier"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${delivery["driver"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || delivery["status"] == selectedStatus;
      
      return matchesSearch && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Preparing":
        return warningColor;
      case "Shipped":
        return infoColor;
      case "In Transit":
        return primaryColor;
      case "Out for Delivery":
        return successColor;
      case "Delivered":
        return successColor;
      case "Delayed":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Low":
        return successColor;
      case "Medium":
        return warningColor;
      case "High":
        return primaryColor;
      case "Urgent":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Delivery Tracking",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Active", icon: Icon(Icons.local_shipping)),
        Tab(text: "History", icon: Icon(Icons.history)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildActiveTab(),
        _buildHistoryTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildActiveTab() {
    List<Map<String, dynamic>> activeDeliveries = deliveries
        .where((d) => d["status"] != "Delivered")
        .toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search deliveries...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.refresh,
                size: bs.sm,
                onPressed: () {
                  // Refresh tracking data
                },
              ),
            ],
          ),

          QDropdownField(
            label: "Filter by Status",
            items: statusOptions,
            value: selectedStatus,
            onChanged: (value, label) {
              selectedStatus = value;
              setState(() {});
            },
          ),

          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatusCard("Active Deliveries", "${activeDeliveries.length}", Icons.local_shipping, primaryColor),
              _buildStatusCard("Out for Delivery", "${deliveries.where((d) => d["status"] == "Out for Delivery").length}", Icons.delivery_dining, successColor),
              _buildStatusCard("Delayed", "${deliveries.where((d) => d["status"] == "Delayed").length}", Icons.warning, dangerColor),
              _buildStatusCard("In Transit", "${deliveries.where((d) => d["status"] == "In Transit").length}", Icons.directions_car, infoColor),
            ],
          ),

          if (activeDeliveries.isEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Icon(Icons.check_circle, size: 64, color: successColor),
                  SizedBox(height: spMd),
                  Text(
                    "No Active Deliveries",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "All deliveries have been completed",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredDeliveries.where((d) => d["status"] != "Delivered").length,
              separatorBuilder: (context, index) => SizedBox(height: spSm),
              itemBuilder: (context, index) {
                final delivery = filteredDeliveries.where((d) => d["status"] != "Delivered").toList()[index];
                return _buildDeliveryCard(delivery);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    List<Map<String, dynamic>> completedDeliveries = deliveries
        .where((d) => d["status"] == "Delivered")
        .toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search delivery history...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: completedDeliveries.length,
            separatorBuilder: (context, index) => SizedBox(height: spSm),
            itemBuilder: (context, index) {
              final delivery = completedDeliveries[index];
              return _buildHistoryCard(delivery);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    double avgDeliveryTime = 24.5; // Calculate from actual data
    int onTimeDeliveries = deliveries.where((d) => d["status"] == "Delivered").length;
    int totalDeliveries = deliveries.length;
    double onTimePercentage = (onTimeDeliveries / totalDeliveries) * 100;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildMetricCard("Total Deliveries", "$totalDeliveries", Icons.local_shipping, primaryColor),
              _buildMetricCard("On-Time Rate", "${onTimePercentage.toStringAsFixed(1)}%", Icons.schedule, successColor),
              _buildMetricCard("Avg Delivery Time", "${avgDeliveryTime}h", Icons.timer, infoColor),
              _buildMetricCard("Delayed Orders", "${deliveries.where((d) => d["status"] == "Delayed").length}", Icons.warning, dangerColor),
            ],
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Delivery Performance by Supplier",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ..._getSupplierPerformance().map((supplier) => _buildSupplierPerformanceItem(supplier)),
              ],
            ),
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Driver Performance",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ..._getDriverPerformance().map((driver) => _buildDriverPerformanceItem(driver)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryCard(Map<String, dynamic> delivery) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${delivery["id"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Order: ${delivery["orderId"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor("${delivery["status"]}").withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${delivery["status"]}",
                  style: TextStyle(
                    color: _getStatusColor("${delivery["status"]}"),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Icon(Icons.business, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${delivery["supplier"]}",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${delivery["driver"]}",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(width: spMd),
              Icon(Icons.phone, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${delivery["driverPhone"]}",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),

          if (delivery["estimatedArrival"] != null)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: _getStatusColor("${delivery["status"]}").withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.schedule, size: 16, color: _getStatusColor("${delivery["status"]}")),
                  SizedBox(width: spSm),
                  Text(
                    "ETA: ${DateTime.parse("${delivery["estimatedArrival"]}").dMMMy} ${TimeOfDay.fromDateTime(DateTime.parse("${delivery["estimatedArrival"]}")).kkmm}",
                    style: TextStyle(
                      fontSize: 12,
                      color: _getStatusColor("${delivery["status"]}"),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

          if (delivery["status"] == "Delayed" && delivery["delayReason"] != null)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, size: 16, color: dangerColor),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Delay: ${delivery["delayReason"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
                      ),
                    ),
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
                  onPressed: () {
                    _showTrackingDialog(delivery);
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.phone,
                size: bs.sm,
                onPressed: () {
                  // Call driver
                },
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  // More options
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> delivery) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${delivery["id"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${delivery["supplier"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "Delivered",
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
                      "Scheduled",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${DateTime.parse("${delivery["scheduledDate"]}").dMMMy} ${delivery["scheduledTime"]}",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Delivered",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${DateTime.parse("${delivery["actualDate"]}").dMMMy} ${delivery["actualTime"]}",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
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
                      "Driver",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${delivery["driver"]}",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Value",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(delivery["totalValue"] as double).currency}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          QButton(
            label: "View Details",
            size: bs.sm,
            onPressed: () {
              _showTrackingDialog(delivery);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupplierPerformanceItem(Map<String, dynamic> supplier) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spSm),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "${supplier["name"]}",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            "${supplier["onTimeRate"]}%",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: (supplier["onTimeRate"] as double) >= 90 
                  ? successColor 
                  : (supplier["onTimeRate"] as double) >= 70 
                      ? warningColor 
                      : dangerColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDriverPerformanceItem(Map<String, dynamic> driver) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spSm),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "${driver["name"]}",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            "${driver["deliveries"]} deliveries",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getSupplierPerformance() {
    return [
      {"name": "Fresh Valley Produce", "onTimeRate": 95.0},
      {"name": "Premium Dairy Co", "onTimeRate": 88.0},
      {"name": "Ocean Fresh Seafood", "onTimeRate": 75.0},
      {"name": "Mountain Beverages", "onTimeRate": 92.0},
    ];
  }

  List<Map<String, dynamic>> _getDriverPerformance() {
    return [
      {"name": "Mike Johnson", "deliveries": 25},
      {"name": "Sarah Williams", "deliveries": 18},
      {"name": "Carlos Rodriguez", "deliveries": 22},
      {"name": "Jennifer Davis", "deliveries": 16},
    ];
  }

  void _showTrackingDialog(Map<String, dynamic> delivery) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delivery Tracking"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${delivery["id"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              ...(delivery["trackingSteps"] as List).map((step) => 
                _buildTrackingStep(step, delivery["trackingSteps"] as List)
              ),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingStep(Map<String, dynamic> step, List<dynamic> allSteps) {
    bool isCompleted = step["completed"] as bool;
    bool isCurrentStep = !isCompleted && 
        (allSteps.indexOf(step) == 0 || 
         (allSteps.where((s) => s["completed"] == true).length == allSteps.indexOf(step)));

    return Container(
      padding: EdgeInsets.symmetric(vertical: spSm),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: isCompleted 
                  ? successColor 
                  : isCurrentStep 
                      ? primaryColor 
                      : disabledColor,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              isCompleted ? Icons.check : Icons.circle,
              size: 16,
              color: Colors.white,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${step["status"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isCompleted || isCurrentStep ? primaryColor : disabledBoldColor,
                  ),
                ),
                if (step["timestamp"] != null)
                  Text(
                    "${DateTime.parse("${step["timestamp"]}").dMMMy} ${TimeOfDay.fromDateTime(DateTime.parse("${step["timestamp"]}")).kkmm}",
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
}
