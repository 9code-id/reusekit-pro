import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosHappyHourView extends StatefulWidget {
  const PosHappyHourView({super.key});

  @override
  State<PosHappyHourView> createState() => _PosHappyHourViewState();
}

class _PosHappyHourViewState extends State<PosHappyHourView> {
  String searchQuery = "";
  String selectedDay = "all";
  String selectedStatus = "all";
  int currentTab = 0;

  List<Map<String, dynamic>> happyHours = [
    {
      "id": "HH001",
      "name": "Weekday Happy Hour",
      "description": "20% off on all beverages during weekdays",
      "discount": {"type": "percentage", "value": 20},
      "status": "active",
      "days": ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"],
      "timeSlots": [
        {"start": "15:00", "end": "18:00", "label": "Afternoon"},
        {"start": "20:00", "end": "22:00", "label": "Evening"}
      ],
      "applicableCategories": ["Beverages", "Cocktails"],
      "excludedItems": ["Premium Wine", "Champagne"],
      "locationRestrictions": [],
      "customerRestrictions": "none",
      "maxDiscount": 50,
      "minAmount": 20,
      "validFrom": "2024-06-01",
      "validTo": "2024-12-31",
      "totalUsage": 456,
      "revenueGenerated": 12450,
      "createdBy": "Restaurant Manager",
      "createdAt": "2024-05-15",
      "lastModified": "2024-06-10"
    },
    {
      "id": "HH002",
      "name": "Weekend Brunch Special",
      "description": "15% off on brunch items during weekends",
      "discount": {"type": "percentage", "value": 15},
      "status": "active",
      "days": ["Saturday", "Sunday"],
      "timeSlots": [
        {"start": "10:00", "end": "14:00", "label": "Late Morning to Afternoon"}
      ],
      "applicableCategories": ["Brunch", "Breakfast", "Light Meals"],
      "excludedItems": [],
      "locationRestrictions": ["Main Hall", "Terrace"],
      "customerRestrictions": "none",
      "maxDiscount": 30,
      "minAmount": 25,
      "validFrom": "2024-06-01",
      "validTo": "2024-08-31",
      "totalUsage": 234,
      "revenueGenerated": 8900,
      "createdBy": "Events Coordinator",
      "createdAt": "2024-05-20",
      "lastModified": "2024-06-05"
    },
    {
      "id": "HH003",
      "name": "Late Night Snacks",
      "description": "Fixed \$10 off on late night food orders",
      "discount": {"type": "fixed", "value": 10},
      "status": "scheduled",
      "days": ["Thursday", "Friday", "Saturday"],
      "timeSlots": [
        {"start": "22:00", "end": "01:00", "label": "Late Night"}
      ],
      "applicableCategories": ["Snacks", "Light Meals", "Desserts"],
      "excludedItems": [],
      "locationRestrictions": [],
      "customerRestrictions": "members_only",
      "maxDiscount": 10,
      "minAmount": 30,
      "validFrom": "2024-07-01",
      "validTo": "2024-09-30",
      "totalUsage": 0,
      "revenueGenerated": 0,
      "createdBy": "Night Shift Manager",
      "createdAt": "2024-06-20",
      "lastModified": "2024-06-20"
    },
    {
      "id": "HH004",
      "name": "Monday Blues Buster",
      "description": "Buy 2 get 1 free on coffee and pastries",
      "discount": {"type": "bogo", "value": 0},
      "status": "paused",
      "days": ["Monday"],
      "timeSlots": [
        {"start": "07:00", "end": "11:00", "label": "Morning"},
        {"start": "14:00", "end": "17:00", "label": "Afternoon"}
      ],
      "applicableCategories": ["Coffee", "Pastries", "Light Snacks"],
      "excludedItems": ["Premium Coffee", "Specialty Cakes"],
      "locationRestrictions": [],
      "customerRestrictions": "none",
      "maxDiscount": 25,
      "minAmount": 15,
      "validFrom": "2024-03-01",
      "validTo": "2024-12-31",
      "totalUsage": 123,
      "revenueGenerated": 3450,
      "createdBy": "Cafe Manager",
      "createdAt": "2024-02-25",
      "lastModified": "2024-06-01"
    },
    {
      "id": "HH005",
      "name": "Summer Sunset Special",
      "description": "30% off on outdoor dining during sunset hours",
      "discount": {"type": "percentage", "value": 30},
      "status": "expired",
      "days": ["Friday", "Saturday", "Sunday"],
      "timeSlots": [
        {"start": "18:30", "end": "20:30", "label": "Sunset Hours"}
      ],
      "applicableCategories": ["All"],
      "excludedItems": ["Alcohol"],
      "locationRestrictions": ["Outdoor Terrace", "Garden Area"],
      "customerRestrictions": "none",
      "maxDiscount": 75,
      "minAmount": 40,
      "validFrom": "2024-05-01",
      "validTo": "2024-05-31",
      "totalUsage": 89,
      "revenueGenerated": 6780,
      "createdBy": "Seasonal Events Team",
      "createdAt": "2024-04-15",
      "lastModified": "2024-05-31"
    }
  ];

