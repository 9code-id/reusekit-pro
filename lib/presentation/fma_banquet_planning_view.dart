import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaBanquetPlanningView extends StatefulWidget {
  const FmaBanquetPlanningView({super.key});

  @override
  State<FmaBanquetPlanningView> createState() => _FmaBanquetPlanningViewState();
}

class _FmaBanquetPlanningViewState extends State<FmaBanquetPlanningView> {
  int currentTab = 0;
  String selectedEventType = "wedding";
  String selectedVenue = "grand_hall";
  String eventName = "";
  String clientName = "";
  String eventDate = "";
  String eventTime = "";
  int guestCount = 0;
  String specialRequests = "";
  String menuType = "buffet";
  String selectedTheme = "elegant";

  List<Map<String, dynamic>> eventTypes = [
    {"label": "Wedding", "value": "wedding"},
    {"label": "Corporate Event", "value": "corporate"},
    {"label": "Birthday Party", "value": "birthday"},
    {"label": "Anniversary", "value": "anniversary"},
    {"label": "Conference", "value": "conference"},
    {"label": "Graduation", "value": "graduation"},
  ];

  List<Map<String, dynamic>> venues = [
    {"label": "Grand Hall", "value": "grand_hall"},
    {"label": "Garden Pavilion", "value": "garden"},
    {"label": "Rooftop Terrace", "value": "rooftop"},
    {"label": "Ballroom", "value": "ballroom"},
    {"label": "Conference Center", "value": "conference_center"},
  ];

  List<Map<String, dynamic>> menuTypes = [
    {"label": "Buffet Style", "value": "buffet"},
    {"label": "Plated Service", "value": "plated"},
    {"label": "Family Style", "value": "family"},
    {"label": "Cocktail Reception", "value": "cocktail"},
  ];

  List<Map<String, dynamic>> themes = [
    {"label": "Elegant", "value": "elegant"},
    {"label": "Rustic", "value": "rustic"},
    {"label": "Modern", "value": "modern"},
    {"label": "Traditional", "value": "traditional"},
    {"label": "Garden Party", "value": "garden"},
  ];

