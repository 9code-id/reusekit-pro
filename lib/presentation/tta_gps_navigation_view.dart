import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaGpsNavigationView extends StatefulWidget {
  const TtaGpsNavigationView({super.key});

  @override
  State<TtaGpsNavigationView> createState() => _TtaGpsNavigationViewState();
}

class _TtaGpsNavigationViewState extends State<TtaGpsNavigationView> {
  String destination = "";
  String travelMode = "driving";
  bool voiceGuidance = true;
  bool avoidTolls = false;
  bool avoidHighways = false;
  bool isNavigating = false;

  List<Map<String, dynamic>> travelModeItems = [
    {"label": "Driving", "value": "driving"},
    {"label": "Walking", "value": "walking"},
    {"label": "Cycling", "value": "cycling"},
    {"label": "Public Transit", "value": "transit"},
  ];

  List<Map<String, dynamic>> recentDestinations = [
    {
      "name": "Eiffel Tower",
      "address": "Champ de Mars, 5 Avenue Anatole France, 75007 Paris",
      "distance": "2.3 km",
      "eta": "8 min",
      "type": "attraction"
    },
    {
      "name": "Louvre Museum", 
      "address": "Rue de Rivoli, 75001 Paris",
      "distance": "1.8 km",
      "eta": "6 min",
      "type": "museum"
    },
    {
      "name": "Notre-Dame Cathedral",
      "address": "6 Parvis Notre-Dame, 75004 Paris",
      "distance": "3.1 km",
      "eta": "12 min",
      "type": "landmark"
    },
  ];

  List<Map<String, dynamic>> quickDestinations = [
    {"name": "Hotel", "icon": Icons.hotel, "type": "accommodation"},
    {"name": "Restaurant", "icon": Icons.restaurant, "type": "food"},
    {"name": "Gas Station", "icon": Icons.local_gas_station, "type": "fuel"},
    {"name": "Hospital", "icon": Icons.local_hospital, "type": "medical"},
    {"name": "ATM", "icon": Icons.atm, "type": "finance"},
    {"name": "Pharmacy", "icon": Icons.local_pharmacy, "type": "medical"},
  ];

  Map<String, dynamic> currentRoute = {
    "distance": "5.2 km",
    "duration": "18 min",
    "traffic": "Light traffic",
    "nextTurn": "Turn right on Avenue des Champs-Élysées in 200m",
    "remainingSteps": 8,
    "arrivalTime": "3:45 PM"
  };

  void _startNavigation() {
    if (destination.trim().isEmpty) {
      se("Please enter a destination");
      return;
    }

    setState(() {
      isNavigating = true;
    });
    
    ss("Navigation started to $destination");
  }

  void _stopNavigation() {
    setState(() {
      isNavigating = false;
    });
    
    ss("Navigation stopped");
  }

  void _selectQuickDestination(Map<String, dynamic> dest) {
    destination = "${dest["name"]} nearby";
    setState(() {});
    _startNavigation();
  }

  IconData _getTravelModeIcon(String mode) {
    switch (mode) {
      case "driving":
        return Icons.directions_car;
      case "walking":
        return Icons.directions_walk;
      case "cycling":
        return Icons.directions_bike;
      case "transit":
        return Icons.directions_transit;
      default:
        return Icons.directions;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GPS Navigation"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Navigation Controls
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Text(
                    "Where to?",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Enter destination...",
                          value: destination,
                          onChanged: (value) {
                            destination = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.my_location,
                        size: bs.sm,
                        onPressed: () {
                          ss("Current location detected");
                        },
                      ),
                    ],
                  ),
                  
                  QDropdownField(
                    label: "Travel Mode",
                    items: travelModeItems,
                    value: travelMode,
                    onChanged: (value, label) {
                      travelMode = value;
                      setState(() {});
                    },
                  ),
                  
                  // Navigation Options
                  Column(
                    spacing: spSm,
                    children: [
                      QSwitch(
                        items: [
                          {
                            "label": "Voice Guidance",
                            "value": true,
                            "checked": voiceGuidance,
                          }
                        ],
                        value: voiceGuidance ? [{"label": "Voice Guidance", "value": true, "checked": true}] : [],
                        onChanged: (values, ids) {
                          voiceGuidance = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                      
                      QSwitch(
                        items: [
                          {
                            "label": "Avoid Tolls",
                            "value": true,
                            "checked": avoidTolls,
                          }
                        ],
                        value: avoidTolls ? [{"label": "Avoid Tolls", "value": true, "checked": true}] : [],
                        onChanged: (values, ids) {
                          avoidTolls = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                      
                      QSwitch(
                        items: [
                          {
                            "label": "Avoid Highways",
                            "value": true,
                            "checked": avoidHighways,
                          }
                        ],
                        value: avoidHighways ? [{"label": "Avoid Highways", "value": true, "checked": true}] : [],
                        onChanged: (values, ids) {
                          avoidHighways = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  
                  Row(
                    spacing: spSm,
                    children: [
                      if (!isNavigating) ...[
                        Expanded(
                          child: QButton(
                            label: "Start Navigation",
                            size: bs.md,
                            onPressed: _startNavigation,
                          ),
                        ),
                      ] else ...[
                        Expanded(
                          child: QButton(
                            label: "Stop Navigation",
                            size: bs.md,
                            onPressed: _stopNavigation,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            // Active Navigation Card
            if (isNavigating) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: successColor.withAlpha(100)),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          _getTravelModeIcon(travelMode),
                          color: successColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Navigating to: $destination",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "Distance",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${currentRoute["distance"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "ETA",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${currentRoute["arrivalTime"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "Duration",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${currentRoute["duration"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        spacing: spXs,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Next Turn",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${currentRoute["nextTurn"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${currentRoute["remainingSteps"]} steps remaining • ${currentRoute["traffic"]}",
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
              ),
            ],

            // Quick Destinations
            Text(
              "Quick Search",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 120,
              children: List.generate(quickDestinations.length, (index) {
                final dest = quickDestinations[index];
                
                return GestureDetector(
                  onTap: () => _selectQuickDestination(dest),
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spSm,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(30),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            dest["icon"] as IconData,
                            color: primaryColor,
                            size: 28,
                          ),
                        ),
                        Text(
                          "${dest["name"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),

            // Recent Destinations
            Text(
              "Recent Destinations",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: List.generate(recentDestinations.length, (index) {
                final dest = recentDestinations[index];
                
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(30),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.place,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "${dest["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${dest["address"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              spacing: spSm,
                              children: [
                                Text(
                                  "${dest["distance"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: infoColor,
                                  ),
                                ),
                                Text(
                                  "•",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${dest["eta"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          destination = "${dest["name"]}";
                          setState(() {});
                        },
                        child: Icon(
                          Icons.navigation,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
