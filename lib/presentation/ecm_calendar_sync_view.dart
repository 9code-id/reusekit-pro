import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmCalendarSyncView extends StatefulWidget {
  const EcmCalendarSyncView({super.key});

  @override
  State<EcmCalendarSyncView> createState() => _EcmCalendarSyncViewState();
}

class _EcmCalendarSyncViewState extends State<EcmCalendarSyncView> {
  bool calendarSyncEnabled = true;
  String selectedCalendarProvider = "Google Calendar";
  bool syncOrderDeliveries = true;
  bool syncAppointments = true;
  bool syncPromotions = false;
  bool syncReminders = true;
  String defaultReminder = "30min";
  String lastSyncTime = "5 minutes ago";
  bool syncInProgress = false;

  List<Map<String, dynamic>> calendarProviders = [
    {"label": "Google Calendar", "value": "Google Calendar"},
    {"label": "Outlook Calendar", "value": "Outlook Calendar"},
    {"label": "Apple Calendar", "value": "Apple Calendar"},
    {"label": "Yahoo Calendar", "value": "Yahoo Calendar"},
    {"label": "CalDAV", "value": "CalDAV"},
  ];

  List<Map<String, dynamic>> reminderOptions = [
    {"label": "15 minutes before", "value": "15min"},
    {"label": "30 minutes before", "value": "30min"},
    {"label": "1 hour before", "value": "1hour"},
    {"label": "2 hours before", "value": "2hour"},
    {"label": "1 day before", "value": "1day"},
  ];

  List<Map<String, dynamic>> syncedEvents = [
    {
      "title": "Product Delivery - Order #12345",
      "type": "Delivery",
      "date": "2024-06-20",
      "time": "2:00 PM - 4:00 PM",
      "status": "Confirmed",
      "description": "Delivery of iPhone 15 Pro Max",
      "reminder": "30 minutes before",
      "icon": Icons.local_shipping,
      "color": "#4CAF50",
    },
    {
      "title": "Customer Consultation Call",
      "type": "Appointment",
      "date": "2024-06-21",
      "time": "10:00 AM - 10:30 AM",
      "status": "Scheduled",
      "description": "Product consultation with John Smith",
      "reminder": "15 minutes before",
      "icon": Icons.phone,
      "color": "#2196F3",
    },
    {
      "title": "Flash Sale Ends",
      "type": "Promotion",
      "date": "2024-06-22",
      "time": "11:59 PM",
      "status": "Active",
      "description": "50% off electronics sale ending",
      "reminder": "1 hour before",
      "icon": Icons.local_offer,
      "color": "#FF9800",
    },
    {
      "title": "Stock Replenishment",
      "type": "Reminder",
      "date": "2024-06-23",
      "time": "9:00 AM",
      "status": "Pending",
      "description": "Restock popular items inventory",
      "reminder": "1 day before",
      "icon": Icons.inventory,
      "color": "#9C27B0",
    },
    {
      "title": "Product Review Follow-up",
      "type": "Reminder",
      "date": "2024-06-25",
      "time": "3:00 PM",
      "status": "Scheduled",
      "description": "Follow up with customers for product reviews",
      "reminder": "2 hours before",
      "icon": Icons.rate_review,
      "color": "#E91E63",
    },
  ];

  List<Map<String, dynamic>> recentSyncActivity = [
    {
      "action": "Order delivery event created",
      "details": "Added delivery schedule for Order #12345",
      "time": "5 minutes ago",
      "type": "create",
      "status": "success",
    },
    {
      "action": "Appointment reminder updated",
      "details": "Modified consultation call reminder settings",
      "time": "15 minutes ago",
      "type": "update",
      "status": "success",
    },
    {
      "action": "Promotional event synchronized",
      "details": "Added flash sale end reminder to calendar",
      "time": "1 hour ago",
      "type": "sync",
      "status": "success",
    },
    {
      "action": "Calendar sync error",
      "details": "Failed to sync due to permission issue",
      "time": "3 hours ago",
      "type": "error",
      "status": "failed",
    },
    {
      "action": "Bulk events synchronized",
      "details": "25 upcoming events synced to Google Calendar",
      "time": "6 hours ago",
      "type": "bulk",
      "status": "success",
    },
  ];

