import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaSleepTrackerView extends StatefulWidget {
  const MhaSleepTrackerView({super.key});

  @override
  State<MhaSleepTrackerView> createState() => _MhaSleepTrackerViewState();
}

class _MhaSleepTrackerViewState extends State<MhaSleepTrackerView> {
  int currentTab = 0;
  Map<String, dynamic> lastNightSleep = {
    "bedtime": "22:30",
    "wakeTime": "06:30",
    "totalSleep": 8.0,
    "deepSleep": 2.5,
    "lightSleep": 4.5,
    "remSleep": 1.0,
    "sleepQuality": 4.2,
    "restfulness": 85,
  };

  List<Map<String, dynamic>> weeklyData = [
    {
      "day": "Mon",
      "date": "Jan 8",
      "bedtime": "23:00",
      "wakeTime": "07:00",
      "duration": 8.0,
      "quality": 4.0,
      "restfulness": 80,
    },
    {
      "day": "Tue",
      "date": "Jan 9",
      "bedtime": "22:45",
      "wakeTime": "06:45",
      "duration": 8.0,
      "quality": 4.5,
      "restfulness": 85,
    },
    {
      "day": "Wed",
      "date": "Jan 10",
      "bedtime": "23:15",
      "wakeTime": "07:15",
      "duration": 8.0,
      "quality": 3.8,
      "restfulness": 78,
    },
    {
      "day": "Thu",
      "date": "Jan 11",
      "bedtime": "22:30",
      "wakeTime": "06:30",
      "duration": 8.0,
      "quality": 4.2,
      "restfulness": 85,
    },
    {
      "day": "Fri",
      "date": "Jan 12",
      "bedtime": "00:30",
      "wakeTime": "08:30",
      "duration": 8.0,
      "quality": 3.5,
      "restfulness": 70,
    },
    {
      "day": "Sat",
      "date": "Jan 13",
      "bedtime": "01:00",
      "wakeTime": "09:30",
      "duration": 8.5,
      "quality": 3.2,
      "restfulness": 65,
    },
    {
      "day": "Sun",
      "date": "Jan 14",
      "bedtime": "22:30",
      "wakeTime": "06:30",
      "duration": 8.0,
      "quality": 4.2,
      "restfulness": 85,
    },
  ];

  List<Map<String, dynamic>> sleepFactors = [
    {
      "name": "Caffeine Intake",
      "value": 2,
      "maxValue": 5,
      "impact": "Negative",
      "icon": Icons.coffee,
      "color": Colors.brown,
    },
    {
      "name": "Exercise",
      "value": 4,
      "maxValue": 5,
      "impact": "Positive",
      "icon": Icons.fitness_center,
      "color": successColor,
    },
    {
      "name": "Screen Time",
      "value": 3,
      "maxValue": 5,
      "impact": "Negative",
      "icon": Icons.phone_android,
      "color": infoColor,
    },
    {
      "name": "Stress Level",
      "value": 2,
      "maxValue": 5,
      "impact": "Negative",
      "icon": Icons.psychology,
      "color": warningColor,
    },
    {
      "name": "Room Temperature",
      "value": 4,
      "maxValue": 5,
      "impact": "Positive",
      "icon": Icons.thermostat,
      "color": primaryColor,
    },
  ];

