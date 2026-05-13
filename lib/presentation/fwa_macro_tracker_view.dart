import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaMacroTrackerView extends StatefulWidget {
  const FwaMacroTrackerView({super.key});

  @override
  State<FwaMacroTrackerView> createState() => _FwaMacroTrackerViewState();
}

class _FwaMacroTrackerViewState extends State<FwaMacroTrackerView> {
  DateTime selectedDate = DateTime.now();
  String selectedPeriod = "Today";
  
  final List<String> periods = ["Today", "Week", "Month"];
  
  // Daily macro targets
  final Map<String, dynamic> macroTargets = {
    "calories": 2000,
    "protein": 150.0,
    "carbs": 250.0,
    "fat": 67.0,
    "fiber": 25.0,
    "sugar": 50.0,
  };
  
  // Current intake
  final Map<String, dynamic> currentIntake = {
    "calories": 1650,
    "protein": 120.5,
    "carbs": 180.0,
    "fat": 55.2,
    "fiber": 18.5,
    "sugar": 35.8,
  };
  
  // Weekly macro data for chart
  final List<Map<String, dynamic>> weeklyData = [
    {"day": "Mon", "protein": 125, "carbs": 190, "fat": 58},
    {"day": "Tue", "protein": 135, "carbs": 165, "fat": 62},
    {"day": "Wed", "protein": 118, "carbs": 205, "fat": 48},
    {"day": "Thu", "protein": 142, "carbs": 178, "fat": 65},
    {"day": "Fri", "protein": 128, "carbs": 195, "fat": 52},
    {"day": "Sat", "protein": 155, "carbs": 185, "fat": 68},
    {"day": "Sun", "protein": 121, "carbs": 180, "fat": 55},
  ];

  Widget _buildPeriodSelector() {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Row(
        children: periods.map((period) {
          bool isSelected = selectedPeriod == period;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                selectedPeriod = period;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: spSm),
                margin: EdgeInsets.only(right: period != periods.last ? spXs : 0),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: isSelected ? [shadowSm] : [],
                  border: !isSelected
                      ? Border.all(color: disabledColor.withAlpha(30))
                      : null,
                ),
                child: Text(
                  period,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : primaryColor,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMacroCard(String name, String unit, dynamic current, dynamic target, Color color) {
    double percentage = (current / target).clamp(0.0, 1.0);
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
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
                  color: color,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
              SizedBox(width: spSm),
              Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          
          // Progress Indicator
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${current is double ? current.toStringAsFixed(1) : current}$unit",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(
                    "/ ${target is double ? target.toStringAsFixed(0) : target}$unit",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              LinearProgressIndicator(
                value: percentage,
                backgroundColor: color.withAlpha(20),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
              SizedBox(height: spSm),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${(percentage * 100).toStringAsFixed(0)}% Complete",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${target - current < 0 ? 0 : (target is double ? (target - current).toStringAsFixed(1) : (target - current))}$unit left",
                    style: TextStyle(
                      fontSize: 12,
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCaloriesSummary() {
    int calories = currentIntake["calories"];
    int target = macroTargets["calories"];
    double percentage = (calories / target).clamp(0.0, 1.0);
    
    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.local_fire_department,
                color: dangerColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Daily Calories",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          
          // Calories Circle Progress
          Center(
            child: Container(
              width: 150,
              height: 150,
              child: Stack(
                children: [
                  // Background Circle
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: dangerColor.withAlpha(10),
                    ),
                  ),
                  // Progress Circle
                  Container(
                    width: 150,
                    height: 150,
                    child: CircularProgressIndicator(
                      value: percentage,
                      strokeWidth: 8,
                      backgroundColor: dangerColor.withAlpha(20),
                      valueColor: AlwaysStoppedAnimation<Color>(dangerColor),
                    ),
                  ),
                  // Center Text
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$calories",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "calories",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "of $target",
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
          ),
          SizedBox(height: spMd),
          
          // Remaining calories
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Remaining",
                  style: TextStyle(
                    fontSize: 14,
                    color: dangerColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "${target - calories} calories",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMacroBreakdown() {
    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.pie_chart,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Macro Breakdown",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          
          // Macros Grid
          Column(
            children: [
              Row(
                children: [
                  Expanded(child: _buildMacroCard("Protein", "g", currentIntake["protein"], macroTargets["protein"], successColor)),
                  SizedBox(width: spSm),
                  Expanded(child: _buildMacroCard("Carbs", "g", currentIntake["carbs"], macroTargets["carbs"], warningColor)),
                ],
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(child: _buildMacroCard("Fat", "g", currentIntake["fat"], macroTargets["fat"], infoColor)),
                  SizedBox(width: spSm),
                  Expanded(child: _buildMacroCard("Fiber", "g", currentIntake["fiber"], macroTargets["fiber"], primaryColor)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyChart() {
    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.trending_up,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Weekly Progress",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          
          // Chart Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildLegendItem("Protein", successColor),
              _buildLegendItem("Carbs", warningColor),
              _buildLegendItem("Fat", infoColor),
            ],
          ),
          SizedBox(height: spMd),
          
          // Simple Bar Chart
          Container(
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: weeklyData.map((data) => _buildChartBar(data)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(width: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildChartBar(Map<String, dynamic> data) {
    double maxValue = 250; // Maximum value for scaling
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Protein Bar
        Container(
          width: 20,
          height: (data["protein"] / maxValue * 60).toDouble(),
          decoration: BoxDecoration(
            color: successColor,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(height: 2),
        // Carbs Bar
        Container(
          width: 20,
          height: (data["carbs"] / maxValue * 60).toDouble(),
          decoration: BoxDecoration(
            color: warningColor,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(height: 2),
        // Fat Bar
        Container(
          width: 20,
          height: (data["fat"] / maxValue * 60).toDouble(),
          decoration: BoxDecoration(
            color: infoColor,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(height: spSm),
        // Day Label
        Text(
          "${data["day"]}",
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.flash_on,
                color: warningColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Quick Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Add Food",
                  icon: Icons.add,
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to add food
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Set Goals",
                  icon: Icons.flag,
                  color: successColor,
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to goal setting
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Reports",
                  icon: Icons.analytics,
                  color: infoColor,
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to reports
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Share Progress",
                  icon: Icons.share,
                  color: warningColor,
                  size: bs.sm,
                  onPressed: () {
                    ss("Progress shared successfully!");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Macro Tracker"),
        actions: [
          GestureDetector(
            onTap: () {
              // Open settings
            },
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              child: Icon(
                Icons.settings,
                size: 24,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            _buildPeriodSelector(),
            _buildCaloriesSummary(),
            _buildMacroBreakdown(),
            if (selectedPeriod == "Week") _buildWeeklyChart(),
            _buildQuickActions(),
          ],
        ),
      ),
    );
  }
}
