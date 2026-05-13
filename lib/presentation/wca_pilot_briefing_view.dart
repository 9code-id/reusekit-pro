import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaPilotBriefingView extends StatefulWidget {
  const WcaPilotBriefingView({super.key});

  @override
  State<WcaPilotBriefingView> createState() => _WcaPilotBriefingViewState();
}

class _WcaPilotBriefingViewState extends State<WcaPilotBriefingView> {
  String departureIcao = "KJFK";
  String arrivalIcao = "KLAX";
  String alternateIcao = "KORD";
  String flightLevel = "FL350";
  String estimatedTime = "5:30";

  List<Map<String, dynamic>> airports = [
    {"label": "KJFK - John F. Kennedy", "value": "KJFK"},
    {"label": "KLAX - Los Angeles", "value": "KLAX"},
    {"label": "KORD - Chicago O'Hare", "value": "KORD"},
    {"label": "KDFW - Dallas Fort Worth", "value": "KDFW"},
    {"label": "KDEN - Denver", "value": "KDEN"},
  ];

  List<Map<String, dynamic>> flightLevels = [
    {"label": "FL280", "value": "FL280"},
    {"label": "FL300", "value": "FL300"},
    {"label": "FL330", "value": "FL330"},
    {"label": "FL350", "value": "FL350"},
    {"label": "FL370", "value": "FL370"},
    {"label": "FL390", "value": "FL390"},
  ];

  Map<String, dynamic> briefingData = {
    "flightNumber": "UAL1234",
    "aircraftType": "B737-800",
    "briefingTime": "2024-06-16 14:30Z",
    "validTime": "16:00Z - 22:00Z",
    "briefingStatus": "Complete",
    "briefingOfficer": "John Smith",
    "weatherSummary": "VFR conditions at departure, MVFR at arrival"
  };

  List<Map<String, dynamic>> briefingSections = [
    {
      "title": "Route Weather",
      "status": "Good",
      "icon": Icons.route,
      "summary": "Clear skies, light winds along route",
      "details": [
        "Departure: VFR, winds 270/12",
        "En route: Clear, occasional light turbulence",
        "Arrival: MVFR, ceiling 3000ft"
      ]
    },
    {
      "title": "NOTAMs",
      "status": "Review Required",
      "icon": Icons.warning,
      "summary": "3 active NOTAMs affecting route",
      "details": [
        "KJFK: Runway 4L/22R closed for maintenance",
        "KLAX: ILS 24R out of service",
        "KORD: ATIS frequency change"
      ]
    },
    {
      "title": "Fuel Planning",
      "status": "Adequate",
      "icon": Icons.local_gas_station,
      "summary": "13,500 lbs required + reserves",
      "details": [
        "Trip fuel: 11,200 lbs",
        "Alternate fuel: 1,800 lbs",
        "Reserve fuel: 500 lbs"
      ]
    },
    {
      "title": "Performance",
      "status": "Normal",
      "icon": Icons.speed,
      "summary": "Standard takeoff and landing performance",
      "details": [
        "Takeoff weight: 154,000 lbs",
        "Landing weight: 142,000 lbs",
        "V1: 142 kts, VR: 147 kts, V2: 153 kts"
      ]
    }
  ];

  List<Map<String, dynamic>> hazards = [
    {
      "type": "Turbulence",
      "severity": "Light",
      "location": "Over Rocky Mountains",
      "altitude": "FL300-FL370",
      "action": "Monitor, consider FL280 or FL390"
    },
    {
      "type": "Convection",
      "severity": "Moderate",
      "location": "Southern California",
      "altitude": "SFC-FL250",
      "action": "Deviation may be required on arrival"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilot Briefing"),
        actions: [
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () {
              ss("Briefing printed");
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
                    Icons.assignment,
                    color: Colors.white,
                    size: 32,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Flight Briefing Package",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Comprehensive pre-flight weather briefing",
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
              "Flight Details",
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
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Departure",
                          items: airports,
                          value: departureIcao,
                          onChanged: (value, label) {
                            departureIcao = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Arrival",
                          items: airports,
                          value: arrivalIcao,
                          onChanged: (value, label) {
                            arrivalIcao = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Alternate",
                          items: airports,
                          value: alternateIcao,
                          onChanged: (value, label) {
                            alternateIcao = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Cruise Altitude",
                          items: flightLevels,
                          value: flightLevel,
                          onChanged: (value, label) {
                            flightLevel = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QTextField(
                    label: "Estimated Flight Time",
                    value: estimatedTime,
                    hint: "5:30",
                    onChanged: (value) {
                      estimatedTime = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            Container(
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
                      Icon(
                        Icons.check_circle,
                        color: successColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Briefing Status: ${briefingData["briefingStatus"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Flight: ${briefingData["flightNumber"]} | Aircraft: ${briefingData["aircraftType"]}",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "Briefed by: ${briefingData["briefingOfficer"]} at ${briefingData["briefingTime"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "Valid: ${briefingData["validTime"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            Text(
              "Briefing Summary",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: briefingSections.map((section) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: _getSectionStatusColor(section["status"]).withAlpha(50),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            section["icon"],
                            color: _getSectionStatusColor(section["status"]),
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${section["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: _getSectionStatusColor(section["status"]),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${section["status"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${section["summary"]}",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: (section["details"] as List).map<Widget>((detail) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: spXs),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "• ",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      detail,
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
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
                );
              }).toList(),
            ),

            if (hazards.isNotEmpty) ...[
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
                children: hazards.map((hazard) {
                  return Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: _getHazardSeverityColor(hazard["severity"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: _getHazardSeverityColor(hazard["severity"]).withAlpha(50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              _getHazardIcon(hazard["type"]),
                              color: _getHazardSeverityColor(hazard["severity"]),
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${hazard["type"]} - ${hazard["severity"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _getHazardSeverityColor(hazard["severity"]),
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
                          "Altitude: ${hazard["altitude"]}",
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
                            "Action: ${hazard["action"]}",
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

            Text(
              "Dispatch Actions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Update Briefing",
                    size: bs.md,
                    onPressed: () {
                      showLoading();
                      Future.delayed(Duration(seconds: 2), () {
                        hideLoading();
                        ss("Briefing updated successfully");
                      });
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Send to Crew",
                    size: bs.md,
                    onPressed: () {
                      showLoading();
                      Future.delayed(Duration(seconds: 1), () {
                        hideLoading();
                        ss("Briefing sent to flight crew");
                      });
                    },
                  ),
                ),
              ],
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Briefing Notes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• This briefing is valid for the specified time period only",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Weather conditions may change - monitor updates",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Contact dispatch for any route modifications",
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
    );
  }

  Color _getSectionStatusColor(String status) {
    switch (status) {
      case "Good":
      case "Normal":
      case "Adequate":
        return successColor;
      case "Review Required":
        return warningColor;
      case "Critical":
        return dangerColor;
      default:
        return infoColor;
    }
  }

  Color _getHazardSeverityColor(String severity) {
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
      case "Convection":
        return Icons.thunderstorm;
      case "Icing":
        return Icons.ac_unit;
      case "Wind Shear":
        return Icons.air;
      default:
        return Icons.warning;
    }
  }
}