  List<Map<String, dynamic>> get filteredHappyHours {
    return happyHours.where((hh) {
      bool matchesSearch = "${hh["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${hh["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesDay = selectedDay == "all" || (hh["days"] as List).contains(selectedDay);
      bool matchesStatus = selectedStatus == "all" || hh["status"] == selectedStatus;
      return matchesSearch && matchesDay && matchesStatus;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "scheduled":
        return infoColor;
      case "paused":
        return warningColor;
      case "expired":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String getDiscountText(Map<String, dynamic> discount) {
    switch (discount["type"]) {
      case "percentage":
        return "${discount["value"]}% OFF";
      case "fixed":
        return "\$${discount["value"]} OFF";
      case "bogo":
        return "BUY 2 GET 1";
      default:
        return "DISCOUNT";
    }
  }

  Widget _buildHappyHourCard(Map<String, dynamic> happyHour) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor.withAlpha(150), primaryColor.withAlpha(100)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusMd),
                topRight: Radius.circular(radiusMd),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.access_time,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "${happyHour["name"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: getStatusColor(happyHour["status"]),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${happyHour["status"]}".toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Content
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${happyHour["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                
                // Discount badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: successColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    getDiscountText(happyHour["discount"]),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: spSm),
                
                // Days
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: infoColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Active Days",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (happyHour["days"] as List).map((day) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "$day",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spSm),
                
                // Time slots
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 16,
                            color: warningColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Time Slots",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      ...(happyHour["timeSlots"] as List).map((slot) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: spXs),
                          child: Row(
                            children: [
                              Text(
                                "${slot["start"]} - ${slot["end"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${slot["label"]}",
                                style: TextStyle(
                                  fontSize: 11,
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
                SizedBox(height: spSm),
                
                // Conditions
                Row(
                  children: [
                    Icon(
                      Icons.info,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Min Amount: \$${happyHour["minAmount"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Max Discount: \$${happyHour["maxDiscount"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                
                // Statistics
                Row(
                  children: [
                    Icon(
                      Icons.analytics,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Used ${happyHour["totalUsage"]} times",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Revenue: \$${((happyHour["revenueGenerated"] as int).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                
                // Applicable categories
                if ((happyHour["applicableCategories"] as List).isNotEmpty) ...[
                  Text(
                    "Applicable to: ${(happyHour["applicableCategories"] as List).join(", ")}",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                ],
                
                // Location restrictions
                if ((happyHour["locationRestrictions"] as List).isNotEmpty) ...[
                  Text(
                    "Locations: ${(happyHour["locationRestrictions"] as List).join(", ")}",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                ],
                
                // Customer restrictions
                if (happyHour["customerRestrictions"] != "none") ...[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      happyHour["customerRestrictions"] == "members_only" ? "MEMBERS ONLY" : "${happyHour["customerRestrictions"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ),
                  SizedBox(height: spSm),
                ],
                
                // Actions
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Edit",
                        size: bs.sm,
                        onPressed: () {
                          // Edit happy hour logic
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: happyHour["status"] == "active" ? "Pause" : "Activate",
                        size: bs.sm,
                        onPressed: () {
                          // Toggle happy hour status
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.copy,
                      size: bs.sm,
                      onPressed: () {
                        // Duplicate happy hour
                      },
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.more_vert,
                      size: bs.sm,
                      onPressed: () {
                        // Show more options
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard() {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${happyHours.where((hh) => hh["status"] == "active").length}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Active",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: disabledColor,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${happyHours.fold(0, (sum, hh) => sum + (hh["totalUsage"] as int))}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Usage",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: disabledColor,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "\$${((happyHours.fold(0, (sum, hh) => sum + (hh["revenueGenerated"] as int))).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Revenue",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Happy Hour"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Add new happy hour
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsCard(),
            
            // Search and filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search happy hours...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Day",
                    items: [
                      {"label": "All Days", "value": "all"},
                      {"label": "Monday", "value": "Monday"},
                      {"label": "Tuesday", "value": "Tuesday"},
                      {"label": "Wednesday", "value": "Wednesday"},
                      {"label": "Thursday", "value": "Thursday"},
                      {"label": "Friday", "value": "Friday"},
                      {"label": "Saturday", "value": "Saturday"},
                      {"label": "Sunday", "value": "Sunday"},
                    ],
                    value: selectedDay,
                    onChanged: (value, label) {
                      selectedDay = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: [
                      {"label": "All Status", "value": "all"},
                      {"label": "Active", "value": "active"},
                      {"label": "Scheduled", "value": "scheduled"},
                      {"label": "Paused", "value": "paused"},
                      {"label": "Expired", "value": "expired"},
                    ],
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            
            // Happy hours list
            Text(
              "Happy Hours (${filteredHappyHours.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            if (filteredHappyHours.isEmpty)
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
                      Icons.access_time_outlined,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No happy hours found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search criteria",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredHappyHours.map((happyHour) => _buildHappyHourCard(happyHour)),
          ],
        ),
      ),
    );
  }
}
