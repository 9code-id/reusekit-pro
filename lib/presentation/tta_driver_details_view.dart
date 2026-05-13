import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaDriverDetailsView extends StatefulWidget {
  const TtaDriverDetailsView({super.key});

  @override
  State<TtaDriverDetailsView> createState() => _TtaDriverDetailsViewState();
}

class _TtaDriverDetailsViewState extends State<TtaDriverDetailsView> {
  bool isDriverOnline = true;
  String selectedTab = "details";

  Map<String, dynamic> driverInfo = {
    "name": "Michael Anderson",
    "photo": "https://picsum.photos/150/150?random=1&keyword=person",
    "rating": 4.9,
    "totalTrips": 2847,
    "yearsExperience": 5,
    "carModel": "BMW X3 2024",
    "carColor": "Pearl White",
    "plateNumber": "NYC-789",
    "carImage": "https://picsum.photos/300/200?random=1&keyword=bmw",
    "languages": ["English", "Spanish", "French"],
    "specialities": ["Airport Transfers", "City Tours", "Business Travel"],
    "joinDate": "January 2019",
    "lastSeen": "2 minutes ago",
    "isVerified": true,
    "phoneNumber": "+1 (555) 123-4567",
    "emergencyContact": "+1 (555) 987-6543",
  };

  List<Map<String, dynamic>> recentTrips = [
    {
      "id": "TRP001",
      "date": "Dec 15, 2024",
      "route": "JFK Airport → Manhattan Hotel",
      "duration": "45 minutes",
      "distance": "18.5 miles",
      "fare": 89.50,
      "rating": 5.0,
      "passenger": "Sarah Johnson",
      "status": "Completed",
    },
    {
      "id": "TRP002", 
      "date": "Dec 14, 2024",
      "route": "Times Square → LaGuardia Airport",
      "duration": "38 minutes",
      "distance": "12.3 miles",
      "fare": 67.25,
      "rating": 4.8,
      "passenger": "John Smith",
      "status": "Completed",
    },
    {
      "id": "TRP003",
      "date": "Dec 14, 2024",
      "route": "Central Park → Brooklyn Bridge",
      "duration": "52 minutes", 
      "distance": "15.7 miles",
      "fare": 72.80,
      "rating": 5.0,
      "passenger": "Emma Wilson",
      "status": "Completed",
    },
    {
      "id": "TRP004",
      "date": "Dec 13, 2024",
      "route": "Grand Central → Wall Street",
      "duration": "28 minutes",
      "distance": "8.2 miles",
      "fare": 45.60,
      "rating": 4.9,
      "passenger": "Mike Chen",
      "status": "Completed",
    },
  ];

  List<Map<String, dynamic>> reviews = [
    {
      "passenger": "Sarah Johnson",
      "rating": 5.0,
      "comment": "Excellent driver! Very professional and knows the city well. The car was clean and comfortable. Highly recommended!",
      "date": "2 days ago",
      "tripId": "TRP001",
      "avatar": "https://picsum.photos/50/50?random=2&keyword=person",
    },
    {
      "passenger": "John Smith",
      "rating": 4.8,
      "comment": "Great service and punctual. Michael was very friendly and helped with luggage. Safe driving throughout the trip.",
      "date": "3 days ago",
      "tripId": "TRP002",
      "avatar": "https://picsum.photos/50/50?random=3&keyword=person",
    },
    {
      "passenger": "Emma Wilson",
      "rating": 5.0,
      "comment": "Amazing experience! Michael provided excellent city tour commentary and took great care of us. Will definitely book again.",
      "date": "4 days ago",
      "tripId": "TRP003",
      "avatar": "https://picsum.photos/50/50?random=4&keyword=person",
    },
    {
      "passenger": "Mike Chen",
      "rating": 4.9,
      "comment": "Professional driver with excellent knowledge of traffic patterns. Arrived early and got us to destination efficiently.",
      "date": "5 days ago",
      "tripId": "TRP004",
      "avatar": "https://picsum.photos/50/50?random=5&keyword=person",
    },
  ];

