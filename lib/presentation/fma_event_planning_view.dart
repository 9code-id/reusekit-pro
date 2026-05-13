import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaEventPlanningView extends StatefulWidget {
  const FmaEventPlanningView({super.key});

  @override
  State<FmaEventPlanningView> createState() => _FmaEventPlanningViewState();
}

class _FmaEventPlanningViewState extends State<FmaEventPlanningView> {
  int currentTab = 0;
  
  // Event Creation Variables
  String eventName = "";
  String eventDescription = "";
  String eventType = "special_dinner";
  String eventDate = "";
  String eventTime = "";
  String duration = "3";
  String capacity = "";
  String ticketPrice = "";
  String depositRequired = "";
  String specialRequirements = "";
  String cateringPackage = "";
  bool requiresBooking = true;
  bool isPrivateEvent = false;
  
  // Venue Setup Variables
  String venueName = "";
  String venueCapacity = "";
  String venueDescription = "";
  String setupType = "banquet";
  String tableArrangement = "round_tables";
  List<String> amenities = [];
  String rentalPrice = "";
  
  // Catering Variables
  String menuPackage = "";
  String serviceStyle = "buffet";
  String guestCount = "";
  List<String> dietaryRequirements = [];
  String beveragePackage = "";
  String additionalServices = "";
  
  // Staff Assignment Variables
  String eventCoordinator = "";
  String headChef = "";
  String serviceStaff = "";
  String setupCrew = "";
  String cleanupCrew = "";
  String securityStaff = "";
  
  // Sample Data
  List<Map<String, dynamic>> events = [
    {
      "id": 1,
      "name": "Summer Wine Tasting",
      "type": "wine_tasting",
      "date": "2024-06-25",
      "time": "19:00",
      "duration": 4,
      "capacity": 50,
      "booked": 38,
      "ticket_price": 75.0,
      "revenue": 2850.0,
      "status": "confirmed",
      "venue": "Main Dining Hall",
      "coordinator": "Sarah Johnson"
    },
    {
      "id": 2,
      "name": "Corporate Team Building Dinner",
      "type": "corporate_event",
      "date": "2024-06-28",
      "time": "18:30",
      "duration": 3,
      "capacity": 80,
      "booked": 75,
      "ticket_price": 120.0,
      "revenue": 9000.0,
      "status": "confirmed",
      "venue": "Private Banquet Room",
      "coordinator": "Mike Davis"
    },
    {
      "id": 3,
      "name": "Chef's Table Experience",
      "type": "chef_table",
      "date": "2024-06-30",
      "time": "20:00",
      "duration": 2.5,
      "capacity": 12,
      "booked": 12,
      "ticket_price": 250.0,
      "revenue": 3000.0,
      "status": "sold_out",
      "venue": "Chef's Private Kitchen",
      "coordinator": "Emma Wilson"
    },
    {
      "id": 4,
      "name": "Birthday Party Celebration",
      "type": "birthday_party",
      "date": "2024-07-02",
      "time": "15:00",
      "duration": 4,
      "capacity": 30,
      "booked": 25,
      "ticket_price": 45.0,
      "revenue": 1125.0,
      "status": "confirmed",
      "venue": "Garden Terrace",
      "coordinator": "Lisa Chen"
    },
  ];

  List<Map<String, dynamic>> venues = [
    {
      "id": 1,
      "name": "Main Dining Hall",
      "capacity": 120,
      "rental_price": 500.0,
      "setup_type": "flexible",
      "amenities": ["sound_system", "projector", "kitchen_access", "bar"],
      "bookings_count": 15,
      "revenue": 7500.0,
      "rating": 4.8,
      "description": "Elegant main dining space with full kitchen access"
    },
    {
      "id": 2,
      "name": "Private Banquet Room",
      "capacity": 80,
      "rental_price": 750.0,
      "setup_type": "banquet",
      "amenities": ["private_bar", "sound_system", "dance_floor", "stage"],
      "bookings_count": 8,
      "revenue": 6000.0,
      "rating": 4.9,
      "description": "Intimate space perfect for corporate events and celebrations"
    },
    {
      "id": 3,
      "name": "Garden Terrace",
      "capacity": 60,
      "rental_price": 400.0,
      "setup_type": "outdoor",
      "amenities": ["garden_view", "canopy", "heaters", "string_lights"],
      "bookings_count": 22,
      "revenue": 8800.0,
      "rating": 4.7,
      "description": "Beautiful outdoor space with garden views"
    },
    {
      "id": 4,
      "name": "Chef's Private Kitchen",
      "capacity": 16,
      "rental_price": 300.0,
      "setup_type": "chef_table",
      "amenities": ["open_kitchen", "wine_storage", "chef_interaction"],
      "bookings_count": 12,
      "revenue": 3600.0,
      "rating": 5.0,
      "description": "Exclusive chef's table experience with kitchen interaction"
    },
  ];

