import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaTideTimesView extends StatefulWidget {
  const WcaTideTimesView({super.key});

  @override
  State<WcaTideTimesView> createState() => _WcaTideTimesViewState();
}

class _WcaTideTimesViewState extends State<WcaTideTimesView> {
  String selectedLocation = "Santa Monica, CA";
  String selectedDate = "2024-06-16";
  String selectedTimeZone = "Pacific Time";

  List<Map<String, dynamic>> locations = [
    {"label": "Santa Monica, CA", "value": "Santa Monica, CA"},
    {"label": "San Francisco, CA", "value": "San Francisco, CA"},
    {"label": "Seattle, WA", "value": "Seattle, WA"},
    {"label": "Boston, MA", "value": "Boston, MA"},
    {"label": "Miami, FL", "value": "Miami, FL"},
  ];

  List<Map<String, dynamic>> timeZones = [
    {"label": "Pacific Time", "value": "Pacific Time"},
    {"label": "Eastern Time", "value": "Eastern Time"},
    {"label": "Central Time", "value": "Central Time"},
    {"label": "Mountain Time", "value": "Mountain Time"},
  ];

  List<Map<String, dynamic>> todayTides = [
    {
      "time": "2:15 AM",
      "type": "Low",
      "height": 0.8,
      "coefficient": 85,
      "moonPhase": "Waning Crescent",
      "icon": Icons.trending_down,
      "color": infoColor,
    },
    {
      "time": "8:30 AM",
      "type": "High",
      "height": 5.2,
      "coefficient": 85,
      "moonPhase": "Waning Crescent",
      "icon": Icons.trending_up,
      "color": successColor,
    },
    {
      "time": "2:45 PM",
      "type": "Low",
      "height": 1.2,
      "coefficient": 85,
      "moonPhase": "Waning Crescent",
      "icon": Icons.trending_down,
      "color": infoColor,
    },
    {
      "time": "9:10 PM",
      "type": "High",
      "height": 4.8,
      "coefficient": 85,
      "moonPhase": "Waning Crescent",
      "icon": Icons.trending_up,
      "color": successColor,
    },
  ];

  List<Map<String, dynamic>> weeklyTides = [
    {
      "date": "June 16",
      "highTimes": ["8:30 AM", "9:10 PM"],
      "lowTimes": ["2:15 AM", "2:45 PM"],
      "range": "4.0 ft",
      "moonPhase": "Waning Crescent",
      "coefficient": 85,
    },
    {
      "date": "June 17",
      "highTimes": ["9:15 AM", "9:55 PM"],
      "lowTimes": ["3:00 AM", "3:30 PM"],
      "range": "3.8 ft",
      "moonPhase": "Waning Crescent",
      "coefficient": 78,
    },
    {
      "date": "June 18",
      "highTimes": ["10:00 AM", "10:40 PM"],
      "lowTimes": ["3:45 AM", "4:15 PM"],
      "range": "3.5 ft",
      "moonPhase": "New Moon",
      "coefficient": 72,
    },
    {
      "date": "June 19",
      "highTimes": ["10:45 AM", "11:25 PM"],
      "lowTimes": ["4:30 AM", "5:00 PM"],
      "range": "3.2 ft",
      "moonPhase": "New Moon",
      "coefficient": 65,
    },
    {
      "date": "June 20",
      "highTimes": ["11:30 AM", "---"],
      "lowTimes": ["5:15 AM", "5:45 PM"],
      "range": "2.9 ft",
      "moonPhase": "Waxing Crescent",
      "coefficient": 58,
    },
  ];

  List<Map<String, dynamic>> activities = [
    {
      "activity": "Fishing",
      "bestTime": "High Tide + 2 hours",
      "nextBest": "8:30 AM - 10:30 AM",
      "rating": "Excellent",
      "color": successColor,
      "icon": Icons.phishing,
      "description": "Incoming tide brings baitfish closer to shore",
    },
    {
      "activity": "Surfing",
      "bestTime": "2 hours before high tide",
      "nextBest": "6:30 AM - 8:30 AM",
      "rating": "Good",
      "color": successColor,
      "icon": Icons.surfing,
      "description": "Rising tide creates better wave conditions",
    },
    {
      "activity": "Beach Walking",
      "bestTime": "Low Tide",
      "nextBest": "2:15 AM or 2:45 PM",
      "rating": "Perfect",
      "color": successColor,
      "icon": Icons.directions_walk,
      "description": "Maximum exposed beach area for exploration",
    },
    {
      "activity": "Tide Pooling",
      "bestTime": "Low Tide - 1 hour",
      "nextBest": "1:15 AM - 3:15 AM",
      "rating": "Excellent",
      "color": successColor,
      "icon": Icons.water_damage,
      "description": "Best access to marine life in tide pools",
    },
    {
      "activity": "Boating",
      "bestTime": "High Tide ± 2 hours",
      "nextBest": "6:30 AM - 11:10 PM",
      "rating": "Good",
      "color": successColor,
      "icon": Icons.sailing,
      "description": "Deeper water provides safer navigation",
    },
  ];

