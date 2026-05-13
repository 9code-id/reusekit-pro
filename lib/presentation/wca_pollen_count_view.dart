import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaPollenCountView extends StatefulWidget {
  const WcaPollenCountView({super.key});

  @override
  State<WcaPollenCountView> createState() => _WcaPollenCountViewState();
}

class _WcaPollenCountViewState extends State<WcaPollenCountView> {
  int selectedDayIndex = 0;
  String selectedAllergen = "all";

  List<Map<String, dynamic>> allergenTypes = [
    {"label": "All Allergens", "value": "all"},
    {"label": "Tree Pollen", "value": "tree"},
    {"label": "Grass Pollen", "value": "grass"},
    {"label": "Weed Pollen", "value": "weed"},
    {"label": "Mold Spores", "value": "mold"},
  ];

  List<Map<String, dynamic>> dailyForecast = [
    {
      "date": DateTime.now(),
      "dayName": "Today",
      "overall": "High",
      "overallLevel": 4,
      "tree": {"level": 4, "name": "High", "color": dangerColor},
      "grass": {"level": 3, "name": "Moderate", "color": warningColor},
      "weed": {"level": 2, "name": "Low", "color": successColor},
      "mold": {"level": 3, "name": "Moderate", "color": warningColor},
      "dominant": ["Oak", "Birch", "Maple"],
      "temperature": 24,
      "humidity": 65,
      "windSpeed": 12,
    },
    {
      "date": DateTime.now().add(Duration(days: 1)),
      "dayName": "Tomorrow",
      "overall": "Very High",
      "overallLevel": 5,
      "tree": {"level": 5, "name": "Very High", "color": Color(0xFF8B0000)},
      "grass": {"level": 4, "name": "High", "color": dangerColor},
      "weed": {"level": 2, "name": "Low", "color": successColor},
      "mold": {"level": 2, "name": "Low", "color": successColor},
      "dominant": ["Oak", "Pine", "Cedar"],
      "temperature": 26,
      "humidity": 58,
      "windSpeed": 8,
    },
    {
      "date": DateTime.now().add(Duration(days: 2)),
      "dayName": "Wednesday",
      "overall": "Moderate",
      "overallLevel": 3,
      "tree": {"level": 3, "name": "Moderate", "color": warningColor},
      "grass": {"level": 3, "name": "Moderate", "color": warningColor},
      "weed": {"level": 1, "name": "Very Low", "color": successColor},
      "mold": {"level": 2, "name": "Low", "color": successColor},
      "dominant": ["Grass Mix", "Ragweed"],
      "temperature": 22,
      "humidity": 72,
      "windSpeed": 15,
    },
    {
      "date": DateTime.now().add(Duration(days: 3)),
      "dayName": "Thursday",
      "overall": "Low",
      "overallLevel": 2,
      "tree": {"level": 2, "name": "Low", "color": successColor},
      "grass": {"level": 2, "name": "Low", "color": successColor},
      "weed": {"level": 1, "name": "Very Low", "color": successColor},
      "mold": {"level": 3, "name": "Moderate", "color": warningColor},
      "dominant": ["Mold Spores"],
      "temperature": 20,
      "humidity": 78,
      "windSpeed": 18,
    },
    {
      "date": DateTime.now().add(Duration(days: 4)),
      "dayName": "Friday",
      "overall": "High",
      "overallLevel": 4,
      "tree": {"level": 4, "name": "High", "color": dangerColor},
      "grass": {"level": 3, "name": "Moderate", "color": warningColor},
      "weed": {"level": 3, "name": "Moderate", "color": warningColor},
      "mold": {"level": 2, "name": "Low", "color": successColor},
      "dominant": ["Birch", "Elm", "Grass"],
      "temperature": 25,
      "humidity": 60,
      "windSpeed": 10,
    },
  ];

  List<Map<String, dynamic>> hourlyData = [
    {"time": "06:00", "level": 2, "status": "Low"},
    {"time": "07:00", "level": 2, "status": "Low"},
    {"time": "08:00", "level": 3, "status": "Moderate"},
    {"time": "09:00", "level": 4, "status": "High"},
    {"time": "10:00", "level": 5, "status": "Very High"},
    {"time": "11:00", "level": 5, "status": "Very High"},
    {"time": "12:00", "level": 4, "status": "High"},
    {"time": "13:00", "level": 4, "status": "High"},
    {"time": "14:00", "level": 3, "status": "Moderate"},
    {"time": "15:00", "level": 3, "status": "Moderate"},
    {"time": "16:00", "level": 2, "status": "Low"},
    {"time": "17:00", "level": 2, "status": "Low"},
    {"time": "18:00", "level": 1, "status": "Very Low"},
  ];

