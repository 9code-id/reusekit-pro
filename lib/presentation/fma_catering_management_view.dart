import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaCateringManagementView extends StatefulWidget {
  const FmaCateringManagementView({super.key});

  @override
  State<FmaCateringManagementView> createState() => _FmaCateringManagementViewState();
}

class _FmaCateringManagementViewState extends State<FmaCateringManagementView> {
  int currentTab = 0;
  
  // Order Management Variables
  String customerName = "";
  String customerPhone = "";
  String customerEmail = "";
  String eventType = "corporate";
  String eventDate = "";
  String eventTime = "";
  String guestCount = "";
  String deliveryAddress = "";
  String specialInstructions = "";
  String menuPackage = "";
  bool requiresSetup = false;
  bool requiresService = false;
  
  // Menu Planning Variables
  String menuName = "";
  String menuDescription = "";
  String menuCategory = "main_course";
  String pricePerPerson = "";
  String minimumGuests = "";
  List<String> dietaryOptions = [];
  List<String> includedItems = [];
  String preparationTime = "";
  
  // Logistics Variables
  String deliveryVehicle = "";
  String driverName = "";
  String setupCrew = "";
  String equipmentNeeded = "";
  String deliveryTime = "";
  String setupDuration = "";
  String pickupTime = "";
  
  // Staff Scheduling Variables
  String staffRole = "chef";
  String staffMember = "";
  String scheduledDate = "";
  String startTime = "";
  String endTime = "";
  String hourlyRate = "";
  String eventLocation = "";
  
  // Sample Data
  List<Map<String, dynamic>> cateringOrders = [
    {
      "id": 1,
      "customer": "TechCorp Inc.",
      "event_type": "corporate",
      "event_date": "2024-06-25",
      "guest_count": 150,
      "menu_package": "Executive Lunch Package",
      "total_amount": 4500.0,
      "status": "confirmed",
      "delivery_address": "123 Business Plaza, Downtown",
      "special_requirements": "Vegetarian options for 20 guests",
      "contact": "(555) 123-4567"
    },
    {
      "id": 2,
      "customer": "Johnson Wedding",
      "event_type": "wedding",
      "event_date": "2024-06-30",
      "guest_count": 200,
      "menu_package": "Premium Wedding Feast",
      "total_amount": 8500.0,
      "status": "confirmed",
      "delivery_address": "Sunset Gardens Venue, 456 Lake View Dr",
      "special_requirements": "Gluten-free options, late evening service",
      "contact": "(555) 987-6543"
    },
    {
      "id": 3,
      "customer": "Smith Birthday Party",
      "event_type": "birthday",
      "event_date": "2024-06-28",
      "guest_count": 50,
      "menu_package": "Family Celebration Package",
      "total_amount": 1250.0,
      "status": "preparing",
      "delivery_address": "789 Maple Street, Residential Area",
      "special_requirements": "Kid-friendly options, birthday cake included",
      "contact": "(555) 456-7890"
    },
    {
      "id": 4,
      "customer": "University Graduation",
      "event_type": "graduation",
      "event_date": "2024-07-05",
      "guest_count": 300,
      "menu_package": "Buffet Style Celebration",
      "total_amount": 6750.0,
      "status": "pending",
      "delivery_address": "University Hall, 321 Campus Drive",
      "special_requirements": "Outdoor setup, multiple dietary restrictions",
      "contact": "(555) 234-5678"
    },
  ];

