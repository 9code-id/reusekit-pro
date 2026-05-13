import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaActivitySchedulerView extends StatefulWidget {
  const TtaActivitySchedulerView({super.key});

  @override
  State<TtaActivitySchedulerView> createState() => _TtaActivitySchedulerViewState();
}

class _TtaActivitySchedulerViewState extends State<TtaActivitySchedulerView> {
  DateTime selectedDate = DateTime.now();
  String selectedTimeSlot = "Morning";
  String filterCategory = "All";
  bool showAvailableOnly = true;
  
  final List<String> timeSlots = [
    "Early Morning",
    "Morning", 
    "Afternoon",
    "Evening",
    "Night"
  ];

  final List<String> categories = [
    "All",
    "Sightseeing",
    "Dining",
    "Adventure",
    "Culture",
    "Nature",
    "Entertainment",
    "Shopping"
  ];

  final List<Map<String, dynamic>> availableActivities = [
    {
      "id": 1,
      "name": "Sunrise Yoga Session",
      "category": "Nature",
      "description": "Start your day with peaceful yoga overlooking rice terraces",
      "duration": 90,
      "timeSlots": ["Early Morning"],
      "cost": 25.0,
      "location": "Tegallalang Rice Terraces",
      "provider": "Bali Yoga Studio",
      "rating": 4.8,
      "reviews": 156,
      "image": "https://picsum.photos/300/200?random=51&keyword=yoga",
      "availability": {
        "slots": ["06:00", "06:30"],
        "maxParticipants": 15,
        "currentBookings": 8,
      },
      "requirements": ["Yoga mat provided", "Comfortable clothes"],
      "includes": ["Yoga mat", "Herbal tea", "Light breakfast"],
    },
    {
      "id": 2,
      "name": "Traditional Cooking Class",
      "category": "Culture",
      "description": "Learn to cook authentic Balinese dishes with local chef",
      "duration": 180,
      "timeSlots": ["Morning", "Afternoon"],
      "cost": 65.0,
      "location": "Ubud Cooking School",
      "provider": "Casa Luna Cooking School",
      "rating": 4.9,
      "reviews": 523,
      "image": "https://picsum.photos/300/200?random=52&keyword=cooking",
      "availability": {
        "slots": ["09:00", "14:00"],
        "maxParticipants": 12,
        "currentBookings": 7,
      },
      "requirements": ["No experience needed", "Apron provided"],
      "includes": ["All ingredients", "Recipe book", "Full meal"],
    },
    {
      "id": 3,
      "name": "Waterfall Trekking Adventure",
      "category": "Adventure",
      "description": "Guided trek to hidden waterfalls with swimming opportunity",
      "duration": 240,
      "timeSlots": ["Morning", "Afternoon"],
      "cost": 45.0,
      "location": "Sekumpul Waterfall",
      "provider": "Bali Adventure Tours",
      "rating": 4.7,
      "reviews": 289,
      "image": "https://picsum.photos/300/200?random=53&keyword=waterfall",
      "availability": {
        "slots": ["08:00", "13:00"],
        "maxParticipants": 20,
        "currentBookings": 15,
      },
      "requirements": ["Good fitness level", "Swimming ability optional"],
      "includes": ["Guide", "Safety equipment", "Light snacks"],
    },
    {
      "id": 4,
      "name": "Temple Blessing Ceremony",
      "category": "Culture",
      "description": "Participate in traditional Balinese blessing ceremony",
      "duration": 120,
      "timeSlots": ["Morning", "Evening"],
      "cost": 35.0,
      "location": "Tirta Empul Temple",
      "provider": "Sacred Bali Tours",
      "rating": 4.6,
      "reviews": 198,
      "image": "https://picsum.photos/300/200?random=54&keyword=temple",
      "availability": {
        "slots": ["10:00", "17:00"],
        "maxParticipants": 25,
        "currentBookings": 12,
      },
      "requirements": ["Sarong and sash required", "Respectful attire"],
      "includes": ["Sarong rental", "Offering basket", "Guide"],
    },
    {
      "id": 5,
      "name": "Sunset Dinner Cruise",
      "category": "Entertainment",
      "description": "Romantic dinner cruise with live music and sunset views",
      "duration": 180,
      "timeSlots": ["Evening"],
      "cost": 85.0,
      "location": "Benoa Harbor",
      "provider": "Bali Sunset Cruises",
      "rating": 4.5,
      "reviews": 412,
      "image": "https://picsum.photos/300/200?random=55&keyword=cruise",
      "availability": {
        "slots": ["17:30"],
        "maxParticipants": 50,
        "currentBookings": 23,
      },
      "requirements": ["Smart casual dress code"],
      "includes": ["3-course dinner", "Welcome drink", "Live entertainment"],
    },
    {
      "id": 6,
      "name": "Art Village Tour",
      "category": "Sightseeing",
      "description": "Visit traditional art villages and meet local artisans",
      "duration": 300,
      "timeSlots": ["Morning", "Afternoon"],
      "cost": 55.0,
      "location": "Mas & Ubud Villages",
      "provider": "Cultural Heritage Tours",
      "rating": 4.4,
      "reviews": 167,
      "image": "https://picsum.photos/300/200?random=56&keyword=art",
      "availability": {
        "slots": ["09:00", "14:00"],
        "maxParticipants": 18,
        "currentBookings": 18,
      },
      "requirements": ["Walking comfortable"],
      "includes": ["Transportation", "Guide", "Village entrance fees"],
    },
  ];

