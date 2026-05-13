import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsLiveOrdersView extends StatefulWidget {
  const RfsLiveOrdersView({super.key});

  @override
  State<RfsLiveOrdersView> createState() => _RfsLiveOrdersViewState();
}

class _RfsLiveOrdersViewState extends State<RfsLiveOrdersView> {
  String selectedStatus = "All";
  
  List<String> statusOptions = ["All", "Pending", "Preparing", "Ready", "Served"];
  
  List<Map<String, dynamic>> liveOrders = [
    {
      "orderNumber": "ORD-001",
      "tableNumber": "T-05",
      "customerName": "John Smith",
      "items": [
        {"name": "Grilled Salmon", "quantity": 2, "price": 28.99},
        {"name": "Caesar Salad", "quantity": 1, "price": 15.99},
        {"name": "Red Wine", "quantity": 1, "price": 12.99},
      ],
      "totalAmount": 86.96,
      "orderTime": "2024-01-15 12:30:00",
      "status": "Preparing",
      "estimatedTime": "15 min",
      "priority": "normal",
      "specialRequests": "No onions in salad",
    },
    {
      "orderNumber": "ORD-002",
      "tableNumber": "T-12",
      "customerName": "Sarah Johnson",
      "items": [
        {"name": "Beef Burger", "quantity": 1, "price": 22.99},
        {"name": "French Fries", "quantity": 1, "price": 8.99},
        {"name": "Coca Cola", "quantity": 2, "price": 4.99},
      ],
      "totalAmount": 41.96,
      "orderTime": "2024-01-15 12:45:00",
      "status": "Pending",
      "estimatedTime": "25 min",
      "priority": "urgent",
      "specialRequests": "",
    },
    {
      "orderNumber": "ORD-003",
      "tableNumber": "T-08",
      "customerName": "Mike Davis",
      "items": [
        {"name": "Chicken Alfredo", "quantity": 1, "price": 24.99},
        {"name": "Garlic Bread", "quantity": 1, "price": 6.99},
        {"name": "Water", "quantity": 2, "price": 0.00},
      ],
      "totalAmount": 31.98,
      "orderTime": "2024-01-15 13:00:00",
      "status": "Ready",
      "estimatedTime": "Ready now",
      "priority": "normal",
      "specialRequests": "Extra cheese",
    },
    {
      "orderNumber": "ORD-004",
      "tableNumber": "T-03",
      "customerName": "Emma Wilson",
      "items": [
        {"name": "Fish & Chips", "quantity": 2, "price": 19.99},
        {"name": "Coleslaw", "quantity": 1, "price": 5.99},
        {"name": "Beer", "quantity": 2, "price": 8.99},
      ],
      "totalAmount": 63.95,
      "orderTime": "2024-01-15 13:15:00",
      "status": "Preparing",
      "estimatedTime": "12 min",
      "priority": "normal",
      "specialRequests": "",
    },
  ];

  List<Map<String, dynamic>> get filteredOrders {
    if (selectedStatus == "All") return liveOrders;
    return liveOrders.where((order) => order["status"] == selectedStatus).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return warningColor;
      case "Preparing":
        return infoColor;
      case "Ready":
        return successColor;
      case "Served":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "urgent":
        return dangerColor;
      case "high":
        return warningColor;
      default:
        return primaryColor;
    }
  }

  void _updateOrderStatus(String orderNumber, String newStatus) {
    setState(() {
      int index = liveOrders.indexWhere((order) => order["orderNumber"] == orderNumber);
      if (index != -1) {
        liveOrders[index]["status"] = newStatus;
        if (newStatus == "Ready") {
          liveOrders[index]["estimatedTime"] = "Ready now";
        }
      }
    });
    ss("Order status updated to $newStatus");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Orders"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Row(
              children: [
                Icon(
                  Icons.filter_list,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QCategoryPicker(
                    items: statusOptions.map((status) => {
                      "label": status,
                      "value": status,
                    }).toList(),
                    value: selectedStatus,
                    onChanged: (index, label, value, item) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
          
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            color: primaryColor.withAlpha(10),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: primaryColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Text(
                  "${filteredOrders.length} active orders",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: successColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: spXs),
                Text(
                  "Live",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: successColor,
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: filteredOrders.length,
              itemBuilder: (context, index) {
                final order = filteredOrders[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: order["priority"] == "urgent"
                        ? Border.all(color: dangerColor, width: 2)
                        : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(order["status"]).withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${order["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getStatusColor(order["status"]),
                              ),
                            ),
                          ),
                          if (order["priority"] == "urgent") ...[
                            SizedBox(width: spXs),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: dangerColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "URGENT",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                            ),
                          ],
                          Spacer(),
                          Text(
                            "${order["orderNumber"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      
                      Row(
                        children: [
                          Icon(
                            Icons.table_restaurant,
                            color: primaryColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${order["tableNumber"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Icon(
                            Icons.person,
                            color: disabledBoldColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${order["customerName"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                          Text(
                            "${order["estimatedTime"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: order["status"] == "Ready" ? successColor : warningColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order Items:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            ...(order["items"] as List).map((item) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 2),
                                child: Row(
                                  children: [
                                    Text(
                                      "${item["quantity"]}x",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Expanded(
                                      child: Text(
                                        "${item["name"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "\$${((item["price"] as num).toDouble()).currency}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                      
                      if (order["specialRequests"].toString().isNotEmpty) ...[
                        SizedBox(height: spSm),
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.note,
                                color: warningColor,
                                size: 14,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${order["specialRequests"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: warningColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      SizedBox(height: spSm),
                      
                      Row(
                        children: [
                          Text(
                            "Total: \$${((order["totalAmount"] as num).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Spacer(),
                          if (order["status"] != "Served") ...[
                            QButton(
                              label: order["status"] == "Pending" 
                                  ? "Start" 
                                  : order["status"] == "Preparing" 
                                      ? "Ready" 
                                      : "Serve",
                              size: bs.sm,
                              onPressed: () {
                                String newStatus = "";
                                switch (order["status"]) {
                                  case "Pending":
                                    newStatus = "Preparing";
                                    break;
                                  case "Preparing":
                                    newStatus = "Ready";
                                    break;
                                  case "Ready":
                                    newStatus = "Served";
                                    break;
                                }
                                if (newStatus.isNotEmpty) {
                                  _updateOrderStatus(order["orderNumber"], newStatus);
                                }
                              },
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
