import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaGolfWeatherView extends StatefulWidget {
  const WcaGolfWeatherView({super.key});

  @override
  State<WcaGolfWeatherView> createState() => _WcaGolfWeatherViewState();
}

class _WcaGolfWeatherViewState extends State<WcaGolfWeatherView> {
  String selectedCourse = "Pebble Beach Golf Links";
  String selectedDate = "Today";
  String selectedTime = "Morning";

  List<String> golfCourses = [
    "Pebble Beach Golf Links",
    "Augusta National Golf Club",
    "St. Andrews Links",
    "Pinehurst Resort",
    "Torrey Pines Golf Course",
    "TPC Sawgrass",
  ];

  List<String> timeSlots = ["Early Morning", "Morning", "Afternoon", "Evening"];

  Map<String, dynamic> currentConditions = {
    "temperature": 22,
    "humidity": 65,
    "windSpeed": 12,
    "windDirection": "NE",
    "pressure": 1015,
    "uvIndex": 6,
    "visibility": 15,
    "dewPoint": 16,
    "cloudCover": 30,
    "precipitation": 0,
    "golfCondition": "Excellent",
    "playability": 95,
  };

  List<Map<String, dynamic>> hourlyForecast = [
    {
      "time": "8:00 AM",
      "temperature": 18,
      "windSpeed": 8,
      "windDirection": "NE",
      "precipitation": 0,
      "humidity": 70,
      "golfRating": "Excellent",
      "icon": Icons.wb_sunny,
    },
    {
      "time": "10:00 AM",
      "temperature": 22,
      "windSpeed": 12,
      "windDirection": "NE",
      "precipitation": 0,
      "humidity": 65,
      "golfRating": "Excellent",
      "icon": Icons.wb_sunny,
    },
    {
      "time": "12:00 PM",
      "temperature": 26,
      "windSpeed": 15,
      "windDirection": "E",
      "precipitation": 10,
      "humidity": 60,
      "golfRating": "Good",
      "icon": Icons.wb_cloudy,
    },
    {
      "time": "2:00 PM",
      "temperature": 28,
      "windSpeed": 18,
      "windDirection": "E",
      "precipitation": 20,
      "humidity": 58,
      "golfRating": "Fair",
      "icon": Icons.wb_cloudy,
    },
    {
      "time": "4:00 PM",
      "temperature": 25,
      "windSpeed": 14,
      "windDirection": "SE",
      "precipitation": 5,
      "humidity": 62,
      "golfRating": "Good",
      "icon": Icons.wb_sunny,
    },
    {
      "time": "6:00 PM",
      "temperature": 21,
      "windSpeed": 10,
      "windDirection": "SE",
      "precipitation": 0,
      "humidity": 68,
      "golfRating": "Excellent",
      "icon": Icons.wb_sunny,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Golf Weather Conditions"),
        actions: [
          QButton(
            icon: Icons.bookmark_add,
            size: bs.sm,
            onPressed: () {
              _saveFavoriteCourse();
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildCourseSelector(),
            _buildCurrentConditions(),
            _buildGolfMetrics(),
            _buildHourlyForecast(),
            _buildWindAnalysis(),
            _buildTeeTimeRecommendations(),
            _buildGolfTips(),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseSelector() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.golf_course,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Golf Course Weather",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Select Golf Course",
            items: golfCourses.map((course) => {
              "label": course,
              "value": course,
            }).toList(),
            value: selectedCourse,
            onChanged: (value, label) {
              selectedCourse = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Preferred Time",
                  items: timeSlots.map((time) => {
                    "label": time,
                    "value": time,
                  }).toList(),
                  value: selectedTime,
                  onChanged: (value, label) {
                    selectedTime = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.location_on,
                size: bs.sm,
                onPressed: () {
                  _showCourseLocation();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentConditions() {
    String golfCondition = currentConditions["golfCondition"] as String;
    int playability = currentConditions["playability"] as int;
    Color conditionColor = _getConditionColor(golfCondition);

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
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
                "Current Conditions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: conditionColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  golfCondition,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: conditionColor,
                  ),
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
                      "${currentConditions["temperature"]}°C",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Feels like ${(currentConditions["temperature"] as int) + 2}°C",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 60,
                color: disabledOutlineBorderColor,
              ),
              Expanded(
                child: Column(
                  spacing: spXs,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.air,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${currentConditions["windSpeed"]} km/h ${currentConditions["windDirection"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.water_drop,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${currentConditions["humidity"]}%",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: conditionColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.sports_golf,
                  color: conditionColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Golf Playability: $playability/100",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: conditionColor,
                    ),
                  ),
                ),
                Container(
                  width: 60,
                  height: 8,
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: playability / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: conditionColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGolfMetrics() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: successColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: successColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.analytics,
                color: successColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Golf-Specific Metrics",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 120,
            children: [
              _buildMetricCard("UV Index", "${currentConditions["uvIndex"]}", "High", warningColor, Icons.wb_sunny),
              _buildMetricCard("Visibility", "${currentConditions["visibility"]} km", "Excellent", successColor, Icons.visibility),
              _buildMetricCard("Dew Point", "${currentConditions["dewPoint"]}°C", "Comfortable", infoColor, Icons.water_drop),
              _buildMetricCard("Cloud Cover", "${currentConditions["cloudCover"]}%", "Partly Cloudy", primaryColor, Icons.cloud),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, String status, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            status,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildHourlyForecast() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
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
                "Hourly Golf Forecast",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QHorizontalScroll(
            children: hourlyForecast.map((forecast) => _buildHourlyItem(forecast)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHourlyItem(Map<String, dynamic> forecast) {
    String golfRating = forecast["golfRating"] as String;
    Color ratingColor = _getConditionColor(golfRating);

    return Container(
      width: 120,
      margin: EdgeInsets.only(right: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: ratingColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: ratingColor.withAlpha(50)),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Text(
            "${forecast["time"]}",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Icon(
            forecast["icon"] as IconData,
            color: ratingColor,
            size: 24,
          ),
          Text(
            "${forecast["temperature"]}°C",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.air,
                size: 12,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${forecast["windSpeed"]} km/h",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: spXs,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: ratingColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              golfRating,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: ratingColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWindAnalysis() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: infoColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.air,
                color: infoColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Wind Analysis for Golf",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              children: [
                _buildWindImpact("Driving Range", "Minimal impact", "NE wind helps distance", successColor),
                _buildWindImpact("Putting Green", "Light effect", "Crosswind may affect line", warningColor),
                _buildWindImpact("Fairway Shots", "Moderate impact", "Adjust club selection", primaryColor),
                _buildWindImpact("Approach Shots", "Significant impact", "Account for wind direction", dangerColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWindImpact(String area, String impact, String advice, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spXs,
            children: [
              Text(
                "$area - $impact",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Text(
                advice,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTeeTimeRecommendations() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: warningColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.schedule,
                color: warningColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Optimal Tee Times",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              children: [
                _buildTeeTimeSlot("8:00 AM - 10:00 AM", "Excellent", "Cool temperature, minimal wind", successColor, true),
                _buildTeeTimeSlot("10:00 AM - 12:00 PM", "Very Good", "Pleasant conditions, light wind", successColor, false),
                _buildTeeTimeSlot("12:00 PM - 2:00 PM", "Good", "Warmer, increasing wind", warningColor, false),
                _buildTeeTimeSlot("2:00 PM - 4:00 PM", "Fair", "Hottest period, strongest wind", dangerColor, false),
                _buildTeeTimeSlot("4:00 PM - 6:00 PM", "Good", "Cooling down, decreasing wind", warningColor, false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeeTimeSlot(String time, String rating, String description, Color color, bool recommended) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: recommended ? color.withAlpha(20) : Colors.transparent,
        borderRadius: BorderRadius.circular(radiusXs),
        border: recommended ? Border.all(color: color.withAlpha(100)) : null,
      ),
      child: Row(
        children: [
          if (recommended)
            Icon(
              Icons.star,
              color: color,
              size: 16,
            ),
          if (recommended) SizedBox(width: spXs),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spXs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: color.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        rating,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: color,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGolfTips() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Weather-Based Golf Tips",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          _buildGolfTip("Wind Strategy", "Use lower trajectory shots in headwinds and higher shots with tailwinds."),
          _buildGolfTip("Temperature Impact", "Ball travels 2 yards less per 10°F temperature drop."),
          _buildGolfTip("Humidity Effect", "High humidity makes the ball travel slightly less distance."),
          _buildGolfTip("UV Protection", "High UV index today - wear sunscreen and a hat."),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Course Map",
                  size: bs.sm,
                  onPressed: () {
                    _showCourseMap();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Book Tee Time",
                  size: bs.sm,
                  onPressed: () {
                    _bookTeeTime();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGolfTip(String title, String tip) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 6),
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spXs,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Text(
                tip,
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getConditionColor(String condition) {
    switch (condition.toLowerCase()) {
      case "excellent":
        return successColor;
      case "very good":
      case "good":
        return primaryColor;
      case "fair":
        return warningColor;
      case "poor":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _saveFavoriteCourse() {
    ss("$selectedCourse saved to favorites");
  }

  void _showCourseLocation() {
    ss("Showing $selectedCourse location on map");
  }

  void _showCourseMap() {
    ss("Opening $selectedCourse course map");
  }

  void _bookTeeTime() {
    ss("Opening tee time booking for $selectedCourse");
  }
}
