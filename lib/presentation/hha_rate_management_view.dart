import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaRateManagementView extends StatefulWidget {
  const HhaRateManagementView({super.key});

  @override
  State<HhaRateManagementView> createState() => _HhaRateManagementViewState();
}

class _HhaRateManagementViewState extends State<HhaRateManagementView> {
  String selectedRoomType = "All";
  String selectedDateRange = "This Week";

  List<Map<String, dynamic>> roomTypes = [
    {
      "id": "RT001",
      "name": "Standard Room",
      "category": "Standard",
      "baseRate": 120.0,
      "weekendRate": 150.0,
      "peakRate": 180.0,
      "minRate": 80.0,
      "maxRate": 250.0,
      "occupancyRate": 85.2,
      "totalRooms": 20,
      "availableRooms": 3,
      "avgDailyRate": 135.0,
      "revenue": 27000.0,
      "ratePlans": [
        {"name": "Best Available Rate", "rate": 120.0, "active": true},
        {"name": "Non-Refundable", "rate": 108.0, "active": true},
        {"name": "Early Bird", "rate": 102.0, "active": false},
      ],
    },
    {
      "id": "RT002",
      "name": "Deluxe Room",
      "category": "Deluxe",
      "baseRate": 180.0,
      "weekendRate": 220.0,
      "peakRate": 280.0,
      "minRate": 150.0,
      "maxRate": 350.0,
      "occupancyRate": 78.5,
      "totalRooms": 15,
      "availableRooms": 4,
      "avgDailyRate": 195.0,
      "revenue": 29250.0,
      "ratePlans": [
        {"name": "Best Available Rate", "rate": 180.0, "active": true},
        {"name": "Romance Package", "rate": 220.0, "active": true},
        {"name": "Business Rate", "rate": 162.0, "active": true},
      ],
    },
    {
      "id": "RT003",
      "name": "Executive Suite",
      "category": "Suite",
      "baseRate": 350.0,
      "weekendRate": 420.0,
      "peakRate": 500.0,
      "minRate": 280.0,
      "maxRate": 650.0,
      "occupancyRate": 65.0,
      "totalRooms": 8,
      "availableRooms": 3,
      "avgDailyRate": 385.0,
      "revenue": 30800.0,
      "ratePlans": [
        {"name": "Executive Rate", "rate": 350.0, "active": true},
        {"name": "Corporate Package", "rate": 315.0, "active": true},
        {"name": "VIP Experience", "rate": 450.0, "active": false},
      ],
    },
    {
      "id": "RT004",
      "name": "Presidential Suite",
      "category": "Luxury",
      "baseRate": 650.0,
      "weekendRate": 800.0,
      "peakRate": 1000.0,
      "minRate": 500.0,
      "maxRate": 1200.0,
      "occupancyRate": 45.0,
      "totalRooms": 2,
      "availableRooms": 1,
      "avgDailyRate": 720.0,
      "revenue": 14400.0,
      "ratePlans": [
        {"name": "Presidential Rate", "rate": 650.0, "active": true},
        {"name": "Luxury Package", "rate": 780.0, "active": true},
        {"name": "Exclusive Deal", "rate": 585.0, "active": false},
      ],
    },
  ];

  List<Map<String, dynamic>> get filteredRoomTypes {
    return roomTypes.where((room) {
      final matchesRoom = selectedRoomType == "All" || room["category"] == selectedRoomType;
      return matchesRoom;
    }).toList();
  }

