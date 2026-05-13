import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaTemperatureView extends StatefulWidget {
  const WcaTemperatureView({super.key});

  @override
  State<WcaTemperatureView> createState() => _WcaTemperatureViewState();
}

class _WcaTemperatureViewState extends State<WcaTemperatureView> {
  String selectedLocation = "Phoenix, AZ";
  String temperatureUnit = "fahrenheit";
  bool isLoading = false;

  Map<String, dynamic> currentTemperature = {
    "current": 105,
    "feelsLike": 112,
    "high": 108,
    "low": 88,
    "condition": "Hot and Sunny",
    "icon": "☀️",
    "lastUpdated": "2:45 PM",
  };

  List<Map<String, dynamic>> hourlyTemperature = [
    {"time": "Now", "temp": 105, "icon": "☀️"},
    {"time": "3 PM", "temp": 107, "icon": "☀️"},
    {"time": "4 PM", "temp": 108, "icon": "☀️"},
    {"time": "5 PM", "temp": 106, "icon": "☀️"},
    {"time": "6 PM", "temp": 104, "icon": "🌤️"},
    {"time": "7 PM", "temp": 101, "icon": "🌤️"},
    {"time": "8 PM", "temp": 98, "icon": "🌅"},
    {"time": "9 PM", "temp": 95, "icon": "🌆"},
    {"time": "10 PM", "temp": 92, "icon": "🌙"},
    {"time": "11 PM", "temp": 90, "icon": "🌙"},
  ];

  List<Map<String, dynamic>> weeklyTemperature = [
    {"day": "Today", "high": 108, "low": 88, "avg": 98},
    {"day": "Tue", "high": 106, "low": 86, "avg": 96},
    {"day": "Wed", "high": 104, "low": 84, "avg": 94},
    {"day": "Thu", "high": 102, "low": 82, "avg": 92},
    {"day": "Fri", "high": 100, "low": 80, "avg": 90},
    {"day": "Sat", "high": 103, "low": 83, "avg": 93},
    {"day": "Sun", "high": 105, "low": 85, "avg": 95},
  ];

  List<Map<String, dynamic>> temperatureRecords = [
    {"label": "Record High", "value": 122, "date": "June 26, 1990"},
    {"label": "Record Low", "value": 16, "date": "January 7, 1913"},
    {"label": "Average High", "value": 104, "date": "This time of year"},
    {"label": "Average Low", "value": 78, "date": "This time of year"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Temperature"),
        actions: [
          IconButton(
            icon: Icon(Icons.thermostat),
            onPressed: () {
              temperatureUnit = temperatureUnit == "fahrenheit" ? "celsius" : "fahrenheit";
              setState(() {});
              si("Temperature unit changed to ${temperatureUnit == "fahrenheit" ? "Fahrenheit" : "Celsius"}");
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(spLg),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [dangerColor, warningColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                selectedLocation,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              temperatureUnit == "fahrenheit" ? "°F" : "°C",
                              style: TextStyle(
                                color: Colors.white.withAlpha(180),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spLg),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${currentTemperature["icon"]}",
                              style: TextStyle(fontSize: 60),
                            ),
                            SizedBox(width: spMd),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${_convertTemperature(currentTemperature["current"])}°",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${currentTemperature["condition"]}",
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(200),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: spMd),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildTempInfo(
                              "Feels Like",
                              "${_convertTemperature(currentTemperature["feelsLike"])}°",
                              Icons.thermostat,
                            ),
                            _buildTempInfo(
                              "High",
                              "${_convertTemperature(currentTemperature["high"])}°",
                              Icons.keyboard_arrow_up,
                            ),
                            _buildTempInfo(
                              "Low",
                              "${_convertTemperature(currentTemperature["low"])}°",
                              Icons.keyboard_arrow_down,
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Last updated: ${currentTemperature["lastUpdated"]}",
                          style: TextStyle(
                            color: Colors.white.withAlpha(180),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Text(
                    "Hourly Temperature",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  QHorizontalScroll(
                    children: hourlyTemperature.map((hour) {
                      bool isNow = hour["time"] == "Now";
                      return Container(
                        width: 80,
                        padding: EdgeInsets.all(spMd),
                        margin: EdgeInsets.only(right: spSm),
                        decoration: BoxDecoration(
                          color: isNow ? primaryColor.withAlpha(20) : Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(
                            color: isNow ? primaryColor.withAlpha(50) : disabledOutlineBorderColor,
                          ),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${hour["time"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isNow ? primaryColor : disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${hour["icon"]}",
                              style: TextStyle(fontSize: 24),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${_convertTemperature(hour["temp"])}°",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isNow ? primaryColor : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),

                  Text(
                    "7-Day Temperature Trend",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spSm,
                      children: weeklyTemperature.map((day) {
                        bool isToday = day["day"] == "Today";
                        return Row(
                          children: [
                            Container(
                              width: 60,
                              child: Text(
                                "${day["day"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                                  color: isToday ? primaryColor : disabledBoldColor,
                                ),
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Container(
                                height: 8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusXs),
                                  gradient: LinearGradient(
                                    colors: [
                                      infoColor.withAlpha(100),
                                      dangerColor.withAlpha(100),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: spMd),
                            Row(
                              children: [
                                Text(
                                  "${_convertTemperature(day["low"])}°",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: infoColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${_convertTemperature(day["high"])}°",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: dangerColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),

                  Text(
                    "Temperature Records",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: temperatureRecords.map((record) {
                      Color cardColor = record["label"] == "Record High" || record["label"] == "Average High"
                          ? dangerColor
                          : infoColor;
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: cardColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(color: cardColor.withAlpha(50)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  record["label"].contains("High") ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                  color: cardColor,
                                  size: 20,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${record["label"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: cardColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${_convertTemperature(record["value"])}°",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${record["date"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
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
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: warningColor.withAlpha(50)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning_amber,
                          color: warningColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Heat Safety Advisory",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Extreme heat conditions. Stay hydrated and avoid prolonged outdoor exposure during peak hours.",
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

                  QButton(
                    label: "Refresh Temperature Data",
                    size: bs.md,
                    onPressed: () {
                      isLoading = true;
                      setState(() {});
                      Future.delayed(Duration(seconds: 2), () {
                        isLoading = false;
                        setState(() {});
                        ss("Temperature data updated");
                      });
                    },
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildTempInfo(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white.withAlpha(180),
          size: 20,
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withAlpha(180),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  int _convertTemperature(int fahrenheit) {
    if (temperatureUnit == "celsius") {
      return ((fahrenheit - 32) * 5 / 9).round();
    }
    return fahrenheit;
  }
}
