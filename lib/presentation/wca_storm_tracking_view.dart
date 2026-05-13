import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaStormTrackingView extends StatefulWidget {
  const WcaStormTrackingView({super.key});

  @override
  State<WcaStormTrackingView> createState() => _WcaStormTrackingViewState();
}

class _WcaStormTrackingViewState extends State<WcaStormTrackingView> {
  String selectedStormType = "All";
  String selectedRange = "50 miles";
  bool showHistorical = false;

  List<Map<String, dynamic>> stormTypeOptions = [
    {"label": "All Storms", "value": "All"},
    {"label": "Thunderstorms", "value": "Thunderstorm"},
    {"label": "Winter Storms", "value": "Winter"},
    {"label": "Tornadoes", "value": "Tornado"},
    {"label": "Hurricanes", "value": "Hurricane"},
  ];

  List<Map<String, dynamic>> rangeOptions = [
    {"label": "25 miles", "value": "25 miles"},
    {"label": "50 miles", "value": "50 miles"},
    {"label": "100 miles", "value": "100 miles"},
    {"label": "200 miles", "value": "200 miles"},
    {"label": "National", "value": "National"},
  ];

  List<Map<String, dynamic>> activeStorms = [
    {
      "name": "Winter Storm Bella",
      "type": "Winter Storm",
      "severity": "High",
      "distance": "15 miles NE",
      "speed": "25 mph",
      "direction": "Southeast",
      "eta": "2 hours",
      "status": "Active",
      "affected": "500,000 people",
      "windSpeed": "45 mph",
      "precipitation": "Heavy Snow",
      "temperature": "22°F",
    },
    {
      "name": "Thunderstorm Cell A",
      "type": "Severe Thunderstorm",
      "severity": "Moderate",
      "distance": "32 miles SW",
      "speed": "35 mph",
      "direction": "Northeast",
      "eta": "45 minutes",
      "status": "Active",
      "affected": "75,000 people",
      "windSpeed": "65 mph",
      "precipitation": "Heavy Rain",
      "temperature": "68°F",
    },
    {
      "name": "Tornado Watch Area",
      "type": "Tornado",
      "severity": "Extreme",
      "distance": "85 miles W",
      "speed": "55 mph",
      "direction": "East",
      "eta": "1.5 hours",
      "status": "Watch",
      "affected": "1.2M people",
      "windSpeed": "120+ mph",
      "precipitation": "Heavy Rain",
      "temperature": "72°F",
    },
  ];

  List<Map<String, dynamic>> stormHistory = [
    {
      "name": "Blizzard Emma",
      "type": "Winter Storm",
      "date": "Dec 10, 2024",
      "severity": "High",
      "duration": "18 hours",
      "affected": "2.1M people",
      "maxWind": "65 mph",
      "snowfall": "24 inches",
    },
    {
      "name": "Thunderstorm Complex",
      "type": "Severe Weather",
      "date": "Nov 28, 2024",
      "severity": "Moderate",
      "duration": "6 hours",
      "affected": "800K people",
      "maxWind": "75 mph",
      "rainfall": "3.2 inches",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Storm Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              si("Storm alerts enabled");
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              si("Storm data refreshed");
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
            // Emergency Alert
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: dangerColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: dangerColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Severe Weather Alert",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Multiple storm systems approaching your area. Stay alert and prepared.",
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

            // Filter Controls
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Storm Type",
                    items: stormTypeOptions,
                    value: selectedStormType,
                    onChanged: (value, label) {
                      selectedStormType = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Range",
                    items: rangeOptions,
                    value: selectedRange,
                    onChanged: (value, label) {
                      selectedRange = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            QSwitch(
              label: "Show Historical Data",
              items: [
                {
                  "label": "Include past storms",
                  "value": true,
                  "checked": showHistorical,
                }
              ],
              value: [
                if (showHistorical)
                  {
                    "label": "Include past storms",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                showHistorical = values.isNotEmpty;
                setState(() {});
              },
            ),

            // Storm Statistics
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Current Storm Activity",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${activeStorms.length}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                              Text(
                                "Active Storms",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
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
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "1.8M",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "People Affected",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
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
                            children: [
                              Text(
                                "45 min",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "Nearest ETA",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Active Storms
            Text(
              "Active Storms",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...activeStorms.map((storm) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getSeverityColor(storm["severity"]),
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${storm["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${storm["type"]} • ${storm["severity"]} Severity",
                              style: TextStyle(
                                color: _getSeverityColor(storm["severity"]),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: _getSeverityColor(storm["severity"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${storm["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: _getSeverityColor(storm["severity"]),
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
                            Row(
                              children: [
                                Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "Distance: ${storm["distance"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "ETA: ${storm["eta"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(Icons.people, size: 16, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "Affected: ${storm["affected"]}",
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
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.air, size: 16, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "Wind: ${storm["windSpeed"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(Icons.water_drop, size: 16, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${storm["precipitation"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(Icons.thermostat, size: 16, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "Temp: ${storm["temperature"]}",
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
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () {
                            si("Viewing storm details for ${storm["name"]}");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Get Alerts",
                          size: bs.sm,
                          onPressed: () {
                            ss("Alert set for ${storm["name"]}");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),

            // Historical Storms (if enabled)
            if (showHistorical) ...[
              Text(
                "Recent Storm History",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              ...stormHistory.map((storm) => Container(
                margin: EdgeInsets.only(bottom: spSm),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${storm["name"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${storm["date"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${storm["type"]} • ${storm["severity"]} Severity",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Duration: ${storm["duration"]} • Affected: ${storm["affected"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )),
            ],

            // Safety Information
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
                        "Storm Safety Tips",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Stay indoors during severe weather",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Keep emergency supplies ready",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Monitor weather alerts and warnings",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Have multiple ways to receive weather information",
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

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case "low":
        return successColor;
      case "moderate":
        return warningColor;
      case "high":
        return dangerColor;
      case "extreme":
        return dangerColor;
      default:
        return infoColor;
    }
  }
}
