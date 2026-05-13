import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaWakeUpCallView extends StatefulWidget {
  const HhaWakeUpCallView({super.key});

  @override
  State<HhaWakeUpCallView> createState() => _HhaWakeUpCallViewState();
}

class _HhaWakeUpCallViewState extends State<HhaWakeUpCallView> {
  int selectedTab = 0;
  String roomNumber = "";
  String callTime = "07:00";
  String callDate = DateTime.now().toString().split(' ')[0];
  String callMessage = "";
  String recurringDays = "";
  bool isRecurring = false;
  
  List<Map<String, dynamic>> wakeUpCalls = [
    {
      "id": "WC001",
      "roomNumber": "205",
      "guestName": "John Smith",
      "date": "2025-06-15",
      "time": "06:30",
      "status": "Scheduled",
      "recurring": false,
      "message": "Good morning! Your taxi will arrive at 8:00 AM",
      "attempts": 0,
      "lastAttempt": null,
    },
    {
      "id": "WC002",
      "roomNumber": "314",
      "guestName": "Sarah Johnson",
      "date": "2025-06-15",
      "time": "07:00",
      "status": "Completed",
      "recurring": true,
      "recurringDays": "Mon, Tue, Wed, Thu, Fri",
      "message": "Wake up call for business meeting",
      "attempts": 1,
      "lastAttempt": "2025-06-15 07:00:15",
    },
    {
      "id": "WC003",
      "roomNumber": "418",
      "guestName": "Mike Chen",
      "date": "2025-06-15",
      "time": "05:45",
      "status": "Failed",
      "recurring": false,
      "message": "Early flight wake up call",
      "attempts": 3,
      "lastAttempt": "2025-06-15 05:47:30",
    },
    {
      "id": "WC004",
      "roomNumber": "156",
      "guestName": "Emma Wilson",
      "date": "2025-06-15",
      "time": "08:00",
      "status": "Scheduled",
      "recurring": true,
      "recurringDays": "Daily",
      "message": "Regular morning wake up call",
      "attempts": 0,
      "lastAttempt": null,
    },
  ];

  List<Map<String, dynamic>> callTemplates = [
    {
      "name": "Standard Wake Up",
      "message": "Good morning! This is your requested wake up call from the hotel. Have a wonderful day!"
    },
    {
      "name": "Flight Reminder",
      "message": "Good morning! This is your wake up call. Please remember your flight departure time."
    },
    {
      "name": "Meeting Reminder",
      "message": "Good morning! This is your wake up call. You have an important meeting scheduled today."
    },
    {
      "name": "Checkout Reminder",
      "message": "Good morning! This is your wake up call. Please remember that checkout time is at 11:00 AM."
    },
    {
      "name": "Tour Reminder",
      "message": "Good morning! This is your wake up call. Your tour guide will meet you at the lobby."
    },
  ];

