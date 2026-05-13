import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaKitchenDisplayView extends StatefulWidget {
  const FmaKitchenDisplayView({super.key});

  @override
  State<FmaKitchenDisplayView> createState() => _FmaKitchenDisplayViewState();
}

class _FmaKitchenDisplayViewState extends State<FmaKitchenDisplayView> {
  int currentTab = 0;
  String selectedStation = "All";
  String selectedPriority = "All";

  List<Map<String, dynamic>> stationItems = [
    {"label": "All Stations", "value": "All"},
    {"label": "Grill Station", "value": "Grill"},
    {"label": "Salad Station", "value": "Salad"},
    {"label": "Pizza Station", "value": "Pizza"},
    {"label": "Dessert Station", "value": "Dessert"},
    {"label": "Beverage Station", "value": "Beverage"},
  ];

  List<Map<String, dynamic>> priorityItems = [
    {"label": "All Priority", "value": "All"},
    {"label": "High Priority", "value": "High"},
    {"label": "Normal Priority", "value": "Normal"},
    {"label": "Low Priority", "value": "Low"},
  ];

  List<Map<String, dynamic>> activeOrders = [
    {
      "id": "KDS001",
      "orderNumber": "ORD-2024-0156",
      "table": "Table 12",
      "server": "Sarah J.",
      "orderTime": "14:35",
      "elapsedTime": "12 min",
      "priority": "High",
      "status": "In Progress",
      "station": "Grill",
      "items": [
        {"name": "Grilled Salmon", "quantity": 2, "notes": "Medium rare, no sauce", "station": "Grill", "status": "Cooking"},
        {"name": "Caesar Salad", "quantity": 1, "notes": "Extra croutons", "station": "Salad", "status": "Ready"},
        {"name": "Garlic Bread", "quantity": 1, "notes": "", "station": "Grill", "status": "Pending"},
      ]
    },
    {
      "id": "KDS002",
      "orderNumber": "ORD-2024-0157",
      "table": "Table 8",
      "server": "Mike D.",
      "orderTime": "14:40",
      "elapsedTime": "7 min",
      "priority": "Normal",
      "status": "New",
      "station": "Pizza",
      "items": [
        {"name": "Margherita Pizza", "quantity": 1, "notes": "Extra cheese", "station": "Pizza", "status": "Pending"},
        {"name": "Buffalo Wings", "quantity": 1, "notes": "Extra spicy", "station": "Grill", "status": "Pending"},
      ]
    },
    {
      "id": "KDS003",
      "orderNumber": "ORD-2024-0158",
      "table": "Table 5",
      "server": "Lisa W.",
      "orderTime": "14:25",
      "elapsedTime": "22 min",
      "priority": "High",
      "status": "Ready",
      "station": "Dessert",
      "items": [
        {"name": "Chocolate Cake", "quantity": 2, "notes": "Birthday candles", "station": "Dessert", "status": "Ready"},
        {"name": "Coffee", "quantity": 2, "notes": "Decaf", "station": "Beverage", "status": "Ready"},
      ]
    },
  ];