  Color getCategoryColor(String category) {
    switch (category) {
      case "Standard":
        return infoColor;
      case "Deluxe":
        return primaryColor;
      case "Suite":
        return successColor;
      case "Luxury":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rate Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo('CreateRatePlanView')
            },
          ),
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              //navigateTo('CalendarRateView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Dashboard Stats
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
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.hotel, color: primaryColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Average Daily Rate",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${(roomTypes.fold(0.0, (sum, r) => sum + (r["avgDailyRate"] as double)) / roomTypes.length).toStringAsFixed(0)}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
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
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.trending_up, color: successColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Occupancy Rate",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${(roomTypes.fold(0.0, (sum, r) => sum + (r["occupancyRate"] as double)) / roomTypes.length).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
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
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.attach_money, color: infoColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Total Revenue",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${((roomTypes.fold(0.0, (sum, r) => sum + (r["revenue"] as double))) / 1000).toStringAsFixed(1)}K",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
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
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.room_preferences, color: warningColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Available Rooms",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${roomTypes.fold(0, (sum, r) => sum + (r["availableRooms"] as int))}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Room Category",
                    items: [
                      {"label": "All", "value": "All"},
                      {"label": "Standard", "value": "Standard"},
                      {"label": "Deluxe", "value": "Deluxe"},
                      {"label": "Suite", "value": "Suite"},
                      {"label": "Luxury", "value": "Luxury"},
                    ],
                    value: selectedRoomType,
                    onChanged: (value, label) {
                      selectedRoomType = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Date Range",
                    items: [
                      {"label": "This Week", "value": "This Week"},
                      {"label": "This Month", "value": "This Month"},
                      {"label": "Next 30 Days", "value": "Next 30 Days"},
                      {"label": "Custom", "value": "Custom"},
                    ],
                    value: selectedDateRange,
                    onChanged: (value, label) {
                      selectedDateRange = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Room Types List
            ...filteredRoomTypes.map((roomType) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      // Header
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${roomType["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: getCategoryColor(roomType["category"]).withAlpha(30),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${roomType["category"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: getCategoryColor(roomType["category"]),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "ID: ${roomType["id"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Occupancy",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${roomType["occupancyRate"]}%",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: roomType["occupancyRate"] > 80 ? successColor : warningColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Current Rates
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Text(
                              "Current Rates",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Base Rate",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${(roomType["baseRate"] as double).toStringAsFixed(0)}",
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
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Weekend Rate",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${(roomType["weekendRate"] as double).toStringAsFixed(0)}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: successColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Peak Rate",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${(roomType["peakRate"] as double).toStringAsFixed(0)}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: warningColor,
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

                      // Rate Range & Performance
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: disabledColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Rate Range",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "\$${(roomType["minRate"] as double).toStringAsFixed(0)} - \$${(roomType["maxRate"] as double).toStringAsFixed(0)}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Average Daily Rate",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "\$${(roomType["avgDailyRate"] as double).toStringAsFixed(0)}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: infoColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Inventory Status
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Rooms",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${roomType["totalRooms"]}",
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Available",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${roomType["availableRooms"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: roomType["availableRooms"] > 5 ? successColor : warningColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Revenue",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "\$${((roomType["revenue"] as double) / 1000).toStringAsFixed(1)}K",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Rate Plans
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Active Rate Plans",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          ...(roomType["ratePlans"] as List<Map<String, dynamic>>).map((plan) {
                            return Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: plan["active"] 
                                    ? successColor.withAlpha(20) 
                                    : disabledColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${plan["name"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: plan["active"] 
                                            ? successColor 
                                            : disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "\$${(plan["rate"] as double).toStringAsFixed(0)}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: plan["active"] 
                                          ? successColor 
                                          : disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Icon(
                                    plan["active"] ? Icons.check_circle : Icons.cancel,
                                    size: 16,
                                    color: plan["active"] ? successColor : disabledBoldColor,
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),

                      // Actions
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Edit Rates",
                              size: bs.sm,
                              onPressed: () {
                                //navigateTo('EditRatesView', arguments: roomType)
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Rate Plans",
                              size: bs.sm,
                              onPressed: () {
                                //navigateTo('RatePlansView', arguments: roomType)
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.calendar_month,
                            size: bs.sm,
                            onPressed: () {
                              //navigateTo('RateCalendarView', arguments: roomType)
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
