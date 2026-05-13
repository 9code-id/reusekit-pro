import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaBoatingForecastView extends StatefulWidget {
  const WcaBoatingForecastView({super.key});

  @override
  State<WcaBoatingForecastView> createState() => _WcaBoatingForecastViewState();
}

class _WcaBoatingForecastViewState extends State<WcaBoatingForecastView> {
  String selectedLocation = "Marina Bay";
  int selectedDayIndex = 0;

  List<Map<String, dynamic>> locations = [
    {"label": "Marina Bay", "value": "Marina Bay"},
    {"label": "Harbor Point", "value": "Harbor Point"},
    {"label": "Coastal Waters", "value": "Coastal Waters"},
    {"label": "Deep Sea", "value": "Deep Sea"},
  ];

  List<Map<String, dynamic>> forecastData = [
    {
      "date": "Today",
      "temperature": 28,
      "windSpeed": 12,
      "windDirection": "NE",
      "waveHeight": 0.8,
      "visibility": 10,
      "precipitation": 5,
      "uvIndex": 8,
      "tideHigh": "06:30",
      "tideLow": "12:45",
      "condition": "Partly Cloudy",
      "advisory": "Ideal for sailing",
      "safety": "good"
    },
    {
      "date": "Tomorrow",
      "temperature": 26,
      "windSpeed": 18,
      "windDirection": "E",
      "waveHeight": 1.2,
      "visibility": 8,
      "precipitation": 15,
      "uvIndex": 6,
      "tideHigh": "07:15",
      "tideLow": "13:30",
      "condition": "Cloudy",
      "advisory": "Moderate conditions",
      "safety": "moderate"
    },
    {
      "date": "Monday",
      "temperature": 24,
      "windSpeed": 25,
      "windDirection": "SE",
      "waveHeight": 2.1,
      "visibility": 6,
      "precipitation": 35,
      "uvIndex": 4,
      "tideHigh": "08:00",
      "tideLow": "14:15",
      "condition": "Stormy",
      "advisory": "Not recommended",
      "safety": "poor"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final currentForecast = forecastData[selectedDayIndex];
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Boating Forecast"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Forecast updated");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(150)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.sailing,
                    color: Colors.white,
                    size: 32,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Marine Weather Forecast",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Real-time boating conditions and forecasts",
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            QDropdownField(
              label: "Select Location",
              items: locations,
              value: selectedLocation,
              onChanged: (value, label) {
                selectedLocation = value;
                setState(() {});
              },
            ),

            Container(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: forecastData.length,
                itemBuilder: (context, index) {
                  final day = forecastData[index];
                  final isSelected = index == selectedDayIndex;
                  
                  return GestureDetector(
                    onTap: () {
                      selectedDayIndex = index;
                      setState(() {});
                    },
                    child: Container(
                      width: 100,
                      margin: EdgeInsets.only(right: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${day["date"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : primaryColor,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${day["temperature"]}°C",
                            style: TextStyle(
                              color: isSelected ? Colors.white : disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: _getSafetyColor(currentForecast["safety"]).withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: _getSafetyColor(currentForecast["safety"]).withAlpha(50),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _getSafetyIcon(currentForecast["safety"]),
                    color: _getSafetyColor(currentForecast["safety"]),
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Boating Advisory",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _getSafetyColor(currentForecast["safety"]),
                          ),
                        ),
                        Text(
                          "${currentForecast["advisory"]}",
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

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.thermostat,
                          color: primaryColor,
                          size: 28,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${currentForecast["temperature"]}°C",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Temperature",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.air,
                          color: infoColor,
                          size: 28,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${currentForecast["windSpeed"]} km/h",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Wind ${currentForecast["windDirection"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Text(
              "Marine Conditions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
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
                          Icon(
                            Icons.waves,
                            color: infoColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Wave Height",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${currentForecast["waveHeight"]} meters",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.visibility,
                            color: warningColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Visibility",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${currentForecast["visibility"]} km",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.water_drop,
                            color: infoColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Precipitation",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${currentForecast["precipitation"]}%",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.wb_sunny,
                            color: warningColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "UV Index",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${currentForecast["uvIndex"]}/10",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Text(
              "Tide Information",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.trending_up,
                          color: successColor,
                          size: 24,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "High Tide",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${currentForecast["tideHigh"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.trending_down,
                          color: dangerColor,
                          size: 24,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Low Tide",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${currentForecast["tideLow"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
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
    );
  }

  Color _getSafetyColor(String safety) {
    switch (safety) {
      case "good":
        return successColor;
      case "moderate":
        return warningColor;
      case "poor":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getSafetyIcon(String safety) {
    switch (safety) {
      case "good":
        return Icons.check_circle;
      case "moderate":
        return Icons.warning;
      case "poor":
        return Icons.dangerous;
      default:
        return Icons.info;
    }
  }
}
