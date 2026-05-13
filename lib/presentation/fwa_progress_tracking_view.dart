import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaProgressTrackingView extends StatefulWidget {
  const FwaProgressTrackingView({super.key});

  @override
  State<FwaProgressTrackingView> createState() => _FwaProgressTrackingViewState();
}

class _FwaProgressTrackingViewState extends State<FwaProgressTrackingView> {
  int selectedTab = 0;
  String selectedPeriod = "week";
  bool loading = false;

  List<Map<String, dynamic>> weeklyProgress = [
    {
      "date": "2024-01-15",
      "weight": 72.5,
      "calories_burned": 450,
      "workout_duration": 45,
      "steps": 8500,
      "water_intake": 2.1,
    },
    {
      "date": "2024-01-16",
      "weight": 72.3,
      "calories_burned": 520,
      "workout_duration": 60,
      "steps": 10200,
      "water_intake": 2.5,
    },
    {
      "date": "2024-01-17",
      "weight": 72.1,
      "calories_burned": 380,
      "workout_duration": 30,
      "steps": 7800,
      "water_intake": 1.8,
    },
    {
      "date": "2024-01-18",
      "weight": 72.0,
      "calories_burned": 600,
      "workout_duration": 75,
      "steps": 12000,
      "water_intake": 2.8,
    },
    {
      "date": "2024-01-19",
      "weight": 71.8,
      "calories_burned": 480,
      "workout_duration": 50,
      "steps": 9500,
      "water_intake": 2.3,
    },
  ];

  List<Map<String, dynamic>> achievements = [
    {
      "title": "First Week Complete",
      "description": "Completed your first week of training",
      "icon": Icons.star,
      "color": warningColor,
      "unlocked": true,
      "date": "2024-01-15",
    },
    {
      "title": "10K Steps Master",
      "description": "Reached 10,000 steps in a single day",
      "icon": Icons.directions_walk,
      "color": successColor,
      "unlocked": true,
      "date": "2024-01-16",
    },
    {
      "title": "Weight Loss Champion",
      "description": "Lost 2kg from starting weight",
      "icon": Icons.trending_down,
      "color": dangerColor,
      "unlocked": true,
      "date": "2024-01-18",
    },
    {
      "title": "Hydration Hero",
      "description": "Drink 3L of water in a day",
      "icon": Icons.local_drink,
      "color": infoColor,
      "unlocked": false,
      "date": "",
    },
    {
      "title": "Marathon Mindset",
      "description": "Complete 30 workouts",
      "icon": Icons.emoji_events,
      "color": primaryColor,
      "unlocked": false,
      "date": "",
    },
  ];

