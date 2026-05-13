import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaBabyTrackerView extends StatefulWidget {
  const MhaBabyTrackerView({super.key});

  @override
  State<MhaBabyTrackerView> createState() => _MhaBabyTrackerViewState();
}

class _MhaBabyTrackerViewState extends State<MhaBabyTrackerView> {
  int currentTab = 0;
  
  // Sample baby data
  final Map<String, dynamic> babyData = {
    "name": "Emma Rose",
    "birth_date": "2024-09-15",
    "age_months": 9,
    "age_days": 15,
    "current_weight": 8.5,
    "current_height": 68.0,
    "photo": "https://picsum.photos/120/120?random=1&keyword=baby"
  };

  final List<Map<String, dynamic>> feedingLogs = [
    {
      "time": "08:30 AM",
      "type": "Breastfeeding",
      "duration": "25 min",
      "side": "Both",
      "amount": null,
      "notes": "Baby seemed satisfied"
    },
    {
      "time": "06:15 AM", 
      "type": "Formula",
      "duration": null,
      "side": null,
      "amount": "120 ml",
      "notes": "Finished entire bottle"
    },
    {
      "time": "03:45 AM",
      "type": "Breastfeeding",
      "duration": "18 min",
      "side": "Left",
      "amount": null,
      "notes": "Sleepy feeding"
    },
  ];

  final List<Map<String, dynamic>> sleepLogs = [
    {
      "start_time": "07:00 PM",
      "end_time": "06:30 AM",
      "duration": "11h 30m",
      "quality": "Good",
      "type": "Night Sleep",
      "notes": "Slept through the night"
    },
    {
      "start_time": "01:30 PM",
      "end_time": "03:00 PM", 
      "duration": "1h 30m",
      "quality": "Fair",
      "type": "Afternoon Nap",
      "notes": "Woke up crying"
    },
    {
      "start_time": "10:15 AM",
      "end_time": "11:00 AM",
      "duration": "45m",
      "quality": "Good",
      "type": "Morning Nap",
      "notes": "Peaceful nap"
    },
  ];

  final List<Map<String, dynamic>> diaperLogs = [
    {
      "time": "09:15 AM",
      "type": "Wet",
      "consistency": null,
      "color": null,
      "notes": "Heavy wet diaper"
    },
    {
      "time": "07:45 AM",
      "type": "Dirty",
      "consistency": "Soft",
      "color": "Yellow",
      "notes": "Normal consistency"
    },
    {
      "time": "05:30 AM",
      "type": "Wet",
      "consistency": null,
      "color": null,
      "notes": "Changed during feeding"
    },
  ];

  final List<Map<String, dynamic>> milestones = [
    {
      "age": "9 months",
      "milestone": "Sitting without support",
      "achieved": true,
      "date_achieved": "2025-05-20",
      "category": "Physical",
      "description": "Can sit independently for extended periods"
    },
    {
      "age": "9 months",
      "milestone": "Crawling",
      "achieved": true,
      "date_achieved": "2025-05-15",
      "category": "Physical",
      "description": "Army crawling and starting to crawl on hands and knees"
    },
    {
      "age": "9 months",
      "milestone": "Saying mama/dada",
      "achieved": false,
      "date_achieved": null,
      "category": "Language",
      "description": "Should start saying first words"
    },
    {
      "age": "9 months",
      "milestone": "Playing peek-a-boo",
      "achieved": true,
      "date_achieved": "2025-05-25",
      "category": "Social",
      "description": "Enjoys interactive games with caregivers"
    },
  ];

