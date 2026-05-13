import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaAstronomicalDataView extends StatefulWidget {
  const WcaAstronomicalDataView({super.key});

  @override
  State<WcaAstronomicalDataView> createState() => _WcaAstronomicalDataViewState();
}

class _WcaAstronomicalDataViewState extends State<WcaAstronomicalDataView> {
  String selectedLocation = "New York, NY";
  String selectedTimeframe = "Current";
  int selectedTab = 0;

  List<Map<String, dynamic>> locationItems = [
    {"label": "New York, NY", "value": "New York, NY"},
    {"label": "Los Angeles, CA", "value": "Los Angeles, CA"},
    {"label": "Chicago, IL", "value": "Chicago, IL"},
    {"label": "Houston, TX", "value": "Houston, TX"},
    {"label": "Phoenix, AZ", "value": "Phoenix, AZ"},
  ];

  List<Map<String, dynamic>> timeframeItems = [
    {"label": "Current", "value": "Current"},
    {"label": "Tonight", "value": "Tonight"},
    {"label": "7-Day Forecast", "value": "7-Day Forecast"},
    {"label": "Monthly", "value": "Monthly"},
  ];

  List<Map<String, dynamic>> planetData = [
    {
      "name": "Mercury",
      "visible": true,
      "magnitude": -0.2,
      "constellation": "Gemini",
      "rise": "05:12",
      "set": "18:45",
      "phase": "Waning Gibbous"
    },
    {
      "name": "Venus",
      "visible": true,
      "magnitude": -4.1,
      "constellation": "Leo",
      "rise": "04:23",
      "set": "19:33",
      "phase": "Crescent"
    },
    {
      "name": "Mars",
      "visible": false,
      "magnitude": 1.8,
      "constellation": "Virgo",
      "rise": "02:15",
      "set": "14:22",
      "phase": "Full"
    },
    {
      "name": "Jupiter",
      "visible": true,
      "magnitude": -2.3,
      "constellation": "Taurus",
      "rise": "19:45",
      "set": "08:12",
      "phase": "Full"
    },
    {
      "name": "Saturn",
      "visible": true,
      "magnitude": 0.6,
      "constellation": "Aquarius",
      "rise": "21:33",
      "set": "10:45",
      "phase": "Full"
    },
  ];

  List<Map<String, dynamic>> constellationData = [
    {
      "name": "Ursa Major",
      "visible": true,
      "bestTime": "21:00 - 03:00",
      "direction": "North",
      "season": "Spring",
      "stars": 7
    },
    {
      "name": "Orion",
      "visible": false,
      "bestTime": "20:00 - 02:00",
      "direction": "South",
      "season": "Winter",
      "stars": 8
    },
    {
      "name": "Cassiopeia",
      "visible": true,
      "bestTime": "22:00 - 04:00",
      "direction": "North",
      "season": "Autumn",
      "stars": 5
    },
    {
      "name": "Leo",
      "visible": true,
      "bestTime": "20:30 - 01:30",
      "direction": "East",
      "season": "Spring",
      "stars": 9
    },
  ];

  List<Map<String, dynamic>> starData = [
    {
      "name": "Sirius",
      "magnitude": -1.46,
      "constellation": "Canis Major",
      "distance": "8.6 ly",
      "color": "Blue-white",
      "visible": true
    },
    {
      "name": "Canopus",
      "magnitude": -0.74,
      "constellation": "Carina",
      "distance": "310 ly",
      "color": "White",
      "visible": false
    },
    {
      "name": "Arcturus",
      "magnitude": -0.05,
      "constellation": "Boötes",
      "distance": "37 ly",
      "color": "Orange",
      "visible": true
    },
    {
      "name": "Vega",
      "magnitude": 0.03,
      "constellation": "Lyra",
      "distance": "25 ly",
      "color": "Blue-white",
      "visible": true
    },
  ];

