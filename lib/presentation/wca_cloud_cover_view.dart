import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaCloudCoverView extends StatefulWidget {
  const WcaCloudCoverView({super.key});

  @override
  State<WcaCloudCoverView> createState() => _WcaCloudCoverViewState();
}

class _WcaCloudCoverViewState extends State<WcaCloudCoverView> {
  String selectedLocation = "New York";
  String selectedTimeframe = "24h";
  bool showSatelliteView = true;
  
  List<Map<String, dynamic>> locations = [
    {"label": "New York", "value": "New York"},
    {"label": "Los Angeles", "value": "Los Angeles"},
    {"label": "Chicago", "value": "Chicago"},
    {"label": "Miami", "value": "Miami"},
    {"label": "Seattle", "value": "Seattle"},
  ];

  List<Map<String, dynamic>> timeframes = [
    {"label": "6 Hours", "value": "6h"},
    {"label": "12 Hours", "value": "12h"},
    {"label": "24 Hours", "value": "24h"},
    {"label": "48 Hours", "value": "48h"},
    {"label": "7 Days", "value": "7d"},
  ];

  List<Map<String, dynamic>> cloudData = [
    {
      "time": "12:00 AM",
      "coverage": 85,
      "type": "Dense Clouds",
      "altitude": "2,500 ft",
      "visibility": "2 km",
      "humidity": 78,
    },
    {
      "time": "03:00 AM", 
      "coverage": 92,
      "type": "Storm Clouds",
      "altitude": "3,200 ft",
      "visibility": "1.5 km",
      "humidity": 85,
    },
    {
      "time": "06:00 AM",
      "coverage": 67,
      "type": "Scattered Clouds",
      "altitude": "1,800 ft", 
      "visibility": "4 km",
      "humidity": 65,
    },
    {
      "time": "09:00 AM",
      "coverage": 45,
      "type": "Light Clouds",
      "altitude": "1,200 ft",
      "visibility": "8 km", 
      "humidity": 52,
    },
    {
      "time": "12:00 PM",
      "coverage": 23,
      "type": "Clear Skies",
      "altitude": "0 ft",
      "visibility": "15 km",
      "humidity": 38,
    },
    {
      "time": "03:00 PM",
      "coverage": 34,
      "type": "Partly Cloudy",
      "altitude": "900 ft",
      "visibility": "12 km",
      "humidity": 45,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cloud Cover Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Cloud data refreshed");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildLocationSelector(),
            _buildTimeframeSelector(),
            _buildSatelliteToggle(),
            _buildCloudCoverageMap(),
            _buildCurrentConditions(),
            _buildHourlyForecast(),
            _buildCloudTypes(),
            _buildVisibilityMeter(),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationSelector() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Location",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Select Location",
            items: locations,
            value: selectedLocation,
            onChanged: (value, label) {
              selectedLocation = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTimeframeSelector() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Forecast Period",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QCategoryPicker(
            items: timeframes,
            value: selectedTimeframe,
            onChanged: (index, label, value, item) {
              selectedTimeframe = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSatelliteToggle() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: QSwitch(
              items: [
                {
                  "label": "Satellite View",
                  "value": true,
                  "checked": showSatelliteView,
                }
              ],
              value: [
                if (showSatelliteView)
                  {"label": "Satellite View", "value": true, "checked": true}
              ],
              onChanged: (values, ids) {
                showSatelliteView = values.isNotEmpty;
                setState(() {});
              },
            ),
          ),
          Icon(
            Icons.satellite_alt,
            color: showSatelliteView ? primaryColor : disabledBoldColor,
          ),
        ],
      ),
    );
  }

  Widget _buildCloudCoverageMap() {
    return Container(
      height: 300,
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.map, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Cloud Coverage Map",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Stack(
                children: [
                  // Simulated cloud coverage overlay
                  Positioned(
                    top: 20,
                    left: 30,
                    child: Container(
                      width: 80,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(120),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    right: 40,
                    child: Container(
                      width: 100,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(180),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cloud,
                          size: 40,
                          color: primaryColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${selectedLocation}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Cloud Coverage: ${cloudData[0]["coverage"]}%",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentConditions() {
    final current = cloudData[0];
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Current Conditions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${current["coverage"]}%",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Coverage",
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
                        "${current["humidity"]}%",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Humidity",
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
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: secondaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.visibility, color: secondaryColor),
                SizedBox(width: spSm),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${current["type"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: secondaryColor,
                      ),
                    ),
                    Text(
                      "Visibility: ${current["visibility"]} • Altitude: ${current["altitude"]}",
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
    );
  }

  Widget _buildHourlyForecast() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Hourly Forecast",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QHorizontalScroll(
            children: List.generate(cloudData.length, (index) {
              final data = cloudData[index];
              return Container(
                width: 120,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  spacing: spXs,
                  children: [
                    Text(
                      "${data["time"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Icon(
                      Icons.cloud,
                      color: _getCloudColor((data["coverage"] as int)),
                      size: 24,
                    ),
                    Text(
                      "${data["coverage"]}%",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${data["type"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildCloudTypes() {
    List<Map<String, dynamic>> cloudTypes = [
      {"name": "Cumulus", "description": "Fair weather clouds", "percentage": 35, "color": Colors.blue},
      {"name": "Stratus", "description": "Low-level gray clouds", "percentage": 25, "color": Colors.grey},
      {"name": "Cirrus", "description": "High-altitude wispy clouds", "percentage": 20, "color": Colors.lightBlue},
      {"name": "Cumulonimbus", "description": "Storm clouds", "percentage": 20, "color": Colors.indigo},
    ];

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Cloud Types Distribution",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...cloudTypes.map((type) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: (type["color"] as Color).withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: type["color"] as Color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${type["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${type["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "${type["percentage"]}%",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: type["color"] as Color,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildVisibilityMeter() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Visibility Conditions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 120,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildVisibilityIndicator("Excellent", ">10km", Colors.green, true),
                    _buildVisibilityIndicator("Good", "5-10km", Colors.blue, false),
                    _buildVisibilityIndicator("Fair", "2-5km", Colors.orange, false),
                    _buildVisibilityIndicator("Poor", "<2km", Colors.red, false),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(Icons.visibility, color: successColor),
                    SizedBox(width: spSm),
                    Text(
                      "Current Visibility: ${cloudData[0]["visibility"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
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
  }

  Widget _buildVisibilityIndicator(String label, String range, Color color, bool isActive) {
    return Column(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: isActive ? color : disabledColor,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: isActive ? color : disabledBoldColor,
          ),
        ),
        Text(
          range,
          style: TextStyle(
            fontSize: 8,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Color _getCloudColor(int coverage) {
    if (coverage >= 80) return Colors.grey;
    if (coverage >= 60) return Colors.blueGrey;
    if (coverage >= 40) return Colors.lightBlue;
    return Colors.blue;
  }
}
