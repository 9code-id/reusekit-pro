import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaFeelsLikeView extends StatefulWidget {
  const WcaFeelsLikeView({super.key});

  @override
  State<WcaFeelsLikeView> createState() => _WcaFeelsLikeViewState();
}

class _WcaFeelsLikeViewState extends State<WcaFeelsLikeView> {
  String selectedLocation = "Houston, TX";
  bool isLoading = false;

  Map<String, dynamic> currentFeelsLike = {
    "actual": 89,
    "feelsLike": 98,
    "humidity": 78,
    "heatIndex": 102,
    "windChill": null,
    "condition": "Hot and Humid",
    "icon": "🔥",
    "advisory": "Extreme Heat Warning",
  };

  List<Map<String, dynamic>> hourlyFeelsLike = [
    {"time": "Now", "actual": 89, "feelsLike": 98, "condition": "Very Hot"},
    {"time": "3 PM", "actual": 91, "feelsLike": 101, "condition": "Extremely Hot"},
    {"time": "4 PM", "actual": 93, "feelsLike": 104, "condition": "Dangerous"},
    {"time": "5 PM", "actual": 90, "feelsLike": 99, "condition": "Very Hot"},
    {"time": "6 PM", "actual": 87, "feelsLike": 94, "condition": "Hot"},
    {"time": "7 PM", "actual": 84, "feelsLike": 90, "condition": "Warm"},
    {"time": "8 PM", "actual": 81, "feelsLike": 86, "condition": "Warm"},
    {"time": "9 PM", "actual": 78, "feelsLike": 82, "condition": "Comfortable"},
    {"time": "10 PM", "actual": 76, "feelsLike": 79, "condition": "Pleasant"},
    {"time": "11 PM", "actual": 74, "feelsLike": 77, "condition": "Pleasant"},
  ];

  List<Map<String, dynamic>> feelsLikeFactors = [
    {
      "title": "Humidity Impact",
      "value": "High",
      "percentage": 85,
      "description": "High humidity makes it feel much hotter",
      "icon": Icons.opacity,
      "color": "info",
    },
    {
      "title": "Wind Effect",
      "value": "Low",
      "percentage": 15,
      "description": "Light winds provide minimal cooling relief",
      "icon": Icons.air,
      "color": "warning",
    },
    {
      "title": "Solar Radiation",
      "value": "High",
      "percentage": 90,
      "description": "Direct sunlight increases perceived temperature",
      "icon": Icons.wb_sunny,
      "color": "danger",
    },
    {
      "title": "Cloud Cover",
      "value": "Low",
      "percentage": 20,
      "description": "Clear skies offer no shade from sun",
      "icon": Icons.cloud,
      "color": "primary",
    },
  ];

