import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmTechnicianAvailabilityView extends StatefulWidget {
  const FsmTechnicianAvailabilityView({super.key});

  @override
  State<FsmTechnicianAvailabilityView> createState() => _FsmTechnicianAvailabilityViewState();
}

class _FsmTechnicianAvailabilityViewState extends State<FsmTechnicianAvailabilityView> {
  bool loading = false;
  String selectedTechnician = "TECH-001";
  String selectedWeek = "2024-06-17";
  String selectedAvailabilityFilter = "All";

  List<Map<String, dynamic>> technicians = [
    {
      "id": "TECH-001",
      "name": "John Smith",
      "department": "IT Support",
      "profileImage": "https://picsum.photos/100/100?random=1",
      "currentStatus": "Available",
      "workingHours": "9:00 AM - 5:00 PM",
      "timeZone": "EST",
      "phone": "+1-555-0101",
      "email": "john.smith@company.com"
    },
    {
      "id": "TECH-002",
      "name": "Sarah Wilson",
      "department": "Field Service",
      "profileImage": "https://picsum.photos/100/100?random=2",
      "currentStatus": "On Job",
      "workingHours": "8:00 AM - 4:00 PM",
      "timeZone": "CST",
      "phone": "+1-555-0102",
      "email": "sarah.wilson@company.com"
    },
    {
      "id": "TECH-003",
      "name": "Mike Davis",
      "department": "Medical Equipment",
      "profileImage": "https://picsum.photos/100/100?random=3",
      "currentStatus": "Available",
      "workingHours": "7:00 AM - 3:00 PM",
      "timeZone": "EST",
      "phone": "+1-555-0103",
      "email": "mike.davis@company.com"
    },
    {
      "id": "TECH-004",
      "name": "Emily Rodriguez",
      "department": "Field Service",
      "profileImage": "https://picsum.photos/100/100?random=4",
      "currentStatus": "On Leave",
      "workingHours": "10:00 AM - 6:00 PM",
      "timeZone": "EST",
      "phone": "+1-555-0104",
      "email": "emily.rodriguez@company.com"
    },
    {
      "id": "TECH-005",
      "name": "Alex Johnson",
      "department": "IT Support",
      "profileImage": "https://picsum.photos/100/100?random=5",
      "currentStatus": "Busy",
      "workingHours": "9:00 AM - 5:00 PM",
      "timeZone": "CST",
      "phone": "+1-555-0105",
      "email": "alex.johnson@company.com"
    }
  ];

  Map<String, List<Map<String, dynamic>>> weeklySchedule = {
    "TECH-001": [
      {
        "date": "2024-06-17",
        "day": "Monday",
        "slots": [
          {"time": "9:00 AM", "duration": "2 hours", "status": "Available", "job": null},
          {"time": "11:00 AM", "duration": "3 hours", "status": "Scheduled", "job": "Network Setup - TechCorp"},
          {"time": "2:00 PM", "duration": "2 hours", "status": "Available", "job": null},
          {"time": "4:00 PM", "duration": "1 hour", "status": "Travel", "job": "Travel to next location"}
        ]
      },
      {
        "date": "2024-06-18",
        "day": "Tuesday",
        "slots": [
          {"time": "9:00 AM", "duration": "4 hours", "status": "Scheduled", "job": "Server Maintenance - GlobalTech"},
          {"time": "1:00 PM", "duration": "1 hour", "status": "Break", "job": "Lunch Break"},
          {"time": "2:00 PM", "duration": "3 hours", "status": "Available", "job": null}
        ]
      },
      {
        "date": "2024-06-19",
        "day": "Wednesday",
        "slots": [
          {"time": "9:00 AM", "duration": "1 hour", "status": "Meeting", "job": "Team Standup"},
          {"time": "10:00 AM", "duration": "6 hours", "status": "Scheduled", "job": "Infrastructure Upgrade - MedCorp"},
          {"time": "4:00 PM", "duration": "1 hour", "status": "Available", "job": null}
        ]
      },
      {
        "date": "2024-06-20",
        "day": "Thursday",
        "slots": [
          {"time": "9:00 AM", "duration": "3 hours", "status": "Available", "job": null},
          {"time": "12:00 PM", "duration": "2 hours", "status": "Scheduled", "job": "Network Troubleshooting - RetailCorp"},
          {"time": "2:00 PM", "duration": "3 hours", "status": "Available", "job": null}
        ]
      },
      {
        "date": "2024-06-21",
        "day": "Friday",
        "slots": [
          {"time": "9:00 AM", "duration": "2 hours", "status": "Training", "job": "Cybersecurity Training"},
          {"time": "11:00 AM", "duration": "4 hours", "status": "Available", "job": null},
          {"time": "3:00 PM", "duration": "2 hours", "status": "Administrative", "job": "Weekly Reports"}
        ]
      }
    ],
    "TECH-002": [
      {
        "date": "2024-06-17",
        "day": "Monday",
        "slots": [
          {"time": "8:00 AM", "duration": "6 hours", "status": "Scheduled", "job": "HVAC Installation - Manufacturing Plant"},
          {"time": "2:00 PM", "duration": "2 hours", "status": "Travel", "job": "Travel to next site"}
        ]
      },
      {
        "date": "2024-06-18",
        "day": "Tuesday",
        "slots": [
          {"time": "8:00 AM", "duration": "4 hours", "status": "Scheduled", "job": "Equipment Maintenance - Factory A"},
          {"time": "12:00 PM", "duration": "1 hour", "status": "Break", "job": "Lunch Break"},
          {"time": "1:00 PM", "duration": "3 hours", "status": "Available", "job": null}
        ]
      },
      {
        "date": "2024-06-19",
        "day": "Wednesday",
        "slots": [
          {"time": "8:00 AM", "duration": "8 hours", "status": "Scheduled", "job": "Emergency Repair - Power Plant"},
        ]
      },
      {
        "date": "2024-06-20",
        "day": "Thursday",
        "slots": [
          {"time": "8:00 AM", "duration": "3 hours", "status": "Available", "job": null},
          {"time": "11:00 AM", "duration": "4 hours", "status": "Scheduled", "job": "Preventive Maintenance - Office Building"},
          {"time": "3:00 PM", "duration": "1 hour", "status": "Available", "job": null}
        ]
      },
      {
        "date": "2024-06-21",
        "day": "Friday",
        "slots": [
          {"time": "8:00 AM", "duration": "6 hours", "status": "Available", "job": null},
          {"time": "2:00 PM", "duration": "2 hours", "status": "Administrative", "job": "Equipment Inventory"}
        ]
      }
    ]
  };