  @override
  Widget build(BuildContext context) {
    final selectedDay = dailyForecast[selectedDayIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text("Pollen Forecast"),
        actions: [
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Current Overall Level
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Text(
                    "Today's Pollen Level",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withAlpha(40),
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${selectedDay["overallLevel"]}",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Level",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "${selectedDay["overall"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Peak: 10:00 AM - 2:00 PM",
                    style: TextStyle(
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                ],
              ),
            ),

            // 5-Day Forecast
            Container(
              width: double.infinity,
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
                    "5-Day Forecast",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QHorizontalScroll(
                    children: List.generate(dailyForecast.length, (index) {
                      final day = dailyForecast[index];
                      final isSelected = index == selectedDayIndex;
                      
                      return GestureDetector(
                        onTap: () {
                          selectedDayIndex = index;
                          setState(() {});
                        },
                        child: Container(
                          width: 120,
                          padding: EdgeInsets.all(spSm),
                          margin: EdgeInsets.only(right: spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.grey[50],
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor : Colors.grey[200]!,
                            ),
                          ),
                          child: Column(
                            spacing: spXs,
                            children: [
                              Text(
                                "${day["dayName"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? Colors.white : primaryColor,
                                ),
                              ),
                              Text(
                                "${(day["date"] as DateTime).dMMMy}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isSelected ? Colors.white.withAlpha(200) : disabledBoldColor,
                                ),
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected ? Colors.white.withAlpha(40) : _getLevelColor(day["overallLevel"] as int).withAlpha(40),
                                  border: Border.all(
                                    color: isSelected ? Colors.white : _getLevelColor(day["overallLevel"] as int),
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "${day["overallLevel"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isSelected ? Colors.white : _getLevelColor(day["overallLevel"] as int),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "${day["overall"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? Colors.white : disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            // Allergen Breakdown
            Container(
              width: double.infinity,
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
                    "Allergen Breakdown",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Column(
                    spacing: spSm,
                    children: [
                      _buildAllergenRow("Tree Pollen", selectedDay["tree"]),
                      _buildAllergenRow("Grass Pollen", selectedDay["grass"]),
                      _buildAllergenRow("Weed Pollen", selectedDay["weed"]),
                      _buildAllergenRow("Mold Spores", selectedDay["mold"]),
                    ],
                  ),
                ],
              ),
            ),

            // Dominant Allergens
            Container(
              width: double.infinity,
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
                        Icons.eco,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Dominant Allergens",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: (selectedDay["dominant"] as List<String>).map((allergen) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: primaryColor.withAlpha(100),
                          ),
                        ),
                        child: Text(
                          allergen,
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Weather Conditions
            Container(
              width: double.infinity,
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
                    "Weather Conditions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildWeatherStat(
                          Icons.thermostat,
                          "Temperature",
                          "${selectedDay["temperature"]}°C",
                        ),
                      ),
                      Expanded(
                        child: _buildWeatherStat(
                          Icons.water_drop,
                          "Humidity",
                          "${selectedDay["humidity"]}%",
                        ),
                      ),
                      Expanded(
                        child: _buildWeatherStat(
                          Icons.air,
                          "Wind Speed",
                          "${selectedDay["windSpeed"]} km/h",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Hourly Trend
            Container(
              width: double.infinity,
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
                    "Today's Hourly Trend",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    height: 150,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: List.generate(hourlyData.length, (index) {
                          final data = hourlyData[index];
                          final level = data["level"] as int;
                          final height = (level / 5.0) * 100;
                          final color = _getLevelColor(level);

                          return Container(
                            width: 50,
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "$level",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: color,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Container(
                                  width: 30,
                                  height: height,
                                  decoration: BoxDecoration(
                                    color: color,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${data["time"]}",
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
                    ),
                  ),
                ],
              ),
            ),

            // Tips for Allergy Sufferers
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: infoColor.withAlpha(100),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.tips_and_updates,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Allergy Tips",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spXs,
                    children: [
                      _buildTipItem("Keep windows closed during peak hours (10 AM - 2 PM)"),
                      _buildTipItem("Use air conditioning with clean filters"),
                      _buildTipItem("Take antihistamines before going outside"),
                      _buildTipItem("Shower and change clothes after outdoor activities"),
                      _buildTipItem("Check pollen forecast before planning outdoor activities"),
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

  Widget _buildAllergenRow(String name, Map<String, dynamic> data) {
    final level = data["level"] as int;
    final color = data["color"] as Color;
    final levelName = data["name"] as String;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: color.withAlpha(100),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: List.generate(5, (index) {
                return Container(
                  width: 12,
                  height: 12,
                  margin: EdgeInsets.only(right: 2),
                  decoration: BoxDecoration(
                    color: index < level ? color : Colors.grey[300],
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                );
              }),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              levelName,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherStat(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: 24,
        ),
        SizedBox(height: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildTipItem(String tip) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6,
          height: 6,
          margin: EdgeInsets.only(top: 6, right: spXs),
          decoration: BoxDecoration(
            color: infoColor,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Text(
            tip,
            style: TextStyle(
              color: infoColor,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Color _getLevelColor(int level) {
    switch (level) {
      case 1:
        return successColor;
      case 2:
        return successColor;
      case 3:
        return warningColor;
      case 4:
        return dangerColor;
      case 5:
        return Color(0xFF8B0000);
      default:
        return successColor;
    }
  }
}
