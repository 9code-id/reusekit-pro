import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaCrimeStatsView extends StatefulWidget {
  const RmaCrimeStatsView({super.key});

  @override
  State<RmaCrimeStatsView> createState() => _RmaCrimeStatsViewState();
}

class _RmaCrimeStatsViewState extends State<RmaCrimeStatsView> {
  String selectedTimeframe = "12 months";
  String selectedRadius = "1 mile";
  bool showHeatMap = false;

  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "3 months", "value": "3 months"},
    {"label": "6 months", "value": "6 months"},
    {"label": "12 months", "value": "12 months"},
    {"label": "2 years", "value": "2 years"},
    {"label": "5 years", "value": "5 years"},
  ];

  List<Map<String, dynamic>> radiusOptions = [
    {"label": "0.5 miles", "value": "0.5 mile"},
    {"label": "1 mile", "value": "1 mile"},
    {"label": "2 miles", "value": "2 mile"},
    {"label": "5 miles", "value": "5 mile"},
  ];

  Map<String, dynamic> crimeStats = {
    "totalIncidents": 234,
    "previousPeriod": 267,
    "safetyScore": 7.8,
    "nationalAverage": 6.5,
    "trend": "decreasing",
    "trendPercentage": 12.4,
  };

  List<Map<String, dynamic>> crimeCategories = [
    {
      "type": "Property Crime",
      "incidents": 89,
      "percentage": 38.0,
      "change": -8.2,
      "color": warningColor,
      "icon": Icons.home_outlined,
      "description": "Burglary, theft, vandalism",
    },
    {
      "type": "Violent Crime",
      "incidents": 23,
      "percentage": 9.8,
      "change": -15.6,
      "color": dangerColor,
      "icon": Icons.warning,
      "description": "Assault, robbery, domestic violence",
    },
    {
      "type": "Drug Related",
      "incidents": 45,
      "percentage": 19.2,
      "change": -5.4,
      "color": infoColor,
      "icon": Icons.medication,
      "description": "Drug possession, trafficking",
    },
    {
      "type": "Traffic Violations",
      "incidents": 67,
      "percentage": 28.6,
      "change": -18.9,
      "color": primaryColor,
      "icon": Icons.traffic,
      "description": "DUI, reckless driving, accidents",
    },
    {
      "type": "Other",
      "incidents": 10,
      "percentage": 4.4,
      "change": 12.5,
      "color": disabledBoldColor,
      "icon": Icons.more_horiz,
      "description": "Miscellaneous incidents",
    },
  ];

  List<Map<String, dynamic>> recentIncidents = [
    {
      "type": "Vehicle Theft",
      "category": "Property Crime",
      "date": "2024-03-15",
      "time": "02:30 AM",
      "location": "Pine St & 3rd Ave",
      "distance": 0.3,
      "status": "Under Investigation",
      "severity": "Medium",
      "description": "Vehicle stolen from parking lot",
      "caseNumber": "SPD-2024-089432",
    },
    {
      "type": "Burglary",
      "category": "Property Crime",
      "date": "2024-03-12",
      "time": "11:45 PM",
      "location": "2nd Ave & Union St",
      "distance": 0.5,
      "status": "Resolved",
      "severity": "High",
      "description": "Residential break-in, suspect apprehended",
      "caseNumber": "SPD-2024-089201",
    },
    {
      "type": "Drug Possession",
      "category": "Drug Related",
      "date": "2024-03-10",
      "time": "06:15 PM",
      "location": "4th Ave & Pike St",
      "distance": 0.2,
      "status": "Closed",
      "severity": "Low",
      "description": "Minor drug possession, citation issued",
      "caseNumber": "SPD-2024-088967",
    },
    {
      "type": "Assault",
      "category": "Violent Crime",
      "date": "2024-03-08",
      "time": "09:22 PM",
      "location": "1st Ave & Spring St",
      "distance": 0.7,
      "status": "Under Investigation",
      "severity": "High",
      "description": "Physical altercation between two individuals",
      "caseNumber": "SPD-2024-088734",
    },
    {
      "type": "DUI",
      "category": "Traffic Violations",
      "date": "2024-03-05",
      "time": "01:15 AM",
      "location": "3rd Ave & Seneca St",
      "distance": 0.4,
      "status": "Resolved",
      "severity": "Medium",
      "description": "Driver arrested for DUI",
      "caseNumber": "SPD-2024-088456",
    },
  ];

  List<Map<String, dynamic>> monthlyTrends = [
    {"month": "Oct 2023", "incidents": 28, "change": 5.2},
    {"month": "Nov 2023", "incidents": 22, "change": -21.4},
    {"month": "Dec 2023", "incidents": 19, "change": -13.6},
    {"month": "Jan 2024", "incidents": 25, "change": 31.6},
    {"month": "Feb 2024", "incidents": 18, "change": -28.0},
    {"month": "Mar 2024", "incidents": 16, "change": -11.1},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crime Statistics"),
        actions: [
          GestureDetector(
            onTap: () {
              showHeatMap = !showHeatMap;
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              margin: EdgeInsets.only(right: spSm),
              decoration: BoxDecoration(
                color: showHeatMap ? dangerColor : Colors.transparent,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: showHeatMap ? dangerColor : disabledColor,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    showHeatMap ? Icons.list : Icons.whatshot,
                    size: 16,
                    color: showHeatMap ? Colors.white : disabledBoldColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    showHeatMap ? "Stats" : "Heat Map",
                    style: TextStyle(
                      fontSize: 12,
                      color: showHeatMap ? Colors.white : disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Timeframe",
                    items: timeframeOptions,
                    value: selectedTimeframe,
                    onChanged: (value, label) {
                      selectedTimeframe = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Radius",
                    items: radiusOptions,
                    value: selectedRadius,
                    onChanged: (value, label) {
                      selectedRadius = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Safety Score Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [successColor, successColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.security,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Safety Score",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Based on local crime data",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Text(
                        "${(crimeStats["safetyScore"] as double).toStringAsFixed(1)}/10",
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Text(
                        "National Average: ${(crimeStats["nationalAverage"] as double).toStringAsFixed(1)}/10",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(40),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Above Average",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            if (showHeatMap) ...[
              // Crime Heat Map
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.whatshot,
                            size: 64,
                            color: dangerColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Crime Heat Map",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Last ${selectedTimeframe} • ${selectedRadius} radius",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(150),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Heat zones simulation
                    Positioned(
                      left: 50,
                      top: 50,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(100),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 60,
                      top: 80,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(80),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 80,
                      bottom: 60,
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(60),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                      ),
                    ),
                    // Legend
                    Positioned(
                      top: spSm,
                      right: spSm,
                      child: Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(150),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLegendItem("High", dangerColor),
                            _buildLegendItem("Medium", warningColor),
                            _buildLegendItem("Low", infoColor),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spMd),
            ],

            // Crime Overview Stats
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    "Total Incidents",
                    "${crimeStats["totalIncidents"]}",
                    Icons.warning_amber,
                    warningColor,
                    subtitle: "Last ${selectedTimeframe}",
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatCard(
                    "Trend",
                    "${(crimeStats["trendPercentage"] as double).toStringAsFixed(1)}%",
                    crimeStats["trend"] == "decreasing" ? Icons.trending_down : Icons.trending_up,
                    crimeStats["trend"] == "decreasing" ? successColor : dangerColor,
                    subtitle: crimeStats["trend"] == "decreasing" ? "Decreasing" : "Increasing",
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Crime Categories
            Text(
              "Crime Breakdown",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...List.generate(crimeCategories.length, (index) {
              final category = crimeCategories[index];
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: category["color"],
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: (category["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        category["icon"],
                        color: category["color"],
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${category["type"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${category["incidents"]} incidents",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: category["color"],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${category["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Container(
                                width: 100,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: disabledColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: 100 * ((category["percentage"] as double) / 100),
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: category["color"],
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${(category["percentage"] as double).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                (category["change"] as double) < 0 ? Icons.arrow_downward : Icons.arrow_upward,
                                size: 14,
                                color: (category["change"] as double) < 0 ? successColor : dangerColor,
                              ),
                              Text(
                                "${((category["change"] as double).abs()).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: (category["change"] as double) < 0 ? successColor : dangerColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),

            SizedBox(height: spMd),

            // Monthly Trends
            Text(
              "Monthly Trends",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Incident Trends",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Container(
                    height: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: monthlyTrends.map((trend) {
                        double maxHeight = 100;
                        double barHeight = ((trend["incidents"] as int) / 30) * maxHeight;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "${trend["incidents"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Container(
                              width: 20,
                              height: barHeight,
                              decoration: BoxDecoration(
                                color: (trend["change"] as double) < 0 ? successColor : warningColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${trend["month"]}".split(" ")[0],
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Recent Incidents
            Text(
              "Recent Incidents",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...List.generate(recentIncidents.length, (index) {
              final incident = recentIncidents[index];
              Color severityColor = incident["severity"] == "High" 
                  ? dangerColor 
                  : incident["severity"] == "Medium" 
                      ? warningColor 
                      : successColor;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: severityColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${incident["severity"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${incident["type"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: incident["status"] == "Resolved" || incident["status"] == "Closed"
                                ? successColor.withAlpha(20)
                                : warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${incident["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: incident["status"] == "Resolved" || incident["status"] == "Closed"
                                  ? successColor
                                  : warningColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${incident["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 14,
                          color: dangerColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${incident["location"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "•",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${incident["distance"]} mi away",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: infoColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${incident["date"]} at ${incident["time"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Case: ${incident["caseNumber"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                            fontFamily: "monospace",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),

            SizedBox(height: spMd),

            // Safety Tips
            Container(
              width: double.infinity,
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
                      Icon(
                        Icons.lightbulb,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Safety Tips",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Be aware of your surroundings, especially during late hours\n"
                    "• Keep valuables secure and out of sight in vehicles\n"
                    "• Report suspicious activities to local authorities\n"
                    "• Use well-lit and populated areas when walking at night\n"
                    "• Consider installing security systems for your property",
                    style: TextStyle(
                      fontSize: 14,
                      color: infoColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Download Report",
                    size: bs.md,
                    icon: Icons.download,
                    onPressed: () {
                      ss("Crime statistics report downloaded");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Set Alerts",
                    size: bs.md,
                    icon: Icons.notifications,
                    onPressed: () {
                      si("Crime alert preferences updated");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color, {String? subtitle}) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          top: BorderSide(
            width: 3,
            color: color,
          ),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 28,
            color: color,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (subtitle != null) ...[
            SizedBox(height: spXs),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(width: spXs),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