  List<Map<String, dynamic>> get filteredActivities {
    var filtered = availableActivities;
    
    // Filter by category
    if (filterCategory != "All") {
      filtered = filtered.where((activity) => 
        activity["category"] == filterCategory).toList();
    }
    
    // Filter by time slot
    filtered = filtered.where((activity) => 
      (activity["timeSlots"] as List<String>).contains(selectedTimeSlot)).toList();
    
    // Filter by availability
    if (showAvailableOnly) {
      filtered = filtered.where((activity) {
        final availability = activity["availability"] as Map<String, dynamic>;
        return (availability["currentBookings"] as int) < (availability["maxParticipants"] as int);
      }).toList();
    }
    
    return filtered;
  }

  String getTimeSlotRange(String timeSlot) {
    switch (timeSlot) {
      case "Early Morning": return "05:00 - 08:00";
      case "Morning": return "08:00 - 12:00";
      case "Afternoon": return "12:00 - 17:00";
      case "Evening": return "17:00 - 21:00";
      case "Night": return "21:00 - 00:00";
      default: return "";
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Sightseeing": return primaryColor;
      case "Dining": return dangerColor;
      case "Adventure": return infoColor;
      case "Culture": return warningColor;
      case "Nature": return successColor;
      case "Entertainment": return Colors.purple;
      case "Shopping": return Colors.pink;
      default: return disabledBoldColor;
    }
  }

