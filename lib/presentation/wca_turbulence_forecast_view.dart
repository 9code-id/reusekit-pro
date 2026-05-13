import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaTurbulenceForecastView extends StatefulWidget {
  const WcaTurbulenceForecastView({super.key});

  @override
  State<WcaTurbulenceForecastView> createState() => _WcaTurbulenceForecastViewState();
}

class _WcaTurbulenceForecastViewState extends State<WcaTurbulenceForecastView> {
  String selectedAltitude = "FL350";
  int selectedTimeIndex = 0;

  List<Map<String, dynamic>> altitudes = [
    {"label": "FL200 (20,000 ft)", "value": "FL200"},
    {"label": "FL250 (25,000 ft)", "value": "FL250"},
    {"label": "FL300 (30,000 ft)", "value": "FL300"},
    {"label": "FL350 (35,000 ft)", "value": "FL350"},
    {"label": "FL400 (40,000 ft)", "value": "FL400"},
  ];

  List<Map<String, dynamic>> timeFrames = [
    {"time": "Current", "period": "Now"},
    {"time": "+3 Hours", "period": "17:00Z"},
    {"time": "+6 Hours", "period": "20:00Z"},
    {"time": "+12 Hours", "period": "02:00Z"},
  ];

  Map<String, dynamic> currentConditions = {
    "overallLevel": "Moderate",
    "maxIntensity": "Severe",
    "affectedAreas": "Mountain Regions, Jet Stream",
    "confidence": "High",
    "forecast": "Increasing intensity expected"
  };

  List<Map<String, dynamic>> turbulenceAreas = [
    {
      "region": "Rocky Mountains",
      "intensity": "Moderate to Severe",
      "altitude": "FL250-FL400",
      "area": "Colorado, Wyoming",
      "cause": "Mountain Wave",
      "duration": "6 hours",
      "confidence": "High"
    },
    {
      "region": "Jet Stream Core",
      "intensity": "Light to Moderate",
      "altitude": "FL300-FL390",
      "area": "Central Plains",
      "cause": "Wind Shear",
      "duration": "4 hours",
      "confidence": "Medium"
    },
    {
      "region": "Convective Areas",
      "intensity": "Severe",
      "altitude": "FL180-FL450",
      "area": "Southeast Texas",
      "cause": "Thunderstorms",
      "duration": "3 hours",
      "confidence": "High"
    }
  ];

