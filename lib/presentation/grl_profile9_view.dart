import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlProfile9View extends StatefulWidget {
  @override
  State<GrlProfile9View> createState() => _GrlProfile9ViewState();
}

class _GrlProfile9ViewState extends State<GrlProfile9View> {
  Map<String, dynamic> user = {
    "name": "Captain Sarah Mitchell",
    "rank": "Captain",
    "airline": "SkyLink Airlines",
    "avatar": "https://picsum.photos/100/100?random=28&keyword=pilot",
    "licenseNumber": "ATP-123456789",
    "experience": "15+ years",
    "totalFlightHours": 12450,
    "aircraftTypes": ["Boeing 777", "Airbus A320", "Boeing 737"],
    "rating": 4.9,
    "safetyRecord": "Perfect",
    "basedIn": "Los Angeles, CA",
    "employeeSince": "2009",
    "totalFlights": 3420,
    "countries": 45,
    "languages": ["English", "Spanish", "French"],
  };

  List<Map<String, dynamic>> certifications = [
    {
      "name": "Airline Transport Pilot License",
      "code": "ATPL",
      "issueDate": "2009",
      "validUntil": "2025",
      "authority": "FAA",
    },
    {
      "name": "Boeing 777 Type Rating",
      "code": "B777",
      "issueDate": "2018",
      "validUntil": "2025",
      "authority": "Boeing",
    },
    {
      "name": "Instrument Rating",
      "code": "IR",
      "issueDate": "2008",
      "validUntil": "2025",
      "authority": "FAA",
    },
    {
      "name": "Multi-Engine Rating",
      "code": "MEL",
      "issueDate": "2007",
      "validUntil": "2025",
      "authority": "FAA",
    },
  ];

  List<Map<String, dynamic>> recentFlights = [
    {
      "flightNumber": "SL 4521",
      "route": "LAX → JFK",
      "aircraft": "Boeing 777-300ER",
      "date": "Dec 20, 2024",
      "duration": "5h 32m",
      "passengers": 320,
      "status": "Completed",
    },
    {
      "flightNumber": "SL 8934",
      "route": "JFK → LHR",
      "aircraft": "Boeing 777-300ER",
      "date": "Dec 18, 2024",
      "duration": "7h 45m",
      "passengers": 298,
      "status": "Completed",
    },
    {
      "flightNumber": "SL 2156",
      "route": "LHR → FRA",
      "aircraft": "Airbus A320",
      "date": "Dec 15, 2024",
      "duration": "1h 20m",
      "passengers": 156,
      "status": "Completed",
    },
    {
      "flightNumber": "SL 7823",
      "route": "FRA → LAX",
      "aircraft": "Boeing 777-300ER",
      "date": "Dec 12, 2024",
      "duration": "11h 15m",
      "passengers": 315,
      "status": "Completed",
    },
  ];

