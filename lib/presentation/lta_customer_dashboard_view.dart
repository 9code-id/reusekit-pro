import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaCustomerDashboardView extends StatefulWidget {
  const LtaCustomerDashboardView({super.key});

  @override
  State<LtaCustomerDashboardView> createState() => _LtaCustomerDashboardViewState();
}

class _LtaCustomerDashboardViewState extends State<LtaCustomerDashboardView> {
  int currentTab = 0;

  List<Map<String, dynamic>> quickActions = [
    {
      "title": "New Shipment",
      "subtitle": "Send a package",
      "icon": Icons.add_box,
      "color": primaryColor,
    },
    {
      "title": "Track Package",
      "subtitle": "Find your shipment",
      "icon": Icons.search,
      "color": infoColor,
    },
    {
      "title": "Schedule Pickup",
      "subtitle": "Book pickup service",
      "icon": Icons.schedule,
      "color": warningColor,
    },
    {
      "title": "Price Quote",
      "subtitle": "Calculate shipping cost",
      "icon": Icons.calculate,
      "color": successColor,
    },
  ];

  List<Map<String, dynamic>> activeShipments = [
    {
      "tracking_id": "LTA001234567",
      "recipient": "John Smith",
      "destination": "New York, NY",
      "status": "In Transit",
      "created": "2024-12-15",
      "estimated_delivery": "2024-12-17",
      "progress": 0.7,
      "priority": "Express",
      "amount": 45.50,
    },
    {
      "tracking_id": "LTA001234568",
      "recipient": "Sarah Johnson",
      "destination": "Los Angeles, CA",
      "status": "Processing",
      "created": "2024-12-14",
      "estimated_delivery": "2024-12-19",
      "progress": 0.2,
      "priority": "Standard",
      "amount": 28.75,
    },
    {
      "tracking_id": "LTA001234569",
      "recipient": "Mike Wilson",
      "destination": "Chicago, IL",
      "status": "Delivered",
      "created": "2024-12-13",
      "estimated_delivery": "2024-12-16",
      "progress": 1.0,
      "priority": "Economy",
      "amount": 19.99,
    },
  ];

  List<Map<String, dynamic>> recentAddresses = [
    {
      "name": "Home",
      "address": "123 Main Street, Anytown, ST 12345",
      "type": "Residential",
      "is_default": true,
    },
    {
      "name": "Office",
      "address": "456 Business Ave, Corporate City, ST 67890",
      "type": "Commercial",
      "is_default": false,
    },
    {
      "name": "Mom's House",
      "address": "789 Family Lane, Hometown, ST 54321",
      "type": "Residential",
      "is_default": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "My Shipments",
      selectedIndex: currentTab,
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
      tabs: [
        Tab(text: "Dashboard", icon: Icon(Icons.dashboard)),
        Tab(text: "Shipments", icon: Icon(Icons.local_shipping)),
        Tab(text: "Addresses", icon: Icon(Icons.location_on)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        // Dashboard Tab
        SingleChildScrollView(
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
                            "Welcome back!",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Manage your shipments and track deliveries",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                          Text(
                            "You have ${activeShipments.where((s) => s["status"] != "Delivered").length} active shipments",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withAlpha(180),
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
                        Icons.dashboard,
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
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Start",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              // Active Shipments Preview
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Active Shipments",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentTab = 1;
                      });
                    },
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
                children: activeShipments
                    .where((shipment) => shipment["status"] != "Delivered")
                    .map((shipment) {
                  Color statusColor = shipment["status"] == "Processing"
                      ? warningColor
                      : shipment["status"] == "In Transit"
                          ? infoColor
                          : successColor;

                  return Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: statusColor,
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
                              "${shipment["tracking_id"]}",
                              style: TextStyle(
                                fontSize: 16,
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
                                color: statusColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${shipment["status"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: statusColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.person, size: 16, color: disabledBoldColor),
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
                            Icon(Icons.location_on, size: 16, color: disabledBoldColor),
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
                          ],
                        ),
                        // Progress Bar
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Progress",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${((shipment["progress"] as double) * 100).toInt()}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: statusColor,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: disabledColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: FractionallySizedBox(
                                widthFactor: shipment["progress"] as double,
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: statusColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "ETA: ${shipment["estimated_delivery"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              spacing: spSm,
                              children: [
                                QButton(
                                  label: "Track",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                                QButton(
                                  label: "Details",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),

        // Shipments Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "All Shipments",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      QButton(
                        label: "Filter",
                        icon: Icons.filter_list,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                      QButton(
                        label: "New Shipment",
                        icon: Icons.add,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                spacing: spSm,
                children: activeShipments.map((shipment) {
                  Color statusColor = shipment["status"] == "Processing"
                      ? warningColor
                      : shipment["status"] == "In Transit"
                          ? infoColor
                          : successColor;

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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Text(
                                  "${shipment["tracking_id"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${shipment["priority"]} Service",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              spacing: spXs,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: statusColor.withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${shipment["status"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: statusColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "\$${(shipment["amount"] as double).toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.person, size: 16, color: disabledBoldColor),
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
                            Icon(Icons.location_on, size: 16, color: disabledBoldColor),
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
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Created: ${shipment["created"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              spacing: spSm,
                              children: [
                                QButton(
                                  icon: Icons.visibility,
                                  size: bs.sm,
                                  onPressed: () {},
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
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),

        // Addresses Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Saved Addresses",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  QButton(
                    label: "Add Address",
                    icon: Icons.add,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
              Column(
                spacing: spSm,
                children: recentAddresses.map((address) {
                  return Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: address["is_default"] as bool
                          ? Border.all(color: primaryColor, width: 2)
                          : null,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              spacing: spSm,
                              children: [
                                Text(
                                  "${address["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (address["is_default"] as bool)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(30),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "DEFAULT",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            QButton(
                              icon: Icons.more_vert,
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ],
                        ),
                        Text(
                          "${address["address"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${address["type"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              spacing: spSm,
                              children: [
                                QButton(
                                  label: "Edit",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                                QButton(
                                  label: "Use",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),

        // History Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Shipment History",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // History content would go here
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Text(
                  "Complete shipment history will be displayed here",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
