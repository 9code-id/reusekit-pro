import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaEmergencyAlertsView extends StatefulWidget {
  const WcaEmergencyAlertsView({super.key});

  @override
  State<WcaEmergencyAlertsView> createState() => _WcaEmergencyAlertsViewState();
}

class _WcaEmergencyAlertsViewState extends State<WcaEmergencyAlertsView> {
  String selectedAlertLevel = "All";
  String selectedRegion = "My Area";
  bool enableSirens = true;
  bool enableVibration = true;
  bool enableFlashlight = false;

  List<Map<String, dynamic>> alertLevelOptions = [
    {"label": "All Emergency Alerts", "value": "All"},
    {"label": "Extreme Alerts", "value": "Extreme"},
    {"label": "Severe Alerts", "value": "Severe"},
    {"label": "Moderate Alerts", "value": "Moderate"},
    {"label": "Minor Alerts", "value": "Minor"},
  ];

  List<Map<String, dynamic>> regionOptions = [
    {"label": "My Area (5 miles)", "value": "My Area"},
    {"label": "County Wide", "value": "County"},
    {"label": "State Wide", "value": "State"},
    {"label": "National", "value": "National"},
  ];

  List<Map<String, dynamic>> currentEmergencies = [
    {
      "id": "EAS-001",
      "level": "Extreme",
      "type": "Tornado Emergency",
      "title": "TORNADO EMERGENCY",
      "message": "CONFIRMED LARGE TORNADO ON GROUND. TAKE SHELTER IMMEDIATELY. THIS IS A LIFE THREATENING SITUATION.",
      "location": "Jefferson County",
      "coordinates": "42.3601° N, 71.0589° W",
      "issuedTime": "3:22 PM",
      "validUntil": "4:00 PM",
      "urgency": "Immediate",
      "severity": "Extreme",
      "certainty": "Observed",
      "category": "Safety",
      "event": "Tornado",
      "headline": "Tornado Emergency for Jefferson County",
      "description": "A confirmed large and extremely dangerous tornado is on the ground in Jefferson County. This tornado is causing considerable damage and is a threat to life and property. Take shelter now!",
      "instruction": "TAKE COVER NOW! Move to a basement or an interior room on the lowest floor of a sturdy building. Avoid windows. If in a mobile home, a vehicle, or outdoors, move to the closest substantial shelter.",
      "area": "Jefferson County including the cities of Springfield, Centerville, and surrounding areas",
      "effectiveTime": "3:22 PM CST",
      "expireTime": "4:00 PM CST",
    },
    {
      "id": "EAS-002",
      "level": "Severe",
      "type": "Flash Flood Emergency",
      "title": "FLASH FLOOD EMERGENCY",
      "message": "Life threatening flash flooding in progress. Move to higher ground immediately.",
      "location": "Madison County",
      "coordinates": "39.7817° N, 89.6501° W",
      "issuedTime": "2:45 PM",
      "validUntil": "6:00 PM",
      "urgency": "Immediate",
      "severity": "Severe",
      "certainty": "Observed",
      "category": "Safety",
      "event": "Flash Flood",
      "headline": "Flash Flood Emergency for Madison County",
      "description": "Life threatening flash flooding is occurring across Madison County due to heavy rainfall. Water is rising rapidly in low-lying areas and near waterways.",
      "instruction": "Move to higher ground immediately. Do not attempt to drive through flooded roadways. Turn around, don't drown. Stay away from storm drains, streams, and washes.",
      "area": "Madison County including Alton, Granite City, and Wood River",
      "effectiveTime": "2:45 PM CST",
      "expireTime": "6:00 PM CST",
    },
    {
      "id": "EAS-003",
      "level": "Severe",
      "type": "Blizzard Warning",
      "title": "BLIZZARD WARNING",
      "message": "Life threatening blizzard conditions with zero visibility and dangerous cold.",
      "location": "Cook County",
      "coordinates": "41.8781° N, 87.6298° W",
      "issuedTime": "12:00 PM",
      "validUntil": "6:00 AM Tomorrow",
      "urgency": "Expected",
      "severity": "Severe",
      "certainty": "Likely",
      "category": "Safety",
      "event": "Blizzard",
      "headline": "Blizzard Warning for Cook County",
      "description": "Heavy snow and strong winds will create blizzard conditions with near zero visibility. Wind chills will be life threatening.",
      "instruction": "Avoid travel if possible. If you must travel, keep an extra flashlight, food, and water in your vehicle. Do not go outside during blizzard conditions as you may become disoriented.",
      "area": "Cook County including Chicago and surrounding suburbs",
      "effectiveTime": "6:00 PM Today",
      "expireTime": "6:00 AM Tomorrow",
    },
  ];

  List<Map<String, dynamic>> emergencyContacts = [
    {
      "service": "Emergency Services",
      "number": "911",
      "description": "Police, Fire, Medical Emergency",
      "available": "24/7",
    },
    {
      "service": "Emergency Management",
      "number": "(555) 123-4567",
      "description": "County Emergency Operations Center",
      "available": "24/7 during emergencies",
    },
    {
      "service": "Red Cross Emergency",
      "number": "1-800-RED-CROSS",
      "description": "Disaster Relief and Emergency Assistance",
      "available": "24/7",
    },
    {
      "service": "Poison Control",
      "number": "1-800-222-1222",
      "description": "Poison Control Center",
      "available": "24/7",
    },
  ];

