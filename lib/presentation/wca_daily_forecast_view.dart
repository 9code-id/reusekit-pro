import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaDailyForecastView extends StatefulWidget {
  const WcaDailyForecastView({super.key});

  @override
  State<WcaDailyForecastView> createState() => _WcaDailyForecastViewState();
}

class _WcaDailyForecastViewState extends State<WcaDailyForecastView> {
  String selectedLocation = "New York, NY";
  String selectedPeriod = "7 Days";
  bool isLoading = false;

  List<Map<String, dynamic>> periodOptions = [
    {"label": "7 Days", "value": "7 Days"},
    {"label": "10 Days", "value": "10 Days"},
    {"label": "14 Days", "value": "14 Days"},
  ];

  List<Map<String, dynamic>> dailyForecast = [
    {
      "date": "Today",
      "day": "Monday",
      "fullDate": "Dec 16",
      "highTemp": 24,
      "lowTemp": 18,
      "condition": "Sunny",
      "icon": Icons.wb_sunny,
      "precipitation": 10,
      "humidity": 65,
      "windSpeed": 12,
      "uvIndex": 8,
      "sunrise": "06:45",
      "sunset": "19:32",
      "isToday": true,
    },
    {
      "date": "Tomorrow",
      "day": "Tuesday",
      "fullDate": "Dec 17",
      "highTemp": 22,
      "lowTemp": 16,
      "condition": "Partly Cloudy",
      "icon": Icons.wb_cloudy,
      "precipitation": 20,
      "humidity": 70,
      "windSpeed": 15,
      "uvIndex": 6,
      "sunrise": "06:46",
      "sunset": "19:32",
      "isToday": false,
    },
    {
      "date": "Wednesday",
      "day": "Wednesday",
      "fullDate": "Dec 18",
      "highTemp": 19,
      "lowTemp": 13,
      "condition": "Rainy",
      "icon": Icons.grain,
      "precipitation": 85,
      "humidity": 80,
      "windSpeed": 18,
      "uvIndex": 3,
      "sunrise": "06:47",
      "sunset": "19:32",
      "isToday": false,
    },
    {
      "date": "Thursday",
      "day": "Thursday",
      "fullDate": "Dec 19",
      "highTemp": 21,
      "lowTemp": 15,
      "condition": "Cloudy",
      "icon": Icons.cloud,
      "precipitation": 40,
      "humidity": 75,
      "windSpeed": 14,
      "uvIndex": 4,
      "sunrise": "06:48",
      "sunset": "19:32",
      "isToday": false,
    },
    {
      "date": "Friday",
      "day": "Friday",
      "fullDate": "Dec 20",
      "highTemp": 26,
      "lowTemp": 20,
      "condition": "Sunny",
      "icon": Icons.wb_sunny,
      "precipitation": 5,
      "humidity": 60,
      "windSpeed": 10,
      "uvIndex": 9,
      "sunrise": "06:49",
      "sunset": "19:33",
      "isToday": false,
    },
    {
      "date": "Saturday",
      "day": "Saturday",
      "fullDate": "Dec 21",
      "highTemp": 28,
      "lowTemp": 22,
      "condition": "Clear",
      "icon": Icons.wb_sunny,
      "precipitation": 0,
      "humidity": 55,
      "windSpeed": 8,
      "uvIndex": 10,
      "sunrise": "06:50",
      "sunset": "19:33",
      "isToday": false,
    },
    {
      "date": "Sunday",
      "day": "Sunday",
      "fullDate": "Dec 22",
      "highTemp": 25,
      "lowTemp": 19,
      "condition": "Partly Cloudy",
      "icon": Icons.wb_cloudy,
      "precipitation": 15,
      "humidity": 62,
      "windSpeed": 12,
      "uvIndex": 7,
      "sunrise": "06:51",
      "sunset": "19:34",
      "isToday": false,
    },
  ];

