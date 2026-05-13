import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlGraph7View extends StatefulWidget {
  @override
  State<GrlGraph7View> createState() => _GrlGraph7ViewState();
}

class _GrlGraph7ViewState extends State<GrlGraph7View> {
  List<Map<String, dynamic>> healthMetrics = [
    {"metric": "Heart Rate", "current": 72, "normal": [60, 100], "unit": "bpm", "trend": "stable", "color": successColor},
    {"metric": "Blood Pressure", "current": 125, "normal": [90, 140], "unit": "mmHg", "trend": "up", "color": warningColor},
    {"metric": "Blood Sugar", "current": 95, "normal": [70, 110], "unit": "mg/dL", "trend": "down", "color": primaryColor},
    {"metric": "Cholesterol", "current": 180, "normal": [100, 200], "unit": "mg/dL", "trend": "stable", "color": infoColor},
  ];

  List<Map<String, dynamic>> activityData = [
    {"day": "Mon", "steps": 8420, "calories": 245, "active_minutes": 32},
    {"day": "Tue", "steps": 10250, "calories": 298, "active_minutes": 45},
    {"day": "Wed", "steps": 6890, "calories": 201, "active_minutes": 28},
    {"day": "Thu", "steps": 12340, "calories": 356, "active_minutes": 52},
    {"day": "Fri", "steps": 9850, "calories": 287, "active_minutes": 38},
    {"day": "Sat", "steps": 15680, "calories": 445, "active_minutes": 68},
    {"day": "Sun", "steps": 11200, "calories": 324, "active_minutes": 41},
  ];

  List<Map<String, dynamic>> sleepData = [
    {"date": "Jun 15", "hours": 7.5, "deep": 2.1, "rem": 1.8, "light": 3.6, "quality": 85},
    {"date": "Jun 16", "hours": 6.8, "deep": 1.9, "rem": 1.5, "light": 3.4, "quality": 72},
    {"date": "Jun 17", "hours": 8.2, "deep": 2.4, "rem": 2.1, "light": 3.7, "quality": 92},
    {"date": "Jun 18", "hours": 7.1, "deep": 2.0, "rem": 1.7, "light": 3.4, "quality": 78},
    {"date": "Jun 19", "hours": 7.8, "deep": 2.2, "rem": 1.9, "light": 3.7, "quality": 88},
  ];

  List<Map<String, dynamic>> nutritionGoals = [
    {"nutrient": "Calories", "consumed": 1850, "target": 2200, "unit": "kcal", "color": primaryColor},
    {"nutrient": "Protein", "consumed": 95, "target": 120, "unit": "g", "color": successColor},
    {"nutrient": "Carbs", "consumed": 220, "target": 275, "unit": "g", "color": warningColor},
    {"nutrient": "Fat", "consumed": 65, "target": 75, "unit": "g", "color": infoColor},
  ];