  List<Map<String, dynamic>> cateringPackages = [
    {
      "id": 1,
      "name": "Gourmet Dinner Package",
      "price_per_person": 85.0,
      "service_style": "plated",
      "courses": 5,
      "includes": ["appetizer", "soup", "main", "dessert", "coffee"],
      "orders": 45,
      "revenue": 3825.0,
      "rating": 4.9
    },
    {
      "id": 2,
      "name": "Buffet Feast",
      "price_per_person": 65.0,
      "service_style": "buffet",
      "courses": 4,
      "includes": ["salads", "mains", "sides", "desserts"],
      "orders": 32,
      "revenue": 2080.0,
      "rating": 4.6
    },
    {
      "id": 3,
      "name": "Cocktail Reception",
      "price_per_person": 45.0,
      "service_style": "standing",
      "courses": 3,
      "includes": ["canapés", "finger_foods", "beverages"],
      "orders": 28,
      "revenue": 1260.0,
      "rating": 4.7
    },
    {
      "id": 4,
      "name": "Family Style Meal",
      "price_per_person": 55.0,
      "service_style": "family",
      "courses": 4,
      "includes": ["shared_appetizers", "main_dishes", "sides", "dessert"],
      "orders": 18,
      "revenue": 990.0,
      "rating": 4.8
    },
  ];

  List<Map<String, dynamic>> staffAssignments = [
    {
      "id": 1,
      "event": "Summer Wine Tasting",
      "coordinator": "Sarah Johnson",
      "chef": "Gordon Martinez",
      "service_staff": 4,
      "setup_crew": 2,
      "security": 1,
      "total_cost": 850.0,
      "status": "assigned"
    },
    {
      "id": 2,
      "event": "Corporate Team Building Dinner",
      "coordinator": "Mike Davis",
      "chef": "Julia Roberts",
      "service_staff": 6,
      "setup_crew": 3,
      "security": 2,
      "total_cost": 1200.0,
      "status": "assigned"
    },
    {
      "id": 3,
      "event": "Chef's Table Experience",
      "coordinator": "Emma Wilson",
      "chef": "Gordon Martinez",
      "service_staff": 2,
      "setup_crew": 1,
      "security": 0,
      "total_cost": 650.0,
      "status": "assigned"
    },
    {
      "id": 4,
      "event": "Birthday Party Celebration",
      "coordinator": "Lisa Chen",
      "chef": "Maria Rodriguez",
      "service_staff": 3,
      "setup_crew": 2,
      "security": 1,
      "total_cost": 750.0,
      "status": "pending"
    },
  ];

  List<Map<String, dynamic>> eventTypeOptions = [
    {"label": "Special Dinner", "value": "special_dinner"},
    {"label": "Wine Tasting", "value": "wine_tasting"},
    {"label": "Corporate Event", "value": "corporate_event"},
    {"label": "Birthday Party", "value": "birthday_party"},
    {"label": "Wedding Reception", "value": "wedding"},
    {"label": "Chef's Table", "value": "chef_table"},
    {"label": "Cooking Class", "value": "cooking_class"},
    {"label": "Holiday Celebration", "value": "holiday"},
  ];

  List<Map<String, dynamic>> setupTypeOptions = [
    {"label": "Banquet Style", "value": "banquet"},
    {"label": "Theater Style", "value": "theater"},
    {"label": "Cocktail Reception", "value": "cocktail"},
    {"label": "Chef's Table", "value": "chef_table"},
    {"label": "Outdoor Setup", "value": "outdoor"},
    {"label": "Flexible Space", "value": "flexible"},
  ];

