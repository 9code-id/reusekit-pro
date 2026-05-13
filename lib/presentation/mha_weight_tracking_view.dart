import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaWeightTrackingView extends StatefulWidget {
  const MhaWeightTrackingView({super.key});

  @override
  State<MhaWeightTrackingView> createState() => _MhaWeightTrackingViewState();
}

class _MhaWeightTrackingViewState extends State<MhaWeightTrackingView> {
  String selectedPeriod = "30 Days";
  String weight = "";
  String bodyFat = "";
  String muscleMass = "";
  String notes = "";
  
  final periods = [
    {"label": "7 Days", "value": "7 Days"},
    {"label": "30 Days", "value": "30 Days"},
    {"label": "3 Months", "value": "3 Months"},
    {"label": "6 Months", "value": "6 Months"},
    {"label": "1 Year", "value": "1 Year"},
  ];

  final weightReadings = [
    {
      "id": "wt001",
      "weight": 70.5,
      "bodyFat": 15.2,
      "muscleMass": 58.4,
      "bmi": 22.1,
      "timestamp": "2024-01-15",
      "notes": "Morning weight after workout",
      "category": "Healthy"
    },
    {
      "id": "wt002",
      "weight": 70.8,
      "bodyFat": 15.5,
      "muscleMass": 58.2,
      "bmi": 22.2,
      "timestamp": "2024-01-14",
      "notes": "Regular morning weigh-in",
      "category": "Healthy"
    },
    {
      "id": "wt003",
      "weight": 71.2,
      "bodyFat": 15.8,
      "muscleMass": 58.0,
      "bmi": 22.4,
      "timestamp": "2024-01-13",
      "notes": "After weekend",
      "category": "Healthy"
    },
    {
      "id": "wt004",
      "weight": 70.9,
      "bodyFat": 15.6,
      "muscleMass": 58.1,
      "bmi": 22.3,
      "timestamp": "2024-01-12",
      "notes": "Mid-week check",
      "category": "Healthy"
    },
    {
      "id": "wt005",
      "weight": 71.0,
      "bodyFat": 15.7,
      "muscleMass": 58.0,
      "bmi": 22.3,
      "timestamp": "2024-01-11",
      "notes": "Weekly weigh-in",
      "category": "Healthy"
    },
    {
      "id": "wt006",
      "weight": 71.5,
      "bodyFat": 16.1,
      "muscleMass": 57.8,
      "bmi": 22.5,
      "timestamp": "2024-01-10",
      "notes": "Start of week",
      "category": "Healthy"
    },
  ];

  final weightGoal = {
    "target": 68.0,
    "current": 70.5,
    "remaining": 2.5,
    "deadline": "2024-06-15",
    "progress": 15.0, // percentage
  };

  final bmiCategories = [
    {
      "name": "Underweight",
      "range": "< 18.5",
      "color": 0xFF2196F3,
      "description": "Below normal weight"
    },
    {
      "name": "Normal",
      "range": "18.5-24.9",
      "color": 0xFF4CAF50,
      "description": "Healthy weight range"
    },
    {
      "name": "Overweight",
      "range": "25.0-29.9",
      "color": 0xFFFF9800,
      "description": "Above normal weight"
    },
    {
      "name": "Obese",
      "range": "≥ 30.0",
      "color": 0xFFF44336,
      "description": "Significantly above normal"
    },
  ];

  Color _getBMIColor(double bmi) {
    if (bmi < 18.5) return Color(0xFF2196F3);
    if (bmi < 25.0) return Color(0xFF4CAF50);
    if (bmi < 30.0) return Color(0xFFFF9800);
    return Color(0xFFF44336);
  }

  String _getBMICategory(double bmi) {
    if (bmi < 18.5) return "Underweight";
    if (bmi < 25.0) return "Normal";
    if (bmi < 30.0) return "Overweight";
    return "Obese";
  }

  double _getAverageWeight() {
    if (weightReadings.isEmpty) return 0;
    return weightReadings
        .map((reading) => reading["weight"] as double)
        .reduce((a, b) => a + b) / weightReadings.length;
  }

  double _getWeightChange() {
    if (weightReadings.length < 2) return 0;
    return (weightReadings.first["weight"] as double) - 
           (weightReadings.last["weight"] as double);
  }