  int selectedDayIndex = 0;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> selectedDay = dailyForecast[selectedDayIndex];
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Forecast"),
        actions: [
          QButton(
            icon: Icons.date_range,
            size: bs.sm,
            onPressed: () {
              _showPeriodSelector();
            },
          ),
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: () async {
              isLoading = true;
              setState(() {});
              await Future.delayed(Duration(seconds: 1));
              isLoading = false;
              setState(() {});
              ss("Daily forecast updated");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: primaryColor.withAlpha(50),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: primaryColor,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "$selectedLocation - $selectedPeriod Forecast",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (isLoading)
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                      ),
                    ),
                ],
              ),
            ),
            Container(
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
                      Icon(
                        Icons.calendar_today,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Weekly Overview",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 120,
                    child: QHorizontalScroll(
                      children: dailyForecast.asMap().entries.map((entry) {
                        int index = entry.key;
                        Map<String, dynamic> day = entry.value;
                        bool isSelected = selectedDayIndex == index;
                        bool isToday = day["isToday"];
                        Color precipColor = _getPrecipitationColor((day["precipitation"] as int));
                        
                        return GestureDetector(
                          onTap: () {
                            selectedDayIndex = index;
                            setState(() {});
                          },
                          child: Container(
                            width: 90,
                            margin: EdgeInsets.only(right: spSm),
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor.withAlpha(20) : (isToday ? successColor.withAlpha(20) : Colors.grey[50]),
                              borderRadius: BorderRadius.circular(radiusMd),
                              border: Border.all(
                                color: isSelected ? primaryColor : (isToday ? successColor : disabledOutlineBorderColor),
                                width: isSelected || isToday ? 2 : 1,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "${day["date"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: isSelected ? primaryColor : (isToday ? successColor : disabledBoldColor),
                                      ),
                                    ),
                                    Text(
                                      "${day["fullDate"]}",
                                      style: TextStyle(
                                        fontSize: 9,
                                        color: disabledColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(
                                  day["icon"],
                                  size: 24,
                                  color: isSelected ? primaryColor : disabledBoldColor,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "${day["highTemp"]}°",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${day["lowTemp"]}°",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    if ((day["precipitation"] as int) > 0)
                                      Container(
                                        margin: EdgeInsets.only(top: 2),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 4,
                                          vertical: 1,
                                        ),
                                        decoration: BoxDecoration(
                                          color: precipColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${day["precipitation"]}%",
                                          style: TextStyle(
                                            fontSize: 7,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primaryColor,
                    primaryColor.withAlpha(180),
                  ],
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${selectedDay["date"]}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "${selectedDay["day"]}, ${selectedDay["fullDate"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                            Text(
                              "${selectedDay["condition"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(220),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Icon(
                          selectedDay["icon"],
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "High",
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white.withAlpha(180),
                              ),
                            ),
                            Text(
                              "${selectedDay["highTemp"]}°C",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Low",
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white.withAlpha(180),
                              ),
                            ),
                            Text(
                              "${selectedDay["lowTemp"]}°C",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Rain",
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white.withAlpha(180),
                              ),
                            ),
                            Text(
                              "${selectedDay["precipitation"]}%",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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
            Container(
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
                      Icon(
                        Icons.analytics,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Weather Details",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 120,
                    children: [
                      _buildDetailCard("Humidity", "${selectedDay["humidity"]}%", Icons.water_drop, Colors.blue),
                      _buildDetailCard("Wind Speed", "${selectedDay["windSpeed"]} km/h", Icons.air, Colors.teal),
                      _buildDetailCard("UV Index", "${selectedDay["uvIndex"]}", Icons.wb_sunny_outlined, Colors.orange),
                      _buildDetailCard("Sunrise", "${selectedDay["sunrise"]}", Icons.wb_twilight, Colors.yellow),
                      _buildDetailCard("Sunset", "${selectedDay["sunset"]}", Icons.brightness_3, Colors.purple),
                      _buildDetailCard("Precipitation", "${selectedDay["precipitation"]}%", Icons.grain, _getPrecipitationColor((selectedDay["precipitation"] as int))),
                    ],
                  ),
                ],
              ),
            ),
            Container(
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
                      Icon(
                        Icons.trending_up,
                        color: successColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Weekly Trends",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: successColor.withAlpha(50),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.thermostat,
                                size: 20,
                                color: successColor,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Avg High",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "24°C",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
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
                            border: Border.all(
                              color: infoColor.withAlpha(50),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.ac_unit,
                                size: 20,
                                color: infoColor,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Avg Low",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "17°C",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
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
                            border: Border.all(
                              color: warningColor.withAlpha(50),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.grain,
                                size: 20,
                                color: warningColor,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Rain Days",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "3 days",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
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
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: color.withAlpha(50),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 20,
            color: color,
          ),
          SizedBox(height: spXs),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getPrecipitationColor(int precipitation) {
    if (precipitation >= 80) return Colors.red;
    if (precipitation >= 60) return Colors.orange;
    if (precipitation >= 40) return Colors.yellow[700]!;
    if (precipitation >= 20) return Colors.blue;
    return Colors.grey;
  }

  void _showPeriodSelector() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Select Forecast Period"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: periodOptions.map((option) {
              return RadioListTile<String>(
                title: Text("${option["label"]}"),
                value: option["value"],
                groupValue: selectedPeriod,
                onChanged: (value) {
                  selectedPeriod = value!;
                  setState(() {});
                  Navigator.pop(context);
                  ss("Showing $selectedPeriod forecast");
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