  int selectedTab = 0;
  String selectedPeriod = "Week";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Health Analytics Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.health_and_safety),
            onPressed: () {
              // Show health tips
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Open settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildTimeSelector(),
            _buildHealthOverview(),
            _buildVitalSigns(),
            _buildActivityChart(),
            _buildSleepAnalysis(),
            _buildNutritionProgress(),
            _buildHealthInsights(),
            _buildQuickActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSelector() {
    List<String> periods = ["Day", "Week", "Month", "Year"];
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Icon(
            Icons.schedule,
            color: primaryColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Text(
            "View Period:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
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
                      margin: EdgeInsets.only(right: spXs),
                      padding: EdgeInsets.symmetric(vertical: spXs, horizontal: spSm),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        period,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthOverview() {
    return Row(
      children: [
        Expanded(
          child: _buildOverviewCard(
            "Health Score",
            "87/100",
            Icons.favorite,
            primaryColor,
            "Good",
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildOverviewCard(
            "Daily Goals",
            "6/8",
            Icons.flag,
            successColor,
            "75%",
          ),
        ),
      ],
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color, String subtitle) {
    return Container(
      padding: EdgeInsets.all(spSm),
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
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: successColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVitalSigns() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
                Icons.monitor_heart,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Vital Signs",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 160,
            children: healthMetrics.map((metric) {
              bool isNormal = (metric["current"] as int) >= (metric["normal"] as List)[0] && 
                             (metric["current"] as int) <= (metric["normal"] as List)[1];
              IconData trendIcon = metric["trend"] == "up" 
                  ? Icons.trending_up 
                  : metric["trend"] == "down" 
                      ? Icons.trending_down 
                      : Icons.trending_flat;
              
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: isNormal ? successColor.withAlpha(100) : warningColor.withAlpha(100),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: (metric["color"] as Color).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            trendIcon,
                            color: metric["color"] as Color,
                            size: 16,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          isNormal ? Icons.check_circle : Icons.warning,
                          color: isNormal ? successColor : warningColor,
                          size: 16,
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${metric["current"]} ${metric["unit"]}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${metric["metric"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Normal: ${(metric["normal"] as List)[0]}-${(metric["normal"] as List)[1]} ${metric["unit"]}",
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
        ],
      ),
    );
  }

  Widget _buildActivityChart() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
                Icons.directions_walk,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Weekly Activity",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  _buildLegendItem("Steps", primaryColor),
                  SizedBox(width: spSm),
                  _buildLegendItem("Calories", successColor),
                ],
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: activityData.map((day) {
                double stepsHeight = ((day["steps"] as int) / 16000) * 160;
                double caloriesHeight = ((day["calories"] as int) / 500) * 160;
                
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: stepsHeight,
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(200),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ),
                            SizedBox(width: 2),
                            Expanded(
                              child: Container(
                                height: caloriesHeight,
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(200),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${day["day"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: _buildActivitySummary(
                  "Total Steps",
                  "${activityData.map((d) => d["steps"] as int).reduce((a, b) => a + b)}",
                  Icons.directions_walk,
                  primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildActivitySummary(
                  "Calories Burned",
                  "${activityData.map((d) => d["calories"] as int).reduce((a, b) => a + b)}",
                  Icons.local_fire_department,
                  successColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildActivitySummary(
                  "Active Minutes",
                  "${activityData.map((d) => d["active_minutes"] as int).reduce((a, b) => a + b)}",
                  Icons.timer,
                  warningColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivitySummary(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
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
        SizedBox(width: 4),
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

  Widget _buildSleepAnalysis() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
                Icons.bedtime,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Sleep Analysis",
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
                child: Column(
                  children: [
                    Text(
                      "Average Sleep",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(sleepData.map((s) => s["hours"] as double).reduce((a, b) => a + b) / sleepData.length).toStringAsFixed(1)}h",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Sleep Quality",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(sleepData.map((s) => s["quality"] as int).reduce((a, b) => a + b) / sleepData.length).toStringAsFixed(0)}%",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            height: 120,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: sleepData.map((sleep) {
                double totalHeight = ((sleep["hours"] as double) / 10) * 100;
                double deepPercent = (sleep["deep"] as double) / (sleep["hours"] as double);
                double remPercent = (sleep["rem"] as double) / (sleep["hours"] as double);
                double lightPercent = (sleep["light"] as double) / (sleep["hours"] as double);
                
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              width: double.infinity,
                              height: totalHeight,
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(100),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: totalHeight * (deepPercent + remPercent),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(200),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: totalHeight * deepPercent,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${sleep["date"]}".split(' ')[1],
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              _buildLegendItem("Deep", primaryColor),
              SizedBox(width: spSm),
              _buildLegendItem("REM", primaryColor.withAlpha(150)),
              SizedBox(width: spSm),
              _buildLegendItem("Light", infoColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionProgress() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
                Icons.restaurant,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Nutrition Progress",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            children: nutritionGoals.map((goal) {
              double progress = (goal["consumed"] as int) / (goal["target"] as int);
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: goal["color"] as Color,
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
                                "${goal["nutrient"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${goal["consumed"]}/${goal["target"]} ${goal["unit"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Container(
                            height: 6,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: progress > 1 ? 1 : progress,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: goal["color"] as Color,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${(progress * 100).toStringAsFixed(0)}%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: goal["color"] as Color,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthInsights() {
    List<Map<String, dynamic>> insights = [
      {"title": "Great Progress!", "message": "You've hit your step goal 5 days this week", "icon": Icons.celebration, "color": successColor},
      {"title": "Sleep Recommendation", "message": "Try to maintain consistent sleep schedule", "icon": Icons.bedtime, "color": infoColor},
      {"title": "Hydration Alert", "message": "Don't forget to drink more water today", "icon": Icons.water_drop, "color": warningColor},
    ];

    return Container(
      padding: EdgeInsets.all(spSm),
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
                Icons.psychology,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Health Insights",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            children: insights.map((insight) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (insight["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: (insight["color"] as Color).withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        insight["icon"] as IconData,
                        color: insight["color"] as Color,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${insight["title"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${insight["message"]}",
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
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
                color: primaryColor,
                size: 20,
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
                  label: "Log Meal",
                  icon: Icons.restaurant,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Start Workout",
                  icon: Icons.fitness_center,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Add Vital Signs",
                  icon: Icons.monitor_heart,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Generate Report",
                  icon: Icons.description,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
