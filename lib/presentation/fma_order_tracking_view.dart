import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaOrderTrackingView extends StatefulWidget {
  const FmaOrderTrackingView({super.key});

  @override
  State<FmaOrderTrackingView> createState() => _FmaOrderTrackingViewState();
}

class _FmaOrderTrackingViewState extends State<FmaOrderTrackingView> {
  int currentTab = 0;
  String selectedStatus = "All";
  String selectedPriority = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> statusItems = [
    {"label": "All", "value": "All"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Confirmed", "value": "Confirmed"},
    {"label": "Preparing", "value": "Preparing"},
    {"label": "Shipped", "value": "Shipped"},
    {"label": "Delivered", "value": "Delivered"},
    {"label": "Cancelled", "value": "Cancelled"},
  ];

  List<Map<String, dynamic>> priorityItems = [
    {"label": "All", "value": "All"},
    {"label": "Low", "value": "Low"},
    {"label": "Medium", "value": "Medium"},
    {"label": "High", "value": "High"},
    {"label": "Urgent", "value": "Urgent"},
  ];

  List<Map<String, dynamic>> orders = [
    {
      "id": "ORD-2024-001",
      "supplier": "Fresh Farm Suppliers",
      "items": [
        {"name": "Organic Tomatoes", "quantity": 50, "unit": "kg"},
        {"name": "Fresh Lettuce", "quantity": 30, "unit": "heads"},
      ],
      "totalAmount": 875.50,
      "status": "Confirmed",
      "priority": "High",
      "orderDate": "2024-06-20",
      "expectedDelivery": "2024-06-22",
      "trackingNumber": "TRK123456789",
      "contactPerson": "John Smith",
      "contactPhone": "+1-555-0101",
      "notes": "Quality check required on delivery",
    },
    {
      "id": "ORD-2024-002",
      "supplier": "Dairy Delights Co.",
      "items": [
        {"name": "Fresh Milk", "quantity": 100, "unit": "liters"},
        {"name": "Greek Yogurt", "quantity": 24, "unit": "cups"},
        {"name": "Aged Cheese", "quantity": 5, "unit": "kg"},
      ],
      "totalAmount": 1250.75,
      "status": "Preparing",
      "priority": "Medium",
      "orderDate": "2024-06-19",
      "expectedDelivery": "2024-06-21",
      "trackingNumber": "TRK987654321",
      "contactPerson": "Sarah Johnson",
      "contactPhone": "+1-555-0202",
      "notes": "Keep refrigerated during transport",
    },
    {
      "id": "ORD-2024-003",
      "supplier": "Meat Masters Ltd.",
      "items": [
        {"name": "Premium Beef", "quantity": 25, "unit": "kg"},
        {"name": "Chicken Breast", "quantity": 40, "unit": "kg"},
      ],
      "totalAmount": 2100.00,
      "status": "Shipped",
      "priority": "Urgent",
      "orderDate": "2024-06-18",
      "expectedDelivery": "2024-06-20",
      "trackingNumber": "TRK456789123",
      "contactPerson": "Mike Wilson",
      "contactPhone": "+1-555-0303",
      "notes": "Temperature-controlled delivery required",
    },
    {
      "id": "ORD-2024-004",
      "supplier": "Spice World Trading",
      "items": [
        {"name": "Black Pepper", "quantity": 2, "unit": "kg"},
        {"name": "Cinnamon Sticks", "quantity": 1, "unit": "kg"},
        {"name": "Turmeric Powder", "quantity": 3, "unit": "kg"},
      ],
      "totalAmount": 325.25,
      "status": "Delivered",
      "priority": "Low",
      "orderDate": "2024-06-15",
      "expectedDelivery": "2024-06-17",
      "trackingNumber": "TRK789123456",
      "contactPerson": "Raj Patel",
      "contactPhone": "+1-555-0404",
      "notes": "Delivered and inspected - all items satisfactory",
    },
  ];

  List<Map<String, dynamic>> recentDeliveries = [
    {
      "id": "DEL-001",
      "orderNumber": "ORD-2024-004",
      "supplier": "Spice World Trading",
      "deliveryDate": "2024-06-17",
      "receivedBy": "Kitchen Manager",
      "status": "Completed",
      "rating": 5,
      "feedback": "Excellent quality spices, delivered on time",
    },
    {
      "id": "DEL-002", 
      "orderNumber": "ORD-2024-005",
      "supplier": "Green Valley Farms",
      "deliveryDate": "2024-06-16",
      "receivedBy": "Head Chef",
      "status": "Completed",
      "rating": 4,
      "feedback": "Good quality vegetables, slight delay in delivery",
    },
  ];

  List<Map<String, dynamic>> orderAnalytics = [
    {"metric": "Total Orders", "value": "127", "change": "+12%", "trend": "up"},
    {"metric": "Pending Orders", "value": "8", "change": "-5%", "trend": "down"},
    {"metric": "On-Time Delivery", "value": "94%", "change": "+3%", "trend": "up"},
    {"metric": "Average Order Value", "value": "\$1,245", "change": "+8%", "trend": "up"},
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return warningColor;
      case "Confirmed":
        return infoColor;
      case "Preparing":
        return primaryColor;
      case "Shipped":
        return secondaryColor;
      case "Delivered":
        return successColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Low":
        return successColor;
      case "Medium":
        return warningColor;
      case "High":
        return dangerColor;
      case "Urgent":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildActiveOrdersTab() {
    final activeOrders = orders.where((order) => 
      !["Delivered", "Cancelled"].contains(order["status"])
    ).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Filters
          Container(
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
                        label: "Search Orders",
                        value: searchQuery,
                        hint: "Order ID, supplier name...",
                        onChanged: (value) {
                          searchQuery = value;
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
                        label: "Priority",
                        items: priorityItems,
                        value: selectedPriority,
                        onChanged: (value, label) {
                          selectedPriority = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Active Orders List
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Text(
                    "Active Orders (${activeOrders.length})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                ...activeOrders.map((order) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: _getStatusColor("${order["status"]}"),
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${order["id"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${order["supplier"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor("${order["status"]}").withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${order["status"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: _getStatusColor("${order["status"]}"),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 2),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getPriorityColor("${order["priority"]}").withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${order["priority"]} Priority",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: _getPriorityColor("${order["priority"]}"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Amount: \$${((order["totalAmount"] as num).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Items: ${(order["items"] as List).length}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Expected: ${DateTime.parse(order["expectedDelivery"] as String).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                if (order["trackingNumber"] != null)
                                  Text(
                                    "Track: ${order["trackingNumber"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: infoColor,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "View Details",
                                size: bs.sm,
                                onPressed: () {
                                  si("Viewing order details for ${order["id"]}");
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QButton(
                                label: "Update Status",
                                size: bs.sm,
                                onPressed: () {
                                  si("Updating status for ${order["id"]}");
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Summary Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
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
                        Icon(Icons.shopping_cart, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Total Orders",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "127",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "+12% this month",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
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
                        Icon(Icons.local_shipping, color: successColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Delivered",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "119",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "94% success rate",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Order History List
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Text(
                    "Recent Orders",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                ...orders.map((order) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: _getStatusColor("${order["status"]}"),
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${order["id"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${order["supplier"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: _getStatusColor("${order["status"]}").withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${order["status"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _getStatusColor("${order["status"]}"),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\$${((order["totalAmount"] as num).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${DateTime.parse(order["orderDate"] as String).dMMMy}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveriesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Recent Deliveries
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Text(
                    "Recent Deliveries",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                ...recentDeliveries.map((delivery) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: successColor,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${delivery["orderNumber"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${delivery["supplier"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  Icons.star,
                                  size: 16,
                                  color: index < (delivery["rating"] as int)
                                      ? warningColor
                                      : disabledColor,
                                );
                              }),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Received by: ${delivery["receivedBy"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${DateTime.parse(delivery["deliveryDate"] as String).dMMMy}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        if (delivery["feedback"] != null) ...[
                          SizedBox(height: spXs),
                          Text(
                            "${delivery["feedback"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Analytics Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: orderAnalytics.map((metric) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${metric["metric"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        Icon(
                          metric["trend"] == "up" ? Icons.trending_up : Icons.trending_down,
                          color: metric["trend"] == "up" ? successColor : dangerColor,
                          size: 20,
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${metric["value"]}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${metric["change"]} from last month",
                      style: TextStyle(
                        fontSize: 12,
                        color: metric["trend"] == "up" ? successColor : dangerColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          // Order Status Distribution
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order Status Distribution",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...["Pending", "Confirmed", "Preparing", "Shipped", "Delivered"].map((status) {
                  final count = orders.where((order) => order["status"] == status).length;
                  final percentage = count / orders.length * 100;
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spXs),
                    child: Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: _getStatusColor(status),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            status,
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Text(
                          "$count (${percentage.toStringAsFixed(1)}%)",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Order Tracking",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Active", icon: Icon(Icons.pending_actions)),
        Tab(text: "History", icon: Icon(Icons.history)),
        Tab(text: "Deliveries", icon: Icon(Icons.local_shipping)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildActiveOrdersTab(),
        _buildOrderHistoryTab(),
        _buildDeliveriesTab(),
        _buildAnalyticsTab(),
      ],
      onInit: (tabController) {},
    );
  }
}