  List<Map<String, dynamic>> achievements = [
    {
      "icon": Icons.flight_takeoff,
      "title": "10,000+ Flight Hours",
      "description": "Achieved milestone in 2022",
      "color": primaryColor,
    },
    {
      "icon": Icons.security,
      "title": "Perfect Safety Record",
      "description": "Zero incidents in 15 years",
      "color": successColor,
    },
    {
      "icon": Icons.star,
      "title": "Pilot of the Year",
      "description": "SkyLink Airlines 2023",
      "color": warningColor,
    },
    {
      "icon": Icons.school,
      "title": "Chief Instructor",
      "description": "Training new pilots since 2020",
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> upcomingFlights = [
    {
      "flightNumber": "SL 1247",
      "route": "LAX → NRT",
      "aircraft": "Boeing 777-300ER",
      "date": "Dec 25, 2024",
      "time": "11:30 PM",
      "gate": "A12",
      "status": "Scheduled",
    },
    {
      "flightNumber": "SL 6834",
      "route": "NRT → ICN",
      "aircraft": "Boeing 777-300ER",
      "date": "Dec 27, 2024",
      "time": "2:15 PM",
      "gate": "B8",
      "status": "Scheduled",
    },
    {
      "flightNumber": "SL 9102",
      "route": "ICN → LAX",
      "aircraft": "Boeing 777-300ER",
      "date": "Dec 29, 2024",
      "time": "6:45 AM",
      "gate": "A15",
      "status": "Scheduled",
    },
  ];

  List<Map<String, dynamic>> passengerReviews = [
    {
      "passengerName": "John D.",
      "rating": 5,
      "comment": "Smooth flight and excellent communication throughout. Captain Mitchell made everyone feel safe and comfortable.",
      "flight": "SL 4521",
      "date": "Dec 20, 2024",
    },
    {
      "passengerName": "Maria L.",
      "rating": 5,
      "comment": "Professional and experienced pilot. The landing was so smooth I barely felt it! Thank you Captain Mitchell.",
      "flight": "SL 8934",
      "date": "Dec 18, 2024",
    },
    {
      "passengerName": "Robert K.",
      "rating": 5,
      "comment": "Captain Mitchell handled turbulence expertly and kept us informed. Felt very safe throughout the journey.",
      "flight": "SL 2156",
      "date": "Dec 15, 2024",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilot Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.flight),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Pilot Header Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue.shade700,
                    Colors.blue.shade500,
                  ],
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowLg],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: [shadowMd],
                        ),
                        child: ClipOval(
                          child: Image.network(
                            "${user["avatar"]}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.flight_takeoff,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${user["rank"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withAlpha(220),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${user["name"]}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "${user["airline"]}",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white.withAlpha(200),
                                  size: 14,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${user["basedIn"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white.withAlpha(200),
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
                  
                  // Key Stats
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatColumn(
                          "${(user["totalFlightHours"] as int) / 1000}K",
                          "Flight Hours",
                          Colors.white,
                        ),
                      ),
                      Expanded(
                        child: _buildStatColumn(
                          "${(user["totalFlights"] as int) / 1000}K",
                          "Total Flights",
                          Colors.white,
                        ),
                      ),
                      Expanded(
                        child: _buildStatColumn(
                          "${user["countries"]}",
                          "Countries",
                          Colors.white,
                        ),
                      ),
                      Expanded(
                        child: _buildStatColumn(
                          "${user["experience"]}",
                          "Experience",
                          Colors.white,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Safety Record & Rating
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.security,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${user["safetyRecord"]} Safety",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${user["rating"]} Rating",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Since ${user["employeeSince"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(180),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Aircraft Types & Languages
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Aircraft Types",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Column(
                          children: (user["aircraftTypes"] as List).map((aircraft) {
                            return Container(
                              margin: EdgeInsets.only(bottom: spXs),
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.airplanemode_active,
                                    color: primaryColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    aircraft,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
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
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
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
                        SizedBox(height: spSm),
                        Column(
                          children: (user["languages"] as List).map((language) {
                            return Container(
                              margin: EdgeInsets.only(bottom: spXs),
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.language,
                                    color: successColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    language,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
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
                ),
              ],
            ),

            // Certifications
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Certifications & Licenses",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: certifications.map((cert) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: primaryColor.withAlpha(50)),
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
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${cert["code"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.verified,
                                  color: successColor,
                                  size: 16,
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${cert["name"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Authority: ${cert["authority"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledColor,
                              ),
                            ),
                            Text(
                              "Valid until: ${cert["validUntil"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledColor,
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

            // Upcoming Flights
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Upcoming Flights",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Column(
                    children: upcomingFlights.map((flight) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: infoColor.withAlpha(100)),
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
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${flight["flightNumber"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${flight["route"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
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
                                    color: infoColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${flight["status"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${flight["aircraft"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(Icons.calendar_today, size: 12, color: disabledColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${flight["date"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Icon(Icons.schedule, size: 12, color: disabledColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${flight["time"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Icon(Icons.door_front_door, size: 12, color: disabledColor),
                                SizedBox(width: spXs),
                                Text(
                                  "Gate ${flight["gate"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
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

            // Recent Flight History
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recent Flights",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 12,
                            color: secondaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Column(
                    children: recentFlights.take(3).map((flight) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
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
                                    color: successColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${flight["flightNumber"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${flight["route"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${flight["date"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Text(
                                  "${flight["aircraft"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Icon(Icons.schedule, size: 12, color: disabledColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${flight["duration"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Icon(Icons.people, size: 12, color: disabledColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${flight["passengers"]} pax",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
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

            // Achievements
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Achievements & Awards",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: achievements.map((achievement) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (achievement["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              achievement["icon"] as IconData,
                              color: achievement["color"] as Color,
                              size: 24,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${achievement["title"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${achievement["description"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledColor,
                                height: 1.3,
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

            // Passenger Reviews
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Passenger Reviews",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 12,
                            color: secondaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Column(
                    children: passengerReviews.take(2).map((review) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${review["passengerName"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${review["flight"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  children: List.generate(5, (index) {
                                    return Icon(
                                      index < (review["rating"] as int) 
                                          ? Icons.star 
                                          : Icons.star_border,
                                      color: warningColor,
                                      size: 14,
                                    );
                                  }),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${review["comment"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${review["date"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledColor,
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

            // License Information
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "License Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Icon(Icons.badge, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "License Number",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledColor,
                              ),
                            ),
                            Text(
                              "${user["licenseNumber"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
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
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Active",
                          style: TextStyle(
                            fontSize: 10,
                            color: successColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Contact Actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Flight Schedule",
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Send Message",
                    color: secondaryColor,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: color.withAlpha(200),
          ),
        ),
      ],
    );
  }
}
