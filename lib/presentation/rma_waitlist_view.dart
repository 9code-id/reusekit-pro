import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaWaitlistView extends StatefulWidget {
  const RmaWaitlistView({super.key});

  @override
  State<RmaWaitlistView> createState() => _RmaWaitlistViewState();
}

class _RmaWaitlistViewState extends State<RmaWaitlistView> {
  String selectedTimeSlot = "all";
  String sortBy = "waitTime";
  bool showNotified = false;
  
  List<Map<String, dynamic>> waitlistEntries = [
    {
      "id": "WAIT-001",
      "customerName": "Jennifer Smith",
      "customerPhone": "+1-555-0123",
      "partySize": 4,
      "estimatedWaitTime": 25,
      "actualWaitTime": 28,
      "timeAdded": "18:30",
      "requestedTable": "booth",
      "priority": "high",
      "status": "waiting",
      "notified": false,
      "specialRequests": "High chair needed",
      "notes": "Birthday celebration",
      "quotedTime": "19:00",
    },
    {
      "id": "WAIT-002", 
      "customerName": "Mark Johnson",
      "customerPhone": "+1-555-0456",
      "partySize": 2,
      "estimatedWaitTime": 15,
      "actualWaitTime": 12,
      "timeAdded": "19:00",
      "requestedTable": "window",
      "priority": "normal",
      "status": "notified",
      "notified": true,
      "specialRequests": "Quiet table",
      "notes": "Anniversary dinner",
      "quotedTime": "19:15",
    },
    {
      "id": "WAIT-003",
      "customerName": "Lisa Chen",
      "customerPhone": "+1-555-0789",
      "partySize": 6,
      "estimatedWaitTime": 35,
      "actualWaitTime": 40,
      "timeAdded": "18:45",
      "requestedTable": "large",
      "priority": "high",
      "status": "waiting",
      "notified": false,
      "specialRequests": "Vegetarian options",
      "notes": "Family dinner with elderly parents",
      "quotedTime": "19:20",
    },
    {
      "id": "WAIT-004",
      "customerName": "Robert Davis",
      "customerPhone": "+1-555-0321",
      "partySize": 3,
      "estimatedWaitTime": 20,
      "actualWaitTime": 18,
      "timeAdded": "19:15",
      "requestedTable": "standard",
      "priority": "normal",
      "status": "seated",
      "notified": true,
      "specialRequests": "Gluten-free menu",
      "notes": "Regular customer",
      "quotedTime": "19:35",
    },
    {
      "id": "WAIT-005",
      "customerName": "Sarah Wilson",
      "customerPhone": "+1-555-0654",
      "partySize": 8,
      "estimatedWaitTime": 45,
      "actualWaitTime": 50,
      "timeAdded": "18:15",
      "requestedTable": "private",
      "priority": "vip",
      "status": "cancelled",
      "notified": false,
      "specialRequests": "Private room",
      "notes": "Business meeting",
      "quotedTime": "19:00",
    },
  ];

