import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlActivity3View extends StatefulWidget {
  const GrlActivity3View({Key? key}) : super(key: key);

  @override
  State<GrlActivity3View> createState() => _GrlActivity3ViewState();
}

class _GrlActivity3ViewState extends State<GrlActivity3View> {
  String selectedDate = "2024-01-15";
  List<Map<String, dynamic>> dailyActivities = [
    {
      "id": 1,
      "name": "Morning Run",
      "category": "Exercise",
      "startTime": "06:00",
      "endTime": "07:00",
      "duration": 60,
      "calories": 450,
      "status": "completed",
      "progress": 100,
      "difficulty": "medium",
      "location": "Central Park"
    },
    {
      "id": 2,
      "name": "Team Meeting",
      "category": "Work",
      "startTime": "09:00",
      "endTime": "10:30",
      "duration": 90,
      "participants": 8,
      "status": "completed",
      "progress": 100,
      "difficulty": "easy",
      "location": "Conference Room A"
    },
    {
      "id": 3,
      "name": "Coding Session",
      "category": "Work",
      "startTime": "11:00",
      "endTime": "13:00",
      "duration": 120,
      "linesOfCode": 245,
      "status": "in_progress",
      "progress": 75,
      "difficulty": "hard",
      "project": "Mobile App Development"
    },
    {
      "id": 4,
      "name": "Lunch Break",
      "category": "Personal",
      "startTime": "13:00",
      "endTime": "14:00",
      "duration": 60,
      "calories": 650,
      "status": "scheduled",
      "progress": 0,
      "difficulty": "easy",
      "restaurant": "Healthy Bites"
    },
    {
      "id": 5,
      "name": "Gym Workout",
      "category": "Exercise",
      "startTime": "18:00",
      "endTime": "19:30",
      "duration": 90,
      "calories": 380,
      "status": "scheduled",
      "progress": 0,
      "difficulty": "hard",
      "exercises": ["Bench Press", "Squats", "Deadlifts"]
    }
  ];

  Map<String, dynamic> dailyStats = {
    "totalActivities": 5,
    "completedActivities": 2,
    "totalDuration": 420,
    "completedDuration": 150,
    "totalCalories": 1925,
    "burnedCalories": 450,
    "productivity": 85,
    "wellness": 78
  };

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "in_progress":
        return warningColor;
      case "scheduled":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "easy":
        return successColor;
      case "medium":
        return warningColor;
      case "hard":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Exercise":
        return Icons.fitness_center;
      case "Work":
        return Icons.work;
      case "Personal":
        return Icons.person;
      default:
        return Icons.circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Activities"),
        actions: [
          QButton(
            icon: Icons.calendar_today,
            size: bs.sm,
            onPressed: () {
              _showDatePicker();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Daily Summary Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor.withAlpha(20), primaryColor.withAlpha(5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.today,
                        color: primaryColor,
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Today's Progress",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${DateTime.parse(selectedDate).day}/${DateTime.parse(selectedDate).month}/${DateTime.parse(selectedDate).year}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "${((dailyStats["completedActivities"] as int) / (dailyStats["totalActivities"] as int) * 100).round()}%",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Progress Indicators
                  Row(
                    children: [
                      Expanded(
                        child: _buildProgressIndicator(
                          "Activities",
                          (dailyStats["completedActivities"] as int),
                          (dailyStats["totalActivities"] as int),
                          primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildProgressIndicator(
                          "Duration",
                          (dailyStats["completedDuration"] as int),
                          (dailyStats["totalDuration"] as int),
                          successColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Stats Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildStatCard(
                  "Total Duration",
                  "${(dailyStats["totalDuration"] as int) ~/ 60}h ${(dailyStats["totalDuration"] as int) % 60}m",
                  Icons.schedule,
                  primaryColor,
                ),
                _buildStatCard(
                  "Calories Burned",
                  "${dailyStats["burnedCalories"]}",
                  Icons.local_fire_department,
                  dangerColor,
                ),
                _buildStatCard(
                  "Productivity",
                  "${dailyStats["productivity"]}%",
                  Icons.trending_up,
                  warningColor,
                ),
                _buildStatCard(
                  "Wellness Score",
                  "${dailyStats["wellness"]}%",
                  Icons.favorite,
                  successColor,
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Activities List Header
            Row(
              children: [
                Text(
                  "Today's Activities",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                QButton(
                  icon: Icons.add,
                  size: bs.sm,
                  onPressed: () {
                    _showAddActivityDialog();
                  },
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Activities List
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: dailyActivities.length,
              itemBuilder: (context, index) {
                final activity = dailyActivities[index];
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: _getStatusColor("${activity["status"]}"),
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Activity Header
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: _getStatusColor("${activity["status"]}").withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              _getCategoryIcon("${activity["category"]}"),
                              color: _getStatusColor("${activity["status"]}"),
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${activity["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${activity["category"]}",
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
                              color: _getDifficultyColor("${activity["difficulty"]}").withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${activity["difficulty"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: _getDifficultyColor("${activity["difficulty"]}"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Time and Duration
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${activity["startTime"]} - ${activity["endTime"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${activity["duration"]} min",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Progress Bar
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Progress",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${activity["progress"]}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _getStatusColor("${activity["status"]}"),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Container(
                            width: double.infinity,
                            height: 8,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: (activity["progress"] as int) / 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _getStatusColor("${activity["status"]}"),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      // Additional Info
                      if (activity["location"] != null) ...[
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${activity["location"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                      
                      if (activity["calories"] != null) ...[
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(
                              Icons.local_fire_department,
                              size: 16,
                              color: dangerColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${activity["calories"]} calories",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(String label, int current, int total, Color color) {
    double progress = total > 0 ? current / total : 0;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            Text(
              "$current/$total",
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: spXs),
        Container(
          width: double.infinity,
          height: 6,
          decoration: BoxDecoration(
            color: disabledColor,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH5,
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
              fontSize: 14,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _showDatePicker() {
    // Date picker implementation
  }

  void _showAddActivityDialog() {
    // Add activity dialog implementation
  }
}