  @override
  Widget build(BuildContext context) {
    final currentReading = weightReadings.first;
    final currentBMI = currentReading["bmi"] as double;
    final weightChange = _getWeightChange();

    return Scaffold(
      appBar: AppBar(
        title: Text("Weight Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddReadingDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.flag),
            onPressed: () {
              _showGoalDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Weight Card
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
                          Icons.monitor_weight,
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
                              "Current Weight",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${currentReading["timestamp"]}",
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
                          color: weightChange < 0 
                              ? successColor.withAlpha(20)
                              : weightChange > 0
                                  ? warningColor.withAlpha(20)
                                  : disabledColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              weightChange < 0 
                                  ? Icons.trending_down
                                  : weightChange > 0
                                      ? Icons.trending_up
                                      : Icons.trending_flat,
                              size: 12,
                              color: weightChange < 0 
                                  ? successColor
                                  : weightChange > 0
                                      ? warningColor
                                      : disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${weightChange.abs().toStringAsFixed(1)} kg",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: weightChange < 0 
                                    ? successColor
                                    : weightChange > 0
                                        ? warningColor
                                        : disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "${currentReading["weight"]}",
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "kg",
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
                            color: _getBMIColor(currentBMI).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "BMI: ${currentBMI} (${_getBMICategory(currentBMI)})",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: _getBMIColor(currentBMI),
                            ),
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
                      _buildStatItem("Body Fat", "${currentReading["bodyFat"]}%", successColor),
                      _buildStatItem("Muscle", "${currentReading["muscleMass"]} kg", primaryColor),
                      _buildStatItem("Average", "${_getAverageWeight().toStringAsFixed(1)} kg", infoColor),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Weight Goal Progress
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
                      Icon(Icons.flag, color: warningColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Weight Goal",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${(weightGoal["progress"] as double).toInt()}%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  LinearProgressIndicator(
                    value: (weightGoal["progress"] as double) / 100,
                    backgroundColor: disabledColor.withAlpha(30),
                    valueColor: AlwaysStoppedAnimation<Color>(warningColor),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Text(
                        "Target: ${weightGoal["target"]} kg",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Remaining: ${weightGoal["remaining"]} kg",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Deadline: ${weightGoal["deadline"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Weight Chart
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
                        "Weight Trend",
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
                      children: weightReadings.reversed.take(6).map((reading) {
                        double weight = reading["weight"] as double;
                        
                        return Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: ((weight - 65) / 10) * 80, // Normalized height
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(radiusXs),
                                    ),
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${reading["timestamp"]}".split('-')[2],
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${weight.toStringAsFixed(1)}",
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

            // BMI Categories
            Text(
              "BMI Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 160,
              children: bmiCategories.map((category) {
                bool isCurrent = _getBMICategory(currentBMI) == category["name"];
                
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isCurrent 
                        ? Color(category["color"] as int).withAlpha(20)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                    border: isCurrent 
                        ? Border.all(color: Color(category["color"] as int), width: 2)
                        : Border.all(color: Color(category["color"] as int).withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Color(category["color"] as int),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${category["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isCurrent ? Color(category["color"] as int) : null,
                              ),
                            ),
                          ),
                          if (isCurrent)
                            Icon(
                              Icons.check_circle,
                              size: 16,
                              color: Color(category["color"] as int),
                            ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${category["range"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(category["color"] as int),
                        ),
                      ),
                      Text(
                        "${category["description"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

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
            ...weightReadings.map((reading) {
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
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            Icons.monitor_weight,
                            size: 16,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${reading["weight"]} kg",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${reading["timestamp"]}",
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
                            color: _getBMIColor(reading["bmi"] as double).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "BMI ${reading["bmi"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: _getBMIColor(reading["bmi"] as double),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 100,
                      children: [
                        _buildMiniStat("Body Fat", "${reading["bodyFat"]}%"),
                        _buildMiniStat("Muscle", "${reading["muscleMass"]} kg"),
                        _buildMiniStat("BMI", "${reading["bmi"]}"),
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
          _showAddReadingDialog();
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
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

  Widget _buildMiniStat(String label, String value) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: disabledColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
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
        title: Text("Add Weight Reading"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QNumberField(
              label: "Weight (kg)",
              value: weight,
              onChanged: (value) {
                weight = value;
              },
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: QNumberField(
                    label: "Body Fat (%)",
                    value: bodyFat,
                    onChanged: (value) {
                      bodyFat = value;
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QNumberField(
                    label: "Muscle (kg)",
                    value: muscleMass,
                    onChanged: (value) {
                      muscleMass = value;
                    },
                  ),
                ),
              ],
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

  void _showGoalDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Set Weight Goal"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QNumberField(
              label: "Target Weight (kg)",
              value: "${weightGoal["target"]}",
              onChanged: (value) {},
            ),
            SizedBox(height: spSm),
            QDatePicker(
              label: "Target Date",
              value: DateTime.parse("${weightGoal["deadline"]}"),
              onChanged: (value) {},
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
              Navigator.pop(context);
            },
            child: Text("Save Goal"),
          ),
        ],
      ),
    );
  }
}