  List<Map<String, dynamic>> sleepTips = [
    {
      "title": "Consistent Schedule",
      "description": "Go to bed and wake up at the same time every day",
      "icon": Icons.schedule,
      "color": primaryColor,
    },
    {
      "title": "Dark Environment",
      "description": "Keep your bedroom dark and cool for better sleep",
      "icon": Icons.dark_mode,
      "color": infoColor,
    },
    {
      "title": "No Screens Before Bed",
      "description": "Avoid screens at least 1 hour before bedtime",
      "icon": Icons.phone_iphone,
      "color": warningColor,
    },
    {
      "title": "Relaxation Techniques",
      "description": "Practice meditation or deep breathing before sleep",
      "icon": Icons.self_improvement,
      "color": successColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Sleep Tracker",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.bedtime)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Insights", icon: Icon(Icons.lightbulb)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildAnalyticsTab(),
        _buildInsightsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildLastNightSummary(),
          _buildSleepStages(),
          _buildQuickActions(),
        ],
      ),
    );
  }

  Widget _buildLastNightSummary() {
    double totalSleep = lastNightSleep["totalSleep"] as double;
    double sleepQuality = lastNightSleep["sleepQuality"] as double;
    int restfulness = lastNightSleep["restfulness"] as int;

    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(
                Icons.bedtime,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Last Night's Sleep",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            width: 180,
            height: 180,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 160,
                  height: 160,
                  child: CircularProgressIndicator(
                    value: totalSleep / 10, // Assuming 10 hours is max
                    strokeWidth: 12,
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      totalSleep >= 7 ? successColor : totalSleep >= 6 ? warningColor : dangerColor,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${totalSleep.toStringAsFixed(1)}h",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Sleep",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return Icon(
                          index < sleepQuality ? Icons.star : Icons.star_border,
                          color: warningColor,
                          size: 16,
                        );
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              _buildSummaryCard("Bedtime", "${lastNightSleep["bedtime"]}", Icons.bedtime, infoColor),
              SizedBox(width: spSm),
              _buildSummaryCard("Wake Time", "${lastNightSleep["wakeTime"]}", Icons.wb_sunny, warningColor),
              SizedBox(width: spSm),
              _buildSummaryCard("Quality", "${sleepQuality.toStringAsFixed(1)}/5", Icons.star, primaryColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          spacing: spXs,
          children: [
            Icon(
              icon,
              color: color,
              size: 20,
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSleepStages() {
    double deepSleep = lastNightSleep["deepSleep"] as double;
    double lightSleep = lastNightSleep["lightSleep"] as double;
    double remSleep = lastNightSleep["remSleep"] as double;
    double totalSleep = lastNightSleep["totalSleep"] as double;

    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(
                Icons.analytics,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Sleep Stages",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          _buildSleepStageBar("Deep Sleep", deepSleep, totalSleep, primaryColor),
          _buildSleepStageBar("Light Sleep", lightSleep, totalSleep, infoColor),
          _buildSleepStageBar("REM Sleep", remSleep, totalSleep, successColor),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: infoColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "Deep sleep is crucial for physical recovery and immune function",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSleepStageBar(String stage, double hours, double total, Color color) {
    double percentage = (hours / total) * 100;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Column(
        spacing: spXs,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: spXs),
              Text(
                stage,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${hours.toStringAsFixed(1)}h (${percentage.toInt()}%)",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 8,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: hours / total,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(
                Icons.flash_on,
                color: primaryColor,
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
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Log Sleep",
                  icon: Icons.add,
                  onPressed: () {
                    //navigateTo('LogSleepView')
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Set Bedtime",
                  icon: Icons.alarm,
                  onPressed: () {
                    //navigateTo('SetBedtimeView')
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildWeeklyTrend(),
          _buildSleepFactors(),
        ],
      ),
    );
  }

  Widget _buildWeeklyTrend() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(
                Icons.trending_up,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Weekly Sleep Trend",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            height: 250,
            child: Column(
              spacing: spXs,
              children: weeklyData.map((day) {
                double duration = day["duration"] as double;
                double quality = day["quality"] as double;
                Color durationColor = duration >= 7 ? successColor : duration >= 6 ? warningColor : dangerColor;
                
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        child: Column(
                          children: [
                            Text(
                              "${day["day"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${day["date"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Duration:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${duration.toStringAsFixed(1)}h",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: durationColor,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 6,
                              decoration: BoxDecoration(
                                color: disabledColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: (duration / 10).clamp(0.0, 1.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: durationColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spSm),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < quality ? Icons.star : Icons.star_border,
                            color: warningColor,
                            size: 12,
                          );
                        }),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSleepFactors() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(
                Icons.assessment,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Sleep Factors",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...sleepFactors.map((factor) => _buildFactorCard(factor)).toList(),
        ],
      ),
    );
  }

  Widget _buildFactorCard(Map<String, dynamic> factor) {
    int value = factor["value"] as int;
    int maxValue = factor["maxValue"] as int;
    String impact = factor["impact"] as String;
    Color factorColor = factor["color"] as Color;
    Color impactColor = impact == "Positive" ? successColor : dangerColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: factorColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: factorColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: factorColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              factor["icon"] as IconData,
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
                      "${factor["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: impactColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        impact,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: disabledColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: value / maxValue,
                          child: Container(
                            decoration: BoxDecoration(
                              color: factorColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "$value/$maxValue",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: factorColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSleepInsights(),
          _buildSleepTipsSection(),
        ],
      ),
    );
  }

  Widget _buildSleepInsights() {
    double avgSleep = weeklyData.fold(0.0, (sum, day) => sum + (day["duration"] as double)) / weeklyData.length;
    double avgQuality = weeklyData.fold(0.0, (sum, day) => sum + (day["quality"] as double)) / weeklyData.length;
    
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(
                Icons.insights,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Sleep Insights",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildInsightCard("Weekly Average", "${avgSleep.toStringAsFixed(1)}h", Icons.access_time, primaryColor),
              SizedBox(width: spSm),
              _buildInsightCard("Avg Quality", "${avgQuality.toStringAsFixed(1)}/5", Icons.star, warningColor),
              SizedBox(width: spSm),
              _buildInsightCard("Best Day", "Tuesday", Icons.emoji_events, successColor),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lightbulb,
                  color: infoColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Sleep Recommendation",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Your sleep quality improves when you go to bed before 23:00. Try maintaining a consistent bedtime routine.",
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
        ],
      ),
    );
  }

  Widget _buildInsightCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          spacing: spXs,
          children: [
            Icon(
              icon,
              color: color,
              size: 20,
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSleepTipsSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(
                Icons.auto_awesome,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Sleep Tips",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...sleepTips.map((tip) => _buildTipCard(tip)).toList(),
        ],
      ),
    );
  }

  Widget _buildTipCard(Map<String, dynamic> tip) {
    Color tipColor = tip["color"] as Color;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: tipColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: tipColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: tipColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              tip["icon"] as IconData,
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
                Text(
                  "${tip["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${tip["description"]}",
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
  }
}