  List<Map<String, dynamic>> callHistory = [
    {
      "date": "2025-06-14",
      "totalCalls": 25,
      "successful": 22,
      "failed": 3,
      "pending": 0,
    },
    {
      "date": "2025-06-13",
      "totalCalls": 18,
      "successful": 16,
      "failed": 1,
      "pending": 1,
    },
    {
      "date": "2025-06-12",
      "totalCalls": 31,
      "successful": 28,
      "failed": 3,
      "pending": 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Wake Up Call Service",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Schedule", icon: Icon(Icons.alarm_add)),
        Tab(text: "Active Calls", icon: Icon(Icons.phone)),
        Tab(text: "Templates", icon: Icon(Icons.message)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildScheduleTab(),
        _buildActiveCallsTab(),
        _buildTemplatesTab(),
        _buildHistoryTab(),
      ],
    );
  }

  Widget _buildScheduleTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Room Information
          Container(
            padding: EdgeInsets.all(spSm),
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
                  "Room Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QTextField(
                  label: "Room Number",
                  value: roomNumber,
                  hint: "Enter room number (e.g., 205, 314)",
                  onChanged: (value) {
                    roomNumber = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Schedule Settings
          Container(
            padding: EdgeInsets.all(spSm),
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
                  "Schedule Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QDatePicker(
                        label: "Call Date",
                        value: DateTime.parse(callDate),
                        onChanged: (value) {
                          callDate = value.toString().split(' ')[0];
                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      child: QTimePicker(
                        label: "Call Time",
                        value: TimeOfDay.fromDateTime(DateTime.parse("2025-01-01 $callTime")),
                        onChanged: (value) {
                          callTime = value!.kkmm;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Set as recurring call",
                      "value": true,
                      "checked": isRecurring,
                    }
                  ],
                  value: isRecurring ? [{"label": "Set as recurring call", "value": true, "checked": true}] : [],
                  onChanged: (values, ids) {
                    isRecurring = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                if (isRecurring) ...[
                  QDropdownField(
                    label: "Recurring Pattern",
                    items: [
                      {"label": "Daily", "value": "daily"},
                      {"label": "Weekdays (Mon-Fri)", "value": "weekdays"},
                      {"label": "Weekends (Sat-Sun)", "value": "weekends"},
                      {"label": "Custom Days", "value": "custom"},
                    ],
                    value: "daily",
                    onChanged: (value, label) {
                      recurringDays = value;
                      setState(() {});
                    },
                  ),
                ],
              ],
            ),
          ),

          // Call Message
          Container(
            padding: EdgeInsets.all(spSm),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Call Message",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QButton(
                      label: "Templates",
                      color: infoColor,
                      size: bs.sm,
                      onPressed: () {
                        selectedTab = 2;
                        setState(() {});
                      },
                    ),
                  ],
                ),
                QMemoField(
                  label: "Custom Message",
                  value: callMessage,
                  hint: "Enter personalized wake up message or use a template",
                  onChanged: (value) {
                    callMessage = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Call Preview
          if (roomNumber.isNotEmpty) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Text(
                    "Call Preview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: infoColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Room:", style: TextStyle(fontWeight: FontWeight.w600)),
                      Text(roomNumber),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Date & Time:", style: TextStyle(fontWeight: FontWeight.w600)),
                      Text("$callDate at $callTime"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Recurring:", style: TextStyle(fontWeight: FontWeight.w600)),
                      Text(isRecurring ? "Yes" : "No"),
                    ],
                  ),
                  if (callMessage.isNotEmpty) ...[
                    SizedBox(height: spXs),
                    Text("Message:", style: TextStyle(fontWeight: FontWeight.w600)),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        callMessage,
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],

          // Action Buttons
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Save Draft",
                  color: disabledBoldColor,
                  size: bs.md,
                  onPressed: () => sw("Wake up call saved as draft"),
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Schedule Call",
                  size: bs.md,
                  onPressed: () => ss("Wake up call scheduled successfully!"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActiveCallsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Quick Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              _buildStatCard("Today's Calls", "${wakeUpCalls.length}", Icons.phone, primaryColor),
              _buildStatCard("Scheduled", "${wakeUpCalls.where((c) => c["status"] == "Scheduled").length}", Icons.schedule, infoColor),
              _buildStatCard("Completed", "${wakeUpCalls.where((c) => c["status"] == "Completed").length}", Icons.check_circle, successColor),
              _buildStatCard("Failed", "${wakeUpCalls.where((c) => c["status"] == "Failed").length}", Icons.error, dangerColor),
            ],
          ),

          // Filter Options
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status Filter",
                  items: [
                    {"label": "All Status", "value": "all"},
                    {"label": "Scheduled", "value": "scheduled"},
                    {"label": "Completed", "value": "completed"},
                    {"label": "Failed", "value": "failed"},
                  ],
                  value: "all",
                  onChanged: (value, label) {},
                ),
              ),
              Expanded(
                child: QTextField(
                  label: "Search Room",
                  value: "",
                  hint: "Room number...",
                  onChanged: (value) {},
                ),
              ),
            ],
          ),

          // Wake Up Calls List
          ...wakeUpCalls.map((call) {
            Color statusColor = call["status"] == "Completed" ? successColor :
                               call["status"] == "Scheduled" ? infoColor :
                               call["status"] == "Failed" ? dangerColor : warningColor;
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(width: 4, color: statusColor),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Room ${call["roomNumber"]} - ${call["guestName"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(100),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          call["status"],
                          style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(color: disabledColor),
                  Row(
                    children: [
                      Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text("${call["date"]} at ${call["time"]}"),
                    ],
                  ),
                  if (call["recurring"] == true) ...[
                    Row(
                      children: [
                        Icon(Icons.repeat, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text("Recurring: ${call["recurringDays"] ?? "Daily"}"),
                      ],
                    ),
                  ],
                  if (call["attempts"] > 0) ...[
                    Row(
                      children: [
                        Icon(Icons.phone_forwarded, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text("Attempts: ${call["attempts"]}"),
                      ],
                    ),
                  ],
                  if (call["message"].isNotEmpty) ...[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "Message: ${call["message"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                  SizedBox(height: spSm),
                  Row(
                    spacing: spXs,
                    children: [
                      if (call["status"] == "Scheduled") ...[
                        Expanded(
                          child: QButton(
                            label: "Call Now",
                            color: successColor,
                            size: bs.sm,
                            onPressed: () => ss("Calling room ${call["roomNumber"]}"),
                          ),
                        ),
                      ],
                      if (call["status"] == "Failed") ...[
                        Expanded(
                          child: QButton(
                            label: "Retry",
                            color: warningColor,
                            size: bs.sm,
                            onPressed: () => sw("Retrying call to room ${call["roomNumber"]}"),
                          ),
                        ),
                      ],
                      Expanded(
                        child: QButton(
                          label: "Edit",
                          color: infoColor,
                          size: bs.sm,
                          onPressed: () => si("Edit wake up call"),
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Cancel",
                          color: dangerColor,
                          size: bs.sm,
                          onPressed: () => se("Wake up call cancelled"),
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

  Widget _buildTemplatesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(100)),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: infoColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Select a template to use as your wake up call message. You can customize it after selection.",
                    style: TextStyle(color: infoColor),
                  ),
                ),
              ],
            ),
          ),
          ...callTemplates.map((template) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${template["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      QButton(
                        label: "Use Template",
                        size: bs.sm,
                        onPressed: () {
                          callMessage = template["message"];
                          selectedTab = 0;
                          setState(() {});
                          ss("Template applied to call message");
                        },
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${template["message"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Date Filter
          QDatePicker(
            label: "Select Date for History",
            value: DateTime.now(),
            onChanged: (value) {},
          ),

          // Daily Statistics
          ...callHistory.map((history) {
            double successRate = (history["successful"] as int) / (history["totalCalls"] as int) * 100;
            return Container(
              padding: EdgeInsets.all(spSm),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${history["date"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(100),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${successRate.toStringAsFixed(1)}% Success",
                          style: TextStyle(
                            color: successColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 80,
                    children: [
                      _buildMiniStatCard("Total", "${history["totalCalls"]}", primaryColor),
                      _buildMiniStatCard("Success", "${history["successful"]}", successColor),
                      _buildMiniStatCard("Failed", "${history["failed"]}", dangerColor),
                      _buildMiniStatCard("Pending", "${history["pending"]}", warningColor),
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

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          top: BorderSide(width: 3, color: color),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStatCard(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