  List<Map<String, dynamic>> upcomingEvents = [
    {
      "id": 1,
      "name": "Johnson Wedding Reception",
      "date": "2025-06-25",
      "time": "18:00",
      "venue": "Grand Hall",
      "guests": 150,
      "status": "confirmed",
      "progress": 0.85,
      "color": successColor,
    },
    {
      "id": 2,
      "name": "TechCorp Annual Meeting",
      "date": "2025-06-28",
      "time": "09:00",
      "venue": "Conference Center",
      "guests": 200,
      "status": "planning",
      "progress": 0.45,
      "color": warningColor,
    },
    {
      "id": 3,
      "name": "Miller Anniversary Celebration",
      "date": "2025-07-02",
      "time": "19:30",
      "venue": "Garden Pavilion",
      "guests": 80,
      "status": "pending",
      "progress": 0.20,
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> menuItems = [
    {
      "category": "Appetizers",
      "items": [
        {"name": "Shrimp Cocktail", "price": 12.50, "selected": true},
        {"name": "Bruschetta", "price": 8.00, "selected": false},
        {"name": "Mini Quiches", "price": 10.00, "selected": true},
      ]
    },
    {
      "category": "Main Course",
      "items": [
        {"name": "Grilled Salmon", "price": 28.00, "selected": true},
        {"name": "Beef Tenderloin", "price": 35.00, "selected": false},
        {"name": "Chicken Marsala", "price": 22.00, "selected": true},
      ]
    },
    {
      "category": "Desserts",
      "items": [
        {"name": "Wedding Cake", "price": 8.00, "selected": true},
        {"name": "Chocolate Fountain", "price": 15.00, "selected": false},
        {"name": "Fruit Tart", "price": 6.50, "selected": false},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Banquet Planning",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Events", icon: Icon(Icons.event)),
        Tab(text: "New Event", icon: Icon(Icons.add_circle)),
        Tab(text: "Menu Selection", icon: Icon(Icons.restaurant_menu)),
        Tab(text: "Schedule", icon: Icon(Icons.schedule)),
      ],
      tabChildren: [
        _buildEventsTab(),
        _buildNewEventTab(),
        _buildMenuSelectionTab(),
        _buildScheduleTab(),
      ],
    );
  }

  Widget _buildEventsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Upcoming Events",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Column(
            spacing: spSm,
            children: upcomingEvents.map((event) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: event["color"] as Color,
                    ),
                  ),
                ),
                child: Column(
                  spacing: spXs,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${event["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: (event["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${event["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: event["color"] as Color,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${event["date"]} at ${event["time"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${event["venue"]} • ${event["guests"]} guests",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spXs),
                    
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Progress: ${((event["progress"] as double) * 100).toInt()}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: 4),
                              Container(
                                height: 6,
                                decoration: BoxDecoration(
                                  color: disabledColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: event["progress"] as double,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: event["color"] as Color,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          label: "Details",
                          size: bs.sm,
                          onPressed: () {
                            // Navigate to event details
                          },
                        ),
                      ],
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

  Widget _buildNewEventTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Create New Event",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                QTextField(
                  label: "Event Name",
                  value: eventName,
                  hint: "Enter event name",
                  onChanged: (value) {
                    eventName = value;
                    setState(() {});
                  },
                ),
                
                QTextField(
                  label: "Client Name",
                  value: clientName,
                  hint: "Enter client name",
                  onChanged: (value) {
                    clientName = value;
                    setState(() {});
                  },
                ),
                
                QDropdownField(
                  label: "Event Type",
                  items: eventTypes,
                  value: selectedEventType,
                  onChanged: (value, label) {
                    selectedEventType = value;
                    setState(() {});
                  },
                ),
                
                Row(
                  children: [
                    Expanded(
                      child: QDatePicker(
                        label: "Event Date",
                        value: eventDate.isNotEmpty 
                          ? DateTime.parse(eventDate) 
                          : DateTime.now(),
                        onChanged: (value) {
                          eventDate = value.toString().split(' ')[0];
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTimePicker(
                        label: "Event Time",
                        value: eventTime.isNotEmpty 
                          ? TimeOfDay.fromDateTime(DateTime.parse("2023-01-01 $eventTime"))
                          : TimeOfDay.now(),
                        onChanged: (value) {
                          eventTime = value!.kkmm;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                
                QDropdownField(
                  label: "Venue",
                  items: venues,
                  value: selectedVenue,
                  onChanged: (value, label) {
                    selectedVenue = value;
                    setState(() {});
                  },
                ),
                
                QNumberField(
                  label: "Guest Count",
                  value: guestCount.toString(),
                  onChanged: (value) {
                    guestCount = int.tryParse(value) ?? 0;
                    setState(() {});
                  },
                ),
                
                QDropdownField(
                  label: "Menu Type",
                  items: menuTypes,
                  value: menuType,
                  onChanged: (value, label) {
                    menuType = value;
                    setState(() {});
                  },
                ),
                
                QDropdownField(
                  label: "Theme",
                  items: themes,
                  value: selectedTheme,
                  onChanged: (value, label) {
                    selectedTheme = value;
                    setState(() {});
                  },
                ),
                
                QMemoField(
                  label: "Special Requests",
                  value: specialRequests,
                  hint: "Any special requirements or requests",
                  onChanged: (value) {
                    specialRequests = value;
                    setState(() {});
                  },
                ),
                
                SizedBox(height: spSm),
                
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Create Event",
                    onPressed: () {
                      ss("Event created successfully");
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSelectionTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Menu Selection",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Column(
            spacing: spSm,
            children: menuItems.map((category) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${category["category"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    
                    Column(
                      spacing: spXs,
                      children: (category["items"] as List).map((item) {
                        return Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: (item["selected"] as bool) 
                              ? primaryColor.withAlpha(10) 
                              : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusXs),
                            border: Border.all(
                              color: (item["selected"] as bool) 
                                ? primaryColor 
                                : disabledOutlineBorderColor,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                (item["selected"] as bool) 
                                  ? Icons.check_circle 
                                  : Icons.circle_outlined,
                                color: (item["selected"] as bool) 
                                  ? primaryColor 
                                  : disabledBoldColor,
                                size: 20,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${item["name"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${(item["price"] as double).toStringAsFixed(2)} per person",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  item["selected"] = !(item["selected"] as bool);
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  child: Icon(
                                    Icons.edit,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
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
            }).toList(),
          ),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(
                color: primaryColor,
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calculate,
                      color: primaryColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Estimated Cost",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Per Person:",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$48.50",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total (150 guests):",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$7,275.00",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
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

  Widget _buildScheduleTab() {
    List<Map<String, dynamic>> schedule = [
      {
        "time": "08:00",
        "task": "Setup begins",
        "description": "Tables, chairs, and decorations",
        "status": "completed",
      },
      {
        "time": "10:00",
        "task": "Kitchen preparation",
        "description": "Food prep and cooking begins",
        "status": "in_progress",
      },
      {
        "time": "15:00",
        "task": "Final setup",
        "description": "Table setting and final touches",
        "status": "pending",
      },
      {
        "time": "17:30",
        "task": "Staff briefing",
        "description": "Service instructions and assignments",
        "status": "pending",
      },
      {
        "time": "18:00",
        "task": "Event begins",
        "description": "Guest arrival and cocktail hour",
        "status": "pending",
      },
      {
        "time": "21:00",
        "task": "Cleanup begins",
        "description": "Post-event cleanup and breakdown",
        "status": "pending",
      },
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Event Schedule",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: schedule.map((item) {
                Color statusColor = item["status"] == "completed" 
                  ? successColor 
                  : item["status"] == "in_progress" 
                    ? warningColor 
                    : disabledBoldColor;
                    
                return Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        width: 3,
                        color: statusColor,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        child: Text(
                          "${item["time"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${item["task"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${item["description"]}",
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
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${item["status"]}".replaceAll("_", " ").toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
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
}