  void scheduleActivity(Map<String, dynamic> activity, String timeSlot) {
    // Here you would typically add the activity to the user's schedule
    ss("${activity["name"]} scheduled for ${selectedDate.dMMMy} $timeSlot");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Activity Scheduler"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.calendar_today),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_list),
          ),
        ],
      ),
      body: Column(
        children: [
          // Date and Time Selection
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date Picker
                Row(
                  children: [
                    Expanded(
                      child: QDatePicker(
                        label: "Select Date",
                        value: selectedDate,
                        onChanged: (value) {
                          selectedDate = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: categories.map((category) => {
                          "label": category,
                          "value": category,
                        }).toList(),
                        value: filterCategory,
                        onChanged: (value, label) {
                          filterCategory = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Filters
                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Show available only",
                            "value": true,
                            "checked": showAvailableOnly,
                          }
                        ],
                        value: [
                          if (showAvailableOnly) {
                            "label": "Show available only",
                            "value": true,
                            "checked": true
                          }
                        ],
                        onChanged: (values, ids) {
                          showAvailableOnly = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Time Slot Selector
          Container(
            height: 80,
            padding: EdgeInsets.symmetric(vertical: spSm),
            child: QHorizontalScroll(
              children: timeSlots.map((timeSlot) {
                final isSelected = selectedTimeSlot == timeSlot;
                final activityCount = availableActivities
                  .where((activity) => 
                    (activity["timeSlots"] as List<String>).contains(timeSlot))
                  .length;
                
                return GestureDetector(
                  onTap: () {
                    selectedTimeSlot = timeSlot;
                    setState(() {});
                  },
                  child: Container(
                    width: 120,
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                      boxShadow: isSelected ? [shadowSm] : [],
                    ),
                    child: Column(
                      children: [
                        Text(
                          timeSlot,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 4),
                        Text(
                          getTimeSlotRange(timeSlot),
                          style: TextStyle(
                            fontSize: 10,
                            color: isSelected ? Colors.white.withValues(alpha: 0.8) : disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "$activityCount activities",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Activities List
          Expanded(
            child: filteredActivities.isEmpty ?
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.event_busy,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No activities available",
                      style: TextStyle(
                        fontSize: fsH6,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try selecting a different time slot or category",
                      style: TextStyle(
                        color: disabledColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ) :
              ListView.builder(
                padding: EdgeInsets.all(spMd),
                itemCount: filteredActivities.length,
                itemBuilder: (context, index) {
                  final activity = filteredActivities[index];
                  final availability = activity["availability"] as Map<String, dynamic>;
                  final isFullyBooked = (availability["currentBookings"] as int) >= 
                    (availability["maxParticipants"] as int);
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        // Image Header
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusMd),
                                topRight: Radius.circular(radiusMd),
                              ),
                              child: AspectRatio(
                                aspectRatio: 16/9,
                                child: Image.network(
                                  "${activity["image"]}",
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            
                            // Category Badge
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _getCategoryColor(activity["category"] as String),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${activity["category"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            
                            // Availability Badge
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: isFullyBooked ? dangerColor : successColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  isFullyBooked ? "FULL" : "AVAILABLE",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Content
                        Padding(
                          padding: EdgeInsets.all(spMd),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title and Rating
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${activity["name"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: warningColor,
                                        size: 16,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${activity["rating"]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        " (${activity["reviews"]})",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: spSm),
                              
                              // Description
                              Text(
                                "${activity["description"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                ),
                              ),
                              
                              SizedBox(height: spMd),
                              
                              // Details Row
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 16,
                                    color: infoColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${activity["duration"]} min",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: infoColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: spMd),
                                  Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      "${activity["location"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: spSm),
                              
                              // Provider
                              Text(
                                "by ${activity["provider"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              
                              SizedBox(height: spMd),
                              
                              // Available Slots
                              Text(
                                "Available Time Slots:",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4),
                              Wrap(
                                spacing: spSm,
                                children: (availability["slots"] as List<String>).map((slot) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      slot,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              
                              SizedBox(height: spMd),
                              
                              // Includes
                              if ((activity["includes"] as List<String>).isNotEmpty)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Includes:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    ...((activity["includes"] as List<String>).map((include) {
                                      return Row(
                                        children: [
                                          Icon(
                                            Icons.check,
                                            size: 14,
                                            color: successColor,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            include,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList()),
                                    SizedBox(height: spMd),
                                  ],
                                ),
                              
                              // Booking Info and Price
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${availability["currentBookings"]}/${availability["maxParticipants"]} booked",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "\$${(activity["cost"] as double).toStringAsFixed(0)} per person",
                                          style: TextStyle(
                                            fontSize: fsH6,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  QButton(
                                    label: isFullyBooked ? "Fully Booked" : "Schedule",
                                    size: bs.sm,
                                    onPressed: isFullyBooked ? null : () {
                                      scheduleActivity(activity, selectedTimeSlot);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
          ),
        ],
      ),
    );
  }
}
