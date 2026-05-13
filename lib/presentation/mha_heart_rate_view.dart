import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaHeartRateView extends StatefulWidget {
  const MhaHeartRateView({super.key});

  @override
  State<MhaHeartRateView> createState() => _MhaHeartRateViewState();
}

class _MhaHeartRateViewState extends State<MhaHeartRateView> {
  String selectedPeriod = "7 Days";
  String heartRate = "";
  String notes = "";
  bool isRecording = false;
  
  final periods = [
    {"label": "24 Hours", "value": "24 Hours"},
    {"label": "7 Days", "value": "7 Days"},
    {"label": "30 Days", "value": "30 Days"},
    {"label": "3 Months", "value": "3 Months"},
  ];

  final heartRateReadings = [
    {
      "id": "hr001",
      "bpm": 72,
      "timestamp": "2024-01-15 08:00",
      "category": "Normal",
      "activity": "Resting",
      "notes": "Morning reading after waking up",
      "duration": 60
    },
    {
      "id": "hr002",
      "bpm": 85,
      "timestamp": "2024-01-15 14:30",
      "category": "Normal",
      "activity": "Walking",
      "notes": "After 10 minutes of walking",
      "duration": 60
    },
    {
      "id": "hr003",
      "bpm": 145,
      "timestamp": "2024-01-15 17:00",
      "category": "Exercise",
      "activity": "Running",
      "notes": "During cardio workout",
      "duration": 60
    },
    {
      "id": "hr004",
      "bpm": 68,
      "timestamp": "2024-01-14 22:00",
      "category": "Normal",
      "activity": "Resting",
      "notes": "Before sleep",
      "duration": 60
    },
    {
      "id": "hr005",
      "bpm": 78,
      "timestamp": "2024-01-14 12:00",
      "category": "Normal",
      "activity": "Light Activity",
      "notes": "During lunch break",
      "duration": 60
    },
    {
      "id": "hr006",
      "bpm": 95,
      "timestamp": "2024-01-14 09:30",
      "category": "Elevated",
      "activity": "Stressed",
      "notes": "During important meeting",
      "duration": 60
    },
  ];

