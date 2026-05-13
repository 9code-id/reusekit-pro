import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaDeliveryConfirmationView extends StatefulWidget {
  const LtaDeliveryConfirmationView({super.key});

  @override
  State<LtaDeliveryConfirmationView> createState() => _LtaDeliveryConfirmationViewState();
}

class _LtaDeliveryConfirmationViewState extends State<LtaDeliveryConfirmationView> {
  String searchQuery = "";
  String selectedStatus = "";
  String selectedDeliveryType = "";
  int currentTab = 0;
  
  // Sample delivery data
  List<Map<String, dynamic>> deliveries = [
    {
      "id": "DEL-001",
      "orderId": "ORD-2024-001",
      "trackingNumber": "TRK789123456",
      "customerName": "John Smith",
      "customerPhone": "+1-555-0123",
      "deliveryAddress": "123 Main St, New York, NY 10001",
      "itemDescription": "Samsung Galaxy S24 + Accessories",
      "deliveryType": "standard",
      "scheduledDate": "2024-01-15",
      "scheduledTime": "10:00 AM - 12:00 PM",
      "actualDeliveryTime": "10:45 AM",
      "status": "delivered",
      "driverName": "Mike Johnson",
      "driverPhone": "+1-555-0789",
      "signatureRequired": true,
      "signatureCaptured": true,
      "photoTaken": true,
      "deliveryNotes": "Package delivered to front door. Customer was home and signed for delivery.",
      "weight": 1.2,
      "value": 899.99,
      "paymentMethod": "prepaid",
      "priority": "normal",
      "attempts": 1,
      "customerSatisfaction": 5.0
    },
    {
      "id": "DEL-002",
      "orderId": "ORD-2024-002", 
      "trackingNumber": "TRK456789123",
      "customerName": "Sarah Wilson",
      "customerPhone": "+1-555-0456",
      "deliveryAddress": "456 Oak Avenue, Los Angeles, CA 90210",
      "itemDescription": "Home Office Furniture Set",
      "deliveryType": "white_glove",
      "scheduledDate": "2024-01-15",
      "scheduledTime": "02:00 PM - 04:00 PM",
      "actualDeliveryTime": "",
      "status": "in_transit",
      "driverName": "David Brown",
      "driverPhone": "+1-555-0321",
      "signatureRequired": true,
      "signatureCaptured": false,
      "photoTaken": false,
      "deliveryNotes": "Customer requested assembly service. Special handling required.",
      "weight": 35.5,
      "value": 1299.99,
      "paymentMethod": "cod",
      "priority": "high",
      "attempts": 0,
      "customerSatisfaction": 0.0
    },
    {
      "id": "DEL-003",
      "orderId": "ORD-2024-003",
      "trackingNumber": "TRK321654987",
      "customerName": "Robert Davis",
      "customerPhone": "+1-555-0654",
      "deliveryAddress": "789 Pine Street, Chicago, IL 60601",
      "itemDescription": "Electronics Package - Laptop & Peripherals",
      "deliveryType": "express",
      "scheduledDate": "2024-01-15",
      "scheduledTime": "08:00 AM - 10:00 AM",
      "actualDeliveryTime": "",
      "status": "failed",
      "driverName": "Emily Davis",
      "driverPhone": "+1-555-0987",
      "signatureRequired": true,
      "signatureCaptured": false,
      "photoTaken": true,
      "deliveryNotes": "Customer not available. Left delivery notice. Will attempt redelivery tomorrow.",
      "weight": 3.8,
      "value": 2199.99,
      "paymentMethod": "prepaid",
      "priority": "high",
      "attempts": 2,
      "customerSatisfaction": 0.0
    },
    {
      "id": "DEL-004",
      "orderId": "ORD-2024-004",
      "trackingNumber": "TRK987123654",
      "customerName": "Lisa Anderson",
      "customerPhone": "+1-555-0147",
      "deliveryAddress": "321 Elm Drive, Miami, FL 33101",
      "itemDescription": "Fashion Items - Clothing & Accessories",
      "deliveryType": "standard",
      "scheduledDate": "2024-01-15",
      "scheduledTime": "01:00 PM - 03:00 PM",
      "actualDeliveryTime": "01:30 PM",
      "status": "delivered",
      "driverName": "James Wilson",
      "driverPhone": "+1-555-0852",
      "signatureRequired": false,
      "signatureCaptured": false,
      "photoTaken": true,
      "deliveryNotes": "Package left at secure location as requested by customer.",
      "weight": 0.8,
      "value": 299.99,
      "paymentMethod": "prepaid",
      "priority": "normal",
      "attempts": 1,
      "customerSatisfaction": 4.5
    },
    {
      "id": "DEL-005",
      "orderId": "ORD-2024-005",
      "trackingNumber": "TRK654321789",
      "customerName": "Michael Taylor",
      "customerPhone": "+1-555-0963",
      "deliveryAddress": "654 Maple Lane, Seattle, WA 98101",
      "itemDescription": "Medical Equipment & Supplies",
      "deliveryType": "priority",
      "scheduledDate": "2024-01-15",
      "scheduledTime": "11:00 AM - 01:00 PM",
      "actualDeliveryTime": "",
      "status": "pending",
      "driverName": "Anna Martinez",
      "driverPhone": "+1-555-0741",
      "signatureRequired": true,
      "signatureCaptured": false,
      "photoTaken": false,
      "deliveryNotes": "Special handling required. Temperature-controlled delivery.",
      "weight": 5.2,
      "value": 1899.99,
      "paymentMethod": "prepaid",
      "priority": "critical",
      "attempts": 0,
      "customerSatisfaction": 0.0
    }
  ];

