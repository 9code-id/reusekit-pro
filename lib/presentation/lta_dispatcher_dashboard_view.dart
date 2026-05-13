import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaDispatcherDashboardView extends StatefulWidget {
  const LtaDispatcherDashboardView({super.key});

  @override
  State<LtaDispatcherDashboardView> createState() => _LtaDispatcherDashboardViewState();
}

class _LtaDispatcherDashboardViewState extends State<LtaDispatcherDashboardView> {
  int currentTab = 0;

  List<Map<String, dynamic>> pendingAssignments = [
    {
      "order_id": "ORD001234",
      "customer": "John Smith",
      "pickup": "Downtown Mall",
      "destination": "Sunset Avenue 123",
      "priority": "High",
      "created": "2024-12-15 09:30",
      "distance": "2.5 km",
      "package_type": "Electronics",
      "special_instructions": "Handle with care - fragile items",
    },
    {
      "order_id": "ORD001235",
      "customer": "Sarah Wilson",
      "pickup": "City Center",
      "destination": "Oak Street 456",
      "priority": "Medium",
      "created": "2024-12-15 08:15",
      "distance": "4.2 km",
      "package_type": "Documents",
      "special_instructions": "Deliver before 5 PM",
    },
    {
      "order_id": "ORD001236",
      "customer": "Mike Davis",
      "pickup": "Business District",
      "destination": "Pine Road 789",
      "priority": "Low",
      "created": "2024-12-15 07:45",
      "distance": "6.8 km",
      "package_type": "Clothing",
      "special_instructions": "No special requirements",
    },
  ];

  List<Map<String, dynamic>> availableDrivers = [
    {
      "id": "DRV001",
      "name": "Mike Johnson",
      "vehicle": "Motorcycle",
      "current_location": "Downtown",
      "status": "Available",
      "rating": 4.8,
      "deliveries_today": 6,
      "last_delivery": "10 min ago",
    },
    {
      "id": "DRV002",
      "name": "Lisa Garcia",
      "vehicle": "Van",
      "current_location": "City Center",
      "status": "Available",
      "rating": 4.9,
      "deliveries_today": 4,
      "last_delivery": "25 min ago",
    },
    {
      "id": "DRV003",
      "name": "David Brown",
      "vehicle": "Truck",
      "current_location": "Industrial Area",
      "status": "On Break",
      "rating": 4.7,
      "deliveries_today": 8,
      "last_delivery": "5 min ago",
    },
    {
      "id": "DRV004",
      "name": "Anna Martinez",
      "vehicle": "Bicycle",
      "current_location": "Downtown",
      "status": "Available",
      "rating": 4.6,
      "deliveries_today": 12,
      "last_delivery": "2 min ago",
    },
  ];

  List<Map<String, dynamic>> activeDeliveries = [
    {
      "order_id": "ORD001230",
      "driver": "Robert Wilson",
      "customer": "Emily Taylor",
      "status": "In Transit",
      "progress": 0.7,
      "eta": "15 min",
      "distance_remaining": "2.1 km",
    },
    {
      "order_id": "ORD001231",
      "driver": "Carlos Rodriguez",
      "customer": "James Anderson",
      "status": "At Pickup",
      "progress": 0.1,
      "eta": "45 min",
      "distance_remaining": "12.5 km",
    },
    {
      "order_id": "ORD001232",
      "driver": "Jennifer Lee",
      "customer": "Maria Garcia",
      "status": "Delivered",
      "progress": 1.0,
      "eta": "Completed",
      "distance_remaining": "0 km",
    },
  ];

