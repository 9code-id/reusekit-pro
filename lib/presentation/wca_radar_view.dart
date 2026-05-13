import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaRadarView extends StatefulWidget {
  const WcaRadarView({super.key});

  @override
  State<WcaRadarView> createState() => _WcaRadarViewState();
}

class _WcaRadarViewState extends State<WcaRadarView> {
  String selectedRadarType = "Precipitation";
  String selectedTimeRange = "Live";
  bool isPlaying = false;
  int currentFrame = 0;
  double zoomLevel = 1.0;

  final List<Map<String, dynamic>> radarTypes = [
    {"label": "Precipitation", "value": "Precipitation"},
    {"label": "Reflectivity", "value": "Reflectivity"},
    {"label": "Velocity", "value": "Velocity"},
    {"label": "Storm Relative", "value": "Storm Relative"},
  ];

  final List<Map<String, dynamic>> timeRanges = [
    {"label": "Live", "value": "Live"},
    {"label": "Last Hour", "value": "Last Hour"},
    {"label": "Last 3 Hours", "value": "Last 3 Hours"},
    {"label": "Last 6 Hours", "value": "Last 6 Hours"},
  ];

  final List<Map<String, dynamic>> radarStations = [
    {
      "name": "KEWX - Austin/San Antonio",
      "location": "Texas",
      "status": "Active",
      "lastUpdate": "2 minutes ago",
      "signal": 98,
      "color": successColor,
    },
    {
      "name": "KGRK - Central Texas",
      "location": "Killeen, TX", 
      "status": "Active",
      "lastUpdate": "1 minute ago",
      "signal": 95,
      "color": successColor,
    },
    {
      "name": "KDFX - Laughlin AFB",
      "location": "Del Rio, TX",
      "status": "Maintenance",
      "lastUpdate": "15 minutes ago",
      "signal": 0,
      "color": warningColor,
    },
    {
      "name": "KCRP - Corpus Christi",
      "location": "Texas",
      "status": "Active",
      "lastUpdate": "3 minutes ago",
      "signal": 92,
      "color": successColor,
    },
  ];

  final List<Map<String, dynamic>> radarAlerts = [
    {
      "type": "Severe Thunderstorm",
      "intensity": "High",
      "location": "Travis County, TX",
      "time": "14:35",
      "description": "Strong rotation detected with heavy precipitation",
    },
    {
      "type": "Flash Flood",
      "intensity": "Moderate",
      "location": "Williamson County, TX",
      "time": "14:22", 
      "description": "Rainfall rate exceeding 2 inches per hour",
    },
    {
      "type": "Hail Detection",
      "intensity": "Low",
      "location": "Hays County, TX",
      "time": "14:18",
      "description": "Possible hail stones up to 0.75 inches detected",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Radar"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              _showRadarSettings();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildRadarControls(),
            _buildRadarDisplay(),
            _buildRadarStations(),
            _buildRadarAlerts(),
          ],
        ),
      ),
    );
  }

  Widget _buildRadarControls() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
                  label: "Radar Type",
                  items: radarTypes,
                  value: selectedRadarType,
                  onChanged: (value, label) {
                    selectedRadarType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Time Range",
                  items: timeRanges,
                  value: selectedTimeRange,
                  onChanged: (value, label) {
                    selectedTimeRange = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              QButton(
                icon: isPlaying ? Icons.pause : Icons.play_arrow,
                size: bs.sm,
                onPressed: () {
                  isPlaying = !isPlaying;
                  setState(() {});
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.skip_previous,
                size: bs.sm,
                onPressed: () {
                  if (currentFrame > 0) {
                    currentFrame--;
                    setState(() {});
                  }
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.skip_next,
                size: bs.sm,
                onPressed: () {
                  if (currentFrame < 20) {
                    currentFrame++;
                    setState(() {});
                  }
                },
              ),
              Spacer(),
              Text(
                "Frame ${currentFrame + 1}/21",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Container(
            height: 40,
            child: Slider(
              value: currentFrame.toDouble(),
              min: 0,
              max: 20,
              divisions: 20,
              onChanged: (value) {
                currentFrame = value.toInt();
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadarDisplay() {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radiusMd),
        child: Stack(
          children: [
            // Radar Map Background
            Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  colors: [
                    Colors.green.withAlpha(100),
                    Colors.yellow.withAlpha(80),
                    Colors.orange.withAlpha(60),
                    Colors.red.withAlpha(40),
                  ],
                ),
              ),
            ),
            // Radar Sweep Animation
            if (isPlaying)
              Container(
                decoration: BoxDecoration(
                  gradient: SweepGradient(
                    startAngle: (currentFrame * 0.3),
                    endAngle: (currentFrame * 0.3) + 1.0,
                    colors: [
                      Colors.transparent,
                      Colors.green.withAlpha(150),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            // Radar Rings
            Center(
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green.withAlpha(100), width: 1),
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green.withAlpha(80), width: 1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green.withAlpha(80), width: 1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Control Overlay
            Positioned(
              top: spSm,
              right: spSm,
              child: Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(150),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${selectedRadarType} Radar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Range: 125 miles",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      "Updated: ${DateTime.now().toString().substring(11, 16)}",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Zoom Controls
            Positioned(
              bottom: spSm,
              right: spSm,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(150),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.add, color: Colors.white),
                      onPressed: () {
                        if (zoomLevel < 3.0) {
                          zoomLevel += 0.5;
                          setState(() {});
                        }
                      },
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(150),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.remove, color: Colors.white),
                      onPressed: () {
                        if (zoomLevel > 0.5) {
                          zoomLevel -= 0.5;
                          setState(() {});
                        }
                      },
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

  Widget _buildRadarStations() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Radar Stations",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...radarStations.map((station) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                border: Border.all(color: disabledOutlineBorderColor),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: station["color"],
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${station["name"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${station["location"]}",
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
                        "${station["status"]}",
                        style: TextStyle(
                          color: station["color"],
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "${station["lastUpdate"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: spSm),
                  if ((station["signal"] as int) > 0)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: station["color"].withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${station["signal"]}%",
                        style: TextStyle(
                          color: station["color"],
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildRadarAlerts() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
                Icons.warning_amber,
                color: dangerColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Radar Alerts",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...radarAlerts.map((alert) {
            Color alertColor = alert["intensity"] == "High" 
                ? dangerColor 
                : alert["intensity"] == "Moderate" 
                    ? warningColor 
                    : infoColor;

            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: alertColor.withAlpha(10),
                border: Border.all(color: alertColor.withAlpha(50)),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: alertColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${alert["type"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: alertColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${alert["intensity"]}",
                          style: TextStyle(
                            color: alertColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${alert["time"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${alert["location"]}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${alert["description"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  void _showRadarSettings() {
    // Implementation for radar settings dialog
  }
}