  final heartRateZones = [
    {
      "name": "Resting",
      "range": "60-100",
      "color": 0xFF4CAF50,
      "description": "Normal resting heart rate"
    },
    {
      "name": "Fat Burn",
      "range": "101-143",
      "color": 0xFF2196F3,
      "description": "Light activity, fat burning zone"
    },
    {
      "name": "Aerobic",
      "range": "144-169",
      "color": 0xFFFF9800,
      "description": "Moderate to vigorous activity"
    },
    {
      "name": "Anaerobic",
      "range": "170-185",
      "color": 0xFFF44336,
      "description": "High intensity exercise"
    },
    {
      "name": "Maximal",
      "range": "186+",
      "color": 0xFF9C27B0,
      "description": "Maximum effort, short duration"
    },
  ];

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Normal":
        return Color(0xFF4CAF50);
      case "Elevated":
        return Color(0xFFFF9800);
      case "Exercise":
        return Color(0xFF2196F3);
      case "High":
        return Color(0xFFF44336);
      default:
        return disabledBoldColor;
    }
  }

  String _getHeartRateCategory(int bpm) {
    if (bpm >= 60 && bpm <= 100) return "Normal";
    if (bpm > 100 && bpm <= 150) return "Elevated";
    if (bpm > 150) return "Exercise";
    return "Low";
  }

  double _getAverageHeartRate() {
    if (heartRateReadings.isEmpty) return 0;
    return heartRateReadings
        .map((reading) => reading["bpm"] as int)
        .reduce((a, b) => a + b) / heartRateReadings.length;
  }

  int _getMaxHeartRate() {
    if (heartRateReadings.isEmpty) return 0;
    return heartRateReadings
        .map((reading) => reading["bpm"] as int)
        .reduce((a, b) => a > b ? a : b);
  }

  int _getMinHeartRate() {
    if (heartRateReadings.isEmpty) return 0;
    return heartRateReadings
        .map((reading) => reading["bpm"] as int)
        .reduce((a, b) => a < b ? a : b);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Heart Rate"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddReadingDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Status Card
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Icon(
                          Icons.monitor_heart,
                          size: 24,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Latest Reading",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${heartRateReadings.first["timestamp"]}".split(' ')[0],
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        label: isRecording ? "Recording..." : "Measure Now",
                        size: bs.sm,
                        onPressed: () {
                          setState(() {
                            isRecording = !isRecording;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "${heartRateReadings.first["bpm"]}",
                          style: TextStyle(
                            fontSize: 56,
                            fontWeight: FontWeight.bold,
                            color: _getCategoryColor(heartRateReadings.first["category"] as String),
                          ),
                        ),
                        Text(
                          "BPM",
                          style: TextStyle(
                            fontSize: 16,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spMd,
                            vertical: spSm,
                          ),
                          decoration: BoxDecoration(
                            color: _getCategoryColor(heartRateReadings.first["category"] as String).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${heartRateReadings.first["category"]} • ${heartRateReadings.first["activity"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: _getCategoryColor(heartRateReadings.first["category"] as String),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spMd),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 100,
                    children: [
                      _buildStatItem("Average", "${_getAverageHeartRate().toInt()}", "BPM"),
                      _buildStatItem("Max", "${_getMaxHeartRate()}", "BPM"),
                      _buildStatItem("Min", "${_getMinHeartRate()}", "BPM"),
                      _buildStatItem("Resting", "72", "BPM"),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Heart Rate Monitor (Visual Effect)
            if (isRecording)
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.monitor_heart,
                              color: dangerColor,
                              size: 32,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Place finger on camera",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: spSm),
                    LinearProgressIndicator(
                      value: 0.7,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(dangerColor),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Measuring... Keep your finger steady",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),

            if (isRecording) SizedBox(height: spMd),

            // Period Selector & Chart
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Heart Rate Trend",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: 120,
                        child: QDropdownField(
                          label: "",
                          items: periods,
                          value: selectedPeriod,
                          onChanged: (value, label) {
                            selectedPeriod = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  // Simple Chart Representation
                  Container(
                    height: 120,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: heartRateReadings.take(6).map((reading) {
                        int bpm = reading["bpm"] as int;
                        
                        return Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: (bpm / 200) * 80,
                                  decoration: BoxDecoration(
                                    color: _getCategoryColor(reading["category"] as String),
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(radiusXs),
                                    ),
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${reading["timestamp"]}".split(' ')[1].split(':')[0],
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "$bpm",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Heart Rate Zones
            Text(
              "Heart Rate Zones",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            ...heartRateZones.map((zone) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: Border.all(
                    color: Color(zone["color"] as int).withAlpha(30),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Color(zone["color"] as int),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${zone["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${zone["range"]} BPM",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(zone["color"] as int),
                                ),
                              ),
                            ],
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

            SizedBox(height: spMd),

            // Recent Readings
            Text(
              "Recent Readings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            ...heartRateReadings.map((reading) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: _getCategoryColor(reading["category"] as String).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            Icons.monitor_heart,
                            size: 16,
                            color: _getCategoryColor(reading["category"] as String),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${reading["bpm"]} BPM",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${reading["timestamp"]} • ${reading["activity"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: _getCategoryColor(reading["category"] as String).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${reading["category"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: _getCategoryColor(reading["category"] as String),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (reading["notes"] != null && (reading["notes"] as String).isNotEmpty) ...[
                      SizedBox(height: spSm),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.note, size: 14, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${reading["notes"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Text(
                          "Duration: ${reading["duration"]}s",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.edit,
                            size: 16,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.delete,
                            size: 16,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            SizedBox(height: spLg),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isRecording = !isRecording;
          });
        },
        backgroundColor: isRecording ? dangerColor : primaryColor,
        child: Icon(
          isRecording ? Icons.stop : Icons.monitor_heart,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, String unit) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: disabledColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            unit,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddReadingDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Heart Rate Reading"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QNumberField(
              label: "Heart Rate (BPM)",
              value: heartRate,
              onChanged: (value) {
                heartRate = value;
              },
            ),
            SizedBox(height: spSm),
            QMemoField(
              label: "Notes (Optional)",
              value: notes,
              onChanged: (value) {
                notes = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              // Add reading logic here
              Navigator.pop(context);
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }
}
