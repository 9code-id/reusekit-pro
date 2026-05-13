import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaPublicTransportView extends StatefulWidget {
  const TtaPublicTransportView({super.key});

  @override
  State<TtaPublicTransportView> createState() => _TtaPublicTransportViewState();
}

class _TtaPublicTransportViewState extends State<TtaPublicTransportView> {
  String fromLocation = "";
  String toLocation = "";
  String selectedTransportType = "All";
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  List<Map<String, dynamic>> transportTypes = [
    {"label": "All", "value": "All"},
    {"label": "Metro", "value": "Metro"},
    {"label": "Bus", "value": "Bus"},
    {"label": "Train", "value": "Train"},
    {"label": "Tram", "value": "Tram"},
  ];

  List<Map<String, dynamic>> routes = [
    {
      "id": "route1",
      "duration": "28 min",
      "price": "€3.50",
      "transfers": 1,
      "walkingTime": "5 min",
      "segments": [
        {
          "type": "walk",
          "duration": "3 min",
          "description": "Walk to Metro Station A",
          "icon": Icons.directions_walk
        },
        {
          "type": "metro",
          "line": "Line 1",
          "duration": "15 min",
          "from": "Station A",
          "to": "Station B",
          "icon": Icons.train,
          "color": 0xFF1976D2
        },
        {
          "type": "bus",
          "line": "Bus 42",
          "duration": "8 min",
          "from": "Station B",
          "to": "Station C",
          "icon": Icons.directions_bus,
          "color": 0xFF388E3C
        },
        {
          "type": "walk",
          "duration": "2 min",
          "description": "Walk to destination",
          "icon": Icons.directions_walk
        }
      ]
    },
    {
      "id": "route2",
      "duration": "35 min",
      "price": "€2.80",
      "transfers": 0,
      "walkingTime": "6 min",
      "segments": [
        {
          "type": "walk",
          "duration": "4 min",
          "description": "Walk to Bus Stop",
          "icon": Icons.directions_walk
        },
        {
          "type": "bus",
          "line": "Bus 73",
          "duration": "29 min",
          "from": "Central Station",
          "to": "Town Square",
          "icon": Icons.directions_bus,
          "color": 0xFFE53935
        },
        {
          "type": "walk",
          "duration": "2 min",
          "description": "Walk to destination",
          "icon": Icons.directions_walk
        }
      ]
    },
    {
      "id": "route3",
      "duration": "22 min",
      "price": "€4.20",
      "transfers": 2,
      "walkingTime": "8 min",
      "segments": [
        {
          "type": "walk",
          "duration": "3 min",
          "description": "Walk to Tram Stop",
          "icon": Icons.directions_walk
        },
        {
          "type": "tram",
          "line": "Tram 5",
          "duration": "8 min",
          "from": "City Center",
          "to": "University",
          "icon": Icons.tram,
          "color": 0xFF7B1FA2
        },
        {
          "type": "metro",
          "line": "Line 3",
          "duration": "9 min",
          "from": "University",
          "to": "Airport",
          "icon": Icons.train,
          "color": 0xFFFF8F00
        },
        {
          "type": "walk",
          "duration": "2 min",
          "description": "Walk to destination",
          "icon": Icons.directions_walk
        }
      ]
    },
  ];

  List<Map<String, dynamic>> nearbyStations = [
    {
      "name": "Central Metro Station",
      "type": "Metro",
      "distance": "150m",
      "lines": ["Line 1", "Line 2", "Line 4"],
      "icon": Icons.train
    },
    {
      "name": "Main Bus Terminal",
      "type": "Bus",
      "distance": "200m", 
      "lines": ["Bus 12", "Bus 34", "Bus 56"],
      "icon": Icons.directions_bus
    },
    {
      "name": "Tram Central",
      "type": "Tram",
      "distance": "300m",
      "lines": ["Tram 1", "Tram 3"],
      "icon": Icons.tram
    },
  ];