  final List<Map<String, dynamic>> growthData = [
    {
      "date": "2025-06-14",
      "age_months": 9,
      "weight": 8.5,
      "height": 68.0,
      "head_circumference": 44.5,
      "percentile_weight": 60,
      "percentile_height": 55
    },
    {
      "date": "2025-05-14",
      "age_months": 8,
      "weight": 8.1,
      "height": 66.5,
      "head_circumference": 44.0,
      "percentile_weight": 58,
      "percentile_height": 52
    },
    {
      "date": "2025-04-14",
      "age_months": 7,
      "weight": 7.8,
      "height": 65.0,
      "head_circumference": 43.5,
      "percentile_weight": 55,
      "percentile_height": 50
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Baby Tracker",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.baby_changing_station)),
        Tab(text: "Feeding", icon: Icon(Icons.restaurant)),
        Tab(text: "Sleep", icon: Icon(Icons.bedtime)),
        Tab(text: "Diapers", icon: Icon(Icons.child_care)),
        Tab(text: "Growth", icon: Icon(Icons.trending_up)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildFeedingTab(),
        _buildSleepTab(),
        _buildDiapersTab(),
        _buildGrowthTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Baby Profile Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(babyData["photo"]),
                ),
                SizedBox(height: spMd),
                Text(
                  "${babyData["name"]}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${babyData["age_months"]} months, ${babyData["age_days"]} days old",
                  style: TextStyle(
                    fontSize: fsH6,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          "${babyData["current_weight"]} kg",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Weight",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "${babyData["current_height"]} cm",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Height",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Today's Summary
          Container(
            width: double.infinity,
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
                  "Today's Summary",
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
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Icon(
                              Icons.restaurant,
                              color: successColor,
                              size: 24,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "8",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Feedings",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Icon(
                              Icons.bedtime,
                              color: infoColor,
                              size: 24,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "13h 45m",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Sleep",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Icon(
                              Icons.child_care,
                              color: warningColor,
                              size: 24,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "6",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Diapers",
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
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Recent Milestones
          Container(
            width: double.infinity,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recent Milestones",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QButton(
                      label: "View All",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                
                ...milestones.where((m) => m["achieved"] == true).take(2).map((milestone) {
                  return Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: successColor.withAlpha(60),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${milestone["milestone"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Achieved on ${milestone["date_achieved"]}",
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
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Quick Actions
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Add Feeding",
                  size: bs.md,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Add Sleep",
                  size: bs.md,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeedingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Feeding Log",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QButton(
                label: "Add Feeding",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: spMd),
          
          ...feedingLogs.map((feeding) {
            Color typeColor = feeding["type"] == "Breastfeeding" ? successColor : infoColor;
            IconData typeIcon = feeding["type"] == "Breastfeeding" ? Icons.child_care : Icons.local_drink;
            
            return Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    color: typeColor,
                    width: 4,
                  ),
                ),
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
                          color: typeColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Icon(
                          typeIcon,
                          color: typeColor,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${feeding["type"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${feeding["time"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  Row(
                    children: [
                      if (feeding["duration"] != null) ...[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Duration",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${feeding["duration"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      if (feeding["amount"] != null) ...[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Amount",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${feeding["amount"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      if (feeding["side"] != null) ...[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Side",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${feeding["side"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                  
                  if (feeding["notes"] != null) ...[
                    SizedBox(height: spMd),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: typeColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${feeding["notes"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildSleepTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Sleep Log",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QButton(
                label: "Add Sleep",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: spMd),
          
          ...sleepLogs.map((sleep) {
            Color qualityColor = sleep["quality"] == "Good" ? successColor : 
                                 sleep["quality"] == "Fair" ? warningColor : dangerColor;
            
            return Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    color: qualityColor,
                    width: 4,
                  ),
                ),
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
                          color: qualityColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Icon(
                          Icons.bedtime,
                          color: qualityColor,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${sleep["type"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${sleep["start_time"]} - ${sleep["end_time"]}",
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
                          color: qualityColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${sleep["quality"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: qualityColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Duration",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${sleep["duration"]}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: qualityColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  if (sleep["notes"] != null) ...[
                    SizedBox(height: spMd),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: qualityColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${sleep["notes"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildDiapersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Diaper Log",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QButton(
                label: "Add Change",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: spMd),
          
          ...diaperLogs.map((diaper) {
            Color typeColor = diaper["type"] == "Wet" ? infoColor : warningColor;
            IconData typeIcon = diaper["type"] == "Wet" ? Icons.water_drop : Icons.child_care;
            
            return Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    color: typeColor,
                    width: 4,
                  ),
                ),
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
                          color: typeColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Icon(
                          typeIcon,
                          color: typeColor,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${diaper["type"]} Diaper",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${diaper["time"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  if (diaper["consistency"] != null || diaper["color"] != null) ...[
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        if (diaper["consistency"] != null) ...[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Consistency",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${diaper["consistency"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        if (diaper["color"] != null) ...[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Color",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${diaper["color"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                  
                  if (diaper["notes"] != null) ...[
                    SizedBox(height: spMd),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: typeColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${diaper["notes"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildGrowthTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Growth Progress",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          ...growthData.map((growth) {
            return Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: spMd),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${growth["age_months"]} Months",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${growth["date"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusMd),
                              ),
                              child: Icon(
                                Icons.monitor_weight,
                                color: successColor,
                                size: 24,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${growth["weight"]} kg",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${growth["percentile_weight"]}th percentile",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusMd),
                              ),
                              child: Icon(
                                Icons.height,
                                color: infoColor,
                                size: 24,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${growth["height"]} cm",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${growth["percentile_height"]}th percentile",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: warningColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusMd),
                              ),
                              child: Icon(
                                Icons.circle,
                                color: warningColor,
                                size: 24,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${growth["head_circumference"]} cm",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Head circumference",
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
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
