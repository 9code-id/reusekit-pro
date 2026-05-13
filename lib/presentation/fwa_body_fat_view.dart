import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaBodyFatView extends StatefulWidget {
  const FwaBodyFatView({Key? key}) : super(key: key);

  @override
  State<FwaBodyFatView> createState() => _FwaBodyFatViewState();
}

class _FwaBodyFatViewState extends State<FwaBodyFatView> {
  String currentBodyFat = "18.5";
  String targetBodyFat = "15.0";
  String selectedPeriod = "This Month";
  
  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "3 Months", "value": "3 Months"},
    {"label": "6 Months", "value": "6 Months"},
  ];

  List<Map<String, dynamic>> bodyFatHistory = [
    {
      "date": "2024-12-01",
      "bodyFat": 20.2,
      "change": 0.0,
      "note": "Starting measurement"
    },
    {
      "date": "2024-12-08",
      "bodyFat": 19.8,
      "change": -0.4,
      "note": "First week progress"
    },
    {
      "date": "2024-12-15",
      "bodyFat": 19.4,
      "change": -0.4,
      "note": "Consistent diet"
    },
    {
      "date": "2024-12-22",
      "bodyFat": 19.0,
      "change": -0.4,
      "note": "Holiday maintenance"
    },
    {
      "date": "2024-12-29",
      "bodyFat": 18.5,
      "change": -0.5,
      "note": "End of month"
    },
  ];

  Map<String, dynamic> bodyFatStats = {
    "totalReduction": 1.7,
    "weeklyAverage": 0.4,
    "measurementsTaken": 12,
    "streakDays": 14,
  };

  List<Map<String, dynamic>> bodyFatRanges = [
    {
      "category": "Essential Fat",
      "maleRange": "2-5%",
      "femaleRange": "10-13%",
      "description": "Minimum fat required for basic physical and physiological health",
      "color": Colors.red
    },
    {
      "category": "Athletes",
      "maleRange": "6-13%",
      "femaleRange": "14-20%",
      "description": "Typical range for elite athletes",
      "color": Colors.green
    },
    {
      "category": "Fitness",
      "maleRange": "14-17%",
      "femaleRange": "21-24%",
      "description": "Acceptable range for fitness enthusiasts",
      "color": Colors.blue
    },
    {
      "category": "Average",
      "maleRange": "18-24%",
      "femaleRange": "25-31%",
      "description": "Average body fat percentage",
      "color": Colors.orange
    },
    {
      "category": "Obese",
      "maleRange": "25%+",
      "femaleRange": "32%+",
      "description": "Above healthy range",
      "color": Colors.red
    },
  ];

  @override
  Widget build(BuildContext context) {
    double currentBodyFatValue = double.tryParse(currentBodyFat) ?? 0.0;
    double targetBodyFatValue = double.tryParse(targetBodyFat) ?? 0.0;
    double remainingReduction = currentBodyFatValue - targetBodyFatValue;
    double progressPercentage = ((20.2 - currentBodyFatValue) / (20.2 - targetBodyFatValue) * 100).clamp(0, 100);

    return Scaffold(
      appBar: AppBar(
        title: Text("Body Fat Tracker"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddBodyFatDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              _showBodyFatInfoDialog();
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
            // Current Body Fat Display
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
                    Icons.analytics,
                    color: Colors.white,
                    size: 48,
                  ),
                  Text(
                    "Current Body Fat",
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
                        currentBodyFat,
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "%",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${remainingReduction.toStringAsFixed(1)}% to goal",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                  Text(
                    _getBodyFatCategory(currentBodyFatValue),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(180),
                      fontWeight: FontWeight.w600,
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
                        "Start: 20.2%",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Goal: $targetBodyFat%",
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

            // Body Fat Statistics
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
                _buildStatCard("Total Reduction", "${bodyFatStats["totalReduction"]}", "%", Icons.trending_down, successColor),
                _buildStatCard("Weekly Avg", "${bodyFatStats["weeklyAverage"]}", "%/week", Icons.insights, primaryColor),
                _buildStatCard("Measurements", "${bodyFatStats["measurementsTaken"]}", "taken", Icons.rule, infoColor),
                _buildStatCard("Streak", "${bodyFatStats["streakDays"]}", "days", Icons.local_fire_department, warningColor),
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

            // Body Fat Chart
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
                    "Body Fat Trend",
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
                        _buildBodyFatPoint("W1", 20.2),
                        _buildBodyFatPoint("W2", 19.8),
                        _buildBodyFatPoint("W3", 19.4),
                        _buildBodyFatPoint("W4", 19.0),
                        _buildBodyFatPoint("W5", 18.5),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Body Fat Ranges Information
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
                    "Body Fat Ranges (Male)",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Column(
                    spacing: spXs,
                    children: bodyFatRanges.map((range) {
                      bool isCurrent = _isInRange(currentBodyFatValue, range["maleRange"] as String);
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: isCurrent ? (range["color"] as Color).withAlpha(20) : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: isCurrent ? Border.all(color: range["color"] as Color, width: 1) : null,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: range["color"] as Color,
                                shape: BoxShape.circle,
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
                                        "${range["category"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${range["maleRange"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: range["color"] as Color,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${range["description"]}",
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
                ],
              ),
            ),

            // Body Fat History
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Measurement History",
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
              children: bodyFatHistory.reversed.take(5).map((entry) {
                double bodyFat = (entry["bodyFat"] as num).toDouble();
                double change = (entry["change"] as num).toDouble();
                Color changeColor = change < 0 ? successColor : change > 0 ? dangerColor : disabledBoldColor;
                String changeText = change == 0 ? "No change" : "${change > 0 ? '+' : ''}${change.toStringAsFixed(1)}%";
                
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
                          Icons.analytics,
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
                            "${bodyFat.toStringAsFixed(1)}%",
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

            // Add Measurement Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Log New Measurement",
                size: bs.md,
                onPressed: () {
                  _showAddBodyFatDialog();
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

  Widget _buildBodyFatPoint(String label, double bodyFat) {
    double normalizedHeight = ((25 - bodyFat) / 10 * 120).clamp(20, 120);
    
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

  String _getBodyFatCategory(double bodyFat) {
    if (bodyFat <= 5) return "Essential Fat";
    if (bodyFat <= 13) return "Athletes";
    if (bodyFat <= 17) return "Fitness";
    if (bodyFat <= 24) return "Average";
    return "Above Average";
  }

  bool _isInRange(double value, String range) {
    if (range.contains("+")) {
      double minValue = double.tryParse(range.replaceAll("%+", "")) ?? 0;
      return value >= minValue;
    }
    
    List<String> parts = range.replaceAll("%", "").split("-");
    if (parts.length == 2) {
      double min = double.tryParse(parts[0]) ?? 0;
      double max = double.tryParse(parts[1]) ?? 100;
      return value >= min && value <= max;
    }
    
    return false;
  }

  void _showAddBodyFatDialog() {
    String newBodyFat = currentBodyFat;
    String note = "";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Log Body Fat"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QNumberField(
              label: "Body Fat (%)",
              value: newBodyFat,
              onChanged: (value) {
                newBodyFat = value;
              },
            ),
            QTextField(
              label: "Note (optional)",
              value: note,
              hint: "Add measurement details",
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
              currentBodyFat = newBodyFat;
              setState(() {});
              Navigator.pop(context);
              ss("Body fat measurement logged!");
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  void _showBodyFatInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Body Fat Information"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Body fat percentage is the proportion of fat to total body weight. It's an important indicator of health and fitness.",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: spSm),
              Text(
                "Measurement Methods:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("• DEXA Scan (most accurate)\n• Hydrostatic weighing\n• BodPod\n• Bioelectrical impedance\n• Skinfold calipers"),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
}
