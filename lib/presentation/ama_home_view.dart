import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaHomeView extends StatefulWidget {
  const AmaHomeView({super.key});

  @override
  State<AmaHomeView> createState() => _AmaHomeViewState();
}

class _AmaHomeViewState extends State<AmaHomeView> {
  List<Map<String, dynamic>> quickActions = [
    {
      "title": "Field Monitor",
      "subtitle": "Check crop status",
      "icon": Icons.visibility,
      "color": primaryColor,
    },
    {
      "title": "Weather",
      "subtitle": "7-day forecast",
      "icon": Icons.wb_sunny,
      "color": warningColor,
    },
    {
      "title": "Tasks",
      "subtitle": "5 pending",
      "icon": Icons.task_alt,
      "color": successColor,
    },
    {
      "title": "Analytics",
      "subtitle": "Farm insights",
      "icon": Icons.analytics,
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> activeFields = [
    {
      "name": "Main Field A",
      "crop": "Wheat",
      "stage": "Flowering",
      "health": "Excellent",
      "area": "15.5 hectares",
      "progress": 0.7,
      "image": "https://picsum.photos/300/150?random=1&keyword=wheat",
      "lastUpdate": "2 hours ago",
    },
    {
      "name": "South Pasture",
      "crop": "Corn",
      "stage": "Vegetative",
      "health": "Good",
      "area": "8.2 hectares",
      "progress": 0.4,
      "image": "https://picsum.photos/300/150?random=2&keyword=corn",
      "lastUpdate": "4 hours ago",
    },
    {
      "name": "East Garden",
      "crop": "Tomatoes",
      "stage": "Fruiting",
      "health": "Fair",
      "area": "3.7 hectares",
      "progress": 0.8,
      "image": "https://picsum.photos/300/150?random=3&keyword=tomato",
      "lastUpdate": "1 hour ago",
    },
  ];

  List<Map<String, dynamic>> recentActivities = [
    {
      "title": "Irrigation completed",
      "description": "Main Field A - 2 hours duration",
      "time": "2 hours ago",
      "icon": Icons.water_drop,
      "type": "irrigation",
    },
    {
      "title": "Fertilizer applied",
      "description": "South Pasture - NPK 10-10-10",
      "time": "1 day ago",
      "icon": Icons.scatter_plot,
      "type": "fertilizer",
    },
    {
      "title": "Pest monitoring",
      "description": "East Garden - No issues detected",
      "time": "2 days ago",
      "icon": Icons.bug_report,
      "type": "monitoring",
    },
    {
      "title": "Harvest completed",
      "description": "North Field - 2.5 tons collected",
      "time": "3 days ago",
      "icon": Icons.agriculture,
      "type": "harvest",
    },
  ];

  List<Map<String, dynamic>> weatherData = [
    {"day": "Today", "temp": "28°C", "condition": "Sunny", "icon": Icons.wb_sunny},
    {"day": "Tomorrow", "temp": "26°C", "condition": "Cloudy", "icon": Icons.cloud},
    {"day": "Thursday", "temp": "24°C", "condition": "Rain", "icon": Icons.grain},
  ];

  Color getHealthColor(String health) {
    switch (health.toLowerCase()) {
      case 'excellent':
        return successColor;
      case 'good':
        return primaryColor;
      case 'fair':
        return warningColor;
      case 'poor':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color getActivityColor(String type) {
    switch (type) {
      case 'irrigation':
        return infoColor;
      case 'fertilizer':
        return successColor;
      case 'monitoring':
        return warningColor;
      case 'harvest':
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome back!"),
            Text(
              "Green Valley Farm",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined),
            onPressed: () {
              si("3 new notifications");
            },
          ),
          IconButton(
            icon: Icon(Icons.person_outline),
            onPressed: () {
              si("Open profile settings");
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
            // Weather Summary
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Today's Weather",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Perfect for farming activities",
                            style: TextStyle(
                              color: Colors.white.withAlpha(200),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.wb_sunny,
                        color: Colors.white,
                        size: 32,
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: weatherData.map((weather) {
                      return Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          child: Column(
                            children: [
                              Icon(
                                weather["icon"],
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${weather["day"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "${weather["temp"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            
            // Quick Actions
            Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: quickActions.map((action) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: (action["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              action["icon"],
                              color: action["color"],
                              size: 24,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: disabledBoldColor,
                            size: 16,
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${action["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${action["subtitle"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            
            // Active Fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Active Fields",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QButton(
                  label: "View All",
                  size: bs.sm,
                  onPressed: () {
                    si("Navigate to fields overview");
                  },
                ),
              ],
            ),
            
            QHorizontalScroll(
              children: activeFields.map((field) {
                return Container(
                  width: 280,
                  margin: EdgeInsets.only(right: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusMd),
                              topRight: Radius.circular(radiusMd),
                            ),
                            child: Image.network(
                              "${field["image"]}",
                              width: double.infinity,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: getHealthColor(field["health"]),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${field["health"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${field["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${field["crop"]} • ${field["area"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: spSm),
                            
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Stage: ${field["stage"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${((field["progress"] as double) * 100).toInt()}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spXs),
                            
                            LinearProgressIndicator(
                              value: field["progress"],
                              backgroundColor: disabledColor.withAlpha(50),
                              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                            ),
                            
                            SizedBox(height: spSm),
                            
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Updated ${field["lastUpdate"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    si("Open field details");
                                  },
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: primaryColor,
                                    size: 16,
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
              }).toList(),
            ),
            
            // Recent Activities
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent Activities",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QButton(
                  label: "View All",
                  size: bs.sm,
                  onPressed: () {
                    si("Navigate to activity log");
                  },
                ),
              ],
            ),
            
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: List.generate(recentActivities.length.clamp(0, 4), (index) {
                  final activity = recentActivities[index];
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: index > 0 ? Border(
                        top: BorderSide(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ) : null,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: getActivityColor(activity["type"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            activity["icon"],
                            color: getActivityColor(activity["type"]),
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${activity["title"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "${activity["description"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${activity["time"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            
            // Farm Stats Summary
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Farm Overview",
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
                        child: Column(
                          children: [
                            Text(
                              "27.4",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Total Hectares",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "3",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Active Fields",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "5",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Crop Types",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
