import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmMobileCheckInView extends StatefulWidget {
  const FsmMobileCheckInView({super.key});

  @override
  State<FsmMobileCheckInView> createState() => _FsmMobileCheckInViewState();
}

class _FsmMobileCheckInViewState extends State<FsmMobileCheckInView> {
  bool isCheckedIn = false;
  String currentLocation = "";
  String notes = "";
  String selectedWorkOrder = "";
  String selectedActivity = "";
  
  String currentShift = "Day Shift (08:00 - 17:00)";
  String lastCheckIn = "";
  String totalHoursToday = "0.0";
  
  List<Map<String, dynamic>> checkInHistory = [
    {
      "id": "CHK-001",
      "type": "Check In",
      "timestamp": "2024-12-20 08:15:00",
      "location": "Main Office",
      "workOrder": "WO-2024-001",
      "activity": "HVAC Maintenance",
      "notes": "Starting morning shift, reviewing work order details",
      "coordinates": "40.7128,-74.0060",
    },
    {
      "id": "CHK-002",
      "type": "Location Update",
      "timestamp": "2024-12-20 09:30:00",
      "location": "Metro Office Complex",
      "workOrder": "WO-2024-001",
      "activity": "On Site",
      "notes": "Arrived at customer location, beginning inspection",
      "coordinates": "40.7589,-73.9851",
    },
    {
      "id": "CHK-003",
      "type": "Break Start",
      "timestamp": "2024-12-20 12:00:00",
      "location": "Metro Office Complex",
      "workOrder": "",
      "activity": "Lunch Break",
      "notes": "Taking lunch break, will resume work at 13:00",
      "coordinates": "40.7589,-73.9851",
    },
    {
      "id": "CHK-004",
      "type": "Break End",
      "timestamp": "2024-12-20 13:00:00",
      "location": "Metro Office Complex",
      "workOrder": "WO-2024-001",
      "activity": "HVAC Maintenance",
      "notes": "Resuming work after lunch break",
      "coordinates": "40.7589,-73.9851",
    },
  ];

  List<Map<String, dynamic>> availableWorkOrders = [
    {"label": "WO-2024-001 - HVAC Maintenance", "value": "WO-2024-001"},
    {"label": "WO-2024-002 - Plumbing Repair", "value": "WO-2024-002"},
    {"label": "WO-2024-003 - Electrical Installation", "value": "WO-2024-003"},
  ];

  List<Map<String, dynamic>> activities = [
    {"label": "On Site", "value": "On Site"},
    {"label": "Travel to Location", "value": "Travel"},
    {"label": "Equipment Setup", "value": "Setup"},
    {"label": "Maintenance Work", "value": "Maintenance"},
    {"label": "Repair Work", "value": "Repair"},
    {"label": "Installation", "value": "Installation"},
    {"label": "Inspection", "value": "Inspection"},
    {"label": "Customer Meeting", "value": "Meeting"},
    {"label": "Lunch Break", "value": "Lunch"},
    {"label": "Coffee Break", "value": "Break"},
    {"label": "Administrative Work", "value": "Admin"},
    {"label": "Return to Base", "value": "Return"},
  ];

  Color getCheckInTypeColor(String type) {
    switch (type) {
      case "Check In":
        return successColor;
      case "Check Out":
        return dangerColor;
      case "Break Start":
        return warningColor;
      case "Break End":
        return infoColor;
      case "Location Update":
        return primaryColor;
      default:
        return disabledColor;
    }
  }

  IconData getCheckInTypeIcon(String type) {
    switch (type) {
      case "Check In":
        return Icons.login;
      case "Check Out":
        return Icons.logout;
      case "Break Start":
        return Icons.pause;
      case "Break End":
        return Icons.play_arrow;
      case "Location Update":
        return Icons.location_on;
      default:
        return Icons.schedule;
    }
  }

