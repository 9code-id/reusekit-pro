import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsKitchenDisplayView extends StatefulWidget {
  const RfsKitchenDisplayView({super.key});

  @override
  State<RfsKitchenDisplayView> createState() => _RfsKitchenDisplayViewState();
}

class _RfsKitchenDisplayViewState extends State<RfsKitchenDisplayView> {
  String selectedStation = "All";
  
  List<String> kitchenStations = [
    "All", "Grill", "Salad", "Hot Kitchen", "Cold Kitchen", "Dessert", "Beverage"
  ];
  
  List<Map<String, dynamic>> kitchenOrders = [
    {
      "orderNumber": "ORD-001",
      "tableNumber": "T-05",
      "items": [
        {
          "name": "Grilled Salmon",
          "quantity": 2,
          "station": "Grill",
          "cookTime": "12 min",
          "status": "Cooking",
          "priority": "normal",
          "startTime": "12:35",
        },
        {
          "name": "Caesar Salad",
          "quantity": 1,
          "station": "Salad",
          "cookTime": "3 min",
          "status": "Ready",
          "priority": "normal",
          "startTime": "12:30",
        },
      ],
      "orderTime": "12:30",
      "totalItems": 3,
      "completedItems": 1,
      "priority": "normal",
    },
    {
      "orderNumber": "ORD-002",
      "tableNumber": "T-12",
      "items": [
        {
          "name": "Beef Burger",
          "quantity": 1,
          "station": "Grill",
          "cookTime": "8 min",
          "status": "Pending",
          "priority": "urgent",
          "startTime": "",
        },
        {
          "name": "French Fries",
          "quantity": 1,
          "station": "Hot Kitchen",
          "cookTime": "4 min",
          "status": "Cooking",
          "priority": "urgent",
          "startTime": "12:50",
        },
      ],
      "orderTime": "12:45",
      "totalItems": 2,
      "completedItems": 0,
      "priority": "urgent",
    },
    {
      "orderNumber": "ORD-003",
      "tableNumber": "T-08",
      "items": [
        {
          "name": "Chicken Alfredo",
          "quantity": 1,
          "station": "Hot Kitchen",
          "cookTime": "10 min",
          "status": "Ready",
          "priority": "normal",
          "startTime": "13:05",
        },
        {
          "name": "Garlic Bread",
          "quantity": 1,
          "station": "Hot Kitchen",
          "cookTime": "5 min",
          "status": "Ready",
          "priority": "normal",
          "startTime": "13:10",
        },
      ],
      "orderTime": "13:00",
      "totalItems": 2,
      "completedItems": 2,
      "priority": "normal",
    },
    {
      "orderNumber": "ORD-004",
      "tableNumber": "T-03",
      "items": [
        {
          "name": "Fish & Chips",
          "quantity": 2,
          "station": "Hot Kitchen",
          "cookTime": "12 min",
          "status": "Cooking",
          "priority": "normal",
          "startTime": "13:20",
        },
        {
          "name": "Coleslaw",
          "quantity": 1,
          "station": "Salad",
          "cookTime": "2 min",
          "status": "Pending",
          "priority": "normal",
          "startTime": "",
        },
      ],
      "orderTime": "13:15",
      "totalItems": 3,
      "completedItems": 0,
      "priority": "normal",
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    List<Map<String, dynamic>> allItems = [];
    
    for (var order in kitchenOrders) {
      for (var item in order["items"]) {
        Map<String, dynamic> kitchenItem = Map.from(item);
        kitchenItem["orderNumber"] = order["orderNumber"];
        kitchenItem["tableNumber"] = order["tableNumber"];
        kitchenItem["orderTime"] = order["orderTime"];
        kitchenItem["orderPriority"] = order["priority"];
        allItems.add(kitchenItem);
      }
    }
    
    if (selectedStation != "All") {
      allItems = allItems.where((item) => item["station"] == selectedStation).toList();
    }
    
    // Sort by priority and time
    allItems.sort((a, b) {
      if (a["priority"] == "urgent" && b["priority"] != "urgent") return -1;
      if (a["priority"] != "urgent" && b["priority"] == "urgent") return 1;
      if (a["status"] == "Pending" && b["status"] != "Pending") return -1;
      if (a["status"] != "Pending" && b["status"] == "Pending") return 1;
      return a["orderTime"].compareTo(b["orderTime"]);
    });
    
    return allItems;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return warningColor;
      case "Cooking":
        return infoColor;
      case "Ready":
        return successColor;
      default:
        return primaryColor;
    }
  }