  void _searchRoutes() {
    if (fromLocation.isEmpty || toLocation.isEmpty) {
      se("Please enter both from and to locations");
      return;
    }
    
    ss("Searching for routes...");
  }

  void _swapLocations() {
    setState(() {
      String temp = fromLocation;
      fromLocation = toLocation;
      toLocation = temp;
    });
  }

  Color _getTransportColor(String type) {
    switch (type.toLowerCase()) {
      case "metro":
        return Color(0xFF1976D2);
      case "bus":
        return Color(0xFF388E3C);
      case "train":
        return Color(0xFF1976D2);
      case "tram":
        return Color(0xFF7B1FA2);
      default:
        return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Public Transport"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Route Planner
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
                    "Plan Your Journey",
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
                          label: "From",
                          value: fromLocation,
                          onChanged: (value) {
                            fromLocation = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(30),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: _swapLocations,
                          icon: Icon(
                            Icons.swap_vert,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTextField(
                          label: "To",
                          value: toLocation,
                          onChanged: (value) {
                            toLocation = value;
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
                          label: "Transport Type",
                          items: transportTypes,
                          value: selectedTransportType,
                          onChanged: (value, label) {
                            selectedTransportType = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDatePicker(
                          label: "Date",
                          value: selectedDate,
                          onChanged: (value) {
                            selectedDate = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  QTimePicker(
                    label: "Departure Time",
                    value: selectedTime,
                    onChanged: (value) {
                      selectedTime = value!;
                      setState(() {});
                    },
                  ),
                  
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Search Routes",
                      size: bs.md,
                      onPressed: _searchRoutes,
                    ),
                  ),
                ],
              ),
            ),

            // Route Results
            Text(
              "Available Routes",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: List.generate(routes.length, (index) {
                final route = routes[index];
                
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Route Summary
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              spacing: spSm,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${route["duration"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${route["price"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            spacing: spXxs,
                            children: [
                              Text(
                                "${route["transfers"]} transfer${(route["transfers"] as int) != 1 ? 's' : ''}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "${route["walkingTime"]} walking",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Route Segments
                      Column(
                        spacing: spXs,
                        children: List.generate((route["segments"] as List).length, (segmentIndex) {
                          final segment = (route["segments"] as List)[segmentIndex];
                          bool isWalking = segment["type"] == "walk";
                          
                          return Row(
                            children: [
                              Container(
                                width: 4,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: isWalking 
                                    ? disabledBoldColor 
                                    : Color(segment["color"] ?? primaryColor.value),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(
                                segment["icon"] as IconData,
                                size: 20,
                                color: isWalking 
                                  ? disabledBoldColor 
                                  : Color(segment["color"] ?? primaryColor.value),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXxs,
                                  children: [
                                    if (isWalking) ...[
                                      Text(
                                        "${segment["description"]} (${segment["duration"]})",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ] else ...[
                                      Text(
                                        "${segment["line"]} • ${segment["duration"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${segment["from"]} → ${segment["to"]}",
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
                          );
                        }),
                      ),

                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Select Route",
                          size: bs.sm,
                          onPressed: () {
                            ss("Route selected");
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),

            // Nearby Stations
            Text(
              "Nearby Stations",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: List.generate(nearbyStations.length, (index) {
                final station = nearbyStations[index];
                
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
                          color: _getTransportColor("${station["type"]}").withAlpha(30),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          station["icon"] as IconData,
                          color: _getTransportColor("${station["type"]}"),
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "${station["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Row(
                              spacing: spSm,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${station["type"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: infoColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${station["distance"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                            QHorizontalScroll(
                              children: List.generate((station["lines"] as List).length, (lineIndex) {
                                final line = (station["lines"] as List)[lineIndex];
                                
                                return Container(
                                  margin: EdgeInsets.only(right: spXs),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: warningColor.withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "$line",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: warningColor,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          fromLocation = "${station["name"]}";
                          setState(() {});
                        },
                        child: Icon(
                          Icons.directions,
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
