import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaScheduledDeliveryView extends StatefulWidget {
  const FdaScheduledDeliveryView({super.key});

  @override
  State<FdaScheduledDeliveryView> createState() => _FdaScheduledDeliveryViewState();
}

class _FdaScheduledDeliveryViewState extends State<FdaScheduledDeliveryView> {
  DateTime selectedDate = DateTime.now().add(Duration(days: 1));
  TimeOfDay selectedTime = TimeOfDay(hour: 12, minute: 0);
  String selectedRecurrence = "Once";
  String deliveryNotes = "";
  bool notifyBeforeDelivery = true;
  bool contactlessDelivery = false;
  int selectedIndex = 0;

  List<Map<String, dynamic>> recurrenceOptions = [
    {"value": "Once", "label": "One-time delivery", "icon": Icons.schedule},
    {"value": "Daily", "label": "Every day", "icon": Icons.today},
    {"value": "Weekly", "label": "Every week", "icon": Icons.date_range},
    {"value": "Monthly", "label": "Every month", "icon": Icons.calendar_month},
  ];

  List<Map<String, dynamic>> scheduledOrders = [
    {
      "id": "1",
      "restaurant": "Healthy Bowl",
      "items": ["Green Salad", "Grilled Chicken", "Quinoa Bowl"],
      "scheduledDate": "2024-12-20",
      "scheduledTime": "12:30 PM",
      "recurrence": "Daily",
      "status": "Active",
      "nextDelivery": "Tomorrow",
      "total": 28.50,
      "image": "https://picsum.photos/300/200?random=30&keyword=salad",
    },
    {
      "id": "2",
      "restaurant": "Coffee & More",
      "items": ["Cappuccino", "Croissant", "Fresh Juice"],
      "scheduledDate": "2024-12-22",
      "scheduledTime": "8:00 AM",
      "recurrence": "Weekly",
      "status": "Active",
      "nextDelivery": "Sunday",
      "total": 15.75,
      "image": "https://picsum.photos/300/200?random=31&keyword=coffee",
    },
    {
      "id": "3",
      "restaurant": "Pizza Corner",
      "items": ["Margherita Pizza", "Garlic Bread"],
      "scheduledDate": "2024-12-25",
      "scheduledTime": "7:00 PM",
      "recurrence": "Once",
      "status": "Scheduled",
      "nextDelivery": "Dec 25",
      "total": 22.00,
      "image": "https://picsum.photos/300/200?random=32&keyword=pizza",
    },
  ];