  Color _getStationColor(String station) {
    switch (station) {
      case "Grill":
        return dangerColor;
      case "Salad":
        return successColor;
      case "Hot Kitchen":
        return warningColor;
      case "Cold Kitchen":
        return infoColor;
      case "Dessert":
        return Colors.purple;
      case "Beverage":
        return Colors.blue;
      default:
        return primaryColor;
    }
  }

  void _updateItemStatus(String orderNumber, String itemName, String newStatus) {
    setState(() {
      for (var order in kitchenOrders) {
        if (order["orderNumber"] == orderNumber) {
          for (var item in order["items"]) {
            if (item["name"] == itemName) {
              item["status"] = newStatus;
              if (newStatus == "Cooking") {
                item["startTime"] = DateTime.now().toString().substring(11, 16);
              }
              break;
            }
          }
          // Update completed count
          int completed = (order["items"] as List)
              .where((item) => item["status"] == "Ready").length;
          order["completedItems"] = completed;
          break;
        }
      }
    });
    ss("Item status updated to $newStatus");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kitchen Display"),
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
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.restaurant_menu,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QCategoryPicker(
                        items: kitchenStations.map((station) => {
                          "label": station,
                          "value": station,
                        }).toList(),
                        value: selectedStation,
                        onChanged: (index, label, value, item) {
                          selectedStation = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    _buildStationLegend("Pending", warningColor),
                    SizedBox(width: spSm),
                    _buildStationLegend("Cooking", infoColor),
                    SizedBox(width: spSm),
                    _buildStationLegend("Ready", successColor),
                  ],
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
                  Icons.timer,
                  color: primaryColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Text(
                  "${filteredItems.length} items in queue",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  DateTime.now().toString().substring(11, 16),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: ResponsiveGridView(
              padding: EdgeInsets.all(spMd),
              minItemWidth: 200,
              children: filteredItems.map((item) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: item["priority"] == "urgent"
                        ? Border.all(color: dangerColor, width: 2)
                        : Border.all(color: _getStatusColor(item["status"]), width: 1),
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
                              color: _getStationColor(item["station"]).withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${item["station"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: _getStationColor(item["station"]),
                              ),
                            ),
                          ),
                          Spacer(),
                          if (item["priority"] == "urgent")
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: dangerColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      
                      Row(
                        children: [
                          Text(
                            "${item["orderNumber"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${item["tableNumber"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      
                      Text(
                        "${item["quantity"]}x ${item["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(item["status"]).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              item["status"] == "Pending" 
                                  ? Icons.schedule
                                  : item["status"] == "Cooking"
                                      ? Icons.local_fire_department
                                      : Icons.check_circle,
                              size: 14,
                              color: _getStatusColor(item["status"]),
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${item["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getStatusColor(item["status"]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: spSm),
                      
                      Row(
                        children: [
                          Icon(
                            Icons.timer,
                            color: disabledBoldColor,
                            size: 14,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${item["cookTime"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          if (item["startTime"].toString().isNotEmpty)
                            Text(
                              "Started: ${item["startTime"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: item["status"] == "Pending" 
                              ? "Start Cooking"
                              : item["status"] == "Cooking"
                                  ? "Mark Ready"
                                  : "Complete",
                          size: bs.sm,
                          onPressed: item["status"] != "Ready" ? () {
                            String newStatus = "";
                            switch (item["status"]) {
                              case "Pending":
                                newStatus = "Cooking";
                                break;
                              case "Cooking":
                                newStatus = "Ready";
                                break;
                            }
                            if (newStatus.isNotEmpty) {
                              _updateItemStatus(
                                item["orderNumber"], 
                                item["name"], 
                                newStatus,
                              );
                            }
                          } : null,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStationLegend(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(width: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }
}