  List<Map<String, dynamic>> kitchenStats = [
    {"station": "Grill", "activeOrders": 8, "avgTime": "15 min", "efficiency": 92},
    {"station": "Salad", "activeOrders": 3, "avgTime": "8 min", "efficiency": 98},
    {"station": "Pizza", "activeOrders": 5, "avgTime": "12 min", "efficiency": 89},
    {"station": "Dessert", "activeOrders": 2, "avgTime": "6 min", "efficiency": 95},
    {"station": "Beverage", "activeOrders": 1, "avgTime": "3 min", "efficiency": 99},
  ];

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Normal":
        return successColor;
      case "Low":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "New":
        return infoColor;
      case "In Progress":
        return warningColor;
      case "Ready":
        return successColor;
      case "Served":
        return primaryColor;
      case "Delayed":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getItemStatusColor(String status) {
    switch (status) {
      case "Pending":
        return warningColor;
      case "Cooking":
        return infoColor;
      case "Ready":
        return successColor;
      case "Served":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    int elapsedMinutes = int.parse(order["elapsedTime"].toString().split(' ')[0]);
    Color timeColor = elapsedMinutes > 20 ? dangerColor : 
                     elapsedMinutes > 15 ? warningColor : 
                     successColor;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border.all(
          color: _getPriorityColor("${order["priority"]}"),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Header
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: _getPriorityColor("${order["priority"]}").withAlpha(10),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusSm),
                topRight: Radius.circular(radiusSm),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${order["orderNumber"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${order["table"]} • ${order["server"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                  decoration: BoxDecoration(
                    color: timeColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${order["elapsedTime"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: timeColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: spXs),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor("${order["status"]}").withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${order["status"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: _getStatusColor("${order["status"]}"),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Order Items
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              spacing: spXs,
              children: (order["items"] as List).map<Widget>((item) => Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: _getItemStatusColor("${item["status"]}").withAlpha(5),
                  borderRadius: BorderRadius.circular(radiusXs),
                  border: Border.all(
                    color: _getItemStatusColor("${item["status"]}").withAlpha(30),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: _getItemStatusColor("${item["status"]}").withAlpha(20),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          "${item["quantity"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: _getItemStatusColor("${item["status"]}"),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${item["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          if (item["notes"].toString().isNotEmpty)
                            Text(
                              "${item["notes"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${item["station"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    if (item["status"] == "Pending")
                      GestureDetector(
                        onTap: () {
                          // Start cooking
                        },
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            Icons.play_arrow,
                            size: 16,
                            color: successColor,
                          ),
                        ),
                      )
                    else if (item["status"] == "Cooking")
                      GestureDetector(
                        onTap: () {
                          // Mark ready
                        },
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            Icons.check,
                            size: 16,
                            color: primaryColor,
                          ),
                        ),
                      )
                    else if (item["status"] == "Ready")
                      Icon(
                        Icons.check_circle,
                        size: 16,
                        color: successColor,
                      ),
                  ],
                ),
              )).toList(),
            ),
          ),

          // Action Buttons
          if (order["status"] != "Ready" && order["status"] != "Served")
            Container(
              padding: EdgeInsets.all(spSm),
              child: Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QButton(
                      label: order["status"] == "New" ? "Start Order" : "Complete",
                      size: bs.sm,
                      onPressed: () {
                        // Update order status
                      },
                    ),
                  ),
                  QButton(
                    icon: Icons.more_vert,
                    size: bs.sm,
                    onPressed: () {
                      // Show options
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStationCard(Map<String, dynamic> station) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _getStationIcon("${station["station"]}"),
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${station["station"]} Station",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getEfficiencyColor(station["efficiency"] as int).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${station["efficiency"]}%",
                  style: TextStyle(
                    fontSize: 12,
                    color: _getEfficiencyColor(station["efficiency"] as int),
                    fontWeight: FontWeight.bold,
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
                      "Active Orders",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${station["activeOrders"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
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
                      "Avg Time",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${station["avgTime"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getStationIcon(String station) {
    switch (station) {
      case "Grill":
        return Icons.outdoor_grill;
      case "Salad":
        return Icons.eco;
      case "Pizza":
        return Icons.local_pizza;
      case "Dessert":
        return Icons.cake;
      case "Beverage":
        return Icons.local_drink;
      default:
        return Icons.restaurant;
    }
  }

  Color _getEfficiencyColor(int efficiency) {
    if (efficiency >= 95) return successColor;
    if (efficiency >= 85) return warningColor;
    return dangerColor;
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Kitchen Display",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Active Orders", icon: Icon(Icons.restaurant)),
        Tab(text: "All Orders", icon: Icon(Icons.list)),
        Tab(text: "Stations", icon: Icon(Icons.kitchen)),
        Tab(text: "Performance", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        // Active Orders Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Quick Stats
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: warningColor.withAlpha(50)),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.pending, color: warningColor, size: 24),
                          SizedBox(height: spXs),
                          Text(
                            "18",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                          Text(
                            "Active Orders",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: successColor.withAlpha(50)),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.timer, color: successColor, size: 24),
                          SizedBox(height: spXs),
                          Text(
                            "12 min",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Avg Time",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Text(
                "Active Orders",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              ...activeOrders.map((order) => _buildOrderCard(order)),
            ],
          ),
        ),

        // All Orders Tab
        Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              color: Colors.white,
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Station",
                          items: stationItems,
                          value: selectedStation,
                          onChanged: (value, label) {
                            selectedStation = value;
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
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  children: activeOrders.map((order) => _buildOrderCard(order)).toList(),
                ),
              ),
            ),
          ],
        ),

        // Stations Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Kitchen Stations",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              ...kitchenStats.map((station) => Container(
                margin: EdgeInsets.only(bottom: spSm),
                child: _buildStationCard(station),
              )),
            ],
          ),
        ),

        // Performance Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Performance Overview
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.speed, color: primaryColor, size: 28),
                          SizedBox(height: spXs),
                          Text(
                            "92%",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Overall Efficiency",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.restaurant_menu, color: successColor, size: 28),
                          SizedBox(height: spXs),
                          Text(
                            "247",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Orders Completed",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Station Performance
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Station Performance",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...kitchenStats.map((station) => Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _getStationIcon("${station["station"]}"),
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${station["station"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Text(
                            "${station["avgTime"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getEfficiencyColor(station["efficiency"] as int).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${station["efficiency"]}%",
                              style: TextStyle(
                                fontSize: 11,
                                color: _getEfficiencyColor(station["efficiency"] as int),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),

              // Time Analysis
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Time Analysis",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "< 10 min",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Fast Orders",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "156 (63%)",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "10-20 min",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Normal Orders",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "78 (32%)",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "> 20 min",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                              Text(
                                "Delayed Orders",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "13 (5%)",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: dangerColor,
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
            ],
          ),
        ),
      ],
    );
  }
}
