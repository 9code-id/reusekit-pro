import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaWaitlistView extends StatefulWidget {
  const FmaWaitlistView({super.key});

  @override
  State<FmaWaitlistView> createState() => _FmaWaitlistViewState();
}

class _FmaWaitlistViewState extends State<FmaWaitlistView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedPartySize = "All";
  bool isAddingToWaitlist = false;
  
  // Add to Waitlist Form
  String customerName = "";
  String customerPhone = "";
  String partySize = "2";
  String specialRequests = "";
  String tablePreference = "Any";
  DateTime estimatedTime = DateTime.now().add(Duration(minutes: 30));
  
  List<Map<String, dynamic>> waitlistEntries = [
    {
      "id": "WL001",
      "customerName": "John Smith",
      "customerPhone": "+1 234-567-8901",
      "partySize": 4,
      "status": "Waiting",
      "joinTime": "2024-12-19 12:00",
      "estimatedTime": "2024-12-19 12:30",
      "actualWaitTime": 25,
      "tablePreference": "Booth",
      "specialRequests": "High chair needed",
      "priority": "Normal",
      "notificationsSent": 0,
      "assignedTable": "",
    },
    {
      "id": "WL002",
      "customerName": "Sarah Johnson",
      "customerPhone": "+1 234-567-8902",
      "partySize": 2,
      "status": "Ready",
      "joinTime": "2024-12-19 11:45",
      "estimatedTime": "2024-12-19 12:15",
      "actualWaitTime": 30,
      "tablePreference": "Window",
      "specialRequests": "",
      "priority": "High",
      "notificationsSent": 1,
      "assignedTable": "Table 5",
    },
    {
      "id": "WL003",
      "customerName": "Mike Wilson",
      "customerPhone": "+1 234-567-8903",
      "partySize": 6,
      "status": "Waiting",
      "joinTime": "2024-12-19 12:15",
      "estimatedTime": "2024-12-19 13:00",
      "actualWaitTime": 10,
      "tablePreference": "Large Table",
      "specialRequests": "Birthday celebration",
      "priority": "Normal",
      "notificationsSent": 0,
      "assignedTable": "",
    },
    {
      "id": "WL004",
      "customerName": "Emily Davis",
      "customerPhone": "+1 234-567-8904",
      "partySize": 3,
      "status": "Seated",
      "joinTime": "2024-12-19 11:30",
      "estimatedTime": "2024-12-19 12:00",
      "actualWaitTime": 25,
      "tablePreference": "Quiet Area",
      "specialRequests": "Wheelchair accessible",
      "priority": "High",
      "notificationsSent": 1,
      "assignedTable": "Table 12",
    },
    {
      "id": "WL005",
      "customerName": "Robert Brown",
      "customerPhone": "+1 234-567-8905",
      "partySize": 2,
      "status": "No Show",
      "joinTime": "2024-12-19 11:00",
      "estimatedTime": "2024-12-19 11:30",
      "actualWaitTime": 45,
      "tablePreference": "Any",
      "specialRequests": "",
      "priority": "Normal",
      "notificationsSent": 2,
      "assignedTable": "Table 8",
    },
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "All"},
    {"label": "Waiting", "value": "Waiting"},
    {"label": "Ready", "value": "Ready"},
    {"label": "Seated", "value": "Seated"},
    {"label": "No Show", "value": "No Show"},
  ];

  List<Map<String, dynamic>> partySizeItems = [
    {"label": "All Sizes", "value": "All"},
    {"label": "1-2 People", "value": "1-2"},
    {"label": "3-4 People", "value": "3-4"},
    {"label": "5-6 People", "value": "5-6"},
    {"label": "7+ People", "value": "7+"},
  ];

  List<Map<String, dynamic>> partySizeOptions = [
    {"label": "1", "value": "1"},
    {"label": "2", "value": "2"},
    {"label": "3", "value": "3"},
    {"label": "4", "value": "4"},
    {"label": "5", "value": "5"},
    {"label": "6", "value": "6"},
    {"label": "7", "value": "7"},
    {"label": "8", "value": "8"},
  ];

  List<Map<String, dynamic>> tablePreferenceItems = [
    {"label": "Any", "value": "Any"},
    {"label": "Booth", "value": "Booth"},
    {"label": "Window", "value": "Window"},
    {"label": "Quiet Area", "value": "Quiet Area"},
    {"label": "Large Table", "value": "Large Table"},
    {"label": "Bar Seating", "value": "Bar Seating"},
  ];

  List<Map<String, dynamic>> get filteredWaitlist {
    return waitlistEntries.where((entry) {
      bool matchesSearch = entry["customerName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          entry["customerPhone"].toString().contains(searchQuery);
      
      bool matchesStatus = selectedStatus == "All" || entry["status"] == selectedStatus;
      
      bool matchesPartySize = selectedPartySize == "All" ||
                             (selectedPartySize == "1-2" && entry["partySize"] <= 2) ||
                             (selectedPartySize == "3-4" && entry["partySize"] >= 3 && entry["partySize"] <= 4) ||
                             (selectedPartySize == "5-6" && entry["partySize"] >= 5 && entry["partySize"] <= 6) ||
                             (selectedPartySize == "7+" && entry["partySize"] >= 7);
      
      return matchesSearch && matchesStatus && matchesPartySize;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Waiting": return warningColor;
      case "Ready": return primaryColor;
      case "Seated": return successColor;
      case "No Show": return dangerColor;
      default: return disabledBoldColor;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status) {
      case "Waiting": return Icons.schedule;
      case "Ready": return Icons.notifications_active;
      case "Seated": return Icons.event_seat;
      case "No Show": return Icons.person_off;
      default: return Icons.help;
    }
  }

  String getWaitTimeDisplay(int minutes) {
    if (minutes < 60) {
      return "${minutes}m";
    } else {
      int hours = minutes ~/ 60;
      int remainingMinutes = minutes % 60;
      return "${hours}h ${remainingMinutes}m";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Waitlist Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () {
              isAddingToWaitlist = true;
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filters
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
                    label: "Search Waitlist",
                    value: searchQuery,
                    hint: "Search by name or phone",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: statusItems,
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Party Size",
                          items: partySizeItems,
                          value: selectedPartySize,
                          onChanged: (value, label) {
                            selectedPartySize = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Add to Waitlist Form
            if (isAddingToWaitlist)
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border.all(color: primaryColor.withAlpha(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person_add, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Add to Waitlist",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            isAddingToWaitlist = false;
                            // Reset form
                            customerName = "";
                            customerPhone = "";
                            partySize = "2";
                            specialRequests = "";
                            tablePreference = "Any";
                            estimatedTime = DateTime.now().add(Duration(minutes: 30));
                            setState(() {});
                          },
                          child: Icon(Icons.close, color: disabledBoldColor, size: 20),
                        ),
                      ],
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Customer Name",
                            value: customerName,
                            validator: Validator.required,
                            onChanged: (value) {
                              customerName = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QTextField(
                            label: "Phone Number",
                            value: customerPhone,
                            hint: "+1 234-567-8900",
                            validator: Validator.required,
                            onChanged: (value) {
                              customerPhone = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Party Size",
                            items: partySizeOptions,
                            value: partySize,
                            onChanged: (value, label) {
                              partySize = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QDropdownField(
                            label: "Table Preference",
                            items: tablePreferenceItems,
                            value: tablePreference,
                            onChanged: (value, label) {
                              tablePreference = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QTimePicker(
                      label: "Estimated Wait Time",
                      value: TimeOfDay.fromDateTime(estimatedTime),
                      onChanged: (value) {
                        if (value != null) {
                          estimatedTime = DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            value.hour,
                            value.minute,
                          );
                          setState(() {});
                        }
                      },
                    ),
                    QMemoField(
                      label: "Special Requests",
                      value: specialRequests,
                      hint: "Any special requirements or notes",
                      onChanged: (value) {
                        specialRequests = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Add to Waitlist",
                            onPressed: () {
                              if (customerName.isNotEmpty && customerPhone.isNotEmpty) {
                                waitlistEntries.insert(0, {
                                  "id": "WL${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}",
                                  "customerName": customerName,
                                  "customerPhone": customerPhone,
                                  "partySize": int.parse(partySize),
                                  "status": "Waiting",
                                  "joinTime": DateTime.now().toIso8601String(),
                                  "estimatedTime": estimatedTime.toIso8601String(),
                                  "actualWaitTime": 0,
                                  "tablePreference": tablePreference,
                                  "specialRequests": specialRequests,
                                  "priority": "Normal",
                                  "notificationsSent": 0,
                                  "assignedTable": "",
                                });
                                isAddingToWaitlist = false;
                                customerName = "";
                                customerPhone = "";
                                partySize = "2";
                                specialRequests = "";
                                tablePreference = "Any";
                                ss("Customer added to waitlist");
                                setState(() {});
                              }
                            },
                          ),
                        ),
                        QButton(
                          label: "Cancel",
                          color: disabledBoldColor,
                          size: bs.sm,
                          onPressed: () {
                            isAddingToWaitlist = false;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            // Waitlist Statistics
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
                    "Waitlist Overview",
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
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${waitlistEntries.where((e) => e["status"] == "Waiting").length}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Waiting",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${waitlistEntries.where((e) => e["status"] == "Ready").length}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Ready",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${waitlistEntries.where((e) => e["status"] == "Seated").length}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Seated",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${(waitlistEntries.where((e) => e["status"] == "Waiting" || e["status"] == "Ready").fold(0, (sum, e) => sum + (e["actualWaitTime"] as int)) / waitlistEntries.where((e) => e["status"] == "Waiting" || e["status"] == "Ready").length).round()}m",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "Avg Wait",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
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

            // Waitlist
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
                      Icon(Icons.people, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Waitlist (${filteredWaitlist.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ...filteredWaitlist.map((entry) {
                    String status = entry["status"];
                    Color statusColor = getStatusColor(status);
                    IconData statusIcon = getStatusIcon(status);
                    String waitTime = getWaitTimeDisplay(entry["actualWaitTime"] as int);
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: statusColor.withAlpha(50)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: statusColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Icon(
                                  statusIcon,
                                  color: statusColor,
                                  size: 18,
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
                                          "${entry["customerName"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        SizedBox(width: spXs),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: statusColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            status,
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: statusColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${entry["customerPhone"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.group, size: 12, color: primaryColor),
                                        SizedBox(width: 4),
                                        Text(
                                          "Party of ${entry["partySize"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: primaryColor,
                                          ),
                                        ),
                                        if (entry["tablePreference"] != "Any") ...[
                                          SizedBox(width: spSm),
                                          Icon(Icons.table_restaurant, size: 12, color: infoColor),
                                          SizedBox(width: 4),
                                          Text(
                                            "${entry["tablePreference"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: infoColor,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    waitTime,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: entry["actualWaitTime"] > 45 ? dangerColor : warningColor,
                                    ),
                                  ),
                                  Text(
                                    "waited",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  if (entry["assignedTable"].toString().isNotEmpty)
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      margin: EdgeInsets.only(top: 4),
                                      decoration: BoxDecoration(
                                        color: successColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${entry["assignedTable"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: successColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                          
                          if (entry["specialRequests"].toString().isNotEmpty) ...[
                            SizedBox(height: spSm),
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.note, color: infoColor, size: 12),
                                  SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      "${entry["specialRequests"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: infoColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          
                          SizedBox(height: spSm),
                          
                          Row(
                            children: [
                              Text(
                                "Joined: ${TimeOfDay.fromDateTime(DateTime.parse(entry["joinTime"])).kkmm}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "ETA: ${TimeOfDay.fromDateTime(DateTime.parse(entry["estimatedTime"])).kkmm}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Row(
                                spacing: spXs,
                                children: [
                                  if (status == "Waiting")
                                    GestureDetector(
                                      onTap: () {
                                        entry["status"] = "Ready";
                                        entry["assignedTable"] = "Table ${(entry["partySize"] as int) + 5}";
                                        ss("${entry["customerName"]} notified - table ready");
                                        setState(() {});
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(spXs),
                                        decoration: BoxDecoration(
                                          color: primaryColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Icon(
                                          Icons.notifications_active,
                                          color: primaryColor,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  if (status == "Ready")
                                    GestureDetector(
                                      onTap: () {
                                        entry["status"] = "Seated";
                                        ss("${entry["customerName"]} seated at ${entry["assignedTable"]}");
                                        setState(() {});
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(spXs),
                                        decoration: BoxDecoration(
                                          color: successColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Icon(
                                          Icons.event_seat,
                                          color: successColor,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  GestureDetector(
                                    onTap: () {
                                      ss("Calling ${entry["customerName"]}...");
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(spXs),
                                      decoration: BoxDecoration(
                                        color: infoColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Icon(
                                        Icons.call,
                                        color: infoColor,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  if (status == "Waiting" || status == "Ready")
                                    GestureDetector(
                                      onTap: () async {
                                        bool isConfirmed = await confirm("Mark ${entry["customerName"]} as no show?");
                                        if (isConfirmed) {
                                          entry["status"] = "No Show";
                                          ss("${entry["customerName"]} marked as no show");
                                          setState(() {});
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(spXs),
                                        decoration: BoxDecoration(
                                          color: dangerColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Icon(
                                          Icons.person_off,
                                          color: dangerColor,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
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