  List<Map<String, dynamic>> menuPackages = [
    {
      "id": 1,
      "name": "Executive Lunch Package",
      "category": "corporate",
      "price_per_person": 30.0,
      "minimum_guests": 20,
      "preparation_time": 4,
      "description": "Premium lunch selection for corporate events",
      "included_items": ["Caesar Salad", "Grilled Chicken", "Seasonal Vegetables", "Dessert", "Coffee"],
      "dietary_options": ["vegetarian", "gluten_free"],
      "orders_count": 45,
      "revenue": 67500.0,
      "rating": 4.8
    },
    {
      "id": 2,
      "name": "Premium Wedding Feast",
      "category": "wedding",
      "price_per_person": 85.0,
      "minimum_guests": 50,
      "preparation_time": 8,
      "description": "Elegant multi-course dining experience for weddings",
      "included_items": ["Cocktail Hour", "Appetizers", "Soup Course", "Main Course", "Wedding Cake", "Open Bar"],
      "dietary_options": ["vegetarian", "vegan", "gluten_free", "kosher"],
      "orders_count": 28,
      "revenue": 119000.0,
      "rating": 4.9
    },
    {
      "id": 3,
      "name": "Family Celebration Package",
      "category": "birthday",
      "price_per_person": 25.0,
      "minimum_guests": 10,
      "preparation_time": 3,
      "description": "Fun and delicious options for family celebrations",
      "included_items": ["Finger Foods", "Main Dishes", "Side Dishes", "Birthday Cake", "Beverages"],
      "dietary_options": ["kid_friendly", "vegetarian"],
      "orders_count": 67,
      "revenue": 83750.0,
      "rating": 4.7
    },
    {
      "id": 4,
      "name": "Buffet Style Celebration",
      "category": "graduation",
      "price_per_person": 22.50,
      "minimum_guests": 30,
      "preparation_time": 5,
      "description": "Self-service buffet perfect for large gatherings",
      "included_items": ["Salad Bar", "Hot Entrees", "Side Dishes", "Dessert Station", "Beverage Station"],
      "dietary_options": ["vegetarian", "vegan", "gluten_free"],
      "orders_count": 34,
      "revenue": 51000.0,
      "rating": 4.6
    },
  ];

  List<Map<String, dynamic>> deliverySchedule = [
    {
      "id": 1,
      "order": "TechCorp Inc.",
      "delivery_date": "2024-06-25",
      "delivery_time": "11:30",
      "setup_time": "10:00",
      "address": "123 Business Plaza",
      "driver": "Mike Johnson",
      "vehicle": "Large Catering Van",
      "setup_crew": 3,
      "equipment": ["Tables", "Chafing Dishes", "Serving Utensils"],
      "status": "scheduled"
    },
    {
      "id": 2,
      "order": "Johnson Wedding",
      "delivery_date": "2024-06-30",
      "delivery_time": "15:00",
      "setup_time": "13:00",
      "address": "Sunset Gardens Venue",
      "driver": "Sarah Davis",
      "vehicle": "Refrigerated Truck",
      "setup_crew": 5,
      "equipment": ["Tables", "Linens", "Serving Stations", "Bar Setup"],
      "status": "scheduled"
    },
    {
      "id": 3,
      "order": "Smith Birthday Party",
      "delivery_date": "2024-06-28",
      "delivery_time": "14:00",
      "setup_time": "13:30",
      "address": "789 Maple Street",
      "driver": "Tom Wilson",
      "vehicle": "Medium Catering Van",
      "setup_crew": 2,
      "equipment": ["Portable Tables", "Serving Trays", "Coolers"],
      "status": "in_progress"
    },
    {
      "id": 4,
      "order": "University Graduation",
      "delivery_date": "2024-07-05",
      "delivery_time": "10:00",
      "setup_time": "08:00",
      "address": "University Hall",
      "driver": "Lisa Chen",
      "vehicle": "Large Catering Truck",
      "setup_crew": 6,
      "equipment": ["Outdoor Tents", "Buffet Stations", "Sound System"],
      "status": "pending"
    },
  ];

