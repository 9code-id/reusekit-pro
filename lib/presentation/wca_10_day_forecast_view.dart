import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class Wca10DayForecastView extends StatefulWidget {
  const Wca10DayForecastView({super.key});

  @override
  State<Wca10DayForecastView> createState() => _Wca10DayForecastViewState();
}

class _Wca10DayForecastViewState extends State<Wca10DayForecastView> {
  String selectedLocation = "Miami, FL";
  bool isLoading = false;
  String selectedView = "detailed";

  List<Map<String, dynamic>> tenDayForecast = [
    {
      "date": "Dec 16",
      "day": "Today",
      "icon": "☀️",
      "condition": "Sunny",
      "high": 84,
      "low": 72,
      "precipitation": 0,
      "humidity": 65,
      "wind": 12,
      "uvIndex": 9,
      "sunrise": "7:05 AM",
      "sunset": "5:32 PM",
    },
    {
      "date": "Dec 17",
      "day": "Tomorrow",
      "icon": "🌤️",
      "condition": "Mostly Sunny",
      "high": 82,
      "low": 70,
      "precipitation": 10,
      "humidity": 68,
      "wind": 14,
      "uvIndex": 8,
      "sunrise": "7:06 AM",
      "sunset": "5:32 PM",
    },
    {
      "date": "Dec 18",
      "day": "Wed",
      "icon": "⛅",
      "condition": "Partly Cloudy",
      "high": 79,
      "low": 68,
      "precipitation": 25,
      "humidity": 72,
      "wind": 16,
      "uvIndex": 6,
      "sunrise": "7:06 AM",
      "sunset": "5:33 PM",
    },
    {
      "date": "Dec 19",
      "day": "Thu",
      "icon": "🌧️",
      "condition": "Scattered Showers",
      "high": 76,
      "low": 65,
      "precipitation": 60,
      "humidity": 78,
      "wind": 18,
      "uvIndex": 4,
      "sunrise": "7:07 AM",
      "sunset": "5:33 PM",
    },
    {
      "date": "Dec 20",
      "day": "Fri",
      "icon": "⛈️",
      "condition": "Thunderstorms",
      "high": 74,
      "low": 63,
      "precipitation": 85,
      "humidity": 82,
      "wind": 22,
      "uvIndex": 3,
      "sunrise": "7:07 AM",
      "sunset": "5:34 PM",
    },
    {
      "date": "Dec 21",
      "day": "Sat",
      "icon": "🌦️",
      "condition": "Light Rain",
      "high": 77,
      "low": 66,
      "precipitation": 50,
      "humidity": 75,
      "wind": 15,
      "uvIndex": 5,
      "sunrise": "7:08 AM",
      "sunset": "5:34 PM",
    },
    {
      "date": "Dec 22",
      "day": "Sun",
      "icon": "⛅",
      "condition": "Partly Cloudy",
      "high": 80,
      "low": 69,
      "precipitation": 20,
      "humidity": 70,
      "wind": 13,
      "uvIndex": 7,
      "sunrise": "7:08 AM",
      "sunset": "5:35 PM",
    },
    {
      "date": "Dec 23",
      "day": "Mon",
      "icon": "☀️",
      "condition": "Sunny",
      "high": 83,
      "low": 71,
      "precipitation": 5,
      "humidity": 62,
      "wind": 11,
      "uvIndex": 9,
      "sunrise": "7:09 AM",
      "sunset": "5:35 PM",
    },
    {
      "date": "Dec 24",
      "day": "Tue",
      "icon": "🌤️",
      "condition": "Mostly Sunny",
      "high": 81,
      "low": 69,
      "precipitation": 15,
      "humidity": 66,
      "wind": 12,
      "uvIndex": 8,
      "sunrise": "7:09 AM",
      "sunset": "5:36 PM",
    },
    {
      "date": "Dec 25",
      "day": "Wed",
      "icon": "⛅",
      "condition": "Partly Cloudy",
      "high": 78,
      "low": 67,
      "precipitation": 30,
      "humidity": 74,
      "wind": 14,
      "uvIndex": 6,
      "sunrise": "7:10 AM",
      "sunset": "5:36 PM",
    },
  ];

