import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaClassScheduleView extends StatefulWidget {
  const FwaClassScheduleView({super.key});

  @override
  State<FwaClassScheduleView> createState() => _FwaClassScheduleViewState();
}

class _FwaClassScheduleViewState extends State<FwaClassScheduleView> {
  int selectedDay = 0;
  String selectedTimeSlot = "All";
  String selectedCategory = "All";
  
  List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  List<String> timeSlots = ["All", "Morning", "Afternoon", "Evening"];
  List<String> categories = ["All", "Yoga", "HIIT", "Strength", "Cardio", "Pilates"];
  
  List<Map<String, dynamic>> classes = [
    {
      "id": 1,
      "name": "Morning Yoga Flow",
      "instructor": "Sarah Johnson",
      "time": "07:00",
      "duration": 60,
      "category": "Yoga",
      "level": "Beginner",
      "spots": 12,
      "maxSpots": 15,
      "image": "https://picsum.photos/80/80?random=1&keyword=yoga",
      "day": 0
    },
    {
      "id": 2,
      "name": "HIIT Bootcamp",
      "instructor": "Mike Chen",
      "time": "08:30",
      "duration": 45,
      "category": "HIIT",
      "level": "Intermediate",
      "spots": 8,
      "maxSpots": 10,
      "image": "https://picsum.photos/80/80?random=2&keyword=fitness",
      "day": 0
    },
    {
      "id": 3,
      "name": "Strength Training",
      "instructor": "David Wilson",
      "time": "18:00",
      "duration": 75,
      "category": "Strength",
      "level": "Advanced",
      "spots": 6,
      "maxSpots": 8,
      "image": "https://picsum.photos/80/80?random=3&keyword=strength",
      "day": 0
    },
    {
      "id": 4,
      "name": "Evening Pilates",
      "instructor": "Emma Davis",
      "time": "19:30",
      "duration": 50,
      "category": "Pilates",
      "level": "Beginner",
      "spots": 10,
      "maxSpots": 12,
      "image": "https://picsum.photos/80/80?random=4&keyword=pilates",
      "day": 1
    },
    {
      "id": 5,
      "name": "Cardio Blast",
      "instructor": "Lisa Rodriguez",
      "time": "17:00",
      "duration": 40,
      "category": "Cardio",
      "level": "Intermediate",
      "spots": 15,
      "maxSpots": 20,
      "image": "https://picsum.photos/80/80?random=5&keyword=cardio",
      "day": 2
    }
  ];

  List<Map<String, dynamic>> get filteredClasses {
    return classes.where((classItem) {
      bool dayMatch = (classItem["day"] as int) == selectedDay;
      bool categoryMatch = selectedCategory == "All" || (classItem["category"] as String) == selectedCategory;
      
      bool timeMatch = true;
      if (selectedTimeSlot != "All") {
        String time = classItem["time"] as String;
        int hour = int.parse(time.split(':')[0]);
        
        if (selectedTimeSlot == "Morning" && (hour < 6 || hour >= 12)) timeMatch = false;
        if (selectedTimeSlot == "Afternoon" && (hour < 12 || hour >= 18)) timeMatch = false;
        if (selectedTimeSlot == "Evening" && (hour < 18 || hour >= 24)) timeMatch = false;
      }
      
      return dayMatch && categoryMatch && timeMatch;
    }).toList();
  }

  Color _getLevelColor(String level) {
    switch (level) {
      case "Beginner": return successColor;
      case "Intermediate": return warningColor;
      case "Advanced": return dangerColor;
      default: return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Class Schedule"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_month),
            onPressed: () {
              // Navigate to calendar view
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Day selector
            Container(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: days.length,
                itemBuilder: (context, index) {
                  bool isSelected = selectedDay == index;
                  return Container(
                    margin: EdgeInsets.only(right: spSm),
                    child: GestureDetector(
                      onTap: () {
                        selectedDay = index;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledOutlineBorderColor,
                          ),
                          boxShadow: isSelected ? [shadowSm] : [],
                        ),
                        child: Center(
                          child: Text(
                            days[index],
                            style: TextStyle(
                              color: isSelected ? Colors.white : disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Time",
                    items: timeSlots.map((slot) => {
                      "label": slot,
                      "value": slot,
                    }).toList(),
                    value: selectedTimeSlot,
                    onChanged: (value, label) {
                      selectedTimeSlot = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categories.map((category) => {
                      "label": category,
                      "value": category,
                    }).toList(),
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Classes list
            Text(
              "Available Classes (${filteredClasses.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            if (filteredClasses.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.event_busy,
                      size: 48,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No classes available",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your filters or select a different day",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            
            ...filteredClasses.map((classItem) {
              int availableSpots = (classItem["maxSpots"] as int) - (classItem["spots"] as int);
              bool isFullyBooked = availableSpots <= 0;
              Color levelColor = _getLevelColor(classItem["level"] as String);
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${classItem["image"]}",
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    
                    SizedBox(width: spSm),
                    
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${classItem["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: levelColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${classItem["level"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: levelColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spXs),
                          
                          Text(
                            "with ${classItem["instructor"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          
                          SizedBox(height: spXs),
                          
                          Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${classItem["time"]} (${classItem["duration"]} min)",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.people,
                                size: 16,
                                color: isFullyBooked ? dangerColor : successColor,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "$availableSpots spots left",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isFullyBooked ? dangerColor : successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: isFullyBooked ? "Fully Booked" : "Book Class",
                              size: bs.sm,
                              onPressed: isFullyBooked ? null : () {
                                // Navigate to booking
                              },
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
    );
  }
}
