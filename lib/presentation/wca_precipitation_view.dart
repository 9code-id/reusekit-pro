import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaPrecipitationView extends StatefulWidget {
  const WcaPrecipitationView({super.key});

  @override
  State<WcaPrecipitationView> createState() => _WcaPrecipitationViewState();
}

class _WcaPrecipitationViewState extends State<WcaPrecipitationView> {
  String selectedLocation = "New York, NY";
  String selectedTimeframe = "24 Hours";
  int selectedTab = 0;

  List<Map<String, dynamic>> locationItems = [
    {"label": "New York, NY", "value": "New York, NY"},
    {"label": "Los Angeles, CA", "value": "Los Angeles, CA"},
    {"label": "Chicago, IL", "value": "Chicago, IL"},
    {"label": "Houston, TX", "value": "Houston, TX"},
    {"label": "Phoenix, AZ", "value": "Phoenix, AZ"},
  ];

  List<Map<String, dynamic>> timeframeItems = [
    {"label": "24 Hours", "value": "24 Hours"},
    {"label": "7 Days", "value": "7 Days"},
    {"label": "30 Days", "value": "30 Days"},
    {"label": "Yearly", "value": "Yearly"},
  ];

  List<Map<String, dynamic>> hourlyPrecipitation = [
    {"hour": "00:00", "rain": 0.0, "snow": 0.0, "type": "Clear"},
    {"hour": "03:00", "rain": 0.2, "snow": 0.0, "type": "Light Rain"},
    {"hour": "06:00", "rain": 1.5, "snow": 0.0, "type": "Rain"},
    {"hour": "09:00", "rain": 3.2, "snow": 0.0, "type": "Heavy Rain"},
    {"hour": "12:00", "rain": 2.1, "snow": 0.0, "type": "Rain"},
    {"hour": "15:00", "rain": 0.8, "snow": 0.0, "type": "Light Rain"},
    {"hour": "18:00", "rain": 0.0, "snow": 0.5, "type": "Light Snow"},
    {"hour": "21:00", "rain": 0.0, "snow": 1.2, "type": "Snow"},
  ];

  List<Map<String, dynamic>> weeklyForecast = [
    {
      "day": "Today",
      "date": "Jun 18",
      "rain": 7.8,
      "snow": 1.7,
      "probability": 85,
      "type": "Mixed"
    },
    {
      "day": "Tomorrow",
      "date": "Jun 19",
      "rain": 2.1,
      "snow": 0.0,
      "probability": 40,
      "type": "Rain"
    },
    {
      "day": "Thursday",
      "date": "Jun 20",
      "rain": 0.0,
      "snow": 0.0,
      "probability": 10,
      "type": "Clear"
    },
    {
      "day": "Friday",
      "date": "Jun 21",
      "rain": 5.3,
      "snow": 0.0,
      "probability": 75,
      "type": "Rain"
    },
    {
      "day": "Saturday",
      "date": "Jun 22",
      "rain": 12.4,
      "snow": 0.0,
      "probability": 95,
      "type": "Heavy Rain"
    },
    {
      "day": "Sunday",
      "date": "Jun 23",
      "rain": 1.8,
      "snow": 0.0,
      "probability": 35,
      "type": "Light Rain"
    },
    {
      "day": "Monday",
      "date": "Jun 24",
      "rain": 0.0,
      "snow": 2.5,
      "probability": 60,
      "type": "Snow"
    },
  ];

  List<Map<String, dynamic>> precipitationTypes = [
    {
      "type": "Rain",
      "amount": 18.2,
      "unit": "mm",
      "percentage": 85,
      "icon": Icons.water_drop,
      "color": infoColor
    },
    {
      "type": "Snow",
      "amount": 4.2,
      "unit": "cm",
      "percentage": 15,
      "icon": Icons.ac_unit,
      "color": primaryColor
    },
    {
      "type": "Sleet",
      "amount": 0.0,
      "unit": "mm",
      "percentage": 0,
      "icon": Icons.grain,
      "color": warningColor
    },
    {
      "type": "Hail",
      "amount": 0.0,
      "unit": "mm",
      "percentage": 0,
      "icon": Icons.circle,
      "color": dangerColor
    },
  ];

