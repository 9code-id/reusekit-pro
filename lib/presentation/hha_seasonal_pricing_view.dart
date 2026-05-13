import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaSeasonalPricingView extends StatefulWidget {
  const HhaSeasonalPricingView({super.key});

  @override
  State<HhaSeasonalPricingView> createState() => _HhaSeasonalPricingViewState();
}

class _HhaSeasonalPricingViewState extends State<HhaSeasonalPricingView> {
  String selectedSeason = "All";
  String selectedRoom = "All";

  List<Map<String, dynamic>> seasonalPricing = [
    {
      "id": "SP001",
      "seasonName": "Summer Peak",
      "startDate": "2024-06-01",
      "endDate": "2024-08-31",
      "status": "Active",
      "priority": "High",
      "description": "Peak summer vacation season with highest demand",
      "baseMultiplier": 1.5,
      "weekendMultiplier": 1.8,
      "minimumStay": 3,
      "advanceBookingDays": 30,
      "roomRates": [
        {"roomType": "Standard Room", "baseRate": 120.0, "seasonalRate": 180.0, "increase": 50.0},
        {"roomType": "Deluxe Room", "baseRate": 180.0, "seasonalRate": 270.0, "increase": 50.0},
        {"roomType": "Executive Suite", "baseRate": 350.0, "seasonalRate": 525.0, "increase": 50.0},
        {"roomType": "Presidential Suite", "baseRate": 650.0, "seasonalRate": 975.0, "increase": 50.0},
      ],
      "totalBookings": 156,
      "totalRevenue": 98500.0,
      "occupancyRate": 92.5,
    },
    {
      "id": "SP002",
      "seasonName": "Holiday Special",
      "startDate": "2024-12-20",
      "endDate": "2025-01-05",
      "status": "Scheduled",
      "priority": "High",
      "description": "Christmas and New Year holiday premium pricing",
      "baseMultiplier": 2.0,
      "weekendMultiplier": 2.2,
      "minimumStay": 2,
      "advanceBookingDays": 60,
      "roomRates": [
        {"roomType": "Standard Room", "baseRate": 120.0, "seasonalRate": 240.0, "increase": 100.0},
        {"roomType": "Deluxe Room", "baseRate": 180.0, "seasonalRate": 360.0, "increase": 100.0},
        {"roomType": "Executive Suite", "baseRate": 350.0, "seasonalRate": 700.0, "increase": 100.0},
        {"roomType": "Presidential Suite", "baseRate": 650.0, "seasonalRate": 1300.0, "increase": 100.0},
      ],
      "totalBookings": 0,
      "totalRevenue": 0.0,
      "occupancyRate": 0.0,
    },
    {
      "id": "SP003",
      "seasonName": "Spring Break",
      "startDate": "2024-03-15",
      "endDate": "2024-04-15",
      "status": "Completed",
      "priority": "Medium",
      "description": "Spring break season with moderate price increase",
      "baseMultiplier": 1.3,
      "weekendMultiplier": 1.5,
      "minimumStay": 2,
      "advanceBookingDays": 21,
      "roomRates": [
        {"roomType": "Standard Room", "baseRate": 120.0, "seasonalRate": 156.0, "increase": 30.0},
        {"roomType": "Deluxe Room", "baseRate": 180.0, "seasonalRate": 234.0, "increase": 30.0},
        {"roomType": "Executive Suite", "baseRate": 350.0, "seasonalRate": 455.0, "increase": 30.0},
        {"roomType": "Presidential Suite", "baseRate": 650.0, "seasonalRate": 845.0, "increase": 30.0},
      ],
      "totalBookings": 89,
      "totalRevenue": 45600.0,
      "occupancyRate": 78.5,
    },
    {
      "id": "SP004",
      "seasonName": "Off-Season Discount",
      "startDate": "2024-09-01",
      "endDate": "2024-11-30",
      "status": "Scheduled",
      "priority": "Low",
      "description": "Reduced rates to attract bookings during slower period",
      "baseMultiplier": 0.8,
      "weekendMultiplier": 0.9,
      "minimumStay": 1,
      "advanceBookingDays": 7,
      "roomRates": [
        {"roomType": "Standard Room", "baseRate": 120.0, "seasonalRate": 96.0, "increase": -20.0},
        {"roomType": "Deluxe Room", "baseRate": 180.0, "seasonalRate": 144.0, "increase": -20.0},
        {"roomType": "Executive Suite", "baseRate": 350.0, "seasonalRate": 280.0, "increase": -20.0},
        {"roomType": "Presidential Suite", "baseRate": 650.0, "seasonalRate": 520.0, "increase": -20.0},
      ],
      "totalBookings": 0,
      "totalRevenue": 0.0,
      "occupancyRate": 0.0,
    },
    {
      "id": "SP005",
      "seasonName": "Valentine's Weekend",
      "startDate": "2025-02-14",
      "endDate": "2025-02-16",
      "status": "Scheduled",
      "priority": "Medium",
      "description": "Special romantic weekend pricing",
      "baseMultiplier": 1.4,
      "weekendMultiplier": 1.6,
      "minimumStay": 2,
      "advanceBookingDays": 45,
      "roomRates": [
        {"roomType": "Standard Room", "baseRate": 120.0, "seasonalRate": 168.0, "increase": 40.0},
        {"roomType": "Deluxe Room", "baseRate": 180.0, "seasonalRate": 252.0, "increase": 40.0},
        {"roomType": "Executive Suite", "baseRate": 350.0, "seasonalRate": 490.0, "increase": 40.0},
        {"roomType": "Presidential Suite", "baseRate": 650.0, "seasonalRate": 910.0, "increase": 40.0},
      ],
      "totalBookings": 0,
      "totalRevenue": 0.0,
      "occupancyRate": 0.0,
    },
  ];