  List<Map<String, dynamic>> staffSchedule = [
    {
      "id": 1,
      "event": "TechCorp Inc.",
      "date": "2024-06-25",
      "role": "Head Chef",
      "staff_member": "Gordon Martinez",
      "start_time": "09:00",
      "end_time": "15:00",
      "hourly_rate": 45.0,
      "total_cost": 270.0,
      "status": "assigned"
    },
    {
      "id": 2,
      "event": "Johnson Wedding",
      "date": "2024-06-30",
      "role": "Event Coordinator",
      "staff_member": "Emma Wilson",
      "start_time": "12:00",
      "end_time": "22:00",
      "hourly_rate": 35.0,
      "total_cost": 350.0,
      "status": "assigned"
    },
    {
      "id": 3,
      "event": "Smith Birthday Party",
      "date": "2024-06-28",
      "role": "Server",
      "staff_member": "Maria Rodriguez",
      "start_time": "13:00",
      "end_time": "18:00",
      "hourly_rate": 18.0,
      "total_cost": 90.0,
      "status": "assigned"
    },
    {
      "id": 4,
      "event": "University Graduation",
      "date": "2024-07-05",
      "role": "Setup Crew",
      "staff_member": "David Brown",
      "start_time": "07:00",
      "end_time": "16:00",
      "hourly_rate": 22.0,
      "total_cost": 198.0,
      "status": "pending"
    },
  ];

  List<Map<String, dynamic>> eventTypeOptions = [
    {"label": "Corporate Event", "value": "corporate"},
    {"label": "Wedding", "value": "wedding"},
    {"label": "Birthday Party", "value": "birthday"},
    {"label": "Graduation", "value": "graduation"},
    {"label": "Anniversary", "value": "anniversary"},
    {"label": "Religious Ceremony", "value": "religious"},
    {"label": "Holiday Party", "value": "holiday"},
    {"label": "Fundraiser", "value": "fundraiser"},
  ];

  List<Map<String, dynamic>> menuCategoryOptions = [
    {"label": "Main Course", "value": "main_course"},
    {"label": "Appetizers", "value": "appetizers"},
    {"label": "Desserts", "value": "desserts"},
    {"label": "Beverages", "value": "beverages"},
    {"label": "Complete Package", "value": "complete"},
    {"label": "Breakfast", "value": "breakfast"},
    {"label": "Lunch", "value": "lunch"},
    {"label": "Dinner", "value": "dinner"},
  ];

  List<Map<String, dynamic>> vehicleOptions = [
    {"label": "Small Catering Van", "value": "small_van"},
    {"label": "Medium Catering Van", "value": "medium_van"},
    {"label": "Large Catering Van", "value": "large_van"},
    {"label": "Refrigerated Truck", "value": "refrigerated"},
    {"label": "Large Catering Truck", "value": "large_truck"},
  ];

  List<Map<String, dynamic>> staffRoleOptions = [
    {"label": "Head Chef", "value": "chef"},
    {"label": "Sous Chef", "value": "sous_chef"},
    {"label": "Server", "value": "server"},
    {"label": "Event Coordinator", "value": "coordinator"},
    {"label": "Setup Crew", "value": "setup"},
    {"label": "Bartender", "value": "bartender"},
    {"label": "Cleaner", "value": "cleaner"},
  ];

  List<Map<String, dynamic>> staffMemberOptions = [
    {"label": "Gordon Martinez", "value": "gordon_martinez"},
    {"label": "Emma Wilson", "value": "emma_wilson"},
    {"label": "Maria Rodriguez", "value": "maria_rodriguez"},
    {"label": "David Brown", "value": "david_brown"},
    {"label": "Sarah Johnson", "value": "sarah_johnson"},
    {"label": "Mike Davis", "value": "mike_davis"},
    {"label": "Lisa Chen", "value": "lisa_chen"},
    {"label": "Tom Wilson", "value": "tom_wilson"},
  ];

  void _createOrder() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    ss("Catering order for '${customerName}' created successfully");
    
