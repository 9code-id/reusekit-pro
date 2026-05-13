import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaRainfallView extends StatefulWidget {
  const WcaRainfallView({super.key});

  @override
  State<WcaRainfallView> createState() => _WcaRainfallViewState();
}

class _WcaRainfallViewState extends State<WcaRainfallView> {
  String selectedLocation = "New York, NY";
  String selectedTimeframe = "This Month";
  int selectedTab = 0;

  List<Map<String, dynamic>> locationItems = [
    {"label": "New York, NY", "value": "New York, NY"},
    {"label": "Los Angeles, CA", "value": "Los Angeles, CA"},
    {"label": "Chicago, IL", "value": "Chicago, IL"},
    {"label": "Houston, TX", "value": "Houston, TX"},
    {"label": "Phoenix, AZ", "value": "Phoenix, AZ"},
  ];

  List<Map<String, dynamic>> timeframeItems = [
    {"label": "This Month", "value": "This Month"},
    {"label": "Last 3 Months", "value": "Last 3 Months"},
    {"label": "This Year", "value": "This Year"},
    {"label": "All Time", "value": "All Time"},
  ];

  List<Map<String, dynamic>> dailyRainfall = [
    {"date": "Jun 1", "rainfall": 0.0, "average": 2.1, "status": "Dry"},
    {"date": "Jun 2", "rainfall": 1.2, "average": 2.1, "status": "Below Average"},
    {"date": "Jun 3", "rainfall": 5.8, "average": 2.1, "status": "Above Average"},
    {"date": "Jun 4", "rainfall": 12.4, "average": 2.1, "status": "Heavy"},
    {"date": "Jun 5", "rainfall": 0.3, "average": 2.1, "status": "Light"},
    {"date": "Jun 6", "rainfall": 0.0, "average": 2.1, "status": "Dry"},
    {"date": "Jun 7", "rainfall": 2.1, "average": 2.1, "status": "Average"},
    {"date": "Jun 8", "rainfall": 8.9, "average": 2.1, "status": "Heavy"},
    {"date": "Jun 9", "rainfall": 0.5, "average": 2.1, "status": "Light"},
    {"date": "Jun 10", "rainfall": 3.2, "average": 2.1, "status": "Above Average"},
    {"date": "Jun 11", "rainfall": 0.0, "average": 2.1, "status": "Dry"},
    {"date": "Jun 12", "rainfall": 1.8, "average": 2.1, "status": "Below Average"},
    {"date": "Jun 13", "rainfall": 6.7, "average": 2.1, "status": "Heavy"},
    {"date": "Jun 14", "rainfall": 0.2, "average": 2.1, "status": "Light"},
    {"date": "Jun 15", "rainfall": 4.1, "average": 2.1, "status": "Above Average"},
  ];

  List<Map<String, dynamic>> monthlyRainfall = [
    {"month": "Jan", "rainfall": 45.2, "average": 52.1, "percentage": 87},
    {"month": "Feb", "rainfall": 38.9, "average": 48.3, "percentage": 81},
    {"month": "Mar", "rainfall": 67.4, "average": 61.2, "percentage": 110},
    {"month": "Apr", "rainfall": 72.8, "average": 68.9, "percentage": 106},
    {"month": "May", "rainfall": 89.1, "average": 75.4, "percentage": 118},
    {"month": "Jun", "rainfall": 52.3, "average": 82.7, "percentage": 63},
    {"month": "Jul", "rainfall": 0.0, "average": 85.2, "percentage": 0},
    {"month": "Aug", "rainfall": 0.0, "average": 79.8, "percentage": 0},
    {"month": "Sep", "rainfall": 0.0, "average": 71.3, "percentage": 0},
    {"month": "Oct", "rainfall": 0.0, "average": 63.5, "percentage": 0},
    {"month": "Nov", "rainfall": 0.0, "average": 55.7, "percentage": 0},
    {"month": "Dec", "rainfall": 0.0, "average": 49.2, "percentage": 0},
  ];

  List<Map<String, dynamic>> rainfallStats = [
    {
      "title": "Total This Month",
      "value": "52.3",
      "unit": "mm",
      "change": "-36.8%",
      "trend": "down",
      "color": dangerColor
    },
    {
      "title": "Monthly Average",
      "value": "82.7",
      "unit": "mm",
      "change": "Normal",
      "trend": "stable",
      "color": infoColor
    },
    {
      "title": "Yearly Total",
      "value": "365.7",
      "unit": "mm",
      "change": "+12.4%",
      "trend": "up",
      "color": successColor
    },
    {
      "title": "Rainy Days",
      "value": "8",
      "unit": "days",
      "change": "-3 days",
      "trend": "down",
      "color": warningColor
    },
  ];

