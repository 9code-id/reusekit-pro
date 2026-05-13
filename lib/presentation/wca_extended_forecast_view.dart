import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaExtendedForecastView extends StatefulWidget {
  const WcaExtendedForecastView({super.key});

  @override
  State<WcaExtendedForecastView> createState() => _WcaExtendedForecastViewState();
}

class _WcaExtendedForecastViewState extends State<WcaExtendedForecastView> {
  String selectedLocation = "San Francisco, CA";
  int selectedDays = 15;
  bool isLoading = false;

  List<Map<String, dynamic>> extendedForecast = [
    {
      "date": "Dec 16",
      "day": "Mon",
      "icon": "☀️",
      "condition": "Sunny",
      "high": 68,
      "low": 52,
      "precipitation": 0,
      "humidity": 45,
      "wind": 8,
      "uvIndex": 6,
    },
    {
      "date": "Dec 17",
      "day": "Tue",
      "icon": "⛅",
      "condition": "Partly Cloudy",
      "high": 64,
      "low": 48,
      "precipitation": 15,
      "humidity": 58,
      "wind": 12,
      "uvIndex": 4,
    },
    {
      "date": "Dec 18",
      "day": "Wed",
      "icon": "🌧️",
      "condition": "Light Rain",
      "high": 59,
      "low": 44,
      "precipitation": 70,
      "humidity": 75,
      "wind": 15,
      "uvIndex": 2,
    },
    {
      "date": "Dec 19",
      "day": "Thu",
      "icon": "⛈️",
      "condition": "Thunderstorms",
      "high": 56,
      "low": 41,
      "precipitation": 90,
      "humidity": 85,
      "wind": 20,
      "uvIndex": 1,
    },
    {
      "date": "Dec 20",
      "day": "Fri",
      "icon": "🌦️",
      "condition": "Scattered Showers",
      "high": 61,
      "low": 46,
      "precipitation": 55,
      "humidity": 65,
      "wind": 10,
      "uvIndex": 3,
    },
    {
      "date": "Dec 21",
      "day": "Sat",
      "icon": "☀️",
      "condition": "Clear",
      "high": 67,
      "low": 51,
      "precipitation": 5,
      "humidity": 42,
      "wind": 7,
      "uvIndex": 7,
    },
    {
      "date": "Dec 22",
      "day": "Sun",
      "icon": "⛅",
      "condition": "Mostly Sunny",
      "high": 65,
      "low": 49,
      "precipitation": 10,
      "humidity": 48,
      "wind": 9,
      "uvIndex": 5,
    },
    {
      "date": "Dec 23",
      "day": "Mon",
      "icon": "🌤️",
      "condition": "Partly Sunny",
      "high": 63,
      "low": 47,
      "precipitation": 20,
      "humidity": 52,
      "wind": 11,
      "uvIndex": 4,
    },
    {
      "date": "Dec 24",
      "day": "Tue",
      "icon": "☁️",
      "condition": "Cloudy",
      "high": 60,
      "low": 45,
      "precipitation": 30,
      "humidity": 60,
      "wind": 8,
      "uvIndex": 2,
    },
    {
      "date": "Dec 25",
      "day": "Wed",
      "icon": "🌧️",
      "condition": "Rain",
      "high": 57,
      "low": 42,
      "precipitation": 80,
      "humidity": 78,
      "wind": 14,
      "uvIndex": 1,
    },
    {
      "date": "Dec 26",
      "day": "Thu",
      "icon": "⛅",
      "condition": "Partly Cloudy",
      "high": 62,
      "low": 46,
      "precipitation": 25,
      "humidity": 55,
      "wind": 10,
      "uvIndex": 4,
    },
    {
      "date": "Dec 27",
      "day": "Fri",
      "icon": "☀️",
      "condition": "Sunny",
      "high": 66,
      "low": 50,
      "precipitation": 5,
      "humidity": 44,
      "wind": 6,
      "uvIndex": 6,
    },
    {
      "date": "Dec 28",
      "day": "Sat",
      "icon": "🌤️",
      "condition": "Mostly Sunny",
      "high": 64,
      "low": 48,
      "precipitation": 15,
      "humidity": 47,
      "wind": 8,
      "uvIndex": 5,
    },
    {
      "date": "Dec 29",
      "day": "Sun",
      "icon": "☁️",
      "condition": "Overcast",
      "high": 61,
      "low": 45,
      "precipitation": 35,
      "humidity": 62,
      "wind": 9,
      "uvIndex": 2,
    },
    {
      "date": "Dec 30",
      "day": "Mon",
      "icon": "🌦️",
      "condition": "Light Showers",
      "high": 58,
      "low": 43,
      "precipitation": 65,
      "humidity": 72,
      "wind": 12,
      "uvIndex": 2,
    },
  ];

  List<Map<String, dynamic>> forecastOptions = [
    {"label": "7 Days", "value": 7},
    {"label": "10 Days", "value": 10},
    {"label": "15 Days", "value": 15},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Extended Forecast"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              si("Filter options coming soon");
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
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [successColor, successColor.withAlpha(180)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            GestureDetector(
                              onTap: () {
                                si("Change location feature coming soon");
                              },
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(50),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Extended $selectedDays-Day Weather Outlook",
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Row(
                    children: [
                      Text(
                        "Forecast Period",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm),
                        decoration: BoxDecoration(
                          border: Border.all(color: disabledOutlineBorderColor),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: DropdownButton<int>(
                          value: selectedDays,
                          underline: SizedBox(),
                          icon: Icon(Icons.keyboard_arrow_down, size: 20),
                          items: forecastOptions.map((option) {
                            return DropdownMenuItem<int>(
                              value: option["value"] as int,
                              child: Text("${option["label"]}"),
                            );
                          }).toList(),
                          onChanged: (value) {
                            selectedDays = value!;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  Column(
                    spacing: spSm,
                    children: extendedForecast.take(selectedDays).map((forecast) {
                      bool isFirstDay = extendedForecast.indexOf(forecast) == 0;
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: isFirstDay ? primaryColor.withAlpha(20) : Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(
                            color: isFirstDay ? primaryColor.withAlpha(50) : disabledOutlineBorderColor,
                          ),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${forecast["icon"]}",
                                      style: TextStyle(fontSize: 20),
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
                                                "${forecast["day"]}, ${forecast["date"]}",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: isFirstDay ? primaryColor : Colors.black,
                                                ),
                                              ),
                                              Text(
                                                "${forecast["condition"]}",
                                                style: TextStyle(
                                                  fontSize: 14,
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
                                                  fontSize: 18,
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spMd),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Icon(
                                      Icons.water_drop,
                                      size: 18,
                                      color: infoColor,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "${forecast["precipitation"]}%",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "Rain",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(
                                      Icons.opacity,
                                      size: 18,
                                      color: successColor,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "${forecast["humidity"]}%",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "Humidity",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(
                                      Icons.air,
                                      size: 18,
                                      color: warningColor,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "${forecast["wind"]} mph",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "Wind",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(
                                      Icons.wb_sunny,
                                      size: 18,
                                      color: dangerColor,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "${forecast["uvIndex"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "UV Index",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledColor,
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
                          Icons.info_outline,
                          color: warningColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Extended Forecast Notice",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Long-term forecasts become less accurate over time. Use as a general guide for planning purposes.",
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
                    label: "Refresh Forecast",
                    size: bs.md,
                    onPressed: () {
                      isLoading = true;
                      setState(() {});
                      Future.delayed(Duration(seconds: 2), () {
                        isLoading = false;
                        setState(() {});
                        ss("Extended forecast updated successfully");
                      });
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