    // Reset form
    customerName = "";
    customerPhone = "";
    customerEmail = "";
    eventType = "corporate";
    eventDate = "";
    eventTime = "";
    guestCount = "";
    deliveryAddress = "";
    specialInstructions = "";
    menuPackage = "";
    requiresSetup = false;
    requiresService = false;
    setState(() {});
  }

  void _saveMenuPackage() async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    ss("Menu package '${menuName}' saved successfully");
    
    // Reset form
    menuName = "";
    menuDescription = "";
    menuCategory = "main_course";
    pricePerPerson = "";
    minimumGuests = "";
    dietaryOptions = [];
    includedItems = [];
    preparationTime = "";
    setState(() {});
  }

  void _scheduleDelivery() async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    ss("Delivery scheduled successfully");
    
    // Reset form
    deliveryVehicle = "";
    driverName = "";
    setupCrew = "";
    equipmentNeeded = "";
    deliveryTime = "";
    setupDuration = "";
    pickupTime = "";
    setState(() {});
  }

  void _scheduleStaff() async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    ss("Staff member scheduled successfully");
    
    // Reset form
    staffRole = "chef";
    staffMember = "";
    scheduledDate = "";
    startTime = "";
    endTime = "";
    hourlyRate = "";
    eventLocation = "";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Catering Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Orders", icon: Icon(Icons.receipt)),
        Tab(text: "Menu Planning", icon: Icon(Icons.restaurant_menu)),
        Tab(text: "Logistics", icon: Icon(Icons.local_shipping)),
        Tab(text: "Staff Schedule", icon: Icon(Icons.schedule)),
      ],
      tabChildren: [
        _buildOrdersTab(),
        _buildMenuPlanningTab(),
        _buildLogisticsTab(),
        _buildStaffScheduleTab(),
      ],
    );
  }

  Widget _buildOrdersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Order Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Total Orders", "${cateringOrders.length}", Icons.receipt, primaryColor),
              _buildStatCard("Confirmed", "${cateringOrders.where((o) => o["status"] == "confirmed").length}", Icons.check_circle, successColor),
              _buildStatCard("Total Revenue", "\$${(cateringOrders.fold(0.0, (sum, o) => sum + (o["total_amount"] as double))).currency}", Icons.attach_money, warningColor),
              _buildStatCard("Avg. Guest Count", "${(cateringOrders.fold(0, (sum, o) => sum + (o["guest_count"] as int)) / cateringOrders.length).toStringAsFixed(0)}", Icons.people, infoColor),
            ],
          ),

          // Create Order Form
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
                  "Create New Catering Order",
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
                        label: "Customer Name",
                        value: customerName,
                        hint: "Enter customer or company name",
                        onChanged: (value) {
                          customerName = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTextField(
                        label: "Phone Number",
                        value: customerPhone,
                        hint: "Enter contact number",
                        onChanged: (value) {
                          customerPhone = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Email Address",
                        value: customerEmail,
                        hint: "Enter email address",
                        onChanged: (value) {
                          customerEmail = value;
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

                QNumberField(
                  label: "Guest Count",
                  value: guestCount,
                  onChanged: (value) {
                    guestCount = value;
                    setState(() {});
                  },
                ),

                QMemoField(
                  label: "Delivery Address",
                  value: deliveryAddress,
                  hint: "Enter complete delivery address with landmarks",
                  onChanged: (value) {
                    deliveryAddress = value;
                    setState(() {});
                  },
                ),

                QMemoField(
                  label: "Special Instructions",
                  value: specialInstructions,
                  hint: "Any dietary restrictions, setup requirements, or special requests",
                  onChanged: (value) {
                    specialInstructions = value;
                    setState(() {});
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Requires setup service",
                            "value": true,
                            "checked": requiresSetup,
                          }
                        ],
                        value: [
                          if (requiresSetup)
                            {
                              "label": "Requires setup service",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          requiresSetup = values.isNotEmpty;
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
                            "label": "Requires serving service",
                            "value": true,
                            "checked": requiresService,
                          }
                        ],
                        value: [
                          if (requiresService)
                            {
                              "label": "Requires serving service",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          requiresService = values.isNotEmpty;
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
                        label: "Create Order",
                        icon: Icons.add,
                        onPressed: _createOrder,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Orders List
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
                  "Recent Catering Orders",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ...cateringOrders.map((order) {
                  Color statusColor = order["status"] == "confirmed" 
                      ? successColor 
                      : order["status"] == "preparing"
                          ? warningColor 
                          : disabledBoldColor;
                  
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
                                "${order["customer"]}",
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
                                "${order["status"]}".toUpperCase(),
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
                                "${order["event_type"]}".replaceAll("_", " ").toUpperCase(),
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${order["event_date"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${(order["guest_count"] as int).toString()} guests",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),

                        Text(
                          "${order["menu_package"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),

                        Row(
                          children: [
                            Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${order["delivery_address"]}",
                                style: TextStyle(fontSize: 12, color: disabledBoldColor),
                              ),
                            ),
                          ],
                        ),

                        if (order["special_requirements"].toString().isNotEmpty) ...[
                          Row(
                            children: [
                              Icon(Icons.info, size: 16, color: infoColor),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${order["special_requirements"]}",
                                  style: TextStyle(fontSize: 12, color: infoColor),
                                ),
                              ),
                            ],
                          ),
                        ],

                        Row(
                          children: [
                            Icon(Icons.phone, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${order["contact"]}",
                              style: TextStyle(fontSize: 12, color: disabledBoldColor),
                            ),
                            Spacer(),
                            Text(
                              "\$${(order["total_amount"] as double).currency}",
                              style: TextStyle(
                                fontSize: 16,
                                color: successColor,
                                fontWeight: FontWeight.bold,
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
                              onPressed: () => si("Editing order: ${order["customer"]}"),
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              label: "Details",
                              size: bs.sm,
                              onPressed: () => si("Viewing order details"),
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              icon: Icons.print,
                              size: bs.sm,
                              onPressed: () => si("Printing order confirmation"),
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

  Widget _buildMenuPlanningTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Menu Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Total Packages", "${menuPackages.length}", Icons.restaurant_menu, primaryColor),
              _buildStatCard("Total Orders", "${menuPackages.fold(0, (sum, m) => sum + (m["orders_count"] as int))}", Icons.shopping_cart, successColor),
              _buildStatCard("Total Revenue", "\$${(menuPackages.fold(0.0, (sum, m) => sum + (m["revenue"] as double))).currency}", Icons.attach_money, warningColor),
              _buildStatCard("Avg. Rating", "${(menuPackages.fold(0.0, (sum, m) => sum + (m["rating"] as double)) / menuPackages.length).toStringAsFixed(1)}", Icons.star, infoColor),
            ],
          ),

          // Create Menu Package Form
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
                  "Create Menu Package",
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
                        label: "Menu Package Name",
                        value: menuName,
                        hint: "Enter menu package name",
                        onChanged: (value) {
                          menuName = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: menuCategoryOptions,
                        value: menuCategory,
                        onChanged: (value, label) {
                          menuCategory = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                QMemoField(
                  label: "Package Description",
                  value: menuDescription,
                  hint: "Describe the menu package and its highlights",
                  onChanged: (value) {
                    menuDescription = value;
                    setState(() {});
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Price per Person (\$)",
                        value: pricePerPerson,
                        onChanged: (value) {
                          pricePerPerson = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QNumberField(
                        label: "Minimum Guests",
                        value: minimumGuests,
                        onChanged: (value) {
                          minimumGuests = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                QNumberField(
                  label: "Preparation Time (hours)",
                  value: preparationTime,
                  onChanged: (value) {
                    preparationTime = value;
                    setState(() {});
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Save Package",
                        icon: Icons.add,
                        onPressed: _saveMenuPackage,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Menu Packages List
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
                  "Available Menu Packages",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: menuPackages.map((package) {
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
                              "${package["category"]}".replaceAll("_", " ").toUpperCase(),
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          Text(
                            "${package["description"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
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
                                "Min: ${(package["minimum_guests"] as int).toString()}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Includes:",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Wrap(
                                spacing: spXs,
                                children: (package["included_items"] as List).take(3).map((item) {
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
                            ],
                          ),

                          Row(
                            children: [
                              Text(
                                "${(package["orders_count"] as int).toString()} orders",
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

  Widget _buildLogisticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Logistics Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Scheduled Deliveries", "${deliverySchedule.length}", Icons.local_shipping, primaryColor),
              _buildStatCard("In Progress", "${deliverySchedule.where((d) => d["status"] == "in_progress").length}", Icons.directions_car, successColor),
              _buildStatCard("Avg. Setup Crew", "${(deliverySchedule.fold(0, (sum, d) => sum + (d["setup_crew"] as int)) / deliverySchedule.length).toStringAsFixed(1)}", Icons.people, infoColor),
              _buildStatCard("Vehicles Active", "${deliverySchedule.where((d) => d["status"] != "pending").length}", Icons.local_shipping, warningColor),
            ],
          ),

          // Schedule Delivery Form
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
                  "Schedule Delivery & Setup",
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
                        label: "Delivery Vehicle",
                        items: vehicleOptions,
                        value: deliveryVehicle,
                        onChanged: (value, label) {
                          deliveryVehicle = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Driver",
                        items: staffMemberOptions,
                        value: driverName,
                        onChanged: (value, label) {
                          driverName = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: QTimePicker(
                        label: "Delivery Time",
                        value: deliveryTime.isNotEmpty 
                            ? deliveryTime.timeOfDay 
                            : TimeOfDay.now(),
                        onChanged: (value) {
                          deliveryTime = value!.kkmm;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QNumberField(
                        label: "Setup Duration (hours)",
                        value: setupDuration,
                        onChanged: (value) {
                          setupDuration = value;
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
                        label: "Setup Crew Size",
                        value: setupCrew,
                        onChanged: (value) {
                          setupCrew = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTimePicker(
                        label: "Pickup Time",
                        value: pickupTime.isNotEmpty 
                            ? pickupTime.timeOfDay 
                            : TimeOfDay.now(),
                        onChanged: (value) {
                          pickupTime = value!.kkmm;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                QMemoField(
                  label: "Equipment Needed",
                  value: equipmentNeeded,
                  hint: "List all equipment, tables, decorations, etc.",
                  onChanged: (value) {
                    equipmentNeeded = value;
                    setState(() {});
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Schedule Delivery",
                        icon: Icons.add,
                        onPressed: _scheduleDelivery,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Delivery Schedule List
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
                  "Delivery Schedule",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ...deliverySchedule.map((delivery) {
                  Color statusColor = delivery["status"] == "scheduled" 
                      ? successColor 
                      : delivery["status"] == "in_progress"
                          ? warningColor 
                          : disabledBoldColor;
                  
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
                                "${delivery["order"]}",
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
                                "${delivery["status"]}".replaceAll("_", " ").toUpperCase(),
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
                            Icon(Icons.event, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${delivery["delivery_date"]}",
                              style: TextStyle(fontSize: 12, color: disabledBoldColor),
                            ),
                            SizedBox(width: spSm),
                            Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "Setup: ${delivery["setup_time"]} | Delivery: ${delivery["delivery_time"]}",
                              style: TextStyle(fontSize: 12, color: disabledBoldColor),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${delivery["address"]}",
                                style: TextStyle(fontSize: 12, color: disabledBoldColor),
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Icon(Icons.person, size: 16, color: primaryColor),
                            SizedBox(width: spXs),
                            Text(
                              "${delivery["driver"]}",
                              style: TextStyle(fontSize: 12, color: primaryColor),
                            ),
                            SizedBox(width: spSm),
                            Icon(Icons.local_shipping, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${delivery["vehicle"]}",
                              style: TextStyle(fontSize: 12, color: disabledBoldColor),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Icon(Icons.people, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${(delivery["setup_crew"] as int).toString()} crew members",
                              style: TextStyle(fontSize: 12, color: disabledBoldColor),
                            ),
                            Spacer(),
                            Text(
                              "${(delivery["equipment"] as List).length} equipment items",
                              style: TextStyle(fontSize: 12, color: disabledBoldColor),
                            ),
                          ],
                        ),

                        Wrap(
                          spacing: spXs,
                          children: (delivery["equipment"] as List).take(3).map((equipment) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${equipment}",
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
                            Spacer(),
                            QButton(
                              label: "Edit",
                              size: bs.sm,
                              onPressed: () => si("Editing delivery schedule"),
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              label: "Track",
                              size: bs.sm,
                              onPressed: () => si("Tracking delivery: ${delivery["order"]}"),
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              icon: Icons.phone,
                              size: bs.sm,
                              onPressed: () => si("Calling driver"),
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

  Widget _buildStaffScheduleTab() {
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
              _buildStatCard("Total Assignments", "${staffSchedule.length}", Icons.assignment, primaryColor),
              _buildStatCard("Assigned", "${staffSchedule.where((s) => s["status"] == "assigned").length}", Icons.check_circle, successColor),
              _buildStatCard("Total Cost", "\$${(staffSchedule.fold(0.0, (sum, s) => sum + (s["total_cost"] as double))).currency}", Icons.attach_money, warningColor),
              _buildStatCard("Avg. Hours", "${(staffSchedule.fold(0.0, (sum, s) => sum + ((s["total_cost"] as double) / (s["hourly_rate"] as double))) / staffSchedule.length).toStringAsFixed(1)}", Icons.schedule, infoColor),
            ],
          ),

          // Schedule Staff Form
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
                  "Schedule Staff Member",
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
                        label: "Staff Role",
                        items: staffRoleOptions,
                        value: staffRole,
                        onChanged: (value, label) {
                          staffRole = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Staff Member",
                        items: staffMemberOptions,
                        value: staffMember,
                        onChanged: (value, label) {
                          staffMember = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: QDatePicker(
                        label: "Scheduled Date",
                        value: scheduledDate.isNotEmpty 
                            ? DateTime.parse(scheduledDate) 
                            : DateTime.now(),
                        onChanged: (value) {
                          scheduledDate = value.toString().split(' ')[0];
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QNumberField(
                        label: "Hourly Rate (\$)",
                        value: hourlyRate,
                        onChanged: (value) {
                          hourlyRate = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: QTimePicker(
                        label: "Start Time",
                        value: startTime.isNotEmpty 
                            ? startTime.timeOfDay 
                            : TimeOfDay.now(),
                        onChanged: (value) {
                          startTime = value!.kkmm;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTimePicker(
                        label: "End Time",
                        value: endTime.isNotEmpty 
                            ? endTime.timeOfDay 
                            : TimeOfDay.now(),
                        onChanged: (value) {
                          endTime = value!.kkmm;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                QTextField(
                  label: "Event Location",
                  value: eventLocation,
                  hint: "Enter event location or venue",
                  onChanged: (value) {
                    eventLocation = value;
                    setState(() {});
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Schedule Staff",
                        icon: Icons.add,
                        onPressed: _scheduleStaff,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Staff Schedule List
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
                  "Staff Schedule",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ...staffSchedule.map((schedule) {
                  Color statusColor = schedule["status"] == "assigned" 
                      ? successColor 
                      : warningColor;
                  
                  double hours = (schedule["total_cost"] as double) / (schedule["hourly_rate"] as double);
                  
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
                                "${schedule["event"]}",
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
                                "${schedule["status"]}".toUpperCase(),
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
                                "${schedule["role"]}".replaceAll("_", " ").toUpperCase(),
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${schedule["staff_member"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Icon(Icons.event, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${schedule["date"]}",
                              style: TextStyle(fontSize: 12, color: disabledBoldColor),
                            ),
                            SizedBox(width: spSm),
                            Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${schedule["start_time"]} - ${schedule["end_time"]}",
                              style: TextStyle(fontSize: 12, color: disabledBoldColor),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Text(
                              "${hours.toStringAsFixed(1)} hours",
                              style: TextStyle(fontSize: 12, color: disabledBoldColor),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "\$${(schedule["hourly_rate"] as double).currency}/hr",
                              style: TextStyle(fontSize: 12, color: disabledBoldColor),
                            ),
                            Spacer(),
                            Text(
                              "\$${(schedule["total_cost"] as double).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                color: successColor,
                                fontWeight: FontWeight.bold,
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
                              onPressed: () => si("Editing staff schedule"),
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              label: schedule["status"] == "assigned" ? "Confirm" : "Assign",
                              size: bs.sm,
                              onPressed: () => si("Staff schedule updated"),
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              icon: Icons.phone,
                              size: bs.sm,
                              onPressed: () => si("Calling staff member"),
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
}