  List<Map<String, dynamic>> radarData = [
    {"time": "30 min ago", "intensity": "Light", "coverage": "15%"},
    {"time": "15 min ago", "intensity": "Moderate", "coverage": "35%"},
    {"time": "Now", "intensity": "Heavy", "coverage": "60%"},
    {"time": "15 min", "intensity": "Moderate", "coverage": "40%"},
    {"time": "30 min", "intensity": "Light", "coverage": "20%"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Precipitation Analysis"),
        actions: [
          IconButton(
            icon: Icon(Icons.radar),
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

            // Current Precipitation Overview
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
                        "Current Precipitation",
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
                              "Current Rate",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "3.2 mm/hr",
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
                              "24hr Total",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "22.4 mm",
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
                              "Probability",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "85%",
                              style: TextStyle(
                                fontSize: 20,
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

            // Precipitation Types Distribution
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
                    "Precipitation Types",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: precipitationTypes.map((type) => Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: (type["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: (type["color"] as Color).withAlpha(50)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Icon(
                                type["icon"] as IconData,
                                color: type["color"] as Color,
                                size: 20,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${type["type"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "${(type["amount"] as double).toStringAsFixed(1)} ${type["unit"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: type["color"] as Color,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${type["percentage"]}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: (type["percentage"] as int) / 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: type["color"] as Color,
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
                          "Hourly",
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
                          "Weekly",
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
                          "Radar",
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
              // Hourly Precipitation
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
                      "24-Hour Precipitation Forecast",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    ...hourlyPrecipitation.map((hour) => Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: _getPrecipitationTypeColor(hour["type"] as String).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: _getPrecipitationTypeColor(hour["type"] as String).withAlpha(50),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 40,
                            decoration: BoxDecoration(
                              color: _getPrecipitationTypeColor(hour["type"] as String),
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Center(
                              child: Text(
                                "${hour["hour"]}".split(':')[0],
                                style: TextStyle(
                                  fontSize: 14,
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
                                      "${hour["type"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Spacer(),
                                    if ((hour["rain"] as double) > 0)
                                      Text(
                                        "Rain: ${(hour["rain"] as double).toStringAsFixed(1)}mm",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: infoColor,
                                        ),
                                      ),
                                    if ((hour["snow"] as double) > 0)
                                      Text(
                                        "Snow: ${(hour["snow"] as double).toStringAsFixed(1)}cm",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: primaryColor,
                                        ),
                                      ),
                                  ],
                                ),
                                Container(
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Row(
                                    children: [
                                      if ((hour["rain"] as double) > 0)
                                        Expanded(
                                          flex: ((hour["rain"] as double) * 10).toInt(),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: infoColor,
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                          ),
                                        ),
                                      if ((hour["snow"] as double) > 0)
                                        Expanded(
                                          flex: ((hour["snow"] as double) * 10).toInt(),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                          ),
                                        ),
                                      Expanded(
                                        flex: (50 - ((hour["rain"] as double) + (hour["snow"] as double)) * 10).toInt().clamp(1, 50),
                                        child: Container(),
                                      ),
                                    ],
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
              // Weekly Forecast
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
                      "7-Day Precipitation Forecast",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    ...weeklyForecast.map((day) => Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        color: _getPrecipitationTypeColor(day["type"] as String).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: _getPrecipitationTypeColor(day["type"] as String).withAlpha(50),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            height: 50,
                            decoration: BoxDecoration(
                              color: _getPrecipitationTypeColor(day["type"] as String),
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${day["day"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "${day["date"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
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
                                      "${day["type"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${day["probability"]}%",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: warningColor,
                                      ),
                                    ),
                                  ],
                                ),
                                if ((day["rain"] as double) > 0)
                                  Text(
                                    "Rain: ${(day["rain"] as double).toStringAsFixed(1)}mm",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                if ((day["snow"] as double) > 0)
                                  Text(
                                    "Snow: ${(day["snow"] as double).toStringAsFixed(1)}cm",
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

            if (selectedTab == 2) ...[
              // Radar Data
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
                      "Precipitation Radar",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.radar,
                              size: 60,
                              color: primaryColor,
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "Interactive Precipitation Radar",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Live precipitation tracking",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      "Radar Timeline",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    ...radarData.map((radar) => Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: _getIntensityColor(radar["intensity"] as String).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: _getIntensityColor(radar["intensity"] as String).withAlpha(50),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 30,
                            decoration: BoxDecoration(
                              color: _getIntensityColor(radar["intensity"] as String),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Center(
                              child: Text(
                                "${radar["time"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  "${radar["intensity"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "Coverage: ${radar["coverage"]}",
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

            // Precipitation Alerts
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: warningColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning_amber, color: warningColor),
                      SizedBox(width: spXs),
                      Text(
                        "Precipitation Alerts",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  Divider(color: warningColor.withAlpha(30)),
                  Text(
                    "⚠️ Heavy rain expected between 9:00 AM - 12:00 PM",
                    style: TextStyle(fontSize: 13, color: primaryColor),
                  ),
                  Text(
                    "• Possible flooding in low-lying areas",
                    style: TextStyle(fontSize: 13, color: primaryColor),
                  ),
                  Text(
                    "• Reduced visibility during precipitation",
                    style: TextStyle(fontSize: 13, color: primaryColor),
                  ),
                  Text(
                    "• Allow extra travel time",
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

  Color _getPrecipitationTypeColor(String type) {
    switch (type) {
      case "Clear":
        return successColor;
      case "Light Rain":
      case "Light Snow":
        return infoColor;
      case "Rain":
      case "Snow":
        return primaryColor;
      case "Heavy Rain":
        return dangerColor;
      case "Mixed":
        return warningColor;
      default:
        return disabledColor;
    }
  }

  Color _getIntensityColor(String intensity) {
    switch (intensity) {
      case "Light":
        return successColor;
      case "Moderate":
        return warningColor;
      case "Heavy":
        return dangerColor;
      default:
        return primaryColor;
    }
  }
}