  List<Map<String, dynamic>> viewOptions = [
    {"label": "Detailed View", "value": "detailed"},
    {"label": "Compact View", "value": "compact"},
    {"label": "Chart View", "value": "chart"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("10-Day Forecast"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              si("Share forecast feature coming soon");
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [infoColor, infoColor.withAlpha(180)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [shadowSm],
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  selectedLocation,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "10-Day Detailed Weather Forecast",
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(200),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              isLoading = true;
                              setState(() {});
                              Future.delayed(Duration(seconds: 2), () {
                                isLoading = false;
                                setState(() {});
                                ss("Forecast refreshed");
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.refresh,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spMd),
                      QCategoryPicker(
                        items: viewOptions,
                        value: selectedView,
                        onChanged: (index, label, value, item) {
                          selectedView = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(spMd),
                    child: selectedView == "detailed"
                        ? _buildDetailedView()
                        : selectedView == "compact"
                            ? _buildCompactView()
                            : _buildChartView(),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildDetailedView() {
    return Column(
      spacing: spMd,
      children: tenDayForecast.map((forecast) {
        bool isToday = forecast["day"] == "Today";
        return Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: isToday ? primaryColor.withAlpha(20) : Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(
              color: isToday ? primaryColor.withAlpha(50) : disabledOutlineBorderColor,
            ),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Center(
                      child: Text(
                        "${forecast["icon"]}",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${forecast["day"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isToday ? primaryColor : Colors.black,
                                  ),
                                ),
                                Text(
                                  "${forecast["date"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "${forecast["high"]}°",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  " / ${forecast["low"]}°",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${forecast["condition"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: isToday ? primaryColor : disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildDetailItem(
                    Icons.water_drop,
                    "${forecast["precipitation"]}%",
                    "Rain",
                    infoColor,
                  ),
                  _buildDetailItem(
                    Icons.opacity,
                    "${forecast["humidity"]}%",
                    "Humidity",
                    successColor,
                  ),
                  _buildDetailItem(
                    Icons.air,
                    "${forecast["wind"]} mph",
                    "Wind",
                    warningColor,
                  ),
                  _buildDetailItem(
                    Icons.wb_sunny,
                    "${forecast["uvIndex"]}",
                    "UV Index",
                    dangerColor,
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.wb_twilight,
                        size: 16,
                        color: warningColor,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "${forecast["sunrise"]}",
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
                        Icons.brightness_3,
                        size: 16,
                        color: primaryColor,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "${forecast["sunset"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
    );
  }

  Widget _buildCompactView() {
    return Column(
      spacing: spSm,
      children: tenDayForecast.map((forecast) {
        bool isToday = forecast["day"] == "Today";
        return Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: isToday ? primaryColor.withAlpha(20) : Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(
              color: isToday ? primaryColor.withAlpha(50) : disabledOutlineBorderColor,
            ),
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              Text(
                "${forecast["icon"]}",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${forecast["day"]} ${forecast["date"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isToday ? primaryColor : Colors.black,
                      ),
                    ),
                    Text(
                      "${forecast["condition"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    "${forecast["high"]}°",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "/${forecast["low"]}°",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              SizedBox(width: spMd),
              Icon(
                Icons.water_drop,
                size: 16,
                color: infoColor,
              ),
              SizedBox(width: 4),
              Text(
                "${forecast["precipitation"]}%",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildChartView() {
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
          Text(
            "Temperature Trend",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Container(
            height: 200,
            child: Center(
              child: Text(
                "Temperature Chart\n(Chart visualization would be implemented here)",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          SizedBox(height: spMd),
          Text(
            "Precipitation Forecast",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Container(
            height: 150,
            child: Center(
              child: Text(
                "Precipitation Chart\n(Chart visualization would be implemented here)",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String value, String label, Color color) {
    return Column(
      children: [
        Icon(
          icon,
          size: 18,
          color: color,
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: disabledBoldColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledColor,
          ),
        ),
      ],
    );
  }
}