  List<Map<String, dynamic>> achievements = [
    {
      "title": "5-Star Champion",
      "description": "Maintained 4.9+ rating for 6 months",
      "icon": Icons.star,
      "color": warningColor,
      "earned": true,
    },
    {
      "title": "Safe Driver",
      "description": "Zero accidents in 2+ years",
      "icon": Icons.shield,
      "color": successColor,
      "earned": true,
    },
    {
      "title": "Top Performer",
      "description": "Top 5% drivers this quarter",
      "icon": Icons.trending_up,
      "color": primaryColor,
      "earned": true,
    },
    {
      "title": "City Expert",
      "description": "Completed 1000+ city tours",
      "icon": Icons.location_city,
      "color": infoColor,
      "earned": false,
    },
    {
      "title": "Frequent Driver",
      "description": "Completed 2000+ trips",
      "icon": Icons.directions_car,
      "color": secondaryColor,
      "earned": true,
    },
    {
      "title": "Customer Favorite",
      "description": "100+ five-star reviews",
      "icon": Icons.favorite,
      "color": dangerColor,
      "earned": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Driver Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Sharing driver profile");
            },
          ),
          IconButton(
            icon: Icon(Icons.report),
            onPressed: () {
              ss("Report driver option");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Driver Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusXl),
                            child: Image.network(
                              "${driverInfo["photo"]}",
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          if (driverInfo["isVerified"] as bool)
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusLg),
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                                child: Icon(
                                  Icons.verified,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: isDriverOnline ? successColor : dangerColor,
                                borderRadius: BorderRadius.circular(radiusLg),
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${driverInfo["name"]}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.star, color: warningColor, size: 16),
                                SizedBox(width: spXs),
                                Text(
                                  "${driverInfo["rating"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  " • ${driverInfo["totalTrips"]} trips",
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(200),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${driverInfo["yearsExperience"]} years experience",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: isDriverOnline 
                                    ? successColor.withAlpha(50)
                                    : dangerColor.withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                isDriverOnline ? "Online" : "Offline",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Call Driver",
                          size: bs.sm,
                          onPressed: () {
                            ss("Calling ${driverInfo["name"]}");
                          },
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: QButton(
                          label: "Send Message",
                          size: bs.sm,
                          onPressed: () {
                            ss("Opening chat with ${driverInfo["name"]}");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Tab Navigation
            Container(
              padding: EdgeInsets.all(spMd),
              child: Row(
                children: [
                  _buildTabButton("Details", "details"),
                  _buildTabButton("Recent Trips", "trips"),
                  _buildTabButton("Reviews", "reviews"),
                  _buildTabButton("Achievements", "achievements"),
                ],
              ),
            ),

            // Tab Content
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: _buildTabContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String label, String value) {
    bool isSelected = selectedTab == value;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          selectedTab = value;
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: spSm),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : disabledBoldColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case "details":
        return _buildDetailsTab();
      case "trips":
        return _buildTripsTab();
      case "reviews":
        return _buildReviewsTab();
      case "achievements":
        return _buildAchievementsTab();
      default:
        return Container();
    }
  }

  Widget _buildDetailsTab() {
    return Column(
      spacing: spMd,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Vehicle Information
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(color: disabledOutlineBorderColor),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Vehicle Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusMd),
                child: Image.network(
                  "${driverInfo["carImage"]}",
                  width: double.infinity,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: _buildInfoItem("Model", "${driverInfo["carModel"]}"),
                  ),
                  Expanded(
                    child: _buildInfoItem("Color", "${driverInfo["carColor"]}"),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              _buildInfoItem("License Plate", "${driverInfo["plateNumber"]}"),
            ],
          ),
        ),