  List<Map<String, dynamic>> emergencyActions = [
    {
      "action": "Take Shelter",
      "description": "Find immediate protective cover",
      "icon": Icons.home,
      "priority": "Critical",
    },
    {
      "action": "Evacuate Area",
      "description": "Leave the area immediately",
      "icon": Icons.directions_run,
      "priority": "Critical",
    },
    {
      "action": "Emergency Kit",
      "description": "Access emergency supplies",
      "icon": Icons.medical_services,
      "priority": "High",
    },
    {
      "action": "Contact Family",
      "description": "Notify family members",
      "icon": Icons.phone,
      "priority": "High",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Emergency Alerts"),
        backgroundColor: dangerColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.emergency),
            onPressed: () {
              si("Emergency mode activated");
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              si("Opening emergency settings");
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
            // Critical Alert Banner
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: dangerColor,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowLg],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.emergency,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "EMERGENCY ALERT SYSTEM",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "${currentEmergencies.length} active emergency alerts in your area",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "VIEW ALL EMERGENCIES",
                      size: bs.md,
                      onPressed: () {
                        si("Viewing all emergency alerts");
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Emergency Actions Quick Access
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
                  Text(
                    "Emergency Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ResponsiveGridView(
                    padding: EdgeInsets.all(0),
                    minItemWidth: 150,
                    children: emergencyActions.map((action) => Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: dangerColor.withAlpha(50)),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            action["icon"],
                            color: dangerColor,
                            size: 32,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "${action["action"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: dangerColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${action["description"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )).toList(),
                  ),
                ],
              ),
            ),

            // Alert Settings
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
                  Text(
                    "Alert Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Alert Level",
                          items: alertLevelOptions,
                          value: selectedAlertLevel,
                          onChanged: (value, label) {
                            selectedAlertLevel = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Coverage Area",
                          items: regionOptions,
                          value: selectedRegion,
                          onChanged: (value, label) {
                            selectedRegion = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  QSwitch(
                    label: "Emergency Sirens",
                    items: [
                      {
                        "label": "Play emergency siren sounds",
                        "value": true,
                        "checked": enableSirens,
                      }
                    ],
                    value: [
                      if (enableSirens)
                        {
                          "label": "Play emergency siren sounds",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      enableSirens = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    label: "Vibration Alerts",
                    items: [
                      {
                        "label": "Vibrate device for emergency alerts",
                        "value": true,
                        "checked": enableVibration,
                      }
                    ],
                    value: [
                      if (enableVibration)
                        {
                          "label": "Vibrate device for emergency alerts",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      enableVibration = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    label: "Flashlight Signal",
                    items: [
                      {
                        "label": "Flash device light for alerts",
                        "value": true,
                        "checked": enableFlashlight,
                      }
                    ],
                    value: [
                      if (enableFlashlight)
                        {
                          "label": "Flash device light for alerts",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      enableFlashlight = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Active Emergency Alerts
            Text(
              "Active Emergency Alerts",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...currentEmergencies.map((emergency) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border.all(
                  color: _getLevelColor(emergency["level"]),
                  width: 2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: _getLevelColor(emergency["level"]),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.emergency,
                          color: Colors.white,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${emergency["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "${emergency["level"]} • ${emergency["type"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "${emergency["headline"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${emergency["description"]}",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "INSTRUCTIONS:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${emergency["instruction"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spMd),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Location: ${emergency["location"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "Issued: ${emergency["issuedTime"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "Valid Until: ${emergency["validUntil"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Urgency: ${emergency["urgency"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "Severity: ${emergency["severity"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "Certainty: ${emergency["certainty"]}",
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
                      ],
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "CALL 911",
                          size: bs.md,
                          onPressed: () {
                            si("Emergency services contacted");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "View Map",
                          size: bs.md,
                          onPressed: () {
                            si("Opening emergency area map");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),

            // Emergency Contacts
            Text(
              "Emergency Contacts",
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
                children: emergencyContacts.map((contact) => Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: dangerColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.phone,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${contact["service"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${contact["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Available: ${contact["available"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spSm),
                      Column(
                        children: [
                          Text(
                            "${contact["number"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: dangerColor,
                            ),
                          ),
                          QButton(
                            label: "Call",
                            size: bs.sm,
                            onPressed: () {
                              si("Calling ${contact["service"]}");
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                )).toList(),
              ),
            ),

            // Safety Information
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
                        Icons.info_outline,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Emergency Preparedness",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Always take emergency alerts seriously",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Have an emergency plan and practice it",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Keep emergency supplies ready",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Know your evacuation routes",
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

  Color _getLevelColor(String level) {
    switch (level.toLowerCase()) {
      case "extreme":
        return dangerColor;
      case "severe":
        return dangerColor;
      case "moderate":
        return warningColor;
      case "minor":
        return infoColor;
      default:
        return infoColor;
    }
  }
}
