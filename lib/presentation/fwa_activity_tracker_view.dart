import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaActivityTrackerView extends StatefulWidget {
  const FwaActivityTrackerView({Key? key}) : super(key: key);

  @override
  State<FwaActivityTrackerView> createState() => _FwaActivityTrackerViewState();
}

class _FwaActivityTrackerViewState extends State<FwaActivityTrackerView> {
  String selectedPeriod = "Today";
  
  List<Map<String, dynamic>> periodOptions = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> todayActivities = [
    {
      "type": "Steps",
      "current": 8543,
      "goal": 10000,
      "icon": Icons.directions_walk,
      "color": Colors.blue,
      "unit": "steps"
    },
    {
      "type": "Calories",
      "current": 420,
      "goal": 600,
      "icon": Icons.local_fire_department,
      "color": Colors.orange,
      "unit": "kcal"
    },
    {
      "type": "Distance",
      "current": 6.2,
      "goal": 8.0,
      "icon": Icons.straighten,
      "color": Colors.green,
      "unit": "km"
    },
    {
      "type": "Active Time",
      "current": 45,
      "goal": 60,
      "icon": Icons.timer,
      "color": Colors.purple,
      "unit": "min"
    }
  ];

  List<Map<String, dynamic>> recentWorkouts = [
    {
      "name": "Morning Run",
      "duration": "30 min",
      "calories": 280,
      "time": "7:00 AM",
      "type": "Cardio",
      "icon": Icons.directions_run
    },
    {
      "name": "Strength Training",
      "duration": "45 min",
      "calories": 320,
      "time": "6:00 PM",
      "type": "Strength",
      "icon": Icons.fitness_center
    },
    {
      "name": "Evening Walk",
      "duration": "25 min",
      "calories": 120,
      "time": "8:30 PM",
      "type": "Cardio",
      "icon": Icons.directions_walk
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Activity Tracker"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              // Navigate to calendar view
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

            // Daily Goals Progress
            Text(
              "Daily Goals",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: todayActivities.map((activity) {
                double progress = (activity["current"] as num) / (activity["goal"] as num);
                progress = progress > 1.0 ? 1.0 : progress;
                
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
                        activity["icon"] as IconData,
                        color: activity["color"] as Color,
                        size: 32,
                      ),
                      Text(
                        "${activity["type"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                          ),
                          Container(
                            height: 8,
                            width: MediaQuery.of(context).size.width * 0.3 * progress,
                            decoration: BoxDecoration(
                              color: activity["color"] as Color,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${activity["current"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "/${activity["goal"]} ${activity["unit"]}",
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
              }).toList(),
            ),

            // Weekly Summary Chart
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
                    "Weekly Activity",
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
                        _buildChartBar("Mon", 80, Colors.blue),
                        _buildChartBar("Tue", 65, Colors.blue),
                        _buildChartBar("Wed", 90, Colors.blue),
                        _buildChartBar("Thu", 75, Colors.blue),
                        _buildChartBar("Fri", 95, Colors.blue),
                        _buildChartBar("Sat", 85, Colors.blue),
                        _buildChartBar("Sun", 70, Colors.blue),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Recent Workouts
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent Workouts",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to all workouts
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
              children: recentWorkouts.map((workout) {
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
                          workout["icon"] as IconData,
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
                              "${workout["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${workout["type"]} • ${workout["duration"]}",
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
                            "${workout["calories"]} kcal",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${workout["time"]}",
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
              }).toList(),
            ),

            // Quick Actions
            Container(
              width: double.infinity,
              child: QButton(
                label: "Start New Workout",
                size: bs.md,
                onPressed: () {
                  // Navigate to workout selection
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartBar(String day, double percentage, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: (120 * percentage / 100),
          width: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusSm),
          ),
        ),
        SizedBox(height: spXs),
        Text(
          day,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }
}
