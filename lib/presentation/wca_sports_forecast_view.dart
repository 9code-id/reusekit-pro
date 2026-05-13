import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaSportsForecastView extends StatefulWidget {
  const WcaSportsForecastView({super.key});

  @override
  State<WcaSportsForecastView> createState() => _WcaSportsForecastViewState();
}

class _WcaSportsForecastViewState extends State<WcaSportsForecastView> {
  String selectedSport = "Football";
  String selectedLocation = "New York";
  
  List<Map<String, dynamic>> sportsItems = [
    {"label": "Football", "value": "Football"},
    {"label": "Soccer", "value": "Soccer"},
    {"label": "Baseball", "value": "Baseball"},
    {"label": "Basketball", "value": "Basketball"},
    {"label": "Tennis", "value": "Tennis"},
    {"label": "Golf", "value": "Golf"},
    {"label": "Running", "value": "Running"},
    {"label": "Cycling", "value": "Cycling"},
  ];

  List<Map<String, dynamic>> forecastData = [
    {
      "date": "Today",
      "time": "2:00 PM",
      "temperature": 75,
      "condition": "Sunny",
      "humidity": 45,
      "windSpeed": 8,
      "windDirection": "NE",
      "precipitation": 0,
      "suitability": "Excellent",
      "suitabilityColor": "success",
      "icon": Icons.wb_sunny,
    },
    {
      "date": "Tomorrow",
      "time": "2:00 PM",
      "temperature": 72,
      "condition": "Partly Cloudy",
      "humidity": 55,
      "windSpeed": 12,
      "windDirection": "E",
      "precipitation": 10,
      "suitability": "Good",
      "suitabilityColor": "info",
      "icon": Icons.wb_cloudy,
    },
    {
      "date": "Wednesday",
      "time": "2:00 PM",
      "temperature": 68,
      "condition": "Light Rain",
      "humidity": 75,
      "windSpeed": 15,
      "windDirection": "SE",
      "precipitation": 60,
      "suitability": "Poor",
      "suitabilityColor": "warning",
      "icon": Icons.grain,
    },
  ];

  List<Map<String, dynamic>> sportsAdvice = [
    {
      "sport": "Football",
      "idealTemp": "60-75°F",
      "idealWind": "< 15 mph",
      "idealCondition": "Clear/Partly Cloudy",
      "tips": "Avoid strong winds and heavy rain",
    },
    {
      "sport": "Tennis",
      "idealTemp": "65-80°F",
      "idealWind": "< 10 mph",
      "idealCondition": "Clear skies",
      "tips": "Wind affects ball trajectory significantly",
    },
    {
      "sport": "Golf",
      "idealTemp": "55-75°F",
      "idealWind": "< 20 mph",
      "idealCondition": "Clear/Light clouds",
      "tips": "Check for lightning warnings",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sports Weather Forecast"),
        actions: [
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () {
              si("Select location for sports forecast");
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Weather forecast updated");
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
                  colors: [primaryColor.withAlpha(20), successColor.withAlpha(20)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.sports,
                    color: primaryColor,
                    size: 32,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sports Weather Forecast",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Get optimal weather conditions for your favorite sports",
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

            Text(
              "Select Sport & Location",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Sport",
                    items: sportsItems,
                    value: selectedSport,
                    onChanged: (value, label) {
                      selectedSport = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QTextField(
                    label: "Location",
                    value: selectedLocation,
                    hint: "Enter city name",
                    onChanged: (value) {
                      selectedLocation = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            Text(
              "3-Day Sports Forecast",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...forecastData.map((forecast) {
              Color suitabilityColor = primaryColor;
              if (forecast["suitabilityColor"] == "success") suitabilityColor = successColor;
              if (forecast["suitabilityColor"] == "warning") suitabilityColor = warningColor;
              if (forecast["suitabilityColor"] == "info") suitabilityColor = infoColor;

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
                    Row(
                      children: [
                        Icon(
                          forecast["icon"] as IconData,
                          color: primaryColor,
                          size: 32,
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${forecast["date"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${forecast["time"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${forecast["temperature"]}°F - ${forecast["condition"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: suitabilityColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${forecast["suitability"]}",
                            style: TextStyle(
                              color: suitabilityColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: _buildWeatherDetail("Humidity", "${forecast["humidity"]}%", Icons.water_drop),
                        ),
                        Expanded(
                          child: _buildWeatherDetail("Wind", "${forecast["windSpeed"]} mph ${forecast["windDirection"]}", Icons.air),
                        ),
                        Expanded(
                          child: _buildWeatherDetail("Rain", "${forecast["precipitation"]}%", Icons.umbrella),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),

            Text(
              "Sports Weather Guidelines",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...sportsAdvice.map((advice) {
              return Container(
                padding: EdgeInsets.all(spMd),
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${advice["sport"]}",
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
                          child: _buildAdviceItem("Temperature", "${advice["idealTemp"]}", Icons.thermostat),
                        ),
                        Expanded(
                          child: _buildAdviceItem("Wind", "${advice["idealWind"]}", Icons.air),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    _buildAdviceItem("Conditions", "${advice["idealCondition"]}", Icons.wb_sunny),
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.lightbulb_outline,
                            color: infoColor,
                            size: 16,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${advice["tips"]}",
                              style: TextStyle(
                                color: infoColor,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),

            QButton(
              label: "Get Extended Forecast",
              size: bs.md,
              onPressed: () {
                si("Extended 7-day sports forecast");
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherDetail(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: 20,
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
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildAdviceItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: 16,
        ),
        SizedBox(width: spSm),
        Text(
          "$label: ",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