  List<Map<String, dynamic>> availabilityFilters = [
    {"label": "All", "value": "All"},
    {"label": "Available", "value": "Available"},
    {"label": "Scheduled", "value": "Scheduled"},
    {"label": "On Job", "value": "On Job"},
    {"label": "Break", "value": "Break"},
    {"label": "Training", "value": "Training"},
    {"label": "Travel", "value": "Travel"},
    {"label": "Meeting", "value": "Meeting"},
    {"label": "Administrative", "value": "Administrative"}
  ];

  List<Map<String, dynamic>> get technicianOptions {
    return technicians.map((tech) => {
      "label": tech["name"],
      "value": tech["id"]
    }).toList();
  }

  Map<String, dynamic> get selectedTechnicianData {
    return technicians.firstWhere((tech) => tech["id"] == selectedTechnician);
  }

  List<Map<String, dynamic>> get currentWeekSchedule {
    return weeklySchedule[selectedTechnician] ?? [];
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Available":
        return successColor;
      case "Scheduled":
        return infoColor;
      case "On Job":
        return primaryColor;
      case "Break":
        return warningColor;
      case "Training":
        return infoColor;
      case "Travel":
        return disabledBoldColor;
      case "Meeting":
        return warningColor;
      case "Administrative":
        return disabledBoldColor;
      case "On Leave":
        return dangerColor;
      case "Busy":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  void _updateAvailability(Map<String, dynamic> slot, String date) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Update Availability"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Text("Time: ${slot["time"]} (${slot["duration"]})"),
            Text("Current Status: ${slot["status"]}"),
            if (slot["job"] != null) Text("Job: ${slot["job"]}"),
            
            SizedBox(height: spSm),
            Text("New Status:", style: TextStyle(fontWeight: FontWeight.bold)),
            
            QDropdownField(
              label: "Select Status",
              items: availabilityFilters.where((f) => f["value"] != "All").toList(),
              value: slot["status"],
              onChanged: (value, label) {
                slot["status"] = value;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Update",
            size: bs.sm,
            onPressed: () {
              back();
              ss("Availability updated successfully");
            },
          ),
        ],
      ),
    );
  }

  void _assignJob(Map<String, dynamic> slot, String date) {
    if (slot["status"] != "Available") {
      se("Time slot is not available for assignment");
      return;
    }
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Assign Job"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Text("Time: ${slot["time"]} (${slot["duration"]})"),
            Text("Technician: ${selectedTechnicianData["name"]}"),
            
            QTextField(
              label: "Job Description",
              value: "",
              hint: "Enter job description",
              onChanged: (value) {},
            ),
            
            QTextField(
              label: "Customer",
              value: "",
              hint: "Enter customer name",
              onChanged: (value) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Assign",
            size: bs.sm,
            onPressed: () {
              back();
              setState(() {
                slot["status"] = "Scheduled";
                slot["job"] = "New Job Assignment";
              });
              ss("Job assigned successfully");
            },
          ),
        ],
      ),
    );
  }

  void _blockTime(String date) {
    ss("Block time functionality for $date");
  }

  void _viewDayDetails(Map<String, dynamic> daySchedule) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${daySchedule["day"]} Schedule"),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text("Date: ${daySchedule["date"]}"),
              Text("Technician: ${selectedTechnicianData["name"]}"),
              
              SizedBox(height: spSm),
              Text("Schedule:", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
              
              ...(daySchedule["slots"] as List).map((slot) => Container(
                margin: EdgeInsets.only(bottom: spXs),
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor(slot["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${slot["time"]}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Text(
                          "${slot["duration"]}",
                          style: TextStyle(color: disabledBoldColor, fontSize: 12),
                        ),
                      ],
                    ),
                    Text(
                      "${slot["status"]}",
                      style: TextStyle(
                        color: _getStatusColor(slot["status"]),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    if (slot["job"] != null)
                      Text(
                        "${slot["job"]}",
                        style: TextStyle(fontSize: 12),
                      ),
                  ],
                ),
              )),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Technician Availability"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Technician Availability"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              ss("Calendar view");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Technician Info Card
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(selectedTechnicianData["profileImage"]),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${selectedTechnicianData["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${selectedTechnicianData["department"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Working Hours: ${selectedTechnicianData["workingHours"]} (${selectedTechnicianData["timeZone"]})",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getStatusColor(selectedTechnicianData["currentStatus"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${selectedTechnicianData["currentStatus"]}",
                          style: TextStyle(
                            color: _getStatusColor(selectedTechnicianData["currentStatus"]),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Icon(Icons.phone, size: 16, color: disabledBoldColor),
                      SizedBox(width: 4),
                      Text("${selectedTechnicianData["phone"]}", style: TextStyle(fontSize: 12)),
                      SizedBox(width: spSm),
                      Icon(Icons.email, size: 16, color: disabledBoldColor),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text("${selectedTechnicianData["email"]}", style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Filters
            QDropdownField(
              label: "Select Technician",
              items: technicianOptions,
              value: selectedTechnician,
              onChanged: (value, label) {
                selectedTechnician = value;
                setState(() {});
              },
            ),

            QDropdownField(
              label: "Filter by Status",
              items: availabilityFilters,
              value: selectedAvailabilityFilter,
              onChanged: (value, label) {
                selectedAvailabilityFilter = value;
                setState(() {});
              },
            ),

            // Weekly Schedule
            Text(
              "Weekly Schedule",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            ...currentWeekSchedule.map((daySchedule) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${daySchedule["day"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${daySchedule["date"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () => _viewDayDetails(daySchedule),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "Block Time",
                        size: bs.sm,
                        onPressed: () => _blockTime(daySchedule["date"]),
                      ),
                    ],
                  ),

                  // Time Slots
                  ...(daySchedule["slots"] as List).where((slot) {
                    if (selectedAvailabilityFilter == "All") return true;
                    return slot["status"] == selectedAvailabilityFilter;
                  }).map((slot) => GestureDetector(
                    onTap: () => _updateAvailability(slot, daySchedule["date"]),
                    child: Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: _getStatusColor(slot["status"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: Border.all(
                          color: _getStatusColor(slot["status"]).withAlpha(40),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${slot["time"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor(slot["status"]).withAlpha(40),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${slot["status"]}",
                                        style: TextStyle(
                                          color: _getStatusColor(slot["status"]),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Duration: ${slot["duration"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                if (slot["job"] != null)
                                  Text(
                                    "${slot["job"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          if (slot["status"] == "Available")
                            QButton(
                              label: "Assign",
                              size: bs.sm,
                              onPressed: () => _assignJob(slot, daySchedule["date"]),
                            ),
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            )),

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Set Unavailable",
                          size: bs.sm,
                          onPressed: () => ss("Set technician unavailable"),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Emergency Override",
                          size: bs.sm,
                          onPressed: () => ss("Emergency override availability"),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Bulk Schedule",
                          size: bs.sm,
                          onPressed: () => ss("Bulk schedule functionality"),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Export Schedule",
                          size: bs.sm,
                          onPressed: () => ss("Export schedule"),
                        ),
                      ),
                    ],
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
