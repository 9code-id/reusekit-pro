import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaFlightConditionsView extends StatefulWidget {
  const WcaFlightConditionsView({super.key});

  @override
  State<WcaFlightConditionsView> createState() => _WcaFlightConditionsViewState();
}

class _WcaFlightConditionsViewState extends State<WcaFlightConditionsView> {
  String departureAirport = "KJFK";
  String arrivalAirport = "KLAX";
  String selectedRoute = "Direct";

  List<Map<String, dynamic>> airports = [
    {"label": "KJFK - John F. Kennedy", "value": "KJFK"},
    {"label": "KLAX - Los Angeles", "value": "KLAX"},
    {"label": "KORD - Chicago O'Hare", "value": "KORD"},
    {"label": "KDFW - Dallas Fort Worth", "value": "KDFW"},
  ];

  List<Map<String, dynamic>> routes = [
    {"label": "Direct Route", "value": "Direct"},
    {"label": "Northern Route", "value": "Northern"},
    {"label": "Southern Route", "value": "Southern"},
  ];

  Map<String, dynamic> flightConditions = {
    "overallRating": "Good",
    "departureConditions": "VFR",
    "arrivalConditions": "MVFR",
    "enrouteConditions": "VFR",
    "estimatedFlightTime": "5h 42m",
    "fuelRequired": "12,500 lbs",
    "alternateAirport": "KORD",
    "recommendedAltitude": "FL350",
    "turbulenceLevel": "Light",
    "icingConditions": "None",
    "convectiveActivity": "Isolated",
    "jetStreamPosition": "North of route"
  };

  List<Map<String, dynamic>> weatherHazards = [
    {
      "type": "Turbulence",
      "severity": "Light",
      "location": "Over Colorado",
      "altitude": "FL300-FL380",
      "timeframe": "14:00-18:00Z",
      "recommendation": "Consider slight course deviation"
    },
    {
      "type": "Convective Activity",
      "severity": "Moderate",
      "location": "Southern California",
      "altitude": "SFC-FL250",
      "timeframe": "16:00-20:00Z",
      "recommendation": "Monitor developments, possible alternate required"
    }
  ];

  List<Map<String, dynamic>> flightLevels = [
    {"altitude": "FL330", "turbulence": "None", "icing": "None", "winds": "280/45"},
    {"altitude": "FL350", "turbulence": "Light", "icing": "None", "winds": "270/52"},
    {"altitude": "FL370", "turbulence": "Light", "icing": "Light", "winds": "265/58"},
    {"altitude": "FL390", "turbulence": "Moderate", "icing": "Light", "winds": "260/62"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flight Conditions"),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              si("Flight route map opened");
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
                  colors: [infoColor, infoColor.withAlpha(150)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.flight_takeoff,
                    color: Colors.white,
                    size: 32,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Flight Planning Weather",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Comprehensive route and conditions analysis",
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

            Text(
              "Flight Route",
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
                    label: "Departure",
                    items: airports,
                    value: departureAirport,
                    onChanged: (value, label) {
                      departureAirport = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Arrival",
                    items: airports,
                    value: arrivalAirport,
                    onChanged: (value, label) {
                      arrivalAirport = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            QDropdownField(
              label: "Route Selection",
              items: routes,
              value: selectedRoute,
              onChanged: (value, label) {
                selectedRoute = value;
                setState(() {});
              },
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: _getRatingColor(flightConditions["overallRating"]).withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: _getRatingColor(flightConditions["overallRating"]).withAlpha(50),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _getRatingIcon(flightConditions["overallRating"]),
                        color: _getRatingColor(flightConditions["overallRating"]),
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Flight Conditions",
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
                    "${flightConditions["overallRating"]}",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: _getRatingColor(flightConditions["overallRating"]),
                    ),
                  ),
                  Text(
                    "Overall flight conditions are favorable",
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
              "Route Conditions",
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
                          Icons.flight_takeoff,
                          color: _getCategoryColor(flightConditions["departureConditions"]),
                          size: 24,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Departure",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${flightConditions["departureConditions"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: _getCategoryColor(flightConditions["departureConditions"]),
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
                          Icons.route,
                          color: _getCategoryColor(flightConditions["enrouteConditions"]),
                          size: 24,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "En Route",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${flightConditions["enrouteConditions"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: _getCategoryColor(flightConditions["enrouteConditions"]),
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
                          Icons.flight_land,
                          color: _getCategoryColor(flightConditions["arrivalConditions"]),
                          size: 24,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Arrival",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${flightConditions["arrivalConditions"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: _getCategoryColor(flightConditions["arrivalConditions"]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Text(
              "Flight Information",
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
                            Icons.schedule,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Flight Time",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${flightConditions["estimatedFlightTime"]}",
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
                            Icons.local_gas_station,
                            color: warningColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Fuel Required",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${flightConditions["fuelRequired"]}",
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
                            Icons.height,
                            color: infoColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Recommended Alt",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${flightConditions["recommendedAltitude"]}",
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
                            Icons.airport_shuttle,
                            color: successColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Alternate Airport",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${flightConditions["alternateAirport"]}",
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
              "Flight Level Analysis",
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
                children: flightLevels.map((level) {
                  final isRecommended = level["altitude"] == flightConditions["recommendedAltitude"];
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: isRecommended ? primaryColor.withAlpha(20) : disabledColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: isRecommended ? primaryColor : disabledOutlineBorderColor,
                      ),
                    ),
                    child: Row(
                      children: [
                        if (isRecommended)
                          Icon(
                            Icons.recommend,
                            color: primaryColor,
                            size: 16,
                          ),
                        if (isRecommended) SizedBox(width: spSm),
                        Text(
                          "${level["altitude"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Turb: ${level["turbulence"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Ice: ${level["icing"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Wind: ${level["winds"]}",
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
            ),

            if (weatherHazards.isNotEmpty) ...[
              Text(
                "Weather Hazards",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              Column(
                spacing: spSm,
                children: weatherHazards.map((hazard) {
                  return Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: _getSeverityColor(hazard["severity"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: _getSeverityColor(hazard["severity"]).withAlpha(50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              _getHazardIcon(hazard["type"]),
                              color: _getSeverityColor(hazard["severity"]),
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${hazard["type"]} - ${hazard["severity"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _getSeverityColor(hazard["severity"]),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Location: ${hazard["location"]}",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Altitude: ${hazard["altitude"]} | Time: ${hazard["timeframe"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "Recommendation: ${hazard["recommendation"]}",
                            style: TextStyle(
                              color: infoColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getRatingColor(String rating) {
    switch (rating) {
      case "Excellent":
        return successColor;
      case "Good":
        return infoColor;
      case "Fair":
        return warningColor;
      case "Poor":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getRatingIcon(String rating) {
    switch (rating) {
      case "Excellent":
        return Icons.check_circle;
      case "Good":
        return Icons.thumb_up;
      case "Fair":
        return Icons.warning;
      case "Poor":
        return Icons.dangerous;
      default:
        return Icons.help;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "VFR":
        return successColor;
      case "MVFR":
        return infoColor;
      case "IFR":
        return warningColor;
      case "LIFR":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "Light":
        return infoColor;
      case "Moderate":
        return warningColor;
      case "Severe":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getHazardIcon(String type) {
    switch (type) {
      case "Turbulence":
        return Icons.waves;
      case "Convective Activity":
        return Icons.thunderstorm;
      case "Icing":
        return Icons.ac_unit;
      default:
        return Icons.warning;
    }
  }
}
