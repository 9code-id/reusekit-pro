import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsWaitlistView extends StatefulWidget {
  const RfsWaitlistView({super.key});

  @override
  State<RfsWaitlistView> createState() => _RfsWaitlistViewState();
}

class _RfsWaitlistViewState extends State<RfsWaitlistView> {
  String selectedFilter = "All";
  String sortBy = "Position";
  
  String guestName = "";
  String guestPhone = "";
  int partySize = 2;
  String preferredTable = "";
  String estimatedWait = "15-20 minutes";

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Waiting", "value": "All"},
    {"label": "Immediate", "value": "Immediate"},
    {"label": "Short Wait", "value": "Short"},
    {"label": "Long Wait", "value": "Long"},
    {"label": "VIP Priority", "value": "VIP"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Position", "value": "Position"},
    {"label": "Wait Time", "value": "WaitTime"},
    {"label": "Party Size", "value": "PartySize"},
    {"label": "Priority", "value": "Priority"},
  ];

  List<Map<String, dynamic>> partySizeOptions = [
    {"label": "1 Guest", "value": 1},
    {"label": "2 Guests", "value": 2},
    {"label": "3 Guests", "value": 3},
    {"label": "4 Guests", "value": 4},
    {"label": "5 Guests", "value": 5},
    {"label": "6 Guests", "value": 6},
    {"label": "7 Guests", "value": 7},
    {"label": "8+ Guests", "value": 8},
  ];

  List<Map<String, dynamic>> tablePreferences = [
    {"label": "No Preference", "value": ""},
    {"label": "Window Table", "value": "Window"},
    {"label": "Booth", "value": "Booth"},
    {"label": "Bar Counter", "value": "Bar"},
    {"label": "Outdoor Terrace", "value": "Outdoor"},
    {"label": "Quiet Area", "value": "Quiet"},
  ];

  List<Map<String, dynamic>> estimatedWaitOptions = [
    {"label": "5-10 minutes", "value": "5-10 minutes"},
    {"label": "10-15 minutes", "value": "10-15 minutes"},
    {"label": "15-20 minutes", "value": "15-20 minutes"},
    {"label": "20-30 minutes", "value": "20-30 minutes"},
    {"label": "30-45 minutes", "value": "30-45 minutes"},
    {"label": "45+ minutes", "value": "45+ minutes"},
  ];

  List<Map<String, dynamic>> waitlist = [
    {
      "id": "W001",
      "position": 1,
      "guestName": "Miller Family",
      "phone": "+1 234-567-8901",
      "partySize": 4,
      "joinTime": "7:15 PM",
      "waitTime": "12 minutes",
      "estimatedWait": "15-20 minutes",
      "priority": "VIP",
      "preferredTable": "Window",
      "notes": "Anniversary dinner",
      "notified": false,
      "tableReady": true,
      "status": "Ready",
    },
    {
      "id": "W002",
      "position": 2,
      "guestName": "Johnson",
      "phone": "+1 234-567-8902",
      "partySize": 2,
      "joinTime": "7:20 PM",
      "waitTime": "7 minutes",
      "estimatedWait": "10-15 minutes",
      "priority": "Normal",
      "preferredTable": "Booth",
      "notes": null,
      "notified": false,
      "tableReady": false,
      "status": "Waiting",
    },
    {
      "id": "W003",
      "position": 3,
      "guestName": "Davis Party",
      "phone": "+1 234-567-8903",
      "partySize": 6,
      "joinTime": "7:10 PM",
      "waitTime": "17 minutes",
      "estimatedWait": "20-30 minutes",
      "priority": "Normal",
      "preferredTable": "",
      "notes": "Large group, flexible timing",
      "notified": true,
      "tableReady": false,
      "status": "Waiting",
    },
    {
      "id": "W004",
      "position": 4,
      "guestName": "Wilson",
      "phone": "+1 234-567-8904",
      "partySize": 3,
      "joinTime": "7:25 PM",
      "waitTime": "2 minutes",
      "estimatedWait": "15-20 minutes",
      "priority": "Normal",
      "preferredTable": "Outdoor",
      "notes": "Weather permitting",
      "notified": false,
      "tableReady": false,
      "status": "Waiting",
    },
    {
      "id": "W005",
      "position": 5,
      "guestName": "Brown Family",
      "phone": "+1 234-567-8905",
      "partySize": 5,
      "joinTime": "7:18 PM",
      "waitTime": "9 minutes",
      "estimatedWait": "25-30 minutes",
      "priority": "Normal",
      "preferredTable": "",
      "notes": "Birthday celebration, high chair needed",
      "notified": false,
      "tableReady": false,
      "status": "Waiting",
    },
  ];

