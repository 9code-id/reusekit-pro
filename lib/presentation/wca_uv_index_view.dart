import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaUvIndexView extends StatefulWidget {
  const WcaUvIndexView({super.key});

  @override
  State<WcaUvIndexView> createState() => _WcaUvIndexViewState();
}

class _WcaUvIndexViewState extends State<WcaUvIndexView> {
  double currentUVIndex = 6.5;
  String selectedSkinType = "Type II";
  bool notificationsEnabled = true;
  
  List<Map<String, dynamic>> skinTypes = [
    {"label": "Type I (Very Fair)", "value": "Type I"},
    {"label": "Type II (Fair)", "value": "Type II"},
    {"label": "Type III (Medium)", "value": "Type III"},
    {"label": "Type IV (Olive)", "value": "Type IV"},
    {"label": "Type V (Brown)", "value": "Type V"},
    {"label": "Type VI (Dark)", "value": "Type VI"},
  ];

  List<Map<String, dynamic>> hourlyUV = [
    {"time": "06:00", "uv": 0.5, "level": "Low"},
    {"time": "09:00", "uv": 3.2, "level": "Moderate"},
    {"time": "12:00", "uv": 7.8, "level": "High"},
    {"time": "15:00", "uv": 6.5, "level": "High"},
    {"time": "18:00", "uv": 2.1, "level": "Low"},
    {"time": "21:00", "uv": 0.0, "level": "None"},
  ];

  List<Map<String, dynamic>> protectionTips = [
    {"tip": "Wear broad-spectrum sunscreen SPF 30+", "icon": Icons.health_and_safety},
    {"tip": "Seek shade during peak hours (10 AM - 4 PM)", "icon": Icons.umbrella},
    {"tip": "Wear protective clothing and wide-brimmed hat", "icon": Icons.checkroom},
    {"tip": "Use UV-blocking sunglasses", "icon": Icons.visibility_off},
    {"tip": "Limit direct sun exposure", "icon": Icons.access_time},
  ];

  String getUVLevel(double uvIndex) {
    if (uvIndex <= 2) return "Low";
    if (uvIndex <= 5) return "Moderate";
    if (uvIndex <= 7) return "High";
    if (uvIndex <= 10) return "Very High";
    return "Extreme";
  }

  Color getUVColor(double uvIndex) {
    if (uvIndex <= 2) return successColor;
    if (uvIndex <= 5) return warningColor;
    if (uvIndex <= 7) return Colors.orange;
    if (uvIndex <= 10) return dangerColor;
    return Colors.purple;
  }

  String getBurnTime(String skinType, double uvIndex) {
    Map<String, int> baseTimes = {
      "Type I": 10,
      "Type II": 15,
      "Type III": 20,
      "Type IV": 30,
      "Type V": 45,
      "Type VI": 60,
    };
    
    int baseTime = baseTimes[skinType] ?? 15;
    int burnTime = (baseTime / uvIndex).round();
    
    if (burnTime < 5) return "< 5 minutes";
    if (burnTime < 60) return "$burnTime minutes";
    return "${(burnTime / 60).round()} hours";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UV Index"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              si("UV alerts settings");
            },
          ),
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              si("UV Index information");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spLg,
          children: [
            // Current UV Index
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    getUVColor(currentUVIndex),
                    getUVColor(currentUVIndex).withAlpha(200),
                  ],
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Text(
                    "Current UV Index",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${currentUVIndex}",
                    style: TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    getUVLevel(currentUVIndex),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spLg),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Burn Time",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                        Text(
                          getBurnTime(selectedSkinType, currentUVIndex),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Skin Type Selection
            Text(
              "Skin Type",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QDropdownField(
              label: "Select Your Skin Type",
              items: skinTypes,
              value: selectedSkinType,
              onChanged: (value, label) {
                selectedSkinType = value;
                setState(() {});
              },
            ),

            // UV Scale
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "UV Index Scale",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  _buildUVScaleItem("0-2", "Low", successColor, "Minimal protection required"),
                  _buildUVScaleItem("3-5", "Moderate", warningColor, "Seek shade during midday hours"),
                  _buildUVScaleItem("6-7", "High", Colors.orange, "Protection required"),
                  _buildUVScaleItem("8-10", "Very High", dangerColor, "Extra protection required"),
                  _buildUVScaleItem("11+", "Extreme", Colors.purple, "Take all precautions"),
                ],
              ),
            ),

            // Hourly UV Forecast
            Text(
              "Hourly UV Forecast",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QHorizontalScroll(
              children: hourlyUV.map((hour) {
                return Container(
                  width: 100,
                  margin: EdgeInsets.only(right: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: getUVColor(hour["uv"] as double).withAlpha(50),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    spacing: spXs,
                    children: [
                      Text(
                        "${hour["time"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: getUVColor(hour["uv"] as double),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "${hour["uv"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "${hour["level"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Protection Tips
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Protection Tips",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...protectionTips.map((tip) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            tip["icon"] as IconData,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${tip["tip"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Notification Settings
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "UV Alerts",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Enable UV Notifications",
                              "value": true,
                              "checked": notificationsEnabled,
                            }
                          ],
                          value: [
                            if (notificationsEnabled)
                              {
                                "label": "Enable UV Notifications",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            notificationsEnabled = values.isNotEmpty;
                            setState(() {});
                            if (notificationsEnabled) {
                              ss("UV notifications enabled");
                            } else {
                              si("UV notifications disabled");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  if (notificationsEnabled) ...[
                    SizedBox(height: spSm),
                    Text(
                      "You'll receive alerts when UV levels are high or extreme.",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUVScaleItem(String range, String level, Color color, String description) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 24,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Center(
              child: Text(
                range,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  level,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
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
}
