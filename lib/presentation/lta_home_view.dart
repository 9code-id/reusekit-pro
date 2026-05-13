import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaHomeView extends StatefulWidget {
  const LtaHomeView({super.key});

  @override
  State<LtaHomeView> createState() => _LtaHomeViewState();
}

class _LtaHomeViewState extends State<LtaHomeView> {
  List<Map<String, dynamic>> quickActions = [
    {
      "title": "Book Shipment",
      "subtitle": "Send packages anywhere",
      "icon": Icons.local_shipping,
      "color": primaryColor,
    },
    {
      "title": "Track Package",
      "subtitle": "Monitor your shipments",
      "icon": Icons.gps_fixed,
      "color": infoColor,
    },
    {
      "title": "Schedule Pickup",
      "subtitle": "Book pickup service",
      "icon": Icons.schedule,
      "color": warningColor,
    },
    {
      "title": "Price Calculator",
      "subtitle": "Estimate shipping cost",
      "icon": Icons.calculate,
      "color": successColor,
    },
  ];

  List<Map<String, dynamic>> recentShipments = [
    {
      "tracking_id": "LTA001234567",
      "recipient": "John Smith",
      "destination": "New York, NY",
      "status": "In Transit",
      "date": "2024-12-15",
      "color": infoColor,
    },
    {
      "tracking_id": "LTA001234568",
      "recipient": "Sarah Johnson",
      "destination": "Los Angeles, CA",
      "status": "Delivered",
      "date": "2024-12-14",
      "color": successColor,
    },
    {
      "tracking_id": "LTA001234569",
      "recipient": "Mike Wilson",
      "destination": "Chicago, IL",
      "status": "Processing",
      "date": "2024-12-13",
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> services = [
    {
      "name": "Express Delivery",
      "description": "Same-day delivery service",
      "price": "25.99",
      "icon": Icons.flash_on,
    },
    {
      "name": "Standard Shipping",
      "description": "2-3 business days",
      "price": "12.99",
      "icon": Icons.schedule_send,
    },
    {
      "name": "Economy Shipping",
      "description": "5-7 business days",
      "price": "7.99",
      "icon": Icons.eco,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LTA Logistics"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Welcome Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "Welcome Back!",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Track, send and manage your shipments efficiently",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Icon(
                      Icons.local_shipping,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ],
              ),
            ),

            // Quick Actions
            Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: quickActions.map((action) {
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
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (action["color"] as Color).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          action["icon"] as IconData,
                          color: action["color"] as Color,
                          size: 24,
                        ),
                      ),
                      Text(
                        "${action["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${action["subtitle"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      QButton(
                        label: "Get Started",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Recent Shipments
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent Shipments",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "View All",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              spacing: spSm,
              children: recentShipments.map((shipment) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: shipment["color"] as Color,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tracking ID: ${shipment["tracking_id"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: (shipment["color"] as Color).withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${shipment["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: shipment["color"] as Color,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "To: ${shipment["recipient"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${shipment["destination"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                          Text(
                            "${shipment["date"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          QButton(
                            label: "Track",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            label: "Details",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Services Overview
            Text(
              "Our Services",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            QHorizontalScroll(
              children: services.map((service) {
                return Container(
                  width: 200,
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
                      Icon(
                        service["icon"] as IconData,
                        color: primaryColor,
                        size: 32,
                      ),
                      Text(
                        "${service["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${service["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Starting from \$${service["price"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Select",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