  List<Map<String, dynamic>> timeSlots = [
    {"time": "8:00 AM", "available": true},
    {"time": "9:00 AM", "available": true},
    {"time": "10:00 AM", "available": false},
    {"time": "11:00 AM", "available": true},
    {"time": "12:00 PM", "available": true},
    {"time": "1:00 PM", "available": true},
    {"time": "2:00 PM", "available": false},
    {"time": "3:00 PM", "available": true},
    {"time": "4:00 PM", "available": true},
    {"time": "5:00 PM", "available": true},
    {"time": "6:00 PM", "available": true},
    {"time": "7:00 PM", "available": true},
    {"time": "8:00 PM", "available": false},
    {"time": "9:00 PM", "available": true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scheduled Delivery"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () => ss("Opening delivery history"),
          ),
        ],
      ),
      body: QTabBar(
        withoutAppBar: true,
        selectedIndex: selectedIndex,
        tabs: [
          Tab(text: "Schedule", icon: Icon(Icons.schedule)),
          Tab(text: "My Schedules", icon: Icon(Icons.event_note)),
          Tab(text: "Settings", icon: Icon(Icons.settings)),
        ],
        tabChildren: [
          _buildScheduleTab(),
          _buildMySchedulesTab(),
          _buildSettingsTab(),
        ],
      ),
    );
  }

  Widget _buildScheduleTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(150)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.schedule,
                  size: 48,
                  color: Colors.white,
                ),
                SizedBox(height: spSm),
                Text(
                  "Schedule Your Delivery",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Plan your meals in advance",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(230),
                  ),
                ),
              ],
            ),
          ),

          // Date Selection
          Text(
            "Select Date",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          QDatePicker(
            label: "Delivery Date",
            value: selectedDate,
            onChanged: (value) {
              selectedDate = value;
              setState(() {});
            },
          ),

          // Time Selection
          Text(
            "Select Time",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          QTimePicker(
            label: "Delivery Time",
            value: selectedTime,
            onChanged: (value) {
              selectedTime = value!;
              setState(() {});
            },
          ),

          // Available Time Slots
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Available Time Slots for ${selectedDate.dMMMy}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                Wrap(
                  spacing: spSm,
                  runSpacing: spSm,
                  children: timeSlots.map((slot) {
                    bool available = slot["available"];
                    bool isSelected = slot["time"] == selectedTime.kkmm;
                    
                    return GestureDetector(
                      onTap: available ? () {
                        String timeStr = slot["time"];
                        int hour = int.parse(timeStr.split(":")[0]);
                        if (timeStr.contains("PM") && hour != 12) hour += 12;
                        if (timeStr.contains("AM") && hour == 12) hour = 0;
                        selectedTime = TimeOfDay(hour: hour, minute: 0);
                        setState(() {});
                      } : null,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spMd,
                          vertical: spSm,
                        ),
                        decoration: BoxDecoration(
                          color: !available 
                              ? disabledColor
                              : isSelected 
                                  ? primaryColor 
                                  : Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: !available 
                                ? disabledOutlineBorderColor
                                : isSelected 
                                    ? primaryColor 
                                    : primaryColor.withAlpha(100),
                          ),
                        ),
                        child: Text(
                          "${slot["time"]}",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: !available 
                                ? disabledBoldColor
                                : isSelected 
                                    ? Colors.white 
                                    : primaryColor,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Recurrence Options
          Text(
            "Repeat Schedule",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Column(
            spacing: spSm,
            children: recurrenceOptions.map((option) {
              bool isSelected = selectedRecurrence == option["value"];
              return GestureDetector(
                onTap: () {
                  selectedRecurrence = option["value"];
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        option["icon"] as IconData,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${option["value"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${option["label"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected) ...[
                        Icon(
                          Icons.check_circle,
                          color: primaryColor,
                          size: 24,
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }).toList(),
          ),

          // Delivery Options
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Delivery Preferences",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                Row(
                  children: [
                    Checkbox(
                      value: notifyBeforeDelivery,
                      onChanged: (value) {
                        notifyBeforeDelivery = value!;
                        setState(() {});
                      },
                      activeColor: primaryColor,
                    ),
                    Expanded(
                      child: Text(
                        "Notify me 30 minutes before delivery",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                
                Row(
                  children: [
                    Checkbox(
                      value: contactlessDelivery,
                      onChanged: (value) {
                        contactlessDelivery = value!;
                        setState(() {});
                      },
                      activeColor: primaryColor,
                    ),
                    Expanded(
                      child: Text(
                        "Contactless delivery with photo",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Special Notes
          QMemoField(
            label: "Delivery Notes",
            value: deliveryNotes,
            hint: "Any special instructions for the scheduled delivery?",
            onChanged: (value) {
              deliveryNotes = value;
              setState(() {});
            },
          ),

          // Confirm Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Schedule Delivery",
              size: bs.md,
              onPressed: () => _scheduleDelivery(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMySchedulesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Header
          Row(
            children: [
              Icon(
                Icons.event_note,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "My Scheduled Deliveries",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          Text(
            "Manage your upcoming deliveries",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),

          // Scheduled Orders
          Column(
            spacing: spMd,
            children: scheduledOrders.map((order) => _buildScheduledOrderCard(order)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduledOrderCard(Map<String, dynamic> order) {
    Color statusColor = order["status"] == "Active" ? successColor : warningColor;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          // Header Row
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${order["image"]}",
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${order["restaurant"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${order["status"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${(order["total"] as double).toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${order["recurrence"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Items
          Text(
            "Items:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          ...((order["items"] as List).map((item) => Text(
            "• $item",
            style: TextStyle(
              fontSize: 13,
              color: disabledBoldColor,
            ),
          ))).toList(),

          // Schedule Info
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.schedule,
                  color: primaryColor,
                  size: 16,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Next delivery: ${order["nextDelivery"]} at ${order["scheduledTime"]}",
                    style: TextStyle(
                      fontSize: 13,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Action Buttons
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Edit",
                  size: bs.sm,
                  onPressed: () => _editScheduledOrder(order),
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Pause",
                  size: bs.sm,
                  onPressed: () => _pauseScheduledOrder(order),
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Cancel",
                  size: bs.sm,
                  onPressed: () => _cancelScheduledOrder(order),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Default Settings
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Default Scheduling Preferences",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                _buildSettingTile(
                  icon: Icons.access_time,
                  title: "Default Time Slot",
                  subtitle: "12:00 PM",
                  onTap: () => ss("Setting default time slot"),
                ),
                
                _buildSettingTile(
                  icon: Icons.location_on,
                  title: "Default Address",
                  subtitle: "123 Main Street, Downtown",
                  onTap: () => ss("Setting default address"),
                ),
                
                _buildSettingTile(
                  icon: Icons.notifications,
                  title: "Notification Settings",
                  subtitle: "30 minutes before delivery",
                  onTap: () => ss("Opening notification settings"),
                ),
                
                _buildSettingTile(
                  icon: Icons.payment,
                  title: "Payment Method",
                  subtitle: "Credit Card ending in 1234",
                  onTap: () => ss("Managing payment methods"),
                ),
              ],
            ),
          ),

          // Advanced Settings
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Advanced Options",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                _buildSettingTile(
                  icon: Icons.autorenew,
                  title: "Auto-reschedule",
                  subtitle: "Automatically reschedule failed deliveries",
                  onTap: () => ss("Setting auto-reschedule options"),
                ),
                
                _buildSettingTile(
                  icon: Icons.calendar_month,
                  title: "Holiday Settings",
                  subtitle: "Manage deliveries during holidays",
                  onTap: () => ss("Opening holiday settings"),
                ),
                
                _buildSettingTile(
                  icon: Icons.group,
                  title: "Family Sharing",
                  subtitle: "Share schedules with family members",
                  onTap: () => ss("Managing family sharing"),
                ),
                
                _buildSettingTile(
                  icon: Icons.backup,
                  title: "Backup & Sync",
                  subtitle: "Sync schedules across devices",
                  onTap: () => ss("Opening backup settings"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: spSm),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: disabledOutlineBorderColor,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 24,
            ),
            SizedBox(width: spMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: disabledBoldColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _scheduleDelivery() {
    String message = "Delivery scheduled for ${selectedDate.dMMMy} at ${selectedTime.kkmm}";
    if (selectedRecurrence != "Once") {
      message += " ($selectedRecurrence)";
    }
    ss(message);
    back();
  }

  void _editScheduledOrder(Map<String, dynamic> order) {
    ss("Editing scheduled order from ${order["restaurant"]}");
  }

  void _pauseScheduledOrder(Map<String, dynamic> order) {
    ss("Pausing scheduled order from ${order["restaurant"]}");
  }

  void _cancelScheduledOrder(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Cancel Scheduled Order"),
        content: Text("Are you sure you want to cancel this scheduled delivery from ${order["restaurant"]}?"),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Confirm",
            size: bs.sm,
            onPressed: () {
              back();
              ss("Scheduled order cancelled");
            },
          ),
        ],
      ),
    );
  }
}