  List<Map<String, dynamic>> comfortLevels = [
    {"range": "Below 60°F", "level": "Cold", "color": "info", "description": "Bundle up and stay warm"},
    {"range": "60-70°F", "level": "Cool", "color": "success", "description": "Light jacket recommended"},
    {"range": "70-80°F", "level": "Comfortable", "color": "success", "description": "Perfect weather conditions"},
    {"range": "80-90°F", "level": "Warm", "color": "warning", "description": "Light clothing, stay hydrated"},
    {"range": "90-100°F", "level": "Hot", "color": "danger", "description": "Limit outdoor activities"},
    {"range": "Above 100°F", "level": "Extreme", "color": "danger", "description": "Stay indoors, high health risk"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feels Like Temperature"),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              si("Feels like temperature considers humidity, wind, and solar radiation");
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
                    padding: EdgeInsets.all(spLg),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [dangerColor, warningColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
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
                              child: Text(
                                selectedLocation,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${currentFeelsLike["advisory"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spLg),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${currentFeelsLike["icon"]}",
                              style: TextStyle(fontSize: 60),
                            ),
                            SizedBox(width: spMd),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Feels Like",
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(200),
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "${currentFeelsLike["feelsLike"]}°F",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Actual: ${currentFeelsLike["actual"]}°F",
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(200),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "${currentFeelsLike["condition"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (currentFeelsLike["heatIndex"] != null) ...[
                          SizedBox(height: spSm),
                          Text(
                            "Heat Index: ${currentFeelsLike["heatIndex"]}°F",
                            style: TextStyle(
                              color: Colors.white.withAlpha(200),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  Text(
                    "Hourly Feels Like",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  QHorizontalScroll(
                    children: hourlyFeelsLike.map((hour) {
                      bool isNow = hour["time"] == "Now";
                      int difference = (hour["feelsLike"] as int) - (hour["actual"] as int);
                      return Container(
                        width: 100,
                        padding: EdgeInsets.all(spMd),
                        margin: EdgeInsets.only(right: spSm),
                        decoration: BoxDecoration(
                          color: isNow ? primaryColor.withAlpha(20) : Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(
                            color: isNow ? primaryColor.withAlpha(50) : disabledOutlineBorderColor,
                          ),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${hour["time"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isNow ? primaryColor : disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${hour["feelsLike"]}°",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isNow ? primaryColor : Colors.black,
                              ),
                            ),
                            Text(
                              "(${hour["actual"]}°)",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: difference > 5 ? dangerColor.withAlpha(20) : successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "+${difference}°",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: difference > 5 ? dangerColor : successColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),

                  Text(
                    "Contributing Factors",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: feelsLikeFactors.map((factor) {
                      Color cardColor = _getColorFromString(factor["color"]);
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: cardColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(color: cardColor.withAlpha(50)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  factor["icon"] as IconData,
                                  color: cardColor,
                                  size: 24,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${factor["title"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: cardColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spMd),
                            Text(
                              "${factor["value"]}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Container(
                              height: 6,
                              decoration: BoxDecoration(
                                color: disabledColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: (factor["percentage"] as int) / 100,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: cardColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${factor["description"]}",
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

                  Text(
                    "Comfort Level Guide",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
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
                      spacing: spSm,
                      children: comfortLevels.map((level) {
                        Color levelColor = _getColorFromString(level["color"]);
                        bool isCurrent = _isCurrentLevel(level["range"]);
                        return Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: isCurrent ? levelColor.withAlpha(20) : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isCurrent ? levelColor.withAlpha(50) : Colors.transparent,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: levelColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: spMd),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${level["level"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: isCurrent ? levelColor : Colors.black,
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        Text(
                                          "${level["range"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${level["description"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isCurrent)
                                Icon(
                                  Icons.radio_button_checked,
                                  color: levelColor,
                                  size: 16,
                                ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: infoColor.withAlpha(50)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.lightbulb_outline,
                          color: infoColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "What is \"Feels Like\" Temperature?",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Feels like temperature combines air temperature with humidity, wind speed, and solar radiation to show how hot or cold it actually feels to your body.",
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
                    label: "Refresh Data",
                    size: bs.md,
                    onPressed: () {
                      isLoading = true;
                      setState(() {});
                      Future.delayed(Duration(seconds: 2), () {
                        isLoading = false;
                        setState(() {});
                        ss("Feels like temperature updated");
                      });
                    },
                  ),
                ],
              ),
            ),
    );
  }

  Color _getColorFromString(String colorName) {
    switch (colorName) {
      case "primary":
        return primaryColor;
      case "danger":
        return dangerColor;
      case "warning":
        return warningColor;
      case "info":
        return infoColor;
      case "success":
        return successColor;
      default:
        return primaryColor;
    }
  }

  bool _isCurrentLevel(String range) {
    int currentTemp = currentFeelsLike["feelsLike"];
    if (range == "Below 60°F") return currentTemp < 60;
    if (range == "60-70°F") return currentTemp >= 60 && currentTemp < 70;
    if (range == "70-80°F") return currentTemp >= 70 && currentTemp < 80;
    if (range == "80-90°F") return currentTemp >= 80 && currentTemp < 90;
    if (range == "90-100°F") return currentTemp >= 90 && currentTemp < 100;
    if (range == "Above 100°F") return currentTemp >= 100;
    return false;
  }
}