  List<Map<String, dynamic>> goals = [
    {
      "title": "Weight Loss Goal",
      "current": 71.8,
      "target": 68.0,
      "unit": "kg",
      "progress": 0.75,
      "color": dangerColor,
      "icon": Icons.trending_down,
    },
    {
      "title": "Weekly Workouts",
      "current": 5,
      "target": 5,
      "unit": "workouts",
      "progress": 1.0,
      "color": successColor,
      "icon": Icons.fitness_center,
    },
    {
      "title": "Daily Steps",
      "current": 9500,
      "target": 10000,
      "unit": "steps",
      "progress": 0.95,
      "color": infoColor,
      "icon": Icons.directions_walk,
    },
    {
      "title": "Water Intake",
      "current": 2.3,
      "target": 3.0,
      "unit": "liters",
      "progress": 0.77,
      "color": infoColor,
      "icon": Icons.local_drink,
    },
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "Last 3 Months", "value": "quarter"},
    {"label": "This Year", "value": "year"},
  ];

  Future<void> _handleSetupComplete() async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 1));

    loading = false;
    setState(() {});

    ss("Setup complete! Welcome to your fitness journey!");
    // navigateTo(FwaHomeView());
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Progress Tracking",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Goals", icon: Icon(Icons.track_changes)),
        Tab(text: "Achievements", icon: Icon(Icons.emoji_events)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildGoalsTab(),
        _buildAchievementsTab(),
        _buildHistoryTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  primaryColor.withAlpha(25),
                  successColor.withAlpha(15),
                ],
              ),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.emoji_events,
                  color: primaryColor,
                  size: 48,
                ),
                SizedBox(height: spMd),
                Text(
                  "Congratulations!",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "You've completed your fitness profile setup. Here's your progress overview.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spLg),

          // Quick Stats
          Text(
            "Today's Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          SizedBox(height: spMd),

          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard(
                title: "Calories Burned",
                value: "480",
                unit: "kcal",
                icon: Icons.local_fire_department,
                color: dangerColor,
                progress: 0.8,
                target: "600 goal",
              ),
              _buildStatCard(
                title: "Steps Taken",
                value: "9,500",
                unit: "steps",
                icon: Icons.directions_walk,
                color: infoColor,
                progress: 0.95,
                target: "10,000 goal",
              ),
              _buildStatCard(
                title: "Water Intake",
                value: "2.3",
                unit: "liters",
                icon: Icons.local_drink,
                color: infoColor,
                progress: 0.77,
                target: "3.0L goal",
              ),
              _buildStatCard(
                title: "Workout Time",
                value: "50",
                unit: "minutes",
                icon: Icons.timer,
                color: warningColor,
                progress: 1.0,
                target: "45min goal",
              ),
            ],
          ),

          SizedBox(height: spLg),

          // Weekly Progress Chart
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Weight Progress (This Week)",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),

                SizedBox(height: spMd),

                Container(
                  height: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: weeklyProgress.map((day) {
                      double weight = day["weight"] as double;
                      double normalizedHeight = ((weight - 70) / 5) * 120 + 30;
                      
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "${weight}kg",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Container(
                            width: 20,
                            height: normalizedHeight,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            DateTime.parse("${day["date"]}").day.toString(),
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spLg),

          // Recent Achievements
          Text(
            "Recent Achievements",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          SizedBox(height: spMd),

          Column(
            children: achievements.where((achievement) => achievement["unlocked"] == true).take(3).map((achievement) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: (achievement["color"] as Color).withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        achievement["icon"] as IconData,
                        color: achievement["color"] as Color,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${achievement["title"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${achievement["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${DateTime.parse(achievement["date"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          SizedBox(height: spXl),

          // Complete Setup Button
          Container(
            width: double.infinity,
            child: loading
                ? Container(
                    height: 50,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : QButton(
                    label: "Start My Fitness Journey",
                    size: bs.md,
                    onPressed: _handleSetupComplete,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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

          SizedBox(height: spLg),

          // Goals Progress
          Text(
            "Goal Progress",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          SizedBox(height: spMd),

          Column(
            children: goals.map((goal) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
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
                        Icon(
                          goal["icon"] as IconData,
                          color: goal["color"] as Color,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${goal["title"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          "${((goal["progress"] as double) * 100).toInt()}%",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: goal["color"] as Color,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spMd),

                    Row(
                      children: [
                        Text(
                          "${goal["current"]}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          " / ${goal["target"]} ${goal["unit"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spSm),

                    Container(
                      width: double.infinity,
                      height: 8,
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8 * (goal["progress"] as double),
                            height: 8,
                            decoration: BoxDecoration(
                              color: goal["color"] as Color,
                              borderRadius: BorderRadius.circular(radiusXs),
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

  Widget _buildAchievementsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: achievements.map((achievement) {
          bool isUnlocked = achievement["unlocked"] as bool;
          return Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: isUnlocked ? Colors.white : Colors.grey[100],
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: isUnlocked 
                        ? (achievement["color"] as Color).withAlpha(25)
                        : Colors.grey[300],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    achievement["icon"] as IconData,
                    color: isUnlocked 
                        ? achievement["color"] as Color
                        : Colors.grey[500],
                    size: 32,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${achievement["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: isUnlocked ? primaryColor : Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${achievement["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: isUnlocked ? disabledBoldColor : Colors.grey[500],
                        ),
                      ),
                      if (isUnlocked && achievement["date"].isNotEmpty) ...[
                        SizedBox(height: spXs),
                        Text(
                          "Unlocked on ${DateTime.parse(achievement["date"]).dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: achievement["color"] as Color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (isUnlocked)
                  Icon(
                    Icons.check_circle,
                    color: achievement["color"] as Color,
                    size: 24,
                  )
                else
                  Icon(
                    Icons.lock,
                    color: Colors.grey[400],
                    size: 24,
                  ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: weeklyProgress.map((day) {
          return Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${DateTime.parse(day["date"]).dMMMy}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: _buildHistoryItem(
                        "Weight",
                        "${day["weight"]}kg",
                        Icons.monitor_weight,
                        primaryColor,
                      ),
                    ),
                    Expanded(
                      child: _buildHistoryItem(
                        "Calories",
                        "${day["calories_burned"]}",
                        Icons.local_fire_department,
                        dangerColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: _buildHistoryItem(
                        "Workout",
                        "${day["workout_duration"]}min",
                        Icons.timer,
                        warningColor,
                      ),
                    ),
                    Expanded(
                      child: _buildHistoryItem(
                        "Steps",
                        "${(day["steps"] as int) / 1000}K",
                        Icons.directions_walk,
                        infoColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String unit,
    required IconData icon,
    required Color color,
    required double progress,
    required String target,
  }) {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              Spacer(),
              Text(
                "${(progress * 100).toInt()}%",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Row(
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
              Text(
                " $unit",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            height: 4,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              children: [
                Container(
                  width: 120 * progress,
                  height: 4,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spXs),
          Text(
            target,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(String title, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 20,
        ),
        SizedBox(height: spXs),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ],
    );
  }
}