  List<Map<String, dynamic>> timeSlotOptions = [
    {"label": "All Times", "value": "all"},
    {"label": "Current Hour", "value": "current"},
    {"label": "Next 30 min", "value": "next30"},
    {"label": "Next Hour", "value": "nextHour"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Wait Time", "value": "waitTime"},
    {"label": "Party Size", "value": "partySize"},
    {"label": "Priority", "value": "priority"},
    {"label": "Time Added", "value": "timeAdded"},
  ];

  Widget _buildWaitlistStats() {
    final activeWaiting = waitlistEntries.where((e) => e["status"] == "waiting").length;
    final totalGuests = waitlistEntries.where((e) => e["status"] == "waiting")
        .map((e) => e["partySize"] as int).fold(0, (a, b) => a + b);
    final avgWaitTime = waitlistEntries.where((e) => e["status"] != "waiting" && e["actualWaitTime"] != null)
        .map((e) => e["actualWaitTime"] as int).fold(0, (a, b) => a + b) / 
        waitlistEntries.where((e) => e["status"] != "waiting").length;
    final readyToSeat = waitlistEntries.where((e) => e["status"] == "notified").length;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Waitlist Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildStatCard(
                "Active Waiting",
                "$activeWaiting",
                Icons.hourglass_empty,
                warningColor,
              ),
              _buildStatCard(
                "Total Guests",
                "$totalGuests",
                Icons.people,
                primaryColor,
              ),
              _buildStatCard(
                "Avg. Wait Time",
                "${avgWaitTime.round()} min",
                Icons.timer,
                infoColor,
              ),
              _buildStatCard(
                "Ready to Seat",
                "$readyToSeat",
                Icons.notifications,
                successColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Time Filter",
                  items: timeSlotOptions,
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
                  label: "Sort By",
                  items: sortOptions,
                  value: sortBy,
                  onChanged: (value, label) {
                    sortBy = value;
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
                      "label": "Show Notified Only",
                      "value": true,
                      "checked": showNotified,
                    }
                  ],
                  value: [
                    if (showNotified)
                      {
                        "label": "Show Notified Only",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    showNotified = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWaitlistCard(Map<String, dynamic> entry) {
    final statusColor = entry["status"] == "waiting" ? warningColor :
                       entry["status"] == "notified" ? successColor :
                       entry["status"] == "seated" ? infoColor :
                       entry["status"] == "cancelled" ? dangerColor :
                       disabledBoldColor;

    final priorityColor = entry["priority"] == "vip" ? warningColor :
                         entry["priority"] == "high" ? dangerColor :
                         primaryColor;

    final statusIcon = entry["status"] == "waiting" ? Icons.hourglass_empty :
                      entry["status"] == "notified" ? Icons.notifications :
                      entry["status"] == "seated" ? Icons.event_seat :
                      entry["status"] == "cancelled" ? Icons.cancel :
                      Icons.people;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${entry["customerName"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: priorityColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${entry["priority"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: priorityColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.people, color: infoColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "${entry["partySize"]} guests",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(Icons.table_restaurant, color: primaryColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "${entry["requestedTable"]} table",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(statusIcon, color: statusColor, size: 12),
                        SizedBox(width: spXs),
                        Text(
                          "${entry["status"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spXs),
                  if (entry["status"] == "waiting")
                    Text(
                      "${entry["estimatedWaitTime"]} min",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    )
                  else
                    Text(
                      "Waited ${entry["actualWaitTime"]} min",
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
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.access_time, color: disabledBoldColor, size: 14),
                        SizedBox(width: spXs),
                        Text(
                          "Added: ${entry["timeAdded"]} • Quoted: ${entry["quotedTime"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    if (entry["specialRequests"] != null && entry["specialRequests"] != "") ...[
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(Icons.info, color: warningColor, size: 14),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${entry["specialRequests"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: warningColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              if (entry["notified"] == true)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.notifications, color: successColor, size: 14),
                      SizedBox(width: spXs),
                      Text(
                        "NOTIFIED",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          if (entry["notes"] != null && entry["notes"] != "") ...[
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.note, color: infoColor, size: 16),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${entry["notes"]}",
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
          SizedBox(height: spMd),
          if (entry["status"] == "waiting") ...[
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Notify Customer",
                    icon: Icons.notifications,
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('NotifyCustomer')
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.event_seat,
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('SeatCustomer')
                  },
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.phone,
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('CallCustomer')
                  },
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.close,
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('RemoveFromWaitlist')
                  },
                ),
              ],
            ),
          ] else if (entry["status"] == "notified") ...[
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Seat Now",
                    icon: Icons.event_seat,
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('SeatCustomer')
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.phone,
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('CallCustomer')
                  },
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.update,
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('UpdateWaitTime')
                  },
                ),
              ],
            ),
          ] else ...[
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "View Details",
                    icon: Icons.info,
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('ViewWaitlistDetails')
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.history,
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('WaitlistHistory')
                  },
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  List<Map<String, dynamic>> get filteredEntries {
    List<Map<String, dynamic>> filtered = List.from(waitlistEntries);
    
    // Apply notified filter
    if (showNotified) {
      filtered = filtered.where((entry) => entry["notified"] == true).toList();
    }
    
    // Apply sorting
    switch (sortBy) {
      case "waitTime":
        filtered.sort((a, b) => (b["estimatedWaitTime"] as int).compareTo(a["estimatedWaitTime"] as int));
        break;
      case "partySize":
        filtered.sort((a, b) => (b["partySize"] as int).compareTo(a["partySize"] as int));
        break;
      case "priority":
        final priorityOrder = {"vip": 3, "high": 2, "normal": 1};
        filtered.sort((a, b) => (priorityOrder[b["priority"]] ?? 0).compareTo(priorityOrder[a["priority"]] ?? 0));
        break;
      case "timeAdded":
        filtered.sort((a, b) => a["timeAdded"].compareTo(b["timeAdded"]));
        break;
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Waitlist"),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              //navigateTo('AddToWaitlist')
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              //navigateTo('WaitlistAnalytics')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildWaitlistStats(),
            _buildFilters(),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Waitlist (${filteredEntries.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Add to Waitlist",
                        icon: Icons.person_add,
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('AddToWaitlist')
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  if (filteredEntries.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        children: [
                          Icon(
                            Icons.event_busy,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No waitlist entries",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Column(
                      children: filteredEntries.map((entry) => _buildWaitlistCard(entry)).toList(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
