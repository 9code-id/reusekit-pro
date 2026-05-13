import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaCreateItineraryView extends StatefulWidget {
  const TtaCreateItineraryView({super.key});

  @override
  State<TtaCreateItineraryView> createState() => _TtaCreateItineraryViewState();
}

class _TtaCreateItineraryViewState extends State<TtaCreateItineraryView> {
  String itineraryName = "";
  String destination = "Bali, Indonesia";
  DateTime? startDate;
  DateTime? endDate;
  int numberOfDays = 5;
  String budget = "Medium";
  List<Map<String, dynamic>> dailyPlans = [];
  int currentDayIndex = 0;
  
  final List<String> budgetOptions = [
    "Budget",
    "Medium", 
    "Luxury",
    "Ultra Luxury"
  ];

  final List<Map<String, dynamic>> activityTemplates = [
    {
      "title": "Morning Sightseeing",
      "category": "Sightseeing",
      "icon": Icons.camera_alt,
      "duration": 3,
      "cost": 25,
      "description": "Visit popular landmarks and attractions",
    },
    {
      "title": "Local Restaurant",
      "category": "Dining",
      "icon": Icons.restaurant,
      "duration": 1,
      "cost": 30,
      "description": "Try authentic local cuisine",
    },
    {
      "title": "Shopping Tour",
      "category": "Shopping",
      "icon": Icons.shopping_bag,
      "duration": 2,
      "cost": 50,
      "description": "Explore local markets and stores",
    },
    {
      "title": "Cultural Experience",
      "category": "Culture",
      "icon": Icons.account_balance,
      "duration": 2,
      "cost": 20,
      "description": "Immerse in local culture and traditions",
    },
    {
      "title": "Adventure Activity",
      "category": "Adventure",
      "icon": Icons.sports_hockey,
      "duration": 4,
      "cost": 75,
      "description": "Exciting outdoor activities",
    },
    {
      "title": "Beach Time",
      "category": "Leisure",
      "icon": Icons.beach_access,
      "duration": 3,
      "cost": 10,
      "description": "Relax and enjoy the beach",
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeDailyPlans();
  }

  void _initializeDailyPlans() {
    dailyPlans = List.generate(numberOfDays, (index) => {
      "day": index + 1,
      "date": DateTime.now().add(Duration(days: index)),
      "activities": <Map<String, dynamic>>[],
      "totalCost": 0.0,
      "totalDuration": 0,
    });
  }

  void _addActivityToDay(int dayIndex, Map<String, dynamic> activity) {
    setState(() {
      final newActivity = {
        ...activity,
        "id": DateTime.now().millisecondsSinceEpoch,
        "startTime": "09:00",
        "endTime": _calculateEndTime("09:00", activity["duration"] as int),
      };
      
      dailyPlans[dayIndex]["activities"].add(newActivity);
      dailyPlans[dayIndex]["totalCost"] = 
        (dailyPlans[dayIndex]["totalCost"] as double) + (activity["cost"] as int);
      dailyPlans[dayIndex]["totalDuration"] = 
        (dailyPlans[dayIndex]["totalDuration"] as int) + (activity["duration"] as int);
    });
  }

  void _removeActivityFromDay(int dayIndex, int activityId) {
    setState(() {
      final activities = dailyPlans[dayIndex]["activities"] as List<Map<String, dynamic>>;
      final activityIndex = activities.indexWhere((activity) => 
        activity["id"] == activityId);
      
      if (activityIndex != -1) {
        final removedActivity = activities[activityIndex];
        activities.removeAt(activityIndex);
        
        dailyPlans[dayIndex]["totalCost"] = 
          (dailyPlans[dayIndex]["totalCost"] as double) - (removedActivity["cost"] as int);
        dailyPlans[dayIndex]["totalDuration"] = 
          (dailyPlans[dayIndex]["totalDuration"] as int) - (removedActivity["duration"] as int);
      }
    });
  }

  String _calculateEndTime(String startTime, int durationHours) {
    final startHour = int.parse(startTime.split(':')[0]);
    final startMinute = int.parse(startTime.split(':')[1]);
    final endHour = (startHour + durationHours) % 24;
    return "${endHour.toString().padLeft(2, '0')}:${startMinute.toString().padLeft(2, '0')}";
  }

  double get totalItineraryCost {
    return dailyPlans.fold(0.0, (sum, day) => sum + (day["totalCost"] as double));
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Sightseeing": return primaryColor;
      case "Dining": return dangerColor;
      case "Shopping": return successColor;
      case "Culture": return warningColor;
      case "Adventure": return infoColor;
      case "Leisure": return Colors.purple;
      default: return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Itinerary"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.save),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share),
          ),
        ],
      ),
      body: Column(
        children: [
          // Header Information
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.1),
              border: Border(
                bottom: BorderSide(
                  color: disabledOutlineBorderColor,
                ),
              ),
            ),
            child: Column(
              children: [
                // Itinerary Details
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Itinerary Name",
                        value: itineraryName,
                        hint: "Enter itinerary name",
                        onChanged: (value) {
                          itineraryName = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: QDropdownField(
                        label: "Budget",
                        items: budgetOptions.map((budget) => {
                          "label": budget,
                          "value": budget,
                        }).toList(),
                        value: budget,
                        onChanged: (value, label) {
                          budget = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Summary Stats
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "$numberOfDays",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Days",
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
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${dailyPlans.fold(0, (sum, day) => sum + (day["activities"] as List).length)}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Activities",
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
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "\$${totalItineraryCost.toStringAsFixed(0)}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Budget",
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
              ],
            ),
          ),

          // Day Tabs
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(vertical: spSm),
            child: QHorizontalScroll(
              children: List.generate(numberOfDays, (index) {
                final isSelected = currentDayIndex == index;
                final day = dailyPlans[index];
                return GestureDetector(
                  onTap: () {
                    currentDayIndex = index;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    margin: EdgeInsets.only(right: spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.grey.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Day ${index + 1}",
                          style: TextStyle(
                            color: isSelected ? Colors.white : disabledBoldColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "${(day["activities"] as List).length} activities",
                          style: TextStyle(
                            color: isSelected ? Colors.white.withValues(alpha: 0.8) : disabledColor,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Current Day Content
          Expanded(
            child: Row(
              children: [
                // Activities for Selected Day
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Row(
                          children: [
                            Text(
                              "Day ${currentDayIndex + 1} - Activities",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "\$${(dailyPlans[currentDayIndex]["totalCost"] as double).toStringAsFixed(0)}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: spMd),
                          itemCount: (dailyPlans[currentDayIndex]["activities"] as List).length,
                          itemBuilder: (context, index) {
                            final activity = (dailyPlans[currentDayIndex]["activities"] as List)[index];
                            return Container(
                              margin: EdgeInsets.only(bottom: spMd),
                              padding: EdgeInsets.all(spMd),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusMd),
                                boxShadow: [shadowSm],
                                border: Border(
                                  left: BorderSide(
                                    width: 4,
                                    color: _getCategoryColor(activity["category"] as String),
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      color: _getCategoryColor(activity["category"] as String).withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Icon(
                                      activity["icon"] as IconData,
                                      color: _getCategoryColor(activity["category"] as String),
                                      size: 20,
                                    ),
                                  ),
                                  SizedBox(width: spMd),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${activity["title"]}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "${activity["description"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Text(
                                              "${activity["startTime"]} - ${activity["endTime"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: infoColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              "\$${activity["cost"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => _removeActivityFromDay(
                                      currentDayIndex, 
                                      activity["id"] as int
                                    ),
                                    icon: Icon(Icons.delete_outline),
                                    color: dangerColor,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Activity Templates
                Container(
                  width: 1,
                  color: disabledOutlineBorderColor,
                ),
                
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Text(
                          "Add Activities",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: spMd),
                          itemCount: activityTemplates.length,
                          itemBuilder: (context, index) {
                            final template = activityTemplates[index];
                            return Container(
                              margin: EdgeInsets.only(bottom: spSm),
                              child: GestureDetector(
                                onTap: () => _addActivityToDay(currentDayIndex, template),
                                child: Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    border: Border.all(
                                      color: disabledOutlineBorderColor,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        template["icon"] as IconData,
                                        color: _getCategoryColor(template["category"] as String),
                                        size: 20,
                                      ),
                                      SizedBox(width: spSm),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${template["title"]}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              "${template["duration"]}h • \$${template["cost"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Icon(
                                        Icons.add,
                                        color: primaryColor,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
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
      floatingActionButton: QButton(
        label: "Save Itinerary",
        size: bs.md,
        onPressed: () {
          if (itineraryName.isEmpty) {
            se("Please enter an itinerary name");
            return;
          }
          ss("Itinerary saved successfully!");
        },
      ),
    );
  }
}
