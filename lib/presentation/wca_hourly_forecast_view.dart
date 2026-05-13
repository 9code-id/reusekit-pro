import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaHourlyForecastView extends StatefulWidget {
  const WcaHourlyForecastView({super.key});

  @override
  State<WcaHourlyForecastView> createState() => _WcaHourlyForecastViewState();
}

class _WcaHourlyForecastViewState extends State<WcaHourlyForecastView> {
  String selectedLocation = "New York, NY";
  String selectedDay = "Today";
  bool isLoading = false;

  List<Map<String, dynamic>> dayOptions = [
    {"label": "Today", "value": "Today"},
    {"label": "Tomorrow", "value": "Tomorrow"},
    {"label": "Day After Tomorrow", "value": "Day After Tomorrow"},
  ];

  List<Map<String, dynamic>> hourlyForecast = [
    {
      "time": "Now",
      "hour": "14:00",
      "temperature": 22,
      "condition": "Sunny",
      "icon": Icons.wb_sunny,
      "humidity": 65,
      "windSpeed": 12,
      "precipitation": 0,
      "feelsLike": 25,
      "isNow": true,
    },
    {
      "time": "15:00",
      "hour": "15:00",
      "temperature": 24,
      "condition": "Sunny",
      "icon": Icons.wb_sunny,
      "humidity": 62,
      "windSpeed": 14,
      "precipitation": 0,
      "feelsLike": 27,
      "isNow": false,
    },
    {
      "time": "16:00",
      "hour": "16:00",
      "temperature": 26,
      "condition": "Partly Cloudy",
      "icon": Icons.wb_cloudy,
      "humidity": 58,
      "windSpeed": 16,
      "precipitation": 10,
      "feelsLike": 29,
      "isNow": false,
    },
    {
      "time": "17:00",
      "hour": "17:00",
      "temperature": 25,
      "condition": "Cloudy",
      "icon": Icons.cloud,
      "humidity": 60,
      "windSpeed": 15,
      "precipitation": 20,
      "feelsLike": 28,
      "isNow": false,
    },
    {
      "time": "18:00",
      "hour": "18:00",
      "temperature": 23,
      "condition": "Light Rain",
      "icon": Icons.grain,
      "humidity": 75,
      "windSpeed": 18,
      "precipitation": 60,
      "feelsLike": 26,
      "isNow": false,
    },
    {
      "time": "19:00",
      "hour": "19:00",
      "temperature": 21,
      "condition": "Rain",
      "icon": Icons.water_drop,
      "humidity": 80,
      "windSpeed": 20,
      "precipitation": 85,
      "feelsLike": 24,
      "isNow": false,
    },
    {
      "time": "20:00",
      "hour": "20:00",
      "temperature": 19,
      "condition": "Heavy Rain",
      "icon": Icons.thunderstorm,
      "humidity": 85,
      "windSpeed": 22,
      "precipitation": 95,
      "feelsLike": 22,
      "isNow": false,
    },
    {
      "time": "21:00",
      "hour": "21:00",
      "temperature": 18,
      "condition": "Thunderstorm",
      "icon": Icons.flash_on,
      "humidity": 88,
      "windSpeed": 25,
      "precipitation": 100,
      "feelsLike": 21,
      "isNow": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hourly Forecast"),
        actions: [
          QButton(
            icon: Icons.calendar_today,
            size: bs.sm,
            onPressed: () {
              _showDaySelector();
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
              ss("Hourly forecast updated");
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
                      "$selectedLocation - $selectedDay",
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
                        Icons.schedule,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "24-Hour Forecast",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 140,
                    child: QHorizontalScroll(
                      children: hourlyForecast.map((hour) {
                        bool isNow = hour["isNow"];
                        Color precipColor = _getPrecipitationColor((hour["precipitation"] as int));
                        
                        return Container(
                          width: 100,
                          margin: EdgeInsets.only(right: spSm),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isNow ? primaryColor.withAlpha(20) : Colors.grey[50],
                            borderRadius: BorderRadius.circular(radiusMd),
                            border: Border.all(
                              color: isNow ? primaryColor : disabledOutlineBorderColor,
                              width: isNow ? 2 : 1,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "${hour["time"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: isNow ? FontWeight.bold : FontWeight.w600,
                                      color: isNow ? primaryColor : disabledBoldColor,
                                    ),
                                  ),
                                  if (!isNow)
                                    Text(
                                      "${hour["hour"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledColor,
                                      ),
                                    ),
                                ],
                              ),
                              Icon(
                                hour["icon"],
                                size: 28,
                                color: isNow ? primaryColor : disabledBoldColor,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "${hour["temperature"]}°",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  if ((hour["precipitation"] as int) > 0)
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 4,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: precipColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${hour["precipitation"]}%",
                                        style: TextStyle(
                                          fontSize: 8,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
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
                        Icons.info,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Detailed Hourly Data",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: hourlyForecast.take(8).map((hour) {
                      Color precipColor = _getPrecipitationColor((hour["precipitation"] as int));
                      bool isNow = hour["isNow"];
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: isNow ? primaryColor.withAlpha(20) : Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isNow ? primaryColor : disabledOutlineBorderColor,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${hour["time"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  if (!isNow)
                                    Text(
                                      "${hour["hour"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledColor,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Container(
                              width: 50,
                              child: Column(
                                children: [
                                  Icon(
                                    hour["icon"],
                                    size: 24,
                                    color: primaryColor,
                                  ),
                                  Text(
                                    "${hour["condition"]}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _buildHourlyMetric("Temp", "${hour["temperature"]}°C", Icons.thermostat),
                                  ),
                                  Expanded(
                                    child: _buildHourlyMetric("Feels", "${hour["feelsLike"]}°C", Icons.device_thermostat),
                                  ),
                                  Expanded(
                                    child: _buildHourlyMetric("Wind", "${hour["windSpeed"]} km/h", Icons.air),
                                  ),
                                  Expanded(
                                    child: _buildHourlyMetric("Rain", "${hour["precipitation"]}%", Icons.water_drop, precipColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: warningColor.withAlpha(50),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Weather Alert",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Thunderstorms expected between 20:00 - 22:00. Heavy rainfall with strong winds up to 25 km/h. Consider indoor activities during this period.",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.umbrella,
                        color: warningColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Carry an umbrella and avoid outdoor activities",
                        style: TextStyle(
                          fontSize: 11,
                          color: warningColor,
                          fontWeight: FontWeight.w600,
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

  Widget _buildHourlyMetric(String label, String value, IconData icon, [Color? color]) {
    return Column(
      children: [
        Icon(
          icon,
          size: 12,
          color: color ?? disabledBoldColor,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 8,
            color: disabledColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: color ?? primaryColor,
          ),
        ),
      ],
    );
  }

  Color _getPrecipitationColor(int precipitation) {
    if (precipitation >= 80) return Colors.red;
    if (precipitation >= 60) return Colors.orange;
    if (precipitation >= 40) return Colors.yellow[700]!;
    if (precipitation >= 20) return Colors.blue;
    return Colors.grey;
  }

  void _showDaySelector() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Select Day"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: dayOptions.map((option) {
              return RadioListTile<String>(
                title: Text("${option["label"]}"),
                value: option["value"],
                groupValue: selectedDay,
                onChanged: (value) {
                  selectedDay = value!;
                  setState(() {});
                  Navigator.pop(context);
                  ss("Showing forecast for $selectedDay");
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