  List<Map<String, dynamic>> tableArrangementOptions = [
    {"label": "Round Tables", "value": "round_tables"},
    {"label": "Long Tables", "value": "long_tables"},
    {"label": "U-Shape", "value": "u_shape"},
    {"label": "Classroom Style", "value": "classroom"},
    {"label": "Theater Style", "value": "theater"},
    {"label": "Standing Only", "value": "standing"},
  ];

  List<Map<String, dynamic>> serviceStyleOptions = [
    {"label": "Buffet Service", "value": "buffet"},
    {"label": "Plated Service", "value": "plated"},
    {"label": "Family Style", "value": "family"},
    {"label": "Cocktail Reception", "value": "cocktail"},
    {"label": "Standing Reception", "value": "standing"},
  ];

  List<Map<String, dynamic>> coordinatorOptions = [
    {"label": "Sarah Johnson", "value": "sarah_johnson"},
    {"label": "Mike Davis", "value": "mike_davis"},
    {"label": "Emma Wilson", "value": "emma_wilson"},
    {"label": "Lisa Chen", "value": "lisa_chen"},
    {"label": "David Brown", "value": "david_brown"},
  ];

  List<Map<String, dynamic>> chefOptions = [
    {"label": "Gordon Martinez", "value": "gordon_martinez"},
    {"label": "Julia Roberts", "value": "julia_roberts"},
    {"label": "Maria Rodriguez", "value": "maria_rodriguez"},
    {"label": "Anthony Kim", "value": "anthony_kim"},
    {"label": "Sophie Turner", "value": "sophie_turner"},
  ];

  void _createEvent() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    ss("Event '${eventName}' created successfully");
    
