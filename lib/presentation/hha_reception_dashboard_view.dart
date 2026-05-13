import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaReceptionDashboardView extends StatefulWidget {
  const HhaReceptionDashboardView({super.key});

  @override
  State<HhaReceptionDashboardView> createState() => _HhaReceptionDashboardViewState();
}

class _HhaReceptionDashboardViewState extends State<HhaReceptionDashboardView> {
  int currentTab = 0;

  // Reception Stats
  List<Map<String, dynamic>> receptionStats = [
    {
      "title": "Check-ins Today",
      "value": "24",
      "subtitle": "3 pending",
      "icon": Icons.login,
      "color": Colors.green,
    },
    {
      "title": "Check-outs Today", 
      "value": "18",
      "subtitle": "2 pending",
      "icon": Icons.logout,
      "color": Colors.blue,
    },
    {
      "title": "Reservations",
      "value": "156",
      "subtitle": "Next 7 days",
      "icon": Icons.book_online,
      "color": Colors.orange,
    },
    {
      "title": "Walk-ins",
      "value": "7",
      "subtitle": "Today",
      "icon": Icons.directions_walk,
      "color": Colors.purple,
    },
  ];

  List<Map<String, dynamic>> todayArrivals = [
    {
      "guest": "Mr. John Smith",
      "room": "205",
      "checkIn": "2:00 PM",
      "status": "confirmed",
      "nights": 3,
      "roomType": "Deluxe Suite",
    },
    {
      "guest": "Mrs. Sarah Johnson",
      "room": "314",
      "checkIn": "3:30 PM", 
      "status": "pending",
      "nights": 2,
      "roomType": "Standard Room",
    },
    {
      "guest": "Mr. David Wilson",
      "room": "101",
      "checkIn": "4:00 PM",
      "status": "confirmed",
      "nights": 5,
      "roomType": "Presidential Suite",
    },
  ];

  List<Map<String, dynamic>> todayDepartures = [
    {
      "guest": "Ms. Emily Davis",
      "room": "407",
      "checkOut": "11:00 AM",
      "status": "completed",
      "bill": 450.00,
    },
    {
      "guest": "Mr. Robert Brown",
      "room": "302",
      "checkOut": "12:00 PM",
      "status": "pending",
      "bill": 280.00,
    },
    {
      "guest": "Mrs. Lisa Anderson",
      "room": "256",
      "checkOut": "12:30 PM",
      "status": "processing",
      "bill": 320.00,
    },
  ];

  List<Map<String, dynamic>> guestMessages = [
    {
      "room": "205",
      "guest": "Mr. Smith",
      "message": "Requesting late checkout",
      "time": "10:15 AM",
      "priority": "normal",
      "replied": false,
    },
    {
      "room": "314", 
      "guest": "Mrs. Johnson",
      "message": "Need extra towels",
      "time": "11:30 AM",
      "priority": "low",
      "replied": true,
    },
    {
      "room": "101",
      "guest": "Mr. Wilson",
      "message": "Restaurant reservation for 8 PM",
      "time": "1:45 PM",
      "priority": "normal",
      "replied": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Reception Dashboard",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)), 
        Tab(text: "Arrivals", icon: Icon(Icons.login)),
        Tab(text: "Departures", icon: Icon(Icons.logout)),
        Tab(text: "Messages", icon: Icon(Icons.message)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildArrivalsTab(),
        _buildDeparturesTab(),
        _buildMessagesTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(200)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Reception Desk",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Welcome guests and manage their experience",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(220),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    Icons.hotel,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ],
            ),
          ),

          // Daily Stats
          Text(
            "Today's Activity",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: receptionStats.map((stat) {
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
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (stat["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            stat["icon"],
                            color: stat["color"],
                            size: 24,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${stat["value"]}",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${stat["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${stat["subtitle"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          // Quick Actions
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildQuickActionCard(
                "Walk-in Check-in",
                "Register new walk-in guests",
                Icons.person_add,
                Colors.green,
              ),
              _buildQuickActionCard(
                "Room Status",
                "View and update room status",
                Icons.hotel,
                Colors.blue,
              ),
              _buildQuickActionCard(
                "Billing",
                "Manage guest billing",
                Icons.receipt,
                Colors.orange,
              ),
              _buildQuickActionCard(
                "Key Cards",
                "Issue and manage key cards",
                Icons.key,
                Colors.purple,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(String title, String description, IconData icon, Color color) {
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
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Open",
              size: bs.sm,
              onPressed: () {
                si("$title module opened");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArrivalsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Today's Arrivals",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${todayArrivals.length} guests",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          ...todayArrivals.map((arrival) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: arrival["status"] == "confirmed"
                        ? successColor
                        : warningColor,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${arrival["guest"]}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${arrival["roomType"]} - Room ${arrival["room"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: arrival["status"] == "confirmed"
                              ? successColor.withAlpha(20)
                              : warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${arrival["status"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: arrival["status"] == "confirmed"
                                ? successColor
                                : warningColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Check-in: ${arrival["checkIn"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Icon(
                        Icons.hotel,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${arrival["nights"]} nights",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: arrival["status"] == "pending" ? "Check In" : "View Details",
                          size: bs.sm,
                          onPressed: () {
                            ss("${arrival["guest"]} checked in successfully");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.key,
                        size: bs.sm,
                        onPressed: () {
                          si("Key card issued for room ${arrival["room"]}");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildDeparturesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Today's Departures",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${todayDepartures.length} guests",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          ...todayDepartures.map((departure) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: departure["status"] == "completed"
                        ? successColor
                        : departure["status"] == "processing"
                            ? warningColor
                            : primaryColor,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${departure["guest"]}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Room ${departure["room"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: departure["status"] == "completed"
                                  ? successColor.withAlpha(20)
                                  : departure["status"] == "processing"
                                      ? warningColor.withAlpha(20)
                                      : primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${departure["status"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: departure["status"] == "completed"
                                    ? successColor
                                    : departure["status"] == "processing"
                                        ? warningColor
                                        : primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "\$${((departure["bill"] as double).toDouble()).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Check-out: ${departure["checkOut"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: departure["status"] == "completed" ? "Print Receipt" : "Process Payment",
                          size: bs.sm,
                          onPressed: () {
                            ss("Payment processed for ${departure["guest"]}");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.receipt,
                        size: bs.sm,
                        onPressed: () {
                          si("Bill generated for room ${departure["room"]}");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildMessagesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Guest Messages",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${guestMessages.where((msg) => !msg["replied"]).length} unread",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: dangerColor,
                  ),
                ),
              ),
            ],
          ),
          ...guestMessages.map((message) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: message["replied"]
                        ? successColor
                        : message["priority"] == "high"
                            ? dangerColor
                            : primaryColor,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Room ${message["room"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${message["guest"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      if (!message["replied"])
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
                  Text(
                    "${message["message"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${message["time"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      if (message["replied"])
                        Text(
                          "REPLIED",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                    ],
                  ),
                  if (!message["replied"])
                    Column(
                      children: [
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "Reply",
                                size: bs.sm,
                                onPressed: () {
                                  ss("Reply sent to ${message["guest"]}");
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              icon: Icons.call,
                              size: bs.sm,
                              onPressed: () {
                                si("Calling room ${message["room"]}");
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
