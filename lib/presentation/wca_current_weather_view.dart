import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaCurrentWeatherView extends StatefulWidget {
  const WcaCurrentWeatherView({super.key});

  @override
  State<WcaCurrentWeatherView> createState() => _WcaCurrentWeatherViewState();
}

class _WcaCurrentWeatherViewState extends State<WcaCurrentWeatherView> {
  String selectedLocation = "New York, NY";
  bool isLoading = false;

  Map<String, dynamic> currentWeather = {
    "temperature": 22,
    "condition": "Sunny",
    "description": "Clear skies with abundant sunshine",
    "feelsLike": 25,
    "humidity": 65,
    "pressure": 1013,
    "visibility": 10,
    "uvIndex": 8,
    "windSpeed": 12,
    "windDirection": "NW",
    "dewPoint": 16,
    "cloudCover": 15,
    "sunrise": "06:45",
    "sunset": "19:32",
    "icon": Icons.wb_sunny,
    "lastUpdated": "2 minutes ago",
  };

  List<Map<String, dynamic>> weatherMetrics = [
    {
      "title": "Feels Like",
      "value": "25°C",
      "icon": Icons.thermostat,
      "color": Colors.orange,
      "description": "Apparent temperature",
    },
    {
      "title": "Humidity",
      "value": "65%",
      "icon": Icons.water_drop,
      "color": Colors.blue,
      "description": "Relative humidity",
    },
    {
      "title": "Pressure",
      "value": "1013 hPa",
      "icon": Icons.speed,
      "color": Colors.purple,
      "description": "Atmospheric pressure",
    },
    {
      "title": "Visibility",
      "value": "10 km",
      "icon": Icons.visibility,
      "color": Colors.green,
      "description": "Visual range",
    },
    {
      "title": "UV Index",
      "value": "8",
      "icon": Icons.wb_sunny_outlined,
      "color": Colors.red,
      "description": "Very high",
    },
    {
      "title": "Wind Speed",
      "value": "12 km/h",
      "icon": Icons.air,
      "color": Colors.teal,
      "description": "From northwest",
    },
    {
      "title": "Dew Point",
      "value": "16°C",
      "icon": Icons.water,
      "color": Colors.indigo,
      "description": "Condensation point",
    },
    {
      "title": "Cloud Cover",
      "value": "15%",
      "icon": Icons.cloud,
      "color": Colors.grey,
      "description": "Sky coverage",
    },
  ];

  List<Map<String, dynamic>> sunInfo = [
    {
      "title": "Sunrise",
      "time": "06:45",
      "icon": Icons.wb_twilight,
      "color": Colors.orange,
    },
    {
      "title": "Sunset",
      "time": "19:32",
      "icon": Icons.brightness_3,
      "color": Colors.purple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Current Weather"),
        actions: [
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: () async {
              isLoading = true;
              setState(() {});
              await Future.delayed(Duration(seconds: 1));
              isLoading = false;
              setState(() {});
              ss("Weather data updated");
            },
          ),
          QButton(
            icon: Icons.share,
            size: bs.sm,
            onPressed: () {
              si("Share weather information");
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          isLoading = true;
          setState(() {});
          await Future.delayed(Duration(seconds: 2));
          isLoading = false;
          setState(() {});
          ss("Weather refreshed");
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      primaryColor,
                      primaryColor.withAlpha(200),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowLg],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            selectedLocation,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(200),
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
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        else
                          Text(
                            "${currentWeather["lastUpdated"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white.withAlpha(160),
                            ),
                          ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${currentWeather["temperature"]}°C",
                                style: TextStyle(
                                  fontSize: 64,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "${currentWeather["condition"]}",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white.withAlpha(220),
                                ),
                              ),
                              Text(
                                "${currentWeather["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withAlpha(180),
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
                            currentWeather["icon"],
                            size: 80,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Row(
                        children: sunInfo.map((info) {
                          return Expanded(
                            child: Column(
                              children: [
                                Icon(
                                  info["icon"],
                                  size: 24,
                                  color: Colors.white,
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${info["title"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.white.withAlpha(180),
                                  ),
                                ),
                                Text(
                                  "${info["time"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
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
                          Icons.thermostat,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Temperature Details",
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
                          child: _buildTemperatureCard("Current", "${currentWeather["temperature"]}°C", Icons.device_thermostat, primaryColor),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: _buildTemperatureCard("Feels Like", "${currentWeather["feelsLike"]}°C", Icons.thermostat, Colors.orange),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: _buildTemperatureCard("Dew Point", "${currentWeather["dewPoint"]}°C", Icons.water, Colors.blue),
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
                          "Weather Metrics",
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
                      minItemWidth: 150,
                      children: weatherMetrics.map((metric) {
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (metric["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusMd),
                            border: Border.all(
                              color: (metric["color"] as Color).withAlpha(50),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    metric["icon"],
                                    size: 20,
                                    color: metric["color"],
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Text(
                                      "${metric["title"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "${metric["value"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${metric["description"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledColor,
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
                          Icons.health_and_safety,
                          color: warningColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Health Advisory",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "UV Index is very high (8). Use sunscreen and avoid prolonged sun exposure between 10 AM - 4 PM.",
                      style: TextStyle(
                        fontSize: 12,
                        color: warningColor,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.water_drop,
                          color: warningColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Stay hydrated in this sunny weather",
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
      ),
    );
  }

  Widget _buildTemperatureCard(String title, String value, IconData icon, Color color) {
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
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