  List<Map<String, dynamic>> dispatchStats = [
    {
      "title": "Pending Orders",
      "value": "23",
      "icon": Icons.pending_actions,
      "color": warningColor,
      "change": "+5",
    },
    {
      "title": "Active Deliveries",
      "value": "47",
      "icon": Icons.local_shipping,
      "color": infoColor,
      "change": "+12",
    },
    {
      "title": "Available Drivers",
      "value": "15",
      "icon": Icons.person,
      "color": successColor,
      "change": "-2",
    },
    {
      "title": "Completed Today",
      "value": "156",
      "icon": Icons.check_circle,
      "color": primaryColor,
      "change": "+28",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Dispatch Center",
      selectedIndex: currentTab,
      actions: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
          decoration: BoxDecoration(
            color: successColor.withAlpha(30),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: spXs,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: successColor,
                  shape: BoxShape.circle,
                ),
              ),
              Text(
                "LIVE",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: successColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: spSm),
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {},
        ),
      ],
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Assignments", icon: Icon(Icons.assignment)),
        Tab(text: "Drivers", icon: Icon(Icons.people)),
        Tab(text: "Live Tracking", icon: Icon(Icons.gps_fixed)),
      ],
      tabChildren: [
        // Overview Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Status Overview
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
                            "Dispatch Control Center",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Monitor and manage delivery operations in real-time",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                          Text(
                            "${pendingAssignments.length} orders pending assignment",
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
                        Icons.control_camera,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ),

              // Dispatch Statistics
              Text(
                "Dispatch Statistics",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: dispatchStats.map((stat) {
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
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: (stat["color"] as Color).withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                stat["icon"] as IconData,
                                color: stat["color"] as Color,
                                size: 20,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: (stat["change"].toString().startsWith('+')
                                        ? successColor
                                        : dangerColor)
                                    .withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${stat["change"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: stat["change"].toString().startsWith('+')
                                      ? successColor
                                      : dangerColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${stat["value"]}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${stat["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              // Urgent Assignments
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Urgent Assignments",
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
                children: pendingAssignments
                    .where((assignment) => assignment["priority"] == "High")
                    .map((assignment) {
                  return Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: dangerColor,
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
                              "${assignment["order_id"]} - HIGH PRIORITY",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: warningColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "PENDING",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: warningColor,
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
                                "Customer: ${assignment["customer"]}",
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
                                "From: ${assignment["pickup"]}",
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
                            Icon(Icons.flag, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "To: ${assignment["destination"]}",
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
                              "Distance: ${assignment["distance"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              spacing: spSm,
                              children: [
                                QButton(
                                  label: "Auto Assign",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                                QButton(
                                  label: "Manual Assign",
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

              // Active Deliveries Status
              Text(
                "Active Deliveries",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                spacing: spSm,
                children: activeDeliveries
                    .where((delivery) => delivery["status"] != "Delivered")
                    .map((delivery) {
                  Color statusColor = delivery["status"] == "At Pickup"
                      ? warningColor
                      : delivery["status"] == "In Transit"
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
                            Text(
                              "${delivery["order_id"]}",
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
                                "${delivery["status"]}",
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Text(
                                  "Driver: ${delivery["driver"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Customer: ${delivery["customer"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              spacing: spXs,
                              children: [
                                Text(
                                  "ETA: ${delivery["eta"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: statusColor,
                                  ),
                                ),
                                Text(
                                  "${delivery["distance_remaining"]} remaining",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
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
                                  "${((delivery["progress"] as double) * 100).toInt()}%",
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
                                widthFactor: delivery["progress"] as double,
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
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),

        // Assignments Tab
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
                    "Pending Assignments",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      QButton(
                        label: "Auto Assign All",
                        icon: Icons.auto_mode,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                      QButton(
                        label: "Refresh",
                        icon: Icons.refresh,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
              // Assignment management interface would go here
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Text(
                  "Detailed assignment management interface will be displayed here",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Drivers Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Driver Status",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                spacing: spSm,
                children: availableDrivers.map((driver) {
                  Color statusColor = driver["status"] == "Available"
                      ? successColor
                      : driver["status"] == "On Break"
                          ? warningColor
                          : infoColor;

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
                                  "${driver["name"]} (${driver["id"]})",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  spacing: spSm,
                                  children: [
                                    Text(
                                      "${driver["vehicle"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Container(
                                      width: 4,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: disabledBoldColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Row(
                                      spacing: spXs,
                                      children: [
                                        Icon(Icons.star, size: 12, color: warningColor),
                                        Text(
                                          "${driver["rating"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
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
                                "${driver["status"]}",
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Text(
                                  "Location: ${driver["current_location"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Deliveries today: ${driver["deliveries_today"]}",
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
                                Text(
                                  "Last delivery:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${driver["last_delivery"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (driver["status"] == "Available")
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            spacing: spSm,
                            children: [
                              QButton(
                                label: "Assign Order",
                                size: bs.sm,
                                onPressed: () {},
                              ),
                              QButton(
                                icon: Icons.message,
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
            ],
          ),
        ),

        // Live Tracking Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Live Tracking",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Live tracking map and interface would go here
              Container(
                height: 300,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: spSm,
                    children: [
                      Icon(
                        Icons.map,
                        size: 48,
                        color: primaryColor,
                      ),
                      Text(
                        "Live Tracking Map",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Real-time driver and delivery tracking interface",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
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