  Widget _buildConnectionStatus() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
        border: Border.all(color: calendarSyncEnabled ? successColor.withAlpha(50) : warningColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Calendar Integration",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: calendarSyncEnabled ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: calendarSyncEnabled ? successColor : warningColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      calendarSyncEnabled ? "Connected" : "Disconnected",
                      style: TextStyle(
                        color: calendarSyncEnabled ? successColor : warningColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
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
              Icon(
                Icons.calendar_today,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                selectedCalendarProvider,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "Last sync: $lastSyncTime",
                style: TextStyle(
                  fontSize: 12,
                  color: successColor,
                  fontWeight: FontWeight.w600,
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
                      "Events Synced",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${syncedEvents.length}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Upcoming",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${syncedEvents.where((e) => e["status"] == "Scheduled" || e["status"] == "Confirmed").length}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "This Week",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${syncedEvents.length}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
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
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    final statusColor = event["status"] == "Confirmed" ? successColor :
                       event["status"] == "Scheduled" ? infoColor :
                       event["status"] == "Active" ? warningColor :
                       event["status"] == "Pending" ? primaryColor : disabledColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: statusColor.withAlpha(50)),
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
                  color: Color(int.parse("0xFF${event["color"].substring(1)}")).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  event["icon"],
                  color: Color(int.parse("0xFF${event["color"].substring(1)}")),
                  size: 20,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "${event["title"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${event["status"]}",
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${event["type"]}",
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
          SizedBox(height: spMd),
          Row(
            children: [
              Icon(Icons.calendar_today, color: disabledBoldColor, size: 14),
              SizedBox(width: spXs),
              Text(
                "${event["date"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Icon(Icons.access_time, color: disabledBoldColor, size: 14),
              SizedBox(width: spXs),
              Text(
                "${event["time"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${event["description"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              height: 1.4,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.alarm, color: disabledColor, size: 12),
                  SizedBox(width: spXs),
                  Text(
                    "Reminder: ${event["reminder"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  QButton(
                    icon: Icons.edit,
                    size: bs.sm,
                    onPressed: () {
                      si("Editing event: ${event["title"]}");
                    },
                  ),
                  SizedBox(width: spXs),
                  QButton(
                    icon: Icons.delete,
                    size: bs.sm,
                    onPressed: () async {
                      bool isConfirmed = await confirm("Remove this event from calendar?");
                      if (isConfirmed) {
                        ss("Event removed from calendar");
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Sync Activity",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        ...recentSyncActivity.take(5).map((activity) {
          final isSuccess = activity["status"] == "success";
          final iconData = activity["type"] == "create" ? Icons.add_circle :
                          activity["type"] == "update" ? Icons.update :
                          activity["type"] == "sync" ? Icons.sync :
                          activity["type"] == "bulk" ? Icons.cloud_sync :
                          Icons.error;
          
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(
                color: isSuccess ? successColor.withAlpha(50) : dangerColor.withAlpha(50),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: isSuccess ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    iconData,
                    color: isSuccess ? successColor : dangerColor,
                    size: 16,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${activity["action"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${activity["details"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${activity["time"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledColor,
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
    );
  }

  void _performManualSync() async {
    syncInProgress = true;
    setState(() {});
    
    // Simulate sync process
    await Future.delayed(Duration(seconds: 3));
    
    lastSyncTime = "Just now";
    syncInProgress = false;
    setState(() {});
    
    ss("Calendar sync completed successfully!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar Sync"),
        actions: [
          if (syncInProgress) ...[
            Container(
              width: 40,
              height: 40,
              child: Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                ),
              ),
            ),
          ] else ...[
            IconButton(
              icon: Icon(Icons.sync),
              onPressed: _performManualSync,
            ),
          ],
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              si("Calendar sync settings");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Calendar Sync Toggle
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: calendarSyncEnabled ? primaryColor.withAlpha(10) : warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: calendarSyncEnabled ? primaryColor : warningColor,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    calendarSyncEnabled ? Icons.event_available : Icons.event_busy,
                    color: calendarSyncEnabled ? primaryColor : warningColor,
                    size: 30,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Calendar Sync",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: calendarSyncEnabled ? primaryColor : warningColor,
                          ),
                        ),
                        Text(
                          calendarSyncEnabled 
                              ? "Sync e-commerce events to your calendar"
                              : "Calendar synchronization is disabled",
                          style: TextStyle(
                            fontSize: 12,
                            color: calendarSyncEnabled ? primaryColor : warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: calendarSyncEnabled,
                    onChanged: (value) {
                      calendarSyncEnabled = value;
                      setState(() {});
                      if (value) {
                        ss("Calendar sync enabled");
                      } else {
                        sw("Calendar sync disabled");
                      }
                    },
                    activeColor: primaryColor,
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Connection Status
            _buildConnectionStatus(),
            SizedBox(height: spLg),

            // Sync Settings
            Text(
              "Sync Settings",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  QDropdownField(
                    label: "Calendar Provider",
                    items: calendarProviders,
                    value: selectedCalendarProvider,
                    onChanged: (value, label) {
                      if (calendarSyncEnabled) {
                        selectedCalendarProvider = value;
                        setState(() {});
                      }
                    },
                  ),
                  SizedBox(height: spMd),
                  QDropdownField(
                    label: "Default Reminder",
                    items: reminderOptions,
                    value: defaultReminder,
                    onChanged: (value, label) {
                      if (calendarSyncEnabled) {
                        defaultReminder = value;
                        setState(() {});
                      }
                    },
                  ),
                  SizedBox(height: spMd),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sync Order Deliveries",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Add delivery schedules to calendar",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Switch(
                        value: syncOrderDeliveries,
                        onChanged: calendarSyncEnabled ? (value) {
                          syncOrderDeliveries = value;
                          setState(() {});
                        } : null,
                        activeColor: primaryColor,
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sync Appointments",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Customer meetings and consultations",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Switch(
                        value: syncAppointments,
                        onChanged: calendarSyncEnabled ? (value) {
                          syncAppointments = value;
                          setState(() {});
                        } : null,
                        activeColor: primaryColor,
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sync Promotions",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Sale events and promotional deadlines",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Switch(
                        value: syncPromotions,
                        onChanged: calendarSyncEnabled ? (value) {
                          syncPromotions = value;
                          setState(() {});
                        } : null,
                        activeColor: primaryColor,
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sync Reminders",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Business tasks and follow-ups",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Switch(
                        value: syncReminders,
                        onChanged: calendarSyncEnabled ? (value) {
                          syncReminders = value;
                          setState(() {});
                        } : null,
                        activeColor: primaryColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Synced Events
            Text(
              "Synced Events",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            ...syncedEvents.map((event) => _buildEventCard(event)).toList(),
            SizedBox(height: spLg),

            // Recent Activity
            _buildRecentActivity(),
            SizedBox(height: spLg),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Manual Sync",
                    size: bs.md,
                    onPressed: calendarSyncEnabled && !syncInProgress ? _performManualSync : null,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Create Event",
                    size: bs.md,
                    onPressed: calendarSyncEnabled ? () {
                      si("Creating new calendar event...");
                    } : null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