    // Reset form
    eventName = "";
    eventDescription = "";
    eventType = "special_dinner";
    eventDate = "";
    eventTime = "";
    duration = "3";
    capacity = "";
    ticketPrice = "";
    depositRequired = "";
    specialRequirements = "";
    cateringPackage = "";
    requiresBooking = true;
    isPrivateEvent = false;
    setState(() {});
  }

  void _saveVenue() async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    ss("Venue '${venueName}' saved successfully");
    
    // Reset form
    venueName = "";
    venueCapacity = "";
    venueDescription = "";
    setupType = "banquet";
    tableArrangement = "round_tables";
    amenities = [];
    rentalPrice = "";
    setState(() {});
  }

  void _saveCateringPackage() async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    ss("Catering package saved successfully");
    
    // Reset form
    menuPackage = "";
    serviceStyle = "buffet";
    guestCount = "";
    dietaryRequirements = [];
    beveragePackage = "";
    additionalServices = "";
    setState(() {});
  }

  void _assignStaff() async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    ss("Staff assigned successfully");
    
    // Reset form
    eventCoordinator = "";
    headChef = "";
    serviceStaff = "";
    setupCrew = "";
    cleanupCrew = "";
    securityStaff = "";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Event Planning",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Events", icon: Icon(Icons.event)),
        Tab(text: "Venues", icon: Icon(Icons.place)),
        Tab(text: "Catering", icon: Icon(Icons.restaurant)),
        Tab(text: "Staff", icon: Icon(Icons.people)),
      ],
      tabChildren: [
        _buildEventsTab(),
        _buildVenuesTab(),
        _buildCateringTab(),
        _buildStaffTab(),
      ],
    );
  }

  Widget _buildEventsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Event Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Total Events", "${events.length}", Icons.event, primaryColor),
              _buildStatCard("Confirmed", "${events.where((e) => e["status"] == "confirmed").length}", Icons.check_circle, successColor),
              _buildStatCard("Total Revenue", "\$${(events.fold(0.0, (sum, e) => sum + (e["revenue"] as double))).currency}", Icons.attach_money, warningColor),
              _buildStatCard("Avg. Capacity", "${(events.fold(0, (sum, e) => sum + (e["capacity"] as int)) / events.length).toStringAsFixed(0)}", Icons.people, infoColor),
            ],
          ),

          // Create Event Form
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Create New Event",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Event Name",
                        value: eventName,
                        hint: "Enter event name",
                        onChanged: (value) {
                          eventName = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Event Type",
                        items: eventTypeOptions,
                        value: eventType,
                        onChanged: (value, label) {
                          eventType = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                QMemoField(
                  label: "Event Description",
                  value: eventDescription,
                  hint: "Describe the event details and special features",
                  onChanged: (value) {
                    eventDescription = value;
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
                            ? eventTime.timeOfDay 
                            : TimeOfDay.now(),
                        onChanged: (value) {
                          eventTime = value!.kkmm;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Duration (hours)",
                        value: duration,
                        onChanged: (value) {
                          duration = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QNumberField(
                        label: "Capacity",
                        value: capacity,
                        onChanged: (value) {
                          capacity = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Ticket Price (\$)",
                        value: ticketPrice,
                        onChanged: (value) {
                          ticketPrice = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QNumberField(
                        label: "Deposit Required (\$)",
                        value: depositRequired,
                        onChanged: (value) {
                          depositRequired = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                QMemoField(
                  label: "Special Requirements",
                  value: specialRequirements,
                  hint: "Any special dietary, setup, or service requirements",
                  onChanged: (value) {
                    specialRequirements = value;
                    setState(() {});
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Requires advance booking",
                            "value": true,
                            "checked": requiresBooking,
                          }
                        ],
                        value: [
                          if (requiresBooking)
                            {
                              "label": "Requires advance booking",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          requiresBooking = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Private event (invitation only)",
                            "value": true,
                            "checked": isPrivateEvent,
                          }
                        ],
                        value: [
                          if (isPrivateEvent)
                            {
                              "label": "Private event (invitation only)",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          isPrivateEvent = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Create Event",
                        icon: Icons.add,
                        onPressed: _createEvent,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Events List
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Upcoming Events",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ...events.map((event) {
                  Color statusColor = event["status"] == "confirmed" 
                      ? successColor 
                      : event["status"] == "sold_out"
                          ? warningColor 
                          : disabledBoldColor;
                  
                  double bookingPercentage = ((event["booked"] as int) / (event["capacity"] as int)) * 100;
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${event["name"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                              decoration: BoxDecoration(
                                color: statusColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${event["status"]}".replaceAll("_", " ").toUpperCase(),
                                style: TextStyle(
                                  color: statusColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${event["type"]}".replaceAll("_", " ").toUpperCase(),
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${event["date"]} at ${event["time"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Icon(Icons.place, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${event["venue"]}",
                              style: TextStyle(fontSize: 12, color: disabledBoldColor),
                            ),
                            SizedBox(width: spSm),
                            Icon(Icons.person, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${event["coordinator"]}",
                              style: TextStyle(fontSize: 12, color: disabledBoldColor),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Bookings: ${(event["booked"] as int).toString()}/${(event["capacity"] as int).toString()}",
                                    style: TextStyle(fontSize: 12, color: disabledBoldColor),
                                  ),
                                  SizedBox(height: spXs),
                                  LinearProgressIndicator(
                                    value: bookingPercentage / 100,
                                    backgroundColor: disabledOutlineBorderColor,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      bookingPercentage > 90 ? warningColor : primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "\$${(event["revenue"] as double).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Spacer(),
                            QButton(
                              label: "Edit",
                              size: bs.sm,
                              onPressed: () => si("Editing event: ${event["name"]}"),
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              label: "Manage",
                              size: bs.sm,
                              onPressed: () => si("Managing event bookings"),
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              icon: Icons.analytics,
                              size: bs.sm,
                              onPressed: () => si("Viewing event analytics"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVenuesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Venue Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Total Venues", "${venues.length}", Icons.place, primaryColor),
              _buildStatCard("Total Bookings", "${venues.fold(0, (sum, v) => sum + (v["bookings_count"] as int))}", Icons.event_available, successColor),
              _buildStatCard("Total Revenue", "\$${(venues.fold(0.0, (sum, v) => sum + (v["revenue"] as double))).currency}", Icons.attach_money, warningColor),
              _buildStatCard("Avg. Rating", "${(venues.fold(0.0, (sum, v) => sum + (v["rating"] as double)) / venues.length).toStringAsFixed(1)}", Icons.star, infoColor),
            ],
          ),

          // Add Venue Form
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Add New Venue",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Venue Name",
                        value: venueName,
                        hint: "Enter venue name",
                        onChanged: (value) {
                          venueName = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QNumberField(
                        label: "Capacity",
                        value: venueCapacity,
                        onChanged: (value) {
                          venueCapacity = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                QMemoField(
                  label: "Venue Description",
                  value: venueDescription,
                  hint: "Describe the venue features and atmosphere",
                  onChanged: (value) {
                    venueDescription = value;
                    setState(() {});
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Setup Type",
                        items: setupTypeOptions,
                        value: setupType,
                        onChanged: (value, label) {
                          setupType = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Table Arrangement",
                        items: tableArrangementOptions,
                        value: tableArrangement,
                        onChanged: (value, label) {
                          tableArrangement = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                QNumberField(
                  label: "Rental Price (\$)",
                  value: rentalPrice,
                  onChanged: (value) {
                    rentalPrice = value;
                    setState(() {});
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Save Venue",
                        icon: Icons.add,
                        onPressed: _saveVenue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Venues List
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Available Venues",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: venues.map((venue) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledOutlineBorderColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${venue["name"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star, size: 16, color: warningColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${(venue["rating"] as double).toStringAsFixed(1)}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: warningColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          
                          Text(
                            "${venue["description"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),

                          Row(
                            children: [
                              Icon(Icons.people, size: 16, color: primaryColor),
                              SizedBox(width: spXs),
                              Text(
                                "${(venue["capacity"] as int).toString()} guests",
                                style: TextStyle(fontSize: 12, color: primaryColor),
                              ),
                              Spacer(),
                              Text(
                                "\$${(venue["rental_price"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),

                          Wrap(
                            spacing: spXs,
                            children: (venue["amenities"] as List).take(3).map((amenity) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${amenity}".replaceAll("_", " "),
                                  style: TextStyle(
                                    color: infoColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),

                          Row(
                            children: [
                              Text(
                                "${(venue["bookings_count"] as int).toString()} bookings",
                                style: TextStyle(fontSize: 12, color: disabledBoldColor),
                              ),
                              Spacer(),
                              Text(
                                "\$${(venue["revenue"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "Book",
                                  size: bs.sm,
                                  onPressed: () => si("Booking venue: ${venue["name"]}"),
                                ),
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                icon: Icons.edit,
                                size: bs.sm,
                                onPressed: () => si("Editing venue"),
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
          ),
        ],
      ),
    );
  }

  Widget _buildCateringTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Catering Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Total Packages", "${cateringPackages.length}", Icons.restaurant_menu, primaryColor),
              _buildStatCard("Total Orders", "${cateringPackages.fold(0, (sum, c) => sum + (c["orders"] as int))}", Icons.shopping_cart, successColor),
              _buildStatCard("Total Revenue", "\$${(cateringPackages.fold(0.0, (sum, c) => sum + (c["revenue"] as double))).currency}", Icons.attach_money, warningColor),
              _buildStatCard("Avg. Rating", "${(cateringPackages.fold(0.0, (sum, c) => sum + (c["rating"] as double)) / cateringPackages.length).toStringAsFixed(1)}", Icons.star, infoColor),
            ],
          ),

          // Create Catering Package Form
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Create Catering Package",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Package Name",
                        value: menuPackage,
                        hint: "Enter package name",
                        onChanged: (value) {
                          menuPackage = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Service Style",
                        items: serviceStyleOptions,
                        value: serviceStyle,
                        onChanged: (value, label) {
                          serviceStyle = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Guest Count",
                        value: guestCount,
                        onChanged: (value) {
                          guestCount = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTextField(
                        label: "Beverage Package",
                        value: beveragePackage,
                        hint: "Wine, beer, cocktails, etc.",
                        onChanged: (value) {
                          beveragePackage = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                QMemoField(
                  label: "Additional Services",
                  value: additionalServices,
                  hint: "Special equipment, decorations, entertainment, etc.",
                  onChanged: (value) {
                    additionalServices = value;
                    setState(() {});
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Save Package",
                        icon: Icons.add,
                        onPressed: _saveCateringPackage,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Catering Packages List
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Catering Packages",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: cateringPackages.map((package) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledOutlineBorderColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${package["name"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star, size: 16, color: warningColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${(package["rating"] as double).toStringAsFixed(1)}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: warningColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${package["service_style"]}".replaceAll("_", " ").toUpperCase(),
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          Row(
                            children: [
                              Text(
                                "\$${(package["price_per_person"] as double).currency}/person",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: successColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${(package["courses"] as int).toString()} courses",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),

                          Wrap(
                            spacing: spXs,
                            children: (package["includes"] as List).take(3).map((item) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${item}",
                                  style: TextStyle(
                                    color: infoColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),

                          Row(
                            children: [
                              Text(
                                "${(package["orders"] as int).toString()} orders",
                                style: TextStyle(fontSize: 12, color: disabledBoldColor),
                              ),
                              Spacer(),
                              Text(
                                "\$${(package["revenue"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "Select",
                                  size: bs.sm,
                                  onPressed: () => si("Selected package: ${package["name"]}"),
                                ),
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                icon: Icons.edit,
                                size: bs.sm,
                                onPressed: () => si("Editing package"),
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
          ),
        ],
      ),
    );
  }

  Widget _buildStaffTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Staff Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Total Assignments", "${staffAssignments.length}", Icons.assignment, primaryColor),
              _buildStatCard("Assigned", "${staffAssignments.where((s) => s["status"] == "assigned").length}", Icons.check_circle, successColor),
              _buildStatCard("Total Cost", "\$${(staffAssignments.fold(0.0, (sum, s) => sum + (s["total_cost"] as double))).currency}", Icons.attach_money, warningColor),
              _buildStatCard("Avg. Staff/Event", "${(staffAssignments.fold(0, (sum, s) => sum + (s["service_staff"] as int)) / staffAssignments.length).toStringAsFixed(1)}", Icons.people, infoColor),
            ],
          ),

          // Staff Assignment Form
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Assign Staff to Event",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Event Coordinator",
                        items: coordinatorOptions,
                        value: eventCoordinator,
                        onChanged: (value, label) {
                          eventCoordinator = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Head Chef",
                        items: chefOptions,
                        value: headChef,
                        onChanged: (value, label) {
                          headChef = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Service Staff Count",
                        value: serviceStaff,
                        onChanged: (value) {
                          serviceStaff = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QNumberField(
                        label: "Setup Crew Count",
                        value: setupCrew,
                        onChanged: (value) {
                          setupCrew = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Cleanup Crew Count",
                        value: cleanupCrew,
                        onChanged: (value) {
                          cleanupCrew = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QNumberField(
                        label: "Security Staff Count",
                        value: securityStaff,
                        onChanged: (value) {
                          securityStaff = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Assign Staff",
                        icon: Icons.add,
                        onPressed: _assignStaff,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Staff Assignments List
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Staff Assignments",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ...staffAssignments.map((assignment) {
                  Color statusColor = assignment["status"] == "assigned" 
                      ? successColor 
                      : warningColor;
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${assignment["event"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                              decoration: BoxDecoration(
                                color: statusColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${assignment["status"]}".toUpperCase(),
                                style: TextStyle(
                                  color: statusColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Icon(Icons.person, size: 16, color: primaryColor),
                            SizedBox(width: spXs),
                            Text(
                              "${assignment["coordinator"]}",
                              style: TextStyle(fontSize: 12, color: primaryColor),
                            ),
                            SizedBox(width: spSm),
                            Icon(Icons.restaurant, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${assignment["chef"]}",
                              style: TextStyle(fontSize: 12, color: disabledBoldColor),
                            ),
                          ],
                        ),

                        ResponsiveGridView(
                          padding: EdgeInsets.zero,
                          minItemWidth: 100,
                          children: [
                            _buildStaffMetric("Service", "${(assignment["service_staff"] as int).toString()}", Icons.room_service),
                            _buildStaffMetric("Setup", "${(assignment["setup_crew"] as int).toString()}", Icons.build),
                            _buildStaffMetric("Security", "${(assignment["security"] as int).toString()}", Icons.security),
                            _buildStaffMetric("Cost", "\$${(assignment["total_cost"] as double).currency}", Icons.attach_money),
                          ],
                        ),

                        Row(
                          children: [
                            Spacer(),
                            QButton(
                              label: "Edit",
                              size: bs.sm,
                              onPressed: () => si("Editing staff assignment"),
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              label: assignment["status"] == "assigned" ? "Confirm" : "Assign",
                              size: bs.sm,
                              onPressed: () => si("Staff assignment updated"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Spacer(),
              Icon(Icons.trending_up, color: successColor, size: 16),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaffMetric(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Column(
        children: [
          Icon(icon, color: primaryColor, size: 16),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: primaryColor,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