  void performCheckIn() async {
    if (currentLocation.isEmpty) {
      se("Please enter your current location");
      return;
    }
    
    showLoading();
    
    // Simulate check-in process
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    
    setState(() {
      isCheckedIn = !isCheckedIn;
      lastCheckIn = DateTime.now().toString();
      if (!isCheckedIn) {
        totalHoursToday = "8.5";
      }
    });
    
    String action = isCheckedIn ? "checked in" : "checked out";
    ss("Successfully $action at $currentLocation");
    
    // Clear form
    currentLocation = "";
    notes = "";
    selectedWorkOrder = "";
    selectedActivity = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mobile Check-In"),
        actions: [
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () {
              // Get current GPS location
              ss("Getting current location...");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Current Status Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isCheckedIn ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: isCheckedIn ? successColor : warningColor,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    isCheckedIn ? Icons.check_circle : Icons.schedule,
                    size: 48,
                    color: isCheckedIn ? successColor : warningColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    isCheckedIn ? "CHECKED IN" : "NOT CHECKED IN",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: isCheckedIn ? successColor : warningColor,
                    ),
                  ),
                  if (lastCheckIn.isNotEmpty)
                    Text(
                      "Last: ${DateTime.parse(lastCheckIn).dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  SizedBox(height: spSm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Current Shift",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            currentShift,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Hours Today",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${totalHoursToday}h",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Check-In Form
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
                    children: [
                      Icon(
                        isCheckedIn ? Icons.logout : Icons.login,
                        color: primaryColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        isCheckedIn ? "Check Out" : "Check In",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QTextField(
                    label: "Current Location",
                    value: currentLocation,
                    hint: "Enter your current location",
                    validator: Validator.required,
                    onChanged: (value) {
                      currentLocation = value;
                      setState(() {});
                    },
                  ),
                  if (!isCheckedIn)
                    QDropdownField(
                      label: "Work Order (Optional)",
                      items: availableWorkOrders,
                      value: selectedWorkOrder,
                      onChanged: (value, label) {
                        selectedWorkOrder = value;
                        setState(() {});
                      },
                    ),
                  QDropdownField(
                    label: "Activity",
                    items: activities,
                    value: selectedActivity,
                    onChanged: (value, label) {
                      selectedActivity = value;
                      setState(() {});
                    },
                  ),
                  QMemoField(
                    label: "Notes (Optional)",
                    value: notes,
                    hint: "Add any additional notes...",
                    onChanged: (value) {
                      notes = value;
                      setState(() {});
                    },
                  ),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: isCheckedIn ? "Check Out" : "Check In",
                      color: isCheckedIn ? dangerColor : successColor,
                      onPressed: performCheckIn,
                    ),
                  ),
                ],
              ),
            ),

            // Quick Actions
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
                    children: [
                      Icon(Icons.flash_on, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Quick Actions",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Start Break",
                          color: warningColor,
                          size: bs.sm,
                          onPressed: () async {
                            bool isConfirmed = await confirm("Start break time?");
                            if (isConfirmed) {
                              ss("Break time started");
                            }
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "End Break",
                          color: infoColor,
                          size: bs.sm,
                          onPressed: () async {
                            bool isConfirmed = await confirm("End break time?");
                            if (isConfirmed) {
                              ss("Break time ended");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Emergency Check-In",
                          color: dangerColor,
                          size: bs.sm,
                          onPressed: () {
                            ss("Emergency check-in recorded");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Update Location",
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo('LocationUpdateView')
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Today's Check-In History
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.history, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "Today's Check-In History",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...checkInHistory.map((entry) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
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
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: getCheckInTypeColor("${entry["type"]}").withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Icon(
                              getCheckInTypeIcon("${entry["type"]}"),
                              color: getCheckInTypeColor("${entry["type"]}"),
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${entry["type"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${DateTime.parse("${entry["timestamp"]}").kkmm}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${entry["location"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                if ("${entry["activity"]}".isNotEmpty)
                                  Text(
                                    "Activity: ${entry["activity"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                if ("${entry["notes"]}".isNotEmpty)
                                  Text(
                                    "${entry["notes"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontStyle: FontStyle.italic,
                                      color: disabledBoldColor,
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
          ],
        ),
      ),
    );
  }
}
