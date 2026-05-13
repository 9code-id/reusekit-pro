import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaAgricultureWeatherView extends StatefulWidget {
  const WcaAgricultureWeatherView({super.key});

  @override
  State<WcaAgricultureWeatherView> createState() => _WcaAgricultureWeatherViewState();
}

class _WcaAgricultureWeatherViewState extends State<WcaAgricultureWeatherView> {
  String selectedLocation = "Current Location";
  String selectedCrop = "Wheat";
  int selectedTab = 0;

  List<Map<String, dynamic>> farmLocations = [
    {"name": "Main Farm", "lat": 40.7128, "lng": -74.0060, "area": "25 hectares"},
    {"name": "North Field", "lat": 40.7589, "lng": -73.9851, "area": "15 hectares"},
    {"name": "South Valley", "lat": 40.6892, "lng": -74.0445, "area": "30 hectares"},
    {"name": "East Pasture", "lat": 40.7505, "lng": -73.9934, "area": "20 hectares"},
  ];

  List<Map<String, dynamic>> cropTypes = [
    {"name": "Wheat", "stage": "Flowering", "planted": "2024-04-15", "harvest": "2024-08-20"},
    {"name": "Corn", "stage": "Grain Filling", "planted": "2024-05-10", "harvest": "2024-09-15"},
    {"name": "Soybeans", "stage": "Pod Development", "planted": "2024-05-20", "harvest": "2024-10-05"},
    {"name": "Barley", "stage": "Ripening", "planted": "2024-04-01", "harvest": "2024-07-30"},
  ];

  List<Map<String, dynamic>> weatherData = [
    {"day": "Today", "temp": "24°C", "humidity": "65%", "rainfall": "2mm", "wind": "12 km/h", "icon": Icons.wb_sunny},
    {"day": "Tomorrow", "temp": "26°C", "humidity": "70%", "rainfall": "5mm", "wind": "15 km/h", "icon": Icons.cloud},
    {"day": "Tuesday", "temp": "22°C", "humidity": "80%", "rainfall": "12mm", "wind": "18 km/h", "icon": Icons.grain},
    {"day": "Wednesday", "temp": "25°C", "humidity": "60%", "rainfall": "0mm", "wind": "10 km/h", "icon": Icons.wb_sunny},
    {"day": "Thursday", "temp": "27°C", "humidity": "55%", "rainfall": "0mm", "wind": "8 km/h", "icon": Icons.wb_sunny},
  ];

  List<Map<String, dynamic>> farmingAlerts = [
    {"type": "warning", "title": "Irrigation Recommended", "message": "Low soil moisture detected in North Field", "time": "2 hours ago"},
    {"type": "success", "title": "Optimal Growing Conditions", "message": "Perfect weather for crop development", "time": "5 hours ago"},
    {"type": "info", "title": "Fertilizer Application Window", "message": "Good conditions for fertilizer application", "time": "1 day ago"},
    {"type": "warning", "title": "Wind Advisory", "message": "Strong winds expected tomorrow afternoon", "time": "1 day ago"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agriculture Weather"),
        actions: [
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () => _showLocationSelector(),
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () => _showWeatherAlerts(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCurrentWeatherCard(),
            _buildLocationCropSelector(),
            _buildWeatherForecast(),
            _buildFarmingInsights(),
            _buildCropStageWeather(),
            _buildSoilConditions(),
            _buildFarmingAlerts(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentWeatherCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
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
              Icon(Icons.agriculture, color: Colors.white, size: 28),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedLocation,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Agricultural Weather Conditions",
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.wb_sunny, color: Colors.white, size: 48),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "24°C",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Temperature",
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "65%",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Humidity",
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "12 km/h",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Wind Speed",
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCropSelector() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Row(
              children: [
                Icon(Icons.location_on, color: primaryColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Location",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        selectedLocation,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
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
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Row(
              children: [
                Icon(Icons.grass, color: successColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Crop Type",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        selectedCrop,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
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
    );
  }

  Widget _buildWeatherForecast() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "5-Day Weather Forecast",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        QHorizontalScroll(
          children: weatherData.map((weather) {
            return Container(
              width: 120,
              margin: EdgeInsets.only(right: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Text(
                    "${weather["day"]}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Icon(
                    weather["icon"] as IconData,
                    color: primaryColor,
                    size: 32,
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${weather["temp"]}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "💧 ${weather["rainfall"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "💨 ${weather["wind"]}",
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
      ],
    );
  }

  Widget _buildFarmingInsights() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: successColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: successColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.insights, color: successColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Today's Farming Insights",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          _buildInsightItem("🌱", "Growing Conditions", "Excellent for photosynthesis and growth"),
          _buildInsightItem("💧", "Irrigation", "Soil moisture at 70% - no watering needed"),
          _buildInsightItem("🌾", "Harvest", "Optimal harvesting weather in 2 days"),
          _buildInsightItem("🚜", "Field Work", "Good conditions for machinery operation"),
        ],
      ),
    );
  }

  Widget _buildInsightItem(String emoji, String title, String description) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Text(emoji, style: TextStyle(fontSize: 20)),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCropStageWeather() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Crop Stage Weather Requirements",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "Wheat - Flowering Stage",
                      style: TextStyle(
                        color: successColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              _buildWeatherRequirement("Temperature", "18-24°C", "✅ Optimal", successColor),
              _buildWeatherRequirement("Humidity", "60-70%", "✅ Good", successColor),
              _buildWeatherRequirement("Rainfall", "Low (0-5mm)", "⚠️ Monitor", warningColor),
              _buildWeatherRequirement("Wind", "Light (5-15 km/h)", "✅ Perfect", successColor),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherRequirement(String parameter, String ideal, String status, Color statusColor) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              parameter,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              ideal,
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSoilConditions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Soil & Environmental Conditions",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Expanded(
              child: _buildSoilCard("Soil Moisture", "70%", "Optimal", successColor, Icons.water_drop),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: _buildSoilCard("Soil Temp", "22°C", "Good", successColor, Icons.thermostat),
            ),
          ],
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Expanded(
              child: _buildSoilCard("UV Index", "6", "Moderate", warningColor, Icons.wb_sunny),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: _buildSoilCard("Evaporation", "4mm", "Normal", infoColor, Icons.cloud),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSoilCard(String title, String value, String status, Color statusColor, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(icon, color: statusColor, size: 28),
          SizedBox(height: spSm),
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
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFarmingAlerts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Weather Alerts & Recommendations",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Column(
          children: farmingAlerts.map((alert) {
            Color alertColor = alert["type"] == "warning" ? warningColor :
                             alert["type"] == "success" ? successColor : infoColor;
            IconData alertIcon = alert["type"] == "warning" ? Icons.warning :
                               alert["type"] == "success" ? Icons.check_circle : Icons.info;
            
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border(
                  left: BorderSide(color: alertColor, width: 4),
                ),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Icon(alertIcon, color: alertColor, size: 24),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${alert["title"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${alert["message"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "${alert["time"]}",
                          style: TextStyle(
                            color: disabledColor,
                            fontSize: 11,
                          ),
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
    );
  }

  void _showLocationSelector() {
    si("Location selector opened");
  }

  void _showWeatherAlerts() {
    si("Weather alerts opened");
  }
}