  List<Map<String, dynamic>> moonTideRelation = [
    {
      "phase": "New Moon",
      "tideType": "Spring Tides",
      "range": "Maximum",
      "description": "Highest high tides and lowest low tides",
      "coefficient": "95-110",
      "icon": Icons.brightness_1,
    },
    {
      "phase": "First Quarter",
      "tideType": "Neap Tides",
      "range": "Minimum",
      "description": "Moderate tidal range with less variation",
      "coefficient": "45-65",
      "icon": Icons.brightness_2,
    },
    {
      "phase": "Full Moon",
      "tideType": "Spring Tides",
      "range": "Maximum",
      "description": "Highest high tides and lowest low tides",
      "coefficient": "95-110",
      "icon": Icons.brightness_7,
    },
    {
      "phase": "Last Quarter",
      "tideType": "Neap Tides",
      "range": "Minimum",
      "description": "Moderate tidal range with less variation",
      "coefficient": "45-65",
      "icon": Icons.brightness_3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tide Times"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              si("Tide calendar view opened");
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              si("Tide alerts configured");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    infoColor.withAlpha(20),
                    successColor.withAlpha(20),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.timeline,
                    color: infoColor,
                    size: 32,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tide Prediction Center",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Accurate tide times and heights for coastal activities and navigation",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Location",
                    items: locations,
                    value: selectedLocation,
                    onChanged: (value, label) {
                      selectedLocation = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Time Zone",
                    items: timeZones,
                    value: selectedTimeZone,
                    onChanged: (value, label) {
                      selectedTimeZone = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            QDatePicker(
              label: "Date",
              value: DateTime.parse(selectedDate),
              onChanged: (value) {
                selectedDate = value.toString().split(' ')[0];
                setState(() {});
              },
            ),

            Text(
              "Today's Tides - ${selectedDate}",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: todayTides.map((tide) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: tide["color"].withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          tide["icon"],
                          color: tide["color"],
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${tide["time"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
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
                                    color: tide["color"].withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${tide["type"]} Tide",
                                    style: TextStyle(
                                      color: tide["color"],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Height: ${tide["height"]} ft • Coefficient: ${tide["coefficient"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${tide["height"]} ft",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            Text(
              "7-Day Tide Overview",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: weeklyTides.map((day) {
                Color coefficientColor = day["coefficient"] > 80
                    ? successColor
                    : day["coefficient"] > 60
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
                    children: [
                      Row(
                        children: [
                          Text(
                            "${day["date"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: coefficientColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "Coeff: ${day["coefficient"]}",
                              style: TextStyle(
                                color: coefficientColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
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
                                  "High Tides",
                                  style: TextStyle(
                                    color: successColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${(day["highTimes"] as List).join(", ")}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 14,
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
                                  "Low Tides",
                                  style: TextStyle(
                                    color: infoColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${(day["lowTimes"] as List).join(", ")}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Range",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${day["range"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                ),
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

            Text(
              "Best Activity Times",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: activities.map((activity) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: activity["color"],
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        activity["icon"],
                        color: activity["color"],
                        size: 24,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${activity["activity"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: activity["color"].withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${activity["rating"]}",
                                    style: TextStyle(
                                      color: activity["color"],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Best Time: ${activity["nextBest"]}",
                              style: TextStyle(
                                color: activity["color"],
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${activity["description"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            Text(
              "Moon Phase & Tide Relationship",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: moonTideRelation.map((relation) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        relation["icon"],
                        color: primaryColor,
                        size: 32,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${relation["phase"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${relation["tideType"]}",
                                  style: TextStyle(
                                    color: infoColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${relation["description"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Coefficient Range: ${relation["coefficient"]}",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Tide Coefficient Explained",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• 20-50: Very weak tides (neap)",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• 51-69: Weak to moderate tides",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• 70-89: Strong tides",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• 90-110: Very strong tides (spring)",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