        // Driver Information
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(color: disabledOutlineBorderColor),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Driver Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              _buildInfoItem("Joined", "${driverInfo["joinDate"]}"),
              SizedBox(height: spSm),
              _buildInfoItem("Last Seen", "${driverInfo["lastSeen"]}"),
              SizedBox(height: spSm),
              _buildInfoItem("Phone", "${driverInfo["phoneNumber"]}"),
              SizedBox(height: spSm),
              _buildInfoItem("Emergency Contact", "${driverInfo["emergencyContact"]}"),
            ],
          ),
        ),

        // Languages & Specialities
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(color: disabledOutlineBorderColor),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Languages",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              Wrap(
                spacing: spSm,
                runSpacing: spSm,
                children: (driverInfo["languages"] as List).map((language) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spMd,
                      vertical: spSm,
                    ),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "$language",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: spMd),
              Text(
                "Specialities",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              Wrap(
                spacing: spSm,
                runSpacing: spSm,
                children: (driverInfo["specialities"] as List).map((speciality) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spMd,
                      vertical: spSm,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "$speciality",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),

        SizedBox(height: spLg),
      ],
    );
  }

  Widget _buildTripsTab() {
    return Column(
      spacing: spMd,
      children: [
        ...recentTrips.map((trip) {
          return Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: disabledOutlineBorderColor),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${trip["route"]}",
                        style: TextStyle(
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
                        color: successColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${trip["status"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(Icons.person, color: disabledBoldColor, size: 14),
                    SizedBox(width: spXs),
                    Text(
                      "${trip["passenger"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${trip["date"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    _buildTripStat(Icons.schedule, "${trip["duration"]}"),
                    _buildTripStat(Icons.straighten, "${trip["distance"]}"),
                    _buildTripStat(Icons.star, "${trip["rating"]}"),
                    Spacer(),
                    Text(
                      "\$${((trip["fare"] as double)).toStringAsFixed(2)}",
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
          );
        }).toList(),
        SizedBox(height: spLg),
      ],
    );
  }

  Widget _buildTripStat(IconData icon, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: disabledBoldColor, size: 14),
        SizedBox(width: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(width: spMd),
      ],
    );
  }

  Widget _buildReviewsTab() {
    return Column(
      spacing: spMd,
      children: [
        ...reviews.map((review) {
          return Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: disabledOutlineBorderColor),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusLg),
                      child: Image.network(
                        "${review["avatar"]}",
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${review["passenger"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Row(
                                children: List.generate(5, (index) {
                                  return Icon(
                                    Icons.star,
                                    size: 12,
                                    color: index < (review["rating"] as double)
                                        ? warningColor
                                        : disabledColor,
                                  );
                                }),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${review["date"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Text(
                  "${review["comment"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Trip ID: ${review["tripId"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        SizedBox(height: spLg),
      ],
    );
  }

  Widget _buildAchievementsTab() {
    return Column(
      spacing: spMd,
      children: [
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 150,
          children: achievements.map((achievement) {
            bool isEarned = achievement["earned"] as bool;
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: isEarned ? Colors.white : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: isEarned 
                      ? (achievement["color"] as Color)
                      : disabledColor,
                ),
                boxShadow: isEarned ? [shadowSm] : [],
              ),
              child: Column(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: isEarned 
                          ? (achievement["color"] as Color).withAlpha(30)
                          : disabledColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      achievement["icon"] as IconData,
                      color: isEarned 
                          ? achievement["color"] as Color
                          : disabledColor,
                      size: 24,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "${achievement["title"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isEarned ? primaryColor : disabledColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${achievement["description"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      color: isEarned ? disabledBoldColor : disabledColor,
                    ),
                  ),
                  if (!isEarned) ...[
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "In Progress",
                        style: TextStyle(
                          fontSize: 8,
                          color: disabledColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            );
          }).toList(),
        ),
        SizedBox(height: spLg),
      ],
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