  List<Map<String, dynamic>> pireps = [
    {
      "time": "14:25Z",
      "aircraft": "B737",
      "altitude": "FL350",
      "location": "30nm W DEN",
      "intensity": "Moderate",
      "type": "CAT",
      "duration": "Occasional",
      "pilot": "Smooth to moderate chop"
    },
    {
      "time": "14:18Z",
      "aircraft": "A320",
      "altitude": "FL370",
      "location": "50nm E LAX",
      "intensity": "Light",
      "type": "Mechanical",
      "duration": "Continuous",
      "pilot": "Light turbulence throughout"
    },
    {
      "time": "14:05Z",
      "aircraft": "B777",
      "altitude": "FL390",
      "location": "40nm N DFW",
      "intensity": "Severe",
      "type": "Convective",
      "duration": "Intermittent",
      "pilot": "Severe turbulence near storms"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Turbulence Forecast"),
        actions: [
          IconButton(
            icon: Icon(Icons.layers),
            onPressed: () {
              si("Altitude layer view toggled");
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
                  colors: [warningColor, warningColor.withAlpha(150)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.waves,
                    color: Colors.white,
                    size: 32,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Turbulence Analysis",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Real-time turbulence conditions and forecasts",
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

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Altitude Level",
                    items: altitudes,
                    value: selectedAltitude,
                    onChanged: (value, label) {
                      selectedAltitude = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            Container(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: timeFrames.length,
                itemBuilder: (context, index) {
                  final timeFrame = timeFrames[index];
                  final isSelected = index == selectedTimeIndex;
                  
                  return GestureDetector(
                    onTap: () {
                      selectedTimeIndex = index;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                      margin: EdgeInsets.only(right: spSm),
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
                            "${timeFrame["time"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : primaryColor,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "${timeFrame["period"]}",
                            style: TextStyle(
                              color: isSelected ? Colors.white.withAlpha(200) : disabledBoldColor,
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
                color: _getIntensityColor(currentConditions["overallLevel"]).withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: _getIntensityColor(currentConditions["overallLevel"]).withAlpha(50),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _getIntensityIcon(currentConditions["overallLevel"]),
                        color: _getIntensityColor(currentConditions["overallLevel"]),
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Current Turbulence Level",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${currentConditions["overallLevel"]}",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: _getIntensityColor(currentConditions["overallLevel"]),
                    ),
                  ),
                  Text(
                    "${currentConditions["forecast"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            Text(
              "Active Turbulence Areas",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: turbulenceAreas.map((area) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: _getIntensityColorFromString(area["intensity"]),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: _getIntensityColorFromString(area["intensity"]),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${area["intensity"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${area["region"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                                fontSize: fsH6,
                              ),
                            ),
                          ),
                          Icon(
                            _getCauseIcon(area["cause"]),
                            color: _getIntensityColorFromString(area["intensity"]),
                            size: 20,
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Altitude: ${area["altitude"]}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "Area: ${area["area"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Duration: ${area["duration"]}",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.verified,
                                    color: _getConfidenceColor(area["confidence"]),
                                    size: 12,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Confidence: ${area["confidence"]}",
                                    style: TextStyle(
                                      color: _getConfidenceColor(area["confidence"]),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info,
                              color: infoColor,
                              size: 16,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Cause: ${area["cause"]}",
                              style: TextStyle(
                                color: infoColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
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

            Text(
              "Pilot Reports (PIREPs)",
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
                children: pireps.map((pirep) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: _getIntensityColor(pirep["intensity"]).withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: _getIntensityColor(pirep["intensity"]).withAlpha(50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: _getIntensityColor(pirep["intensity"]),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${pirep["intensity"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${pirep["aircraft"]} at ${pirep["altitude"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${pirep["time"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Location: ${pirep["location"]}",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Type: ${pirep["type"]} | Duration: ${pirep["duration"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: disabledColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "\"${pirep["pilot"]}\"",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            Text(
              "Turbulence Legend",
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
                children: [
                  _buildLegendItem("Light", "Slight, erratic changes in altitude", successColor),
                  _buildLegendItem("Moderate", "Changes in altitude, airspeed", warningColor),
                  _buildLegendItem("Severe", "Large, abrupt changes, difficult control", dangerColor),
                  _buildLegendItem("Extreme", "Aircraft out of control, structural damage", dangerColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String intensity, String description, Color color) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                intensity,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
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
    );
  }

  Color _getIntensityColor(String intensity) {
    switch (intensity.toLowerCase()) {
      case "light":
        return successColor;
      case "moderate":
        return warningColor;
      case "severe":
      case "extreme":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getIntensityColorFromString(String intensityString) {
    if (intensityString.toLowerCase().contains("severe")) return dangerColor;
    if (intensityString.toLowerCase().contains("moderate")) return warningColor;
    if (intensityString.toLowerCase().contains("light")) return successColor;
    return infoColor;
  }

  IconData _getIntensityIcon(String intensity) {
    switch (intensity.toLowerCase()) {
      case "light":
        return Icons.waves;
      case "moderate":
        return Icons.warning;
      case "severe":
      case "extreme":
        return Icons.dangerous;
      default:
        return Icons.help;
    }
  }

  IconData _getCauseIcon(String cause) {
    switch (cause.toLowerCase()) {
      case "mountain wave":
        return Icons.terrain;
      case "wind shear":
        return Icons.air;
      case "thunderstorms":
        return Icons.thunderstorm;
      case "jet stream":
        return Icons.timeline;
      default:
        return Icons.waves;
    }
  }

  Color _getConfidenceColor(String confidence) {
    switch (confidence.toLowerCase()) {
      case "high":
        return successColor;
      case "medium":
        return warningColor;
      case "low":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