  List<Map<String, dynamic>> droughtIndex = [
    {
      "category": "Abnormally Dry",
      "percentage": 0,
      "description": "Short-term dryness",
      "color": warningColor.withAlpha(100)
    },
    {
      "category": "Moderate Drought",
      "percentage": 0,
      "description": "Some damage to crops",
      "color": warningColor
    },
    {
      "category": "Severe Drought",
      "percentage": 0,
      "description": "Crop losses likely",
      "color": dangerColor.withAlpha(150)
    },
    {
      "category": "Extreme Drought",
      "percentage": 0,
      "description": "Major crop/pasture losses",
      "color": dangerColor
    },
    {
      "category": "Exceptional Drought",
      "percentage": 0,
      "description": "Exceptional widespread losses",
      "color": Color(0xFF8B0000)
    },
  ];

  List<Map<String, dynamic>> rainfallRecords = [
    {
      "type": "Highest Daily",
      "value": "89.2 mm",
      "date": "March 15, 2023",
      "description": "Record daily rainfall"
    },
    {
      "type": "Wettest Month",
      "value": "234.5 mm",
      "date": "April 2023",
      "description": "Highest monthly total"
    },
    {
      "type": "Longest Dry Spell",
      "value": "45 days",
      "date": "Jul-Aug 2022",
      "description": "No measurable rainfall"
    },
    {
      "type": "Annual Record",
      "value": "1,456 mm",
      "date": "2019",
      "description": "Wettest year on record"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rainfall Analysis"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
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
          spacing: spLg,
          children: [
            // Location and Timeframe Selection
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Location",
                    items: locationItems,
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
                    label: "Time Period",
                    items: timeframeItems,
                    value: selectedTimeframe,
                    onChanged: (value, label) {
                      selectedTimeframe = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Current Rainfall Status
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.water_drop, color: infoColor),
                      SizedBox(width: spXs),
                      Text(
                        "Current Rainfall Status",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Divider(color: infoColor.withAlpha(30)),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "Today",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "4.1 mm",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "This Week",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "15.8 mm",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "vs Average",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "63%",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
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

            // Rainfall Statistics
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
                spacing: spMd,
                children: [
                  Text(
                    "Rainfall Statistics",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: rainfallStats.map((stat) => Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: (stat["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: (stat["color"] as Color).withAlpha(50)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "${stat["title"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "${stat["value"]}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: stat["color"] as Color,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${stat["unit"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                _getTrendIcon(stat["trend"] as String),
                                size: 16,
                                color: stat["color"] as Color,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${stat["change"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: stat["color"] as Color,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )).toList(),
                  ),
                ],
              ),
            ),

            // Tab Navigation
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              padding: EdgeInsets.all(4),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        selectedTab = 0;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: spSm),
                        decoration: BoxDecoration(
                          color: selectedTab == 0 ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Daily",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: selectedTab == 0 ? Colors.white : disabledBoldColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        selectedTab = 1;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: spSm),
                        decoration: BoxDecoration(
                          color: selectedTab == 1 ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Monthly",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: selectedTab == 1 ? Colors.white : disabledBoldColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        selectedTab = 2;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: spSm),
                        decoration: BoxDecoration(
                          color: selectedTab == 2 ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Records",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: selectedTab == 2 ? Colors.white : disabledBoldColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Tab Content
            if (selectedTab == 0) ...[
              // Daily Rainfall
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
                  spacing: spMd,
                  children: [
                    Text(
                      "Daily Rainfall (June 2024)",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: dailyRainfall.take(15).map((day) {
                            final maxRainfall = 15.0; // Max value for scaling
                            final height = ((day["rainfall"] as double) / maxRainfall * 150).clamp(2.0, 150.0);
                            
                            return Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 1),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: height,
                                      decoration: BoxDecoration(
                                        color: _getRainfallStatusColor(day["status"] as String),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${day["date"]}".split(' ')[1],
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        _buildLegendItem("Dry", successColor),
                        SizedBox(width: spSm),
                        _buildLegendItem("Light", infoColor),
                        SizedBox(width: spSm),
                        _buildLegendItem("Average", primaryColor),
                        SizedBox(width: spSm),
                        _buildLegendItem("Heavy", dangerColor),
                      ],
                    ),
                  ],
                ),
              ),

              // Daily Details
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
                  spacing: spMd,
                  children: [
                    Text(
                      "Recent Daily Records",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    ...dailyRainfall.take(10).map((day) => Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: _getRainfallStatusColor(day["status"] as String).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: _getRainfallStatusColor(day["status"] as String).withAlpha(50),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 40,
                            decoration: BoxDecoration(
                              color: _getRainfallStatusColor(day["status"] as String),
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Center(
                              child: Text(
                                "${day["date"]}".split(' ')[1],
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${day["status"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${(day["rainfall"] as double).toStringAsFixed(1)} mm",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: _getRainfallStatusColor(day["status"] as String),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Average: ${(day["average"] as double).toStringAsFixed(1)} mm",
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
                    )),
                  ],
                ),
              ),
            ],

            if (selectedTab == 1) ...[
              // Monthly Rainfall
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
                  spacing: spMd,
                  children: [
                    Text(
                      "Monthly Rainfall Comparison",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 200,
                      children: monthlyRainfall.take(6).map((month) => Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: _getMonthlyStatusColor(month["percentage"] as int).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: _getMonthlyStatusColor(month["percentage"] as int).withAlpha(50),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${month["month"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${month["percentage"]}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: _getMonthlyStatusColor(month["percentage"] as int),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Actual: ${(month["rainfall"] as double).toStringAsFixed(1)} mm",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Average: ${(month["average"] as double).toStringAsFixed(1)} mm",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Container(
                              height: 6,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: ((month["percentage"] as int) / 100).clamp(0.0, 1.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: _getMonthlyStatusColor(month["percentage"] as int),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )).toList(),
                    ),
                  ],
                ),
              ),
            ],

            if (selectedTab == 2) ...[
              // Rainfall Records
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
                  spacing: spMd,
                  children: [
                    Text(
                      "Rainfall Records",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    ...rainfallRecords.map((record) => Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: warningColor.withAlpha(50)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 50,
                            decoration: BoxDecoration(
                              color: warningColor,
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Icon(
                              Icons.emoji_events,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${record["type"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${record["value"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: warningColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${record["date"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${record["description"]}",
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
                    )),
                  ],
                ),
              ),
            ],

            // Drought Conditions
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
                spacing: spMd,
                children: [
                  Text(
                    "Drought Monitor",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: successColor.withAlpha(50)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, color: successColor),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "No Drought Conditions",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Adequate rainfall levels maintained",
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
                  ),
                ],
              ),
            ),

            // Rainfall Tips
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.tips_and_updates, color: infoColor),
                      SizedBox(width: spXs),
                      Text(
                        "Rainfall Conservation Tips",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Divider(color: infoColor.withAlpha(30)),
                  Text(
                    "• Install rain barrels to collect rainwater for garden use",
                    style: TextStyle(fontSize: 13, color: primaryColor),
                  ),
                  Text(
                    "• Use rain gardens to manage stormwater runoff",
                    style: TextStyle(fontSize: 13, color: primaryColor),
                  ),
                  Text(
                    "• Choose drought-resistant plants for landscaping",
                    style: TextStyle(fontSize: 13, color: primaryColor),
                  ),
                  Text(
                    "• Monitor local rainfall patterns for optimal water usage",
                    style: TextStyle(fontSize: 13, color: primaryColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
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
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  IconData _getTrendIcon(String trend) {
    switch (trend) {
      case "up":
        return Icons.trending_up;
      case "down":
        return Icons.trending_down;
      case "stable":
        return Icons.trending_flat;
      default:
        return Icons.trending_flat;
    }
  }

  Color _getRainfallStatusColor(String status) {
    switch (status) {
      case "Dry":
        return warningColor;
      case "Light":
        return infoColor;
      case "Below Average":
        return infoColor;
      case "Average":
        return primaryColor;
      case "Above Average":
        return successColor;
      case "Heavy":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getMonthlyStatusColor(int percentage) {
    if (percentage == 0) return disabledColor;
    if (percentage < 50) return dangerColor;
    if (percentage < 80) return warningColor;
    if (percentage < 120) return successColor;
    return infoColor;
  }
}
