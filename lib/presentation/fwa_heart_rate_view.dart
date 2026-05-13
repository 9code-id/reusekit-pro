import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaHeartRateView extends StatefulWidget {
  const FwaHeartRateView({Key? key}) : super(key: key);

  @override
  State<FwaHeartRateView> createState() => _FwaHeartRateViewState();
}

class _FwaHeartRateViewState extends State<FwaHeartRateView> {
  String selectedPeriod = "Today";
  bool isRecording = false;
  int currentHeartRate = 72;
  
  List<Map<String, dynamic>> periodOptions = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
  ];

  List<Map<String, dynamic>> heartRateZones = [
    {
      "zone": "Resting",
      "range": "50-60 BPM",
      "color": Colors.blue,
      "percentage": 25,
      "description": "Recovery and relaxation"
    },
    {
      "zone": "Fat Burn",
      "range": "60-70 BPM", 
      "color": Colors.green,
      "percentage": 35,
      "description": "Optimal fat burning zone"
    },
    {
      "zone": "Cardio",
      "range": "70-85 BPM",
      "color": Colors.orange,
      "percentage": 30,
      "description": "Cardiovascular fitness"
    },
    {
      "zone": "Peak",
      "range": "85-95 BPM",
      "color": Colors.red,
      "percentage": 10,
      "description": "Maximum performance"
    },
  ];

  List<Map<String, dynamic>> heartRateHistory = [
    {
      "time": "08:00",
      "bpm": 68,
      "type": "Resting",
      "activity": "Morning coffee"
    },
    {
      "time": "09:30",
      "bpm": 85,
      "type": "Exercise",
      "activity": "Morning run"
    },
    {
      "time": "12:00",
      "bpm": 72,
      "type": "Normal",
      "activity": "After lunch"
    },
    {
      "time": "15:30",
      "bpm": 78,
      "type": "Active",
      "activity": "Walking meeting"
    },
    {
      "time": "18:00",
      "bpm": 92,
      "type": "Exercise",
      "activity": "Gym workout"
    },
  ];

  Map<String, dynamic> todayStats = {
    "average": 74,
    "minimum": 58,
    "maximum": 95,
    "restingHR": 62,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Heart Rate Monitor"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // Navigate to history
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings
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
            // Current Heart Rate Display
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(150)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 48,
                  ),
                  Text(
                    "Current Heart Rate",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                  Text(
                    "$currentHeartRate",
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "BPM",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: isRecording ? "Stop Recording" : "Start Recording",
                      size: bs.md,
                      onPressed: () {
                        isRecording = !isRecording;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Period Filter
            QDropdownField(
              label: "Time Period",
              items: periodOptions,
              value: selectedPeriod,
              onChanged: (value, label) {
                selectedPeriod = value;
                setState(() {});
              },
            ),

            // Today's Statistics
            Text(
              "Today's Statistics",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: [
                _buildStatCard("Average", "${todayStats["average"]}", "BPM", Icons.trending_up, Colors.blue),
                _buildStatCard("Resting", "${todayStats["restingHR"]}", "BPM", Icons.bedtime, Colors.green),
                _buildStatCard("Minimum", "${todayStats["minimum"]}", "BPM", Icons.trending_down, Colors.orange),
                _buildStatCard("Maximum", "${todayStats["maximum"]}", "BPM", Icons.trending_up, Colors.red),
              ],
            ),

            // Heart Rate Zones
            Text(
              "Heart Rate Zones",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: heartRateZones.map((zone) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 40,
                        decoration: BoxDecoration(
                          color: zone["color"] as Color,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${zone["zone"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${zone["percentage"]}%",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: zone["color"] as Color,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${zone["range"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${zone["description"]}",
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
              }).toList(),
            ),

            // Heart Rate Chart
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Heart Rate Trend",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    height: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildHeartRatePoint("6AM", 68),
                        _buildHeartRatePoint("9AM", 85),
                        _buildHeartRatePoint("12PM", 72),
                        _buildHeartRatePoint("3PM", 78),
                        _buildHeartRatePoint("6PM", 92),
                        _buildHeartRatePoint("9PM", 65),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Recent Readings
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent Readings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to all readings
                  },
                  child: Text(
                    "View All",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            Column(
              spacing: spSm,
              children: heartRateHistory.map((reading) {
                Color statusColor = _getHeartRateColor((reading["bpm"] as int));
                
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.favorite,
                          color: statusColor,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${reading["activity"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${reading["type"]} • ${reading["time"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${reading["bpm"]} BPM",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String unit, IconData icon, Color color) {
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
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spXs),
              Text(
                unit,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeartRatePoint(String time, int bpm) {
    double normalizedHeight = (bpm / 100.0 * 80).clamp(20, 80);
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: normalizedHeight,
          width: 3,
          decoration: BoxDecoration(
            color: _getHeartRateColor(bpm),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
        ),
        SizedBox(height: spXs),
        Text(
          time,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Color _getHeartRateColor(int bpm) {
    if (bpm < 60) return Colors.blue;
    if (bpm < 70) return Colors.green;
    if (bpm < 85) return Colors.orange;
    return Colors.red;
  }
}
