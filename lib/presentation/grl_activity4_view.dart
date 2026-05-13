import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlActivity4View extends StatefulWidget {
  @override
  State<GrlActivity4View> createState() => _GrlActivity4ViewState();
}

class _GrlActivity4ViewState extends State<GrlActivity4View> {
  int selectedFilter = 0;
  String searchQuery = "";
  
  final List<Map<String, dynamic>> activities = [
    {
      "id": 1,
      "title": "Morning Run",
      "type": "Cardio",
      "duration": "45 minutes",
      "calories": 420,
      "intensity": "High",
      "status": "completed",
      "date": "2024-01-15",
      "time": "06:30",
      "location": "Central Park",
      "weather": "Sunny",
      "heartRate": 145,
      "distance": 6.2,
      "steps": 8420,
      "image": "https://placehold.co/300x200?text=Running"
    },
    {
      "id": 2,
      "title": "Yoga Session",
      "type": "Flexibility",
      "duration": "60 minutes",
      "calories": 180,
      "intensity": "Low",
      "status": "active",
      "date": "2024-01-15",
      "time": "18:00",
      "location": "Home Studio",
      "weather": "Indoor",
      "heartRate": 85,
      "distance": 0.0,
      "steps": 120,
      "image": "https://placehold.co/300x200?text=Yoga"
    },
    {
      "id": 3,
      "title": "Weight Training",
      "type": "Strength",
      "duration": "75 minutes",
      "calories": 350,
      "intensity": "High",
      "status": "scheduled",
      "date": "2024-01-16",
      "time": "08:00",
      "location": "Fitness Center",
      "weather": "Indoor",
      "heartRate": 120,
      "distance": 0.0,
      "steps": 2500,
      "image": "https://placehold.co/300x200?text=Weight+Training"
    },
    {
      "id": 4,
      "title": "Swimming",
      "type": "Cardio",
      "duration": "40 minutes",
      "calories": 380,
      "intensity": "Medium",
      "status": "completed",
      "date": "2024-01-14",
      "time": "19:00",
      "location": "Aquatic Center",
      "weather": "Indoor",
      "heartRate": 135,
      "distance": 1.5,
      "steps": 0,
      "image": "https://placehold.co/300x200?text=Swimming"
    },
    {
      "id": 5,
      "title": "Cycling",
      "type": "Cardio",
      "duration": "90 minutes",
      "calories": 550,
      "intensity": "Medium",
      "status": "completed",
      "date": "2024-01-13",
      "time": "16:00",
      "location": "Mountain Trail",
      "weather": "Cloudy",
      "heartRate": 140,
      "distance": 25.8,
      "steps": 0,
      "image": "https://placehold.co/300x200?text=Cycling"
    },
    {
      "id": 6,
      "title": "Pilates",
      "type": "Flexibility",
      "duration": "50 minutes",
      "calories": 200,
      "intensity": "Low",
      "status": "scheduled",
      "date": "2024-01-16",
      "time": "17:30",
      "location": "Studio Downtown",
      "weather": "Indoor",
      "heartRate": 90,
      "distance": 0.0,
      "steps": 150,
      "image": "https://placehold.co/300x200?text=Pilates"
    }
  ];

  final List<String> filterOptions = ["All", "Completed", "Active", "Scheduled"];
  
  List<Map<String, dynamic>> get filteredActivities {
    List<Map<String, dynamic>> filtered = activities;
    
    if (selectedFilter != 0) {
      String status = filterOptions[selectedFilter].toLowerCase();
      filtered = filtered.where((activity) => 
        "${activity["status"]}" == status).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((activity) =>
        "${activity["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        "${activity["type"]}".toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }
    
    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed": return successColor;
      case "active": return primaryColor;
      case "scheduled": return warningColor;
      default: return disabledColor;
    }
  }

  Color _getIntensityColor(String intensity) {
    switch (intensity) {
      case "High": return dangerColor;
      case "Medium": return warningColor;
      case "Low": return successColor;
      default: return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Activity Tracker"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search activities...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),

            // Filter Tabs
            QCategoryPicker(
              items: filterOptions.map((filter) => {
                "label": filter,
                "value": filter,
              }).toList(),
              value: filterOptions[selectedFilter],
              onChanged: (index, label, value, item) {
                selectedFilter = index;
                setState(() {});
              },
            ),

            // Statistics Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.local_fire_department,
                          color: dangerColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "2,080",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Calories",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.timer,
                          color: primaryColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "5h 20m",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Time",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.trending_up,
                          color: successColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "33.5 km",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Distance",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Activities List
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recent Activities",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Column(
                    spacing: spSm,
                    children: filteredActivities.map((activity) {
                      return Container(
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
                          children: [
                            // Activity Image
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(radiusLg),
                              ),
                              child: Image.network(
                                "${activity["image"]}",
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            
                            Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  // Title and Status
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${activity["title"]}",
                                          style: TextStyle(
                                            fontSize: fsH6,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor("${activity["status"]}").withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${activity["status"]}".toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: _getStatusColor("${activity["status"]}"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Type and Intensity
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: primaryColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${activity["type"]}",
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getIntensityColor("${activity["intensity"]}").withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${activity["intensity"]}",
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: _getIntensityColor("${activity["intensity"]}"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Date and Time
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today,
                                        size: 14,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${activity["date"]} at ${activity["time"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Location
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 14,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${activity["location"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Stats Row
                                  Container(
                                    margin: EdgeInsets.only(top: spXs),
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withAlpha(10),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            Icon(
                                              Icons.timer,
                                              size: 16,
                                              color: primaryColor,
                                            ),
                                            Text(
                                              "${activity["duration"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Icon(
                                              Icons.local_fire_department,
                                              size: 16,
                                              color: dangerColor,
                                            ),
                                            Text(
                                              "${activity["calories"]} cal",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: dangerColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Icon(
                                              Icons.favorite,
                                              size: 16,
                                              color: dangerColor,
                                            ),
                                            Text(
                                              "${activity["heartRate"]} bpm",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: dangerColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        if ((activity["distance"] as double) > 0)
                                          Column(
                                            children: [
                                              Icon(
                                                Icons.straighten,
                                                size: 16,
                                                color: successColor,
                                              ),
                                              Text(
                                                "${(activity["distance"] as double).toStringAsFixed(1)} km",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                  color: successColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),

                                  // Action Buttons
                                  Row(
                                    children: [
                                      Expanded(
                                        child: QButton(
                                          label: "View Details",
                                          size: bs.sm,
                                          onPressed: () {},
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      QButton(
                                        icon: Icons.more_vert,
                                        size: bs.sm,
                                        onPressed: () {},
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
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
