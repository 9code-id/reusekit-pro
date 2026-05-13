import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaOrderHistoryView extends StatefulWidget {
  const FdaOrderHistoryView({super.key});

  @override
  State<FdaOrderHistoryView> createState() => _FdaOrderHistoryViewState();
}

class _FdaOrderHistoryViewState extends State<FdaOrderHistoryView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedStatus = "All";
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Delivered", "value": "Delivered"},
    {"label": "Cancelled", "value": "Cancelled"},
    {"label": "Processing", "value": "Processing"},
  ];

  List<Map<String, dynamic>> orders = [
    {
      "id": "ORD-2024-001",
      "restaurant": "Burger Palace",
      "restaurantImage": "https://picsum.photos/80/80?random=1&keyword=restaurant",
      "date": "2024-01-15 14:30",
      "status": "Delivered",
      "total": 24.99,
      "items": [
        {"name": "Classic Burger", "quantity": 2, "price": 9.99},
        {"name": "French Fries", "quantity": 1, "price": 4.99},
      ],
      "deliveryAddress": "123 Main St, Downtown",
      "rating": 4.5,
      "deliveryTime": "25 mins",
    },
    {
      "id": "ORD-2024-002", 
      "restaurant": "Pizza Corner",
      "restaurantImage": "https://picsum.photos/80/80?random=2&keyword=pizza",
      "date": "2024-01-14 19:15",
      "status": "Delivered",
      "total": 18.50,
      "items": [
        {"name": "Margherita Pizza", "quantity": 1, "price": 15.99},
        {"name": "Garlic Bread", "quantity": 1, "price": 2.50},
      ],
      "deliveryAddress": "456 Oak Ave, Westside",
      "rating": 5.0,
      "deliveryTime": "35 mins",
    },
    {
      "id": "ORD-2024-003",
      "restaurant": "Sushi Express",
      "restaurantImage": "https://picsum.photos/80/80?random=3&keyword=sushi",
      "date": "2024-01-13 12:45",
      "status": "Cancelled",
      "total": 32.00,
      "items": [
        {"name": "Salmon Sashimi", "quantity": 1, "price": 18.00},
        {"name": "California Roll", "quantity": 2, "price": 7.00},
      ],
      "deliveryAddress": "789 Pine Rd, Eastside",
      "rating": null,
      "deliveryTime": null,
      "cancelReason": "Restaurant was closed",
    },
    {
      "id": "ORD-2024-004",
      "restaurant": "Taco Fiesta",
      "restaurantImage": "https://picsum.photos/80/80?random=4&keyword=tacos",
      "date": "2024-01-12 20:30",
      "status": "Delivered",
      "total": 16.75,
      "items": [
        {"name": "Beef Tacos", "quantity": 3, "price": 4.50},
        {"name": "Nachos", "quantity": 1, "price": 3.75},
      ],
      "deliveryAddress": "321 Elm St, Southside",
      "rating": 4.0,
      "deliveryTime": "30 mins",
    },
    {
      "id": "ORD-2024-005",
      "restaurant": "Pasta House",
      "restaurantImage": "https://picsum.photos/80/80?random=5&keyword=pasta",
      "date": "2024-01-11 18:00",
      "status": "Processing",
      "total": 21.25,
      "items": [
        {"name": "Spaghetti Carbonara", "quantity": 1, "price": 14.99},
        {"name": "Caesar Salad", "quantity": 1, "price": 6.25},
      ],
      "deliveryAddress": "654 Maple Dr, Northside",
      "rating": null,
      "deliveryTime": "Expected: 40 mins",
    },
  ];

  List<Map<String, dynamic>> get filteredOrders {
    List<Map<String, dynamic>> filtered = orders;
    
    if (selectedStatus != "All") {
      filtered = filtered.where((order) => order["status"] == selectedStatus).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((order) =>
        (order["restaurant"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (order["id"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Delivered":
        return successColor;
      case "Cancelled":
        return dangerColor;
      case "Processing":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "Delivered":
        return Icons.check_circle;
      case "Cancelled":
        return Icons.cancel;
      case "Processing":
        return Icons.access_time;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Order History",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "All Orders", icon: Icon(Icons.list_alt)),
        Tab(text: "Statistics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOrdersTab(),
        _buildStatisticsTab(),
      ],
    );
  }

  Widget _buildOrdersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filter Section
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
                QTextField(
                  label: "Search Orders",
                  value: searchQuery,
                  hint: "Search by restaurant or order ID",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
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
              ],
            ),
          ),

          // Orders List
          if (filteredOrders.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.receipt_long,
                    size: 60,
                    color: disabledColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No Orders Found",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Try adjusting your search or filter criteria",
                    style: TextStyle(
                      color: disabledColor,
                    ),
                  ),
                ],
              ),
            )
          else
            ...filteredOrders.map((order) => _buildOrderCard(order)).toList(),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          // Header with Restaurant Info and Status
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${order["restaurantImage"]}",
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${order["restaurant"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${order["id"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "${order["date"]}",
                      style: TextStyle(
                        color: disabledColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(order["status"]).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getStatusIcon(order["status"]),
                      size: 14,
                      color: _getStatusColor(order["status"]),
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${order["status"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _getStatusColor(order["status"]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Order Items
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text(
                  "Items:",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                ...(order["items"] as List).map((item) => 
                  Text(
                    "${item["quantity"]}x ${item["name"]} - \$${((item["price"] as double).toStringAsFixed(2))}",
                    style: TextStyle(fontSize: 12),
                  )
                ).toList(),
              ],
            ),
          ),

          // Footer with Total and Actions
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total: \$${((order["total"] as double).toStringAsFixed(2))}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    if (order["deliveryTime"] != null)
                      Text(
                        "Delivery: ${order["deliveryTime"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                      ),
                  ],
                ),
              ),
              if (order["status"] == "Delivered") ...[
                if (order["rating"] != null)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star, size: 12, color: warningColor),
                        SizedBox(width: 2),
                        Text(
                          "${order["rating"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  QButton(
                    label: "Rate",
                    size: bs.sm,
                    onPressed: () {
                      // navigateTo('RateOrderView')
                    },
                  ),
                SizedBox(width: spXs),
                QButton(
                  label: "Reorder",
                  size: bs.sm,
                  onPressed: () {
                    // navigateTo('ReorderView')
                  },
                ),
              ] else if (order["status"] == "Cancelled") ...[
                Text(
                  "Reason: ${order["cancelReason"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: dangerColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ] else if (order["status"] == "Processing") ...[
                QButton(
                  label: "Track",
                  size: bs.sm,
                  onPressed: () {
                    // navigateTo('OrderTrackingView')
                  },
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsTab() {
    Map<String, int> stats = {
      "Total Orders": orders.length,
      "Delivered": orders.where((o) => o["status"] == "Delivered").length,
      "Cancelled": orders.where((o) => o["status"] == "Cancelled").length,
      "Processing": orders.where((o) => o["status"] == "Processing").length,
    };

    double totalSpent = orders
        .where((o) => o["status"] == "Delivered")
        .fold(0.0, (sum, order) => sum + (order["total"] as double));

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Overview Stats
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "Order Statistics",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${stats["Total Orders"]}",
                            style: TextStyle(
                              fontSize: fsH3,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Total Orders",
                            style: TextStyle(
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "\$${totalSpent.toStringAsFixed(0)}",
                            style: TextStyle(
                              fontSize: fsH3,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Total Spent",
                            style: TextStyle(
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Status Breakdown
          ResponsiveGridView(
            padding: EdgeInsets.all(0),
            minItemWidth: 150,
            children: [
              _buildStatCard("Delivered", stats["Delivered"]!, successColor, Icons.check_circle),
              _buildStatCard("Processing", stats["Processing"]!, warningColor, Icons.access_time),
              _buildStatCard("Cancelled", stats["Cancelled"]!, dangerColor, Icons.cancel),
            ],
          ),

          // Favorite Restaurants
          Container(
            padding: EdgeInsets.all(spSm),
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
                  "Most Ordered From",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...orders
                    .where((o) => o["status"] == "Delivered")
                    .take(3)
                    .map((order) => Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(radiusXs),
                                child: Image.network(
                                  "${order["restaurantImage"]}",
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${order["restaurant"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "Last order: ${order["date"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "\$${((order["total"] as double).toStringAsFixed(2))}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, int value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: color.withAlpha(50),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "$value",
            style: TextStyle(
              fontSize: fsH4,
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
}