  // Today's summary data
  Map<String, dynamic> todaySummary = {
    "totalDeliveries": 25,
    "completed": 18,
    "pending": 4,
    "failed": 3,
    "revenue": 15750.50,
    "successRate": 72.0,
    "avgDeliveryTime": 25,
    "customerSatisfaction": 4.3
  };

  List<Map<String, dynamic>> get filteredDeliveries {
    return deliveries.where((delivery) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${delivery["trackingNumber"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${delivery["customerName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${delivery["orderId"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${delivery["deliveryAddress"]}".toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesStatus = selectedStatus.isEmpty || delivery["status"] == selectedStatus;
      bool matchesType = selectedDeliveryType.isEmpty || delivery["deliveryType"] == selectedDeliveryType;

      return matchesSearch && matchesStatus && matchesType;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "delivered":
        return successColor;
      case "in_transit":
        return infoColor;
      case "pending":
        return warningColor;
      case "failed":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status) {
      case "delivered":
        return Icons.check_circle;
      case "in_transit":
        return Icons.local_shipping;
      case "pending":
        return Icons.schedule;
      case "failed":
        return Icons.error;
      default:
        return Icons.help;
    }
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case "critical":
        return dangerColor;
      case "high":
        return warningColor;
      case "normal":
        return successColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Delivery Confirmation",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Deliveries", icon: Icon(Icons.local_shipping)),
        Tab(text: "Summary", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildDeliveriesTab(),
        _buildSummaryTab(),
      ],
    );
  }

  Widget _buildDeliveriesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search and Filters
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search deliveries, customers, orders...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Filter by Status",
                  items: [
                    {"label": "All Status", "value": ""},
                    {"label": "Delivered", "value": "delivered"},
                    {"label": "In Transit", "value": "in_transit"},
                    {"label": "Pending", "value": "pending"},
                    {"label": "Failed", "value": "failed"},
                  ],
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
                  label: "Filter by Type",
                  items: [
                    {"label": "All Types", "value": ""},
                    {"label": "Standard", "value": "standard"},
                    {"label": "Express", "value": "express"},
                    {"label": "Priority", "value": "priority"},
                    {"label": "White Glove", "value": "white_glove"},
                  ],
                  value: selectedDeliveryType,
                  onChanged: (value, label) {
                    selectedDeliveryType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),

          // Quick Stats
          Row(
            children: [
              _buildQuickStat("Today's Deliveries", "${deliveries.length}", Icons.local_shipping, primaryColor),
              SizedBox(width: spSm),
              _buildQuickStat("Completed", "${deliveries.where((d) => d["status"] == "delivered").length}", Icons.check_circle, successColor),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              _buildQuickStat("In Transit", "${deliveries.where((d) => d["status"] == "in_transit").length}", Icons.local_shipping, infoColor),
              SizedBox(width: spSm),
              _buildQuickStat("Failed", "${deliveries.where((d) => d["status"] == "failed").length}", Icons.error, dangerColor),
            ],
          ),
          SizedBox(height: spLg),

          // Deliveries List
          Text(
            "Delivery Status",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          ...filteredDeliveries.map((delivery) => _buildDeliveryCard(delivery)).toList(),
        ],
      ),
    );
  }

  Widget _buildSummaryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          // Performance Metrics
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildMetricCard("Total Deliveries", "${todaySummary["totalDeliveries"]}", Icons.local_shipping, primaryColor),
              _buildMetricCard("Success Rate", "${(todaySummary["successRate"] as double).toStringAsFixed(1)}%", Icons.trending_up, successColor),
              _buildMetricCard("Revenue", "\$${((todaySummary["revenue"] as double)).currency}", Icons.attach_money, successColor),
              _buildMetricCard("Avg Delivery Time", "${todaySummary["avgDeliveryTime"]} min", Icons.timer, infoColor),
              _buildMetricCard("Customer Rating", "${(todaySummary["customerSatisfaction"] as double).toStringAsFixed(1)}/5.0", Icons.star, warningColor),
              _buildMetricCard("Failed Deliveries", "${todaySummary["failed"]}", Icons.error, dangerColor),
            ],
          ),
          SizedBox(height: spLg),

          // Status Breakdown
          Text(
            "Status Breakdown",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          _buildStatusBreakdownCard(),
        ],
      ),
    );
  }

  Widget _buildQuickStat(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 24,
            ),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: spXs),
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
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBreakdownCard() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          _buildStatusRow("Completed", todaySummary["completed"] as int, todaySummary["totalDeliveries"] as int, successColor),
          SizedBox(height: spSm),
          _buildStatusRow("Pending", todaySummary["pending"] as int, todaySummary["totalDeliveries"] as int, warningColor),
          SizedBox(height: spSm),
          _buildStatusRow("Failed", todaySummary["failed"] as int, todaySummary["totalDeliveries"] as int, dangerColor),
        ],
      ),
    );
  }

  Widget _buildStatusRow(String status, int count, int total, Color color) {
    double percentage = total > 0 ? (count / total) : 0.0;
    
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              status,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Text(
              "$count (${(percentage * 100).toStringAsFixed(1)}%)",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: spXs),
        LinearProgressIndicator(
          value: percentage,
          backgroundColor: disabledColor,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ],
    );
  }

  Widget _buildDeliveryCard(Map<String, dynamic> delivery) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: getStatusColor("${delivery["status"]}"),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                getStatusIcon("${delivery["status"]}"),
                color: getStatusColor("${delivery["status"]}"),
                size: 20,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${delivery["trackingNumber"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: getPriorityColor("${delivery["priority"]}").withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${delivery["priority"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: getPriorityColor("${delivery["priority"]}"),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${delivery["customerName"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${delivery["customerPhone"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${delivery["deliveryAddress"]}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: getStatusColor("${delivery["status"]}").withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${delivery["status"]}".toUpperCase().replaceAll('_', ' '),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: getStatusColor("${delivery["status"]}"),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${delivery["itemDescription"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "Weight: ${(delivery["weight"] as double).toStringAsFixed(1)} kg",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Value: \$${((delivery["value"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Driver: ${delivery["driverName"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Scheduled: ${delivery["scheduledTime"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    if ("${delivery["actualDeliveryTime"]}".isNotEmpty)
                      Text(
                        "Delivered: ${delivery["actualDeliveryTime"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      if (delivery["signatureCaptured"] == true)
                        Icon(Icons.edit, size: 16, color: successColor)
                      else
                        Icon(Icons.edit_off, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      if (delivery["photoTaken"] == true)
                        Icon(Icons.camera_alt, size: 16, color: successColor)
                      else
                        Icon(Icons.camera_alt_outlined, size: 16, color: disabledBoldColor),
                    ],
                  ),
                  Text(
                    "Attempts: ${delivery["attempts"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          if ("${delivery["deliveryNotes"]}".isNotEmpty) ...[
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${delivery["deliveryNotes"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
          
          SizedBox(height: spSm),
          Row(
            children: [
              if (delivery["status"] == "delivered" && (delivery["customerSatisfaction"] as double) > 0) ...[
                Row(
                  children: List.generate(5, (index) => Icon(
                    index < (delivery["customerSatisfaction"] as double).floor() ? Icons.star : Icons.star_border,
                    size: 14,
                    color: warningColor,
                  )),
                ),
                Spacer(),
              ] else
                Spacer(),
              QButton(
                label: delivery["status"] == "delivered" ? "View Receipt" : 
                       delivery["status"] == "failed" ? "Reschedule" : "Track",
                size: bs.sm,
                onPressed: () {
                  // Handle action based on status
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  // Handle more options
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
