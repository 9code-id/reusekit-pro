import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaWeatherForecastView extends StatefulWidget {
  const AmaWeatherForecastView({super.key});

  @override
  State<AmaWeatherForecastView> createState() => _AmaWeatherForecastViewState();
}

class _AmaWeatherForecastViewState extends State<AmaWeatherForecastView> {
  List<Map<String, dynamic>> extendedForecast = [
    {
      "date": "2024-06-15",
      "day": "Today",
      "high": 82,
      "low": 65,
      "condition": "Partly Cloudy",
      "description": "Partly cloudy with occasional sunshine",
      "precipitation": 20,
      "humidity": 65,
      "windSpeed": 12,
      "windDirection": "NW",
      "uvIndex": 6,
      "sunrise": "06:15",
      "sunset": "20:30",
      "moonPhase": "Waxing Crescent",
      "hourlyDetails": [
        {"time": "06:00", "temp": 65, "condition": "Clear", "precipitation": 0, "humidity": 75},
        {"time": "09:00", "temp": 72, "condition": "Sunny", "precipitation": 0, "humidity": 68},
        {"time": "12:00", "temp": 78, "condition": "Partly Cloudy", "precipitation": 5, "humidity": 62},
        {"time": "15:00", "temp": 82, "condition": "Partly Cloudy", "precipitation": 10, "humidity": 58},
        {"time": "18:00", "temp": 79, "condition": "Cloudy", "precipitation": 20, "humidity": 65},
        {"time": "21:00", "temp": 73, "condition": "Clear", "precipitation": 0, "humidity": 70},
      ]
    },
    {
      "date": "2024-06-16",
      "day": "Tomorrow",
      "high": 85,
      "low": 68,
      "condition": "Sunny",
      "description": "Clear skies with bright sunshine all day",
      "precipitation": 5,
      "humidity": 58,
      "windSpeed": 8,
      "windDirection": "SW",
      "uvIndex": 8,
      "sunrise": "06:15",
      "sunset": "20:31",
      "moonPhase": "Waxing Crescent",
      "hourlyDetails": [
        {"time": "06:00", "temp": 68, "condition": "Clear", "precipitation": 0, "humidity": 72},
        {"time": "09:00", "temp": 75, "condition": "Sunny", "precipitation": 0, "humidity": 65},
        {"time": "12:00", "temp": 81, "condition": "Sunny", "precipitation": 0, "humidity": 55},
        {"time": "15:00", "temp": 85, "condition": "Sunny", "precipitation": 0, "humidity": 50},
        {"time": "18:00", "temp": 82, "condition": "Sunny", "precipitation": 0, "humidity": 58},
        {"time": "21:00", "temp": 76, "condition": "Clear", "precipitation": 0, "humidity": 65},
      ]
    },
    {
      "date": "2024-06-17",
      "day": "Monday",
      "high": 83,
      "low": 66,
      "condition": "Partly Cloudy",
      "description": "Mix of sun and clouds throughout the day",
      "precipitation": 15,
      "humidity": 62,
      "windSpeed": 10,
      "windDirection": "W",
      "uvIndex": 7,
      "sunrise": "06:16",
      "sunset": "20:31",
      "moonPhase": "First Quarter",
      "hourlyDetails": [
        {"time": "06:00", "temp": 66, "condition": "Cloudy", "precipitation": 10, "humidity": 78},
        {"time": "09:00", "temp": 73, "condition": "Partly Cloudy", "precipitation": 5, "humidity": 68},
        {"time": "12:00", "temp": 79, "condition": "Partly Cloudy", "precipitation": 10, "humidity": 60},
        {"time": "15:00", "temp": 83, "condition": "Partly Cloudy", "precipitation": 15, "humidity": 55},
        {"time": "18:00", "temp": 80, "condition": "Cloudy", "precipitation": 20, "humidity": 62},
        {"time": "21:00", "temp": 74, "condition": "Partly Cloudy", "precipitation": 10, "humidity": 70},
      ]
    },
    {
      "date": "2024-06-18",
      "day": "Tuesday",
      "high": 79,
      "low": 63,
      "condition": "Rainy",
      "description": "Periods of rain, heavy at times during afternoon",
      "precipitation": 75,
      "humidity": 82,
      "windSpeed": 15,
      "windDirection": "E",
      "uvIndex": 3,
      "sunrise": "06:16",
      "sunset": "20:32",
      "moonPhase": "First Quarter",
      "hourlyDetails": [
        {"time": "06:00", "temp": 63, "condition": "Light Rain", "precipitation": 60, "humidity": 85},
        {"time": "09:00", "temp": 68, "condition": "Rainy", "precipitation": 70, "humidity": 82},
        {"time": "12:00", "temp": 72, "condition": "Heavy Rain", "precipitation": 85, "humidity": 88},
        {"time": "15:00", "temp": 75, "condition": "Heavy Rain", "precipitation": 90, "humidity": 85},
        {"time": "18:00", "temp": 74, "condition": "Light Rain", "precipitation": 65, "humidity": 80},
        {"time": "21:00", "temp": 70, "condition": "Cloudy", "precipitation": 40, "humidity": 78},
      ]
    },
    {
      "date": "2024-06-19",
      "day": "Wednesday",
      "high": 76,
      "low": 60,
      "condition": "Cloudy",
      "description": "Overcast skies with occasional light drizzle",
      "precipitation": 35,
      "humidity": 75,
      "windSpeed": 12,
      "windDirection": "NE",
      "uvIndex": 4,
      "sunrise": "06:17",
      "sunset": "20:32",
      "moonPhase": "Waxing Gibbous",
      "hourlyDetails": [
        {"time": "06:00", "temp": 60, "condition": "Cloudy", "precipitation": 30, "humidity": 80},
        {"time": "09:00", "temp": 65, "condition": "Cloudy", "precipitation": 25, "humidity": 75},
        {"time": "12:00", "temp": 71, "condition": "Light Rain", "precipitation": 40, "humidity": 78},
        {"time": "15:00", "temp": 74, "condition": "Cloudy", "precipitation": 35, "humidity": 72},
        {"time": "18:00", "temp": 72, "condition": "Cloudy", "precipitation": 30, "humidity": 75},
        {"time": "21:00", "temp": 67, "condition": "Cloudy", "precipitation": 25, "humidity": 78},
      ]
    },
  ];

