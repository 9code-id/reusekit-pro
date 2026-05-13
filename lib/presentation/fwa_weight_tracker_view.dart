import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaWeightTrackerView extends StatefulWidget {
  const FwaWeightTrackerView({Key? key}) : super(key: key);

  @override
  State<FwaWeightTrackerView> createState() => _FwaWeightTrackerViewState();
}

class _FwaWeightTrackerViewState extends State<FwaWeightTrackerView> {
  String currentWeight = "70.5";
  String targetWeight = "65.0";
  String selectedPeriod = "This Month";
  
  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "3 Months", "value": "3 Months"},
    {"label": "6 Months", "value": "6 Months"},
    {"label": "1 Year", "value": "1 Year"},
  ];

  List<Map<String, dynamic>> weightHistory = [
    {
      "date": "2024-12-01",
      "weight": 72.0,
      "change": 0.0,
      "note": "Starting weight"
    },
    {
      "date": "2024-12-08",
      "weight": 71.5,
      "change": -0.5,
      "note": "First week progress"
    },
    {
      "date": "2024-12-15",
      "weight": 71.2,
      "change": -0.3,
      "note": "Steady progress"
    },
    {
      "date": "2024-12-22",
      "weight": 70.8,
      "change": -0.4,
      "note": "Holiday season"
    },
    {
      "date": "2024-12-29",
      "weight": 70.5,
      "change": -0.3,
      "note": "End of year"
    },
  ];

  Map<String, dynamic> weightStats = {
    "totalLoss": 1.5,
    "weeklyAverage": 0.3,
    "daysTracked": 28,
    "streakDays": 7,
  };

  @override
  Widget build(BuildContext context) {
    double currentWeightValue = double.tryParse(currentWeight) ?? 0.0;
    double targetWeightValue = double.tryParse(targetWeight) ?? 0.0;
    double remainingWeight = currentWeightValue - targetWeightValue;
    double progressPercentage = ((72.0 - currentWeightValue) / (72.0 - targetWeightValue) * 100).clamp(0, 100);

    return Scaffold(
      appBar: AppBar(
        title: Text("Weight Tracker"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddWeightDialog();
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
            // Current Weight Display
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
                    Icons.monitor_weight,
                    color: Colors.white,
                    size: 48,
                  ),
                  Text(
                    "Current Weight",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        currentWeight,
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "kg",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${remainingWeight.toStringAsFixed(1)} kg to goal",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                ],
              ),
            ),

            // Progress to Goal
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Progress to Goal",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${progressPercentage.toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 12,
                        decoration: BoxDecoration(
                          color: disabledColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                      ),
                      Container(
                        height: 12,
                        width: MediaQuery.of(context).size.width * (progressPercentage / 100) * 0.8,
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Start: 72.0 kg",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Goal: $targetWeight kg",
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

            // Weight Statistics
            Text(
              "Statistics",
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
                _buildStatCard("Total Loss", "${weightStats["totalLoss"]}", "kg", Icons.trending_down, successColor),
                _buildStatCard("Weekly Avg", "${weightStats["weeklyAverage"]}", "kg/week", Icons.insights, primaryColor),
                _buildStatCard("Days Tracked", "${weightStats["daysTracked"]}", "days", Icons.calendar_today, infoColor),
                _buildStatCard("Current Streak", "${weightStats["streakDays"]}", "days", Icons.local_fire_department, warningColor),
              ],
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

            // Weight Chart
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
                    "Weight Trend",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    height: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildWeightPoint("W1", 72.0),
                        _buildWeightPoint("W2", 71.5),
                        _buildWeightPoint("W3", 71.2),
                        _buildWeightPoint("W4", 70.8),
                        _buildWeightPoint("W5", 70.5),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Weight History
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Weight History",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to all history
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
              children: weightHistory.reversed.take(5).map((entry) {
                double weight = (entry["weight"] as num).toDouble();
                double change = (entry["change"] as num).toDouble();
                Color changeColor = change < 0 ? successColor : change > 0 ? dangerColor : disabledBoldColor;
                String changeText = change == 0 ? "No change" : "${change > 0 ? '+' : ''}${change.toStringAsFixed(1)} kg";
                
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
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.monitor_weight,
                          color: primaryColor,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${DateTime.parse(entry["date"] as String).dMMMy}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${entry["note"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${weight.toStringAsFixed(1)} kg",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            changeText,
                            style: TextStyle(
                              fontSize: 12,
                              color: changeColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Add Weight Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Log Today's Weight",
                size: bs.md,
                onPressed: () {
                  _showAddWeightDialog();
                },
              ),
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
            textAlign: TextAlign.center,
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
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spXs),
              Text(
                unit,
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeightPoint(String label, double weight) {
    double normalizedHeight = ((weight - 68) / 6 * 120).clamp(20, 120);
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: normalizedHeight,
          width: 3,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(radiusLg),
          ),
        ),
        SizedBox(height: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  void _showAddWeightDialog() {
    String newWeight = currentWeight;
    String note = "";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Log Weight"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QNumberField(
              label: "Weight (kg)",
              value: newWeight,
              onChanged: (value) {
                newWeight = value;
              },
            ),
            QTextField(
              label: "Note (optional)",
              value: note,
              hint: "Add a note about today",
              onChanged: (value) {
                note = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              currentWeight = newWeight;
              setState(() {});
              Navigator.pop(context);
              ss("Weight logged successfully!");
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }
}