  List<Map<String, dynamic>> astronomicalEvents = [
    {
      "date": "June 18",
      "time": "03:42",
      "event": "Mercury at Greatest Eastern Elongation",
      "type": "Planet",
      "visibility": "High"
    },
    {
      "date": "June 20",
      "time": "22:15",
      "event": "June Solstice",
      "type": "Solar",
      "visibility": "Global"
    },
    {
      "date": "June 22",
      "time": "01:30",
      "event": "Moon Occults Mars",
      "type": "Lunar",
      "visibility": "Medium"
    },
    {
      "date": "June 25",
      "time": "19:45",
      "event": "Venus at Greatest Brightness",
      "type": "Planet",
      "visibility": "High"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Astronomical Data"),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spLg,
          children: [
            // Location and Timeframe Selection
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Location",
                    items: locationItems,
                    value: selectedLocation,
                    onChanged: (value, label) {
                      selectedLocation = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Timeframe",
                    items: timeframeItems,
                    value: selectedTimeframe,
                    onChanged: (value, label) {
                      selectedTimeframe = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Current Sky Conditions
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.wb_twilight, color: primaryColor),
                      SizedBox(width: spXs),
                      Text(
                        "Current Sky Conditions",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Divider(color: primaryColor.withAlpha(30)),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "Visibility",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Excellent",
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
                              "Cloud Cover",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "15%",
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
                              "Seeing",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "4/5",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
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

            // Tab Navigation
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              padding: EdgeInsets.all(4),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        selectedTab = 0;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: spSm),
                        decoration: BoxDecoration(
                          color: selectedTab == 0 ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Planets",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: selectedTab == 0 ? Colors.white : disabledBoldColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        selectedTab = 1;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: spSm),
                        decoration: BoxDecoration(
                          color: selectedTab == 1 ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Stars",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: selectedTab == 1 ? Colors.white : disabledBoldColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        selectedTab = 2;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: spSm),
                        decoration: BoxDecoration(
                          color: selectedTab == 2 ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Events",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: selectedTab == 2 ? Colors.white : disabledBoldColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Tab Content
            if (selectedTab == 0) ...[
              // Planets Tab
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "Visible Planets Tonight",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    ...planetData.map((planet) => Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: (planet["visible"] as bool) 
                            ? successColor.withAlpha(20) 
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: (planet["visible"] as bool) 
                              ? successColor.withAlpha(50) 
                              : Colors.grey[300]!,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: (planet["visible"] as bool) ? successColor : disabledColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Icon(
                              Icons.circle,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${planet["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: (planet["visible"] as bool) 
                                            ? successColor 
                                            : disabledColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        (planet["visible"] as bool) ? "Visible" : "Not Visible",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Magnitude: ${planet["magnitude"]} | ${planet["constellation"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Rise: ${planet["rise"]} | Set: ${planet["set"]}",
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
                    )),
                  ],
                ),
              ),

              // Constellations
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "Visible Constellations",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 200,
                      children: constellationData.map((constellation) => Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (constellation["visible"] as bool) 
                              ? infoColor.withAlpha(20) 
                              : Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: (constellation["visible"] as bool) 
                                ? infoColor.withAlpha(50) 
                                : Colors.grey[300]!,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.stars,
                                  color: (constellation["visible"] as bool) ? infoColor : disabledColor,
                                  size: 20,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${constellation["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Best Time: ${constellation["bestTime"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Direction: ${constellation["direction"]} | ${constellation["stars"]} stars",
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
            ],

            if (selectedTab == 1) ...[
              // Stars Tab
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "Brightest Stars Tonight",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    ...starData.map((star) => Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        color: (star["visible"] as bool) 
                            ? warningColor.withAlpha(20) 
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: (star["visible"] as bool) 
                              ? warningColor.withAlpha(50) 
                              : Colors.grey[300]!,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: (star["visible"] as bool) ? warningColor : disabledColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${star["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "Mag: ${star["magnitude"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: warningColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${star["constellation"]} | ${star["color"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Distance: ${star["distance"]}",
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
                    )),
                  ],
                ),
              ),
            ],

            if (selectedTab == 2) ...[
              // Events Tab
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "Upcoming Astronomical Events",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    ...astronomicalEvents.map((event) => Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        color: secondaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: secondaryColor.withAlpha(50)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 50,
                            decoration: BoxDecoration(
                              color: _getEventTypeColor(event["type"] as String),
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${event["date"]}".split(' ')[1],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "${event["time"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Text(
                                  "${event["event"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getEventTypeColor(event["type"] as String),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${event["type"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Visibility: ${event["visibility"]}",
                                      style: TextStyle(
                                        fontSize: 12,
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
                    )),
                  ],
                ),
              ),
            ],

            // Observation Tips
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb_outline, color: infoColor),
                      SizedBox(width: spXs),
                      Text(
                        "Observation Tips",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Divider(color: infoColor.withAlpha(30)),
                  Text(
                    "• Allow 20-30 minutes for your eyes to adapt to darkness",
                    style: TextStyle(fontSize: 13, color: primaryColor),
                  ),
                  Text(
                    "• Use a red flashlight to preserve night vision",
                    style: TextStyle(fontSize: 13, color: primaryColor),
                  ),
                  Text(
                    "• Find a location away from city lights for best viewing",
                    style: TextStyle(fontSize: 13, color: primaryColor),
                  ),
                  Text(
                    "• Check weather conditions for clear skies",
                    style: TextStyle(fontSize: 13, color: primaryColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getEventTypeColor(String type) {
    switch (type) {
      case "Planet":
        return warningColor;
      case "Solar":
        return dangerColor;
      case "Lunar":
        return infoColor;
      default:
        return primaryColor;
    }
  }
}