  List<Map<String, dynamic>> get filteredSeasons {
    return seasonalPricing.where((season) {
      final matchesSeason = selectedSeason == "All" || season["status"] == selectedSeason;
      return matchesSeason;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Scheduled":
        return infoColor;
      case "Completed":
        return disabledBoldColor;
      case "Expired":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seasonal Pricing"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo('CreateSeasonalPricingView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Overview Stats
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
                          Icon(Icons.schedule, color: primaryColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Total Seasons",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${seasonalPricing.length}",
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
                            "Active Seasons",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${seasonalPricing.where((s) => s["status"] == "Active").length}",
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
                        "\$${((seasonalPricing.fold(0.0, (sum, s) => sum + (s["totalRevenue"] as double))) / 1000).toStringAsFixed(1)}K",
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
                          Icon(Icons.hotel, color: warningColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Avg Occupancy",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${(seasonalPricing.where((s) => s["occupancyRate"] > 0).fold(0.0, (sum, s) => sum + (s["occupancyRate"] as double)) / seasonalPricing.where((s) => s["occupancyRate"] > 0).length).toStringAsFixed(1)}%",
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
                    label: "Season Status",
                    items: [
                      {"label": "All", "value": "All"},
                      {"label": "Active", "value": "Active"},
                      {"label": "Scheduled", "value": "Scheduled"},
                      {"label": "Completed", "value": "Completed"},
                      {"label": "Expired", "value": "Expired"},
                    ],
                    value: selectedSeason,
                    onChanged: (value, label) {
                      selectedSeason = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Room Type",
                    items: [
                      {"label": "All", "value": "All"},
                      {"label": "Standard Room", "value": "Standard Room"},
                      {"label": "Deluxe Room", "value": "Deluxe Room"},
                      {"label": "Executive Suite", "value": "Executive Suite"},
                      {"label": "Presidential Suite", "value": "Presidential Suite"},
                    ],
                    value: selectedRoom,
                    onChanged: (value, label) {
                      selectedRoom = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Seasonal Pricing List
            ...filteredSeasons.map((season) {
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
                                  "${season["seasonName"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${season["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "ID: ${season["id"]}",
                                  style: TextStyle(
                                    fontSize: 10,
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
                                  color: getStatusColor(season["status"]),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${season["status"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(height: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: getPriorityColor(season["priority"]),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${season["priority"]} Priority",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Date Range & Multipliers
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.calendar_today, size: 16, color: primaryColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${season["startDate"]} - ${season["endDate"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Base Multiplier: ${season["baseMultiplier"]}x",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "Weekend: ${season["weekendMultiplier"]}x",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Min Stay: ${season["minimumStay"]} nights",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "Advance Booking: ${season["advanceBookingDays"]} days",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Performance Metrics (if applicable)
                      if (season["status"] == "Active" || season["status"] == "Completed") ...[
                        ResponsiveGridView(
                          padding: EdgeInsets.zero,
                          minItemWidth: 200,
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Bookings",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${season["totalBookings"]}",
                                    style: TextStyle(
                                      fontSize: 16,
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
                                color: infoColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Revenue",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "\$${((season["totalRevenue"] as double) / 1000).toStringAsFixed(1)}K",
                                    style: TextStyle(
                                      fontSize: 16,
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
                                color: warningColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Occupancy Rate",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${season["occupancyRate"]}%",
                                    style: TextStyle(
                                      fontSize: 16,
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

                      // Room Rates
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Room Rate Adjustments",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          ...(season["roomRates"] as List<Map<String, dynamic>>).where((room) {
                            return selectedRoom == "All" || room["roomType"] == selectedRoom;
                          }).map((room) {
                            final increase = room["increase"] as double;
                            final isIncrease = increase > 0;
                            final isDecrease = increase < 0;
                            
                            return Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: disabledColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "${room["roomType"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
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
                                          "\$${(room["baseRate"] as double).toStringAsFixed(0)}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
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
                                          "Seasonal Rate",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "\$${(room["seasonalRate"] as double).toStringAsFixed(0)}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: isIncrease ? successColor : 
                                                   isDecrease ? dangerColor : primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: (isIncrease ? successColor : 
                                             isDecrease ? dangerColor : primaryColor).withAlpha(30),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${isIncrease ? '+' : ''}${increase.toStringAsFixed(0)}%",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: isIncrease ? successColor : 
                                               isDecrease ? dangerColor : primaryColor,
                                      ),
                                    ),
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
                              label: "Edit Pricing",
                              size: bs.sm,
                              onPressed: () {
                                //navigateTo('EditSeasonalPricingView', arguments: season)
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () {
                                //navigateTo('SeasonalPricingDetailView', arguments: season)
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.copy,
                            size: bs.sm,
                            onPressed: () {
                              //duplicateSeasonalPricing(season)
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