  List<Map<String, dynamic>> farmingAlerts = [
    {
      "type": "Planting Alert",
      "message": "Excellent planting conditions expected tomorrow",
      "severity": "Info",
      "recommendations": [
        "Ideal soil temperature and moisture",
        "Low wind speeds perfect for seeding",
        "No rain expected for 48 hours"
      ]
    },
    {
      "type": "Spray Warning",
      "message": "Avoid spraying Tuesday due to rain",
      "severity": "Warning",
      "recommendations": [
        "Heavy rain will wash away chemicals",
        "High humidity reduces effectiveness",
        "Plan spraying for Wednesday morning"
      ]
    },
    {
      "type": "Harvest Advisory",
      "message": "Good harvest window Friday-Sunday",
      "severity": "Info",
      "recommendations": [
        "Dry conditions ideal for harvest",
        "Low humidity prevents mold",
        "Prepare equipment for optimal window"
      ]
    },
  ];

  String selectedLocation = "Farm Headquarters";
  String forecastType = "5-Day";
  int selectedDayIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Forecast"),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              // navigateTo('weather-map')
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // navigateTo('weather-alerts')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(20)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.cloud,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Extended Weather Forecast",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Detailed weather predictions for farm planning",
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

            SizedBox(height: spLg),

            // Location and Type Selection
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Location",
                    items: [
                      {"label": "Farm Headquarters", "value": "Farm Headquarters"},
                      {"label": "North Field", "value": "North Field"},
                      {"label": "South Field", "value": "South Field"},
                      {"label": "East Field", "value": "East Field"},
                      {"label": "West Field", "value": "West Field"},
                    ],
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
                    label: "Forecast Type",
                    items: [
                      {"label": "5-Day", "value": "5-Day"},
                      {"label": "7-Day", "value": "7-Day"},
                      {"label": "14-Day", "value": "14-Day"},
                    ],
                    value: forecastType,
                    onChanged: (value, label) {
                      forecastType = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Farming Alerts
            if (farmingAlerts.isNotEmpty) ...[
              Text(
                "Farming Alerts & Recommendations",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              SizedBox(height: spMd),

              ...farmingAlerts.map((alert) {
                Color alertColor = infoColor;
                if ("${alert["severity"]}" == "Warning") alertColor = warningColor;
                if ("${alert["severity"]}" == "Critical") alertColor = dangerColor;

                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: alertColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: alertColor.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.agriculture,
                            color: alertColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${alert["type"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: alertColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${alert["message"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: alertColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      ...(alert["recommendations"] as List<String>).map((rec) =>
                        Padding(
                          padding: EdgeInsets.only(bottom: spXs),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.check_circle,
                                size: 16,
                                color: alertColor,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  rec,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: alertColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),

              SizedBox(height: spLg),
            ],

            // Daily Forecast Cards
            Text(
              "Daily Forecast",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            SizedBox(height: spMd),

            QHorizontalScroll(
              children: extendedForecast.asMap().entries.map((entry) {
                final index = entry.key;
                final day = entry.value;
                final isSelected = index == selectedDayIndex;

                return GestureDetector(
                  onTap: () {
                    selectedDayIndex = index;
                    setState(() {});
                  },
                  child: Container(
                    width: 160,
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${day["day"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${day["date"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: isSelected ? Colors.white.withAlpha(200) : disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Icon(
                              _getWeatherIcon("${day["condition"]}"),
                              color: isSelected ? Colors.white : primaryColor,
                              size: 32,
                            ),
                            SizedBox(width: spSm),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${day["high"]}°",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected ? Colors.white : primaryColor,
                                  ),
                                ),
                                Text(
                                  "${day["low"]}°",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: isSelected ? Colors.white.withAlpha(200) : disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${day["condition"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: isSelected ? Colors.white.withAlpha(200) : disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(
                              Icons.opacity,
                              size: 12,
                              color: isSelected ? Colors.white.withAlpha(200) : infoColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${day["precipitation"]}%",
                              style: TextStyle(
                                fontSize: 12,
                                color: isSelected ? Colors.white.withAlpha(200) : infoColor,
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

            SizedBox(height: spLg),

            // Detailed View for Selected Day
            if (selectedDayIndex < extendedForecast.length) ...[
              Text(
                "Detailed Forecast - ${extendedForecast[selectedDayIndex]["day"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              SizedBox(height: spMd),

              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          _getWeatherIcon("${extendedForecast[selectedDayIndex]["condition"]}"),
                          color: primaryColor,
                          size: 48,
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${extendedForecast[selectedDayIndex]["condition"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${extendedForecast[selectedDayIndex]["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${extendedForecast[selectedDayIndex]["high"]}° / ${extendedForecast[selectedDayIndex]["low"]}°",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spLg),

                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 200,
                      children: [
                        _buildDetailCard("Precipitation", "${extendedForecast[selectedDayIndex]["precipitation"]}%", Icons.opacity, infoColor),
                        _buildDetailCard("Humidity", "${extendedForecast[selectedDayIndex]["humidity"]}%", Icons.water_drop, infoColor),
                        _buildDetailCard("Wind", "${extendedForecast[selectedDayIndex]["windSpeed"]} mph ${extendedForecast[selectedDayIndex]["windDirection"]}", Icons.air, warningColor),
                        _buildDetailCard("UV Index", "${extendedForecast[selectedDayIndex]["uvIndex"]}", Icons.wb_sunny, dangerColor),
                        _buildDetailCard("Sunrise", "${extendedForecast[selectedDayIndex]["sunrise"]}", Icons.wb_sunny_outlined, successColor),
                        _buildDetailCard("Sunset", "${extendedForecast[selectedDayIndex]["sunset"]}", Icons.brightness_3, successColor),
                      ],
                    ),

                    SizedBox(height: spLg),

                    Text(
                      "Hourly Breakdown",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),

                    SizedBox(height: spMd),

                    ...((extendedForecast[selectedDayIndex]["hourlyDetails"] as List).map((hour) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "${hour["time"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Icon(
                              _getWeatherIcon("${hour["condition"]}"),
                              color: primaryColor,
                              size: 20,
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Text(
                                "${hour["condition"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                            Text(
                              "${hour["temp"]}°",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Text(
                              "${hour["precipitation"]}%",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    })),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: color.withAlpha(20)),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: color,
          ),
          SizedBox(width: spSm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'sunny':
      case 'clear':
        return Icons.wb_sunny;
      case 'partly cloudy':
        return Icons.wb_cloudy;
      case 'cloudy':
        return Icons.cloud;
      case 'rainy':
      case 'light rain':
        return Icons.grain;
      case 'heavy rain':
        return Icons.thunderstorm;
      case 'thunderstorm':
        return Icons.flash_on;
      case 'snow':
        return Icons.ac_unit;
      default:
        return Icons.wb_sunny;
    }
  }
}