  List<Map<String, dynamic>> get filteredWaitlist {
    var filtered = waitlist.where((entry) {
      switch (selectedFilter) {
        case "Immediate":
          return entry["status"] == "Ready";
        case "Short":
          return entry["estimatedWait"].contains("5-10") || entry["estimatedWait"].contains("10-15");
        case "Long":
          return entry["estimatedWait"].contains("30") || entry["estimatedWait"].contains("45");
        case "VIP":
          return entry["priority"] == "VIP";
        default:
          return true;
      }
    }).toList();

    // Sort the filtered list
    filtered.sort((a, b) {
      switch (sortBy) {
        case "Position":
          return (a["position"] as int).compareTo(b["position"] as int);
        case "WaitTime":
          return int.parse(b["waitTime"].split(" ")[0]).compareTo(int.parse(a["waitTime"].split(" ")[0]));
        case "PartySize":
          return (b["partySize"] as int).compareTo(a["partySize"] as int);
        case "Priority":
          if (a["priority"] == "VIP" && b["priority"] != "VIP") return -1;
          if (b["priority"] == "VIP" && a["priority"] != "VIP") return 1;
          return 0;
        default:
          return 0;
      }
    });

    return filtered;
  }

  Map<String, dynamic> get waitlistStats {
    return {
      "total": waitlist.length,
      "ready": waitlist.where((w) => w["status"] == "Ready").length,
      "vip": waitlist.where((w) => w["priority"] == "VIP").length,
      "avgWait": waitlist.isNotEmpty 
        ? "${(waitlist.map((w) => int.parse(w["waitTime"].split(" ")[0])).reduce((a, b) => a + b) / waitlist.length).round()} min"
        : "0 min",
    };
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "VIP":
        return Color(0xFFFFD700);
      default:
        return primaryColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Ready":
        return successColor;
      case "Waiting":
        return warningColor;
      case "Notified":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  void _addToWaitlist() async {
    if (guestName.isEmpty || guestPhone.isEmpty) {
      se("Please fill in guest name and phone number");
      return;
    }

    bool isConfirmed = await confirm("Add $guestName to the waitlist?");
    if (isConfirmed) {
      setState(() {
        waitlist.add({
          "id": "W${(waitlist.length + 1).toString().padLeft(3, '0')}",
          "position": waitlist.length + 1,
          "guestName": guestName,
          "phone": guestPhone,
          "partySize": partySize,
          "joinTime": TimeOfDay.now().kkmm,
          "waitTime": "0 minutes",
          "estimatedWait": estimatedWait,
          "priority": "Normal",
          "preferredTable": preferredTable,
          "notes": null,
          "notified": false,
          "tableReady": false,
          "status": "Waiting",
        });

        // Reset form
        guestName = "";
        guestPhone = "";
        partySize = 2;
        preferredTable = "";
        estimatedWait = "15-20 minutes";
      });

      ss("$guestName added to waitlist successfully!");
    }
  }

  void _seatGuest(Map<String, dynamic> entry) async {
    bool isConfirmed = await confirm("Seat ${entry["guestName"]} now?");
    if (isConfirmed) {
      setState(() {
        waitlist.remove(entry);
        // Update positions
        for (int i = 0; i < waitlist.length; i++) {
          waitlist[i]["position"] = i + 1;
        }
      });
      ss("${entry["guestName"]} has been seated");
    }
  }

  void _notifyGuest(Map<String, dynamic> entry) {
    setState(() {
      entry["notified"] = true;
      entry["status"] = "Notified";
    });
    ss("${entry["guestName"]} has been notified");
  }

  void _markTableReady(Map<String, dynamic> entry) {
    setState(() {
      entry["tableReady"] = true;
      entry["status"] = "Ready";
    });
    ss("Table ready for ${entry["guestName"]}");
  }

  void _removeFromWaitlist(Map<String, dynamic> entry) async {
    bool isConfirmed = await confirm("Remove ${entry["guestName"]} from waitlist?");
    if (isConfirmed) {
      setState(() {
        waitlist.remove(entry);
        // Update positions
        for (int i = 0; i < waitlist.length; i++) {
          waitlist[i]["position"] = i + 1;
        }
      });
      ss("${entry["guestName"]} removed from waitlist");
    }
  }

  void _editWaitlistEntry(Map<String, dynamic> entry) {
    si("Editing waitlist entry for ${entry["guestName"]}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Waitlist Management"),
        actions: [
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: () {
              setState(() {});
              si("Waitlist refreshed");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Waitlist Stats
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildStatCard("Total Waiting", "${waitlistStats["total"]}", Icons.people_alt, primaryColor),
                _buildStatCard("Ready to Seat", "${waitlistStats["ready"]}", Icons.check_circle, successColor),
                _buildStatCard("VIP Priority", "${waitlistStats["vip"]}", Icons.star, Color(0xFFFFD700)),
                _buildStatCard("Avg Wait Time", "${waitlistStats["avgWait"]}", Icons.timer, warningColor),
              ],
            ),

            // Add to Waitlist Form
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.add_circle, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Add to Waitlist",
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
                        child: QTextField(
                          label: "Guest Name*",
                          value: guestName,
                          hint: "Enter guest name",
                          onChanged: (value) {
                            guestName = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTextField(
                          label: "Phone Number*",
                          value: guestPhone,
                          hint: "+1 234-567-8900",
                          onChanged: (value) {
                            guestPhone = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  Row(
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
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Table Preference",
                          items: tablePreferences,
                          value: preferredTable,
                          onChanged: (value, label) {
                            preferredTable = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Estimated Wait",
                          items: estimatedWaitOptions,
                          value: estimatedWait,
                          onChanged: (value, label) {
                            estimatedWait = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "Add to Waitlist",
                        onPressed: _addToWaitlist,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Filter",
                    items: filterOptions,
                    value: selectedFilter,
                    onChanged: (value, label) {
                      selectedFilter = value;
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

            // Waitlist
            Text(
              "Current Waitlist (${filteredWaitlist.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            if (filteredWaitlist.isEmpty) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.event_available, size: 64, color: disabledColor),
                    SizedBox(height: spSm),
                    Text(
                      "No one waiting",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "The waitlist is currently empty",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              Column(
                spacing: spSm,
                children: filteredWaitlist.map((entry) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: _getStatusColor(entry["status"]),
                        ),
                      ),
                    ),
                    child: Column(
                      spacing: spSm,
                      children: [
                        // Entry Header
                        Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: entry["priority"] == "VIP" ? Color(0xFFFFD700) : primaryColor,
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Center(
                                child: Text(
                                  "${entry["position"]}",
                                  style: TextStyle(
                                    color: entry["priority"] == "VIP" ? Colors.black : Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
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
                                        "${entry["guestName"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      if (entry["priority"] == "VIP") ...[
                                        SizedBox(width: 4),
                                        Icon(Icons.star, color: Color(0xFFFFD700), size: 16),
                                      ],
                                    ],
                                  ),
                                  Text(
                                    "Party of ${entry["partySize"]} • ${entry["phone"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                              decoration: BoxDecoration(
                                color: _getStatusColor(entry["status"]),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${entry["status"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Wait Info
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                spacing: spXs,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                                      SizedBox(width: 4),
                                      Text(
                                        "Waiting: ${entry["waitTime"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.timer, size: 14, color: disabledBoldColor),
                                      SizedBox(width: 4),
                                      Text(
                                        "Est: ${entry["estimatedWait"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                spacing: spXs,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.access_time, size: 14, color: disabledBoldColor),
                                      SizedBox(width: 4),
                                      Text(
                                        "Joined: ${entry["joinTime"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (entry["preferredTable"].isNotEmpty)
                                    Row(
                                      children: [
                                        Icon(Icons.table_restaurant, size: 14, color: disabledBoldColor),
                                        SizedBox(width: 4),
                                        Text(
                                          "Prefers: ${entry["preferredTable"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        // Notes
                        if (entry["notes"] != null) ...[
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.note, size: 12, color: infoColor),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    "${entry["notes"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: infoColor,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],

                        // Action Buttons
                        Row(
                          children: [
                            if (entry["status"] == "Ready") ...[
                              Expanded(
                                child: QButton(
                                  label: "Seat Now",
                                  size: bs.sm,
                                  onPressed: () => _seatGuest(entry),
                                ),
                              ),
                            ] else if (entry["status"] == "Waiting") ...[
                              Expanded(
                                child: QButton(
                                  label: "Notify Guest",
                                  size: bs.sm,
                                  onPressed: () => _notifyGuest(entry),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: QButton(
                                  label: "Table Ready",
                                  size: bs.sm,
                                  onPressed: () => _markTableReady(entry),
                                ),
                              ),
                            ] else if (entry["status"] == "Notified") ...[
                              Expanded(
                                child: QButton(
                                  label: "Seat Guest",
                                  size: bs.sm,
                                  onPressed: () => _seatGuest(entry),
                                ),
                              ),
                            ],
                            SizedBox(width: spSm),
                            QButton(
                              icon: Icons.edit,
                              size: bs.sm,
                              onPressed: () => _editWaitlistEntry(entry),
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              icon: Icons.delete,
                              size: bs.sm,
                              onPressed: () => _removeFromWaitlist(entry),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
