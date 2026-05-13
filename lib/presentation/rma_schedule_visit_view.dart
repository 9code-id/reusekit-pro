import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaScheduleVisitView extends StatefulWidget {
  const RmaScheduleVisitView({super.key});

  @override
  State<RmaScheduleVisitView> createState() => _RmaScheduleVisitViewState();
}

class _RmaScheduleVisitViewState extends State<RmaScheduleVisitView> {
  final formKey = GlobalKey<FormState>();
  
  String selectedProperty = "";
  String selectedDate = DateTime.now().add(Duration(days: 1)).toIso8601String().split('T')[0];
  String selectedTimeSlot = "";
  String visitorName = "";
  String visitorPhone = "";
  String visitorEmail = "";
  String visitType = "";
  String groupSize = "1";
  String specialRequests = "";
  String agentNotes = "";
  bool isConfirmed = false;
  bool requiresPreApproval = false;
  bool hasTransportation = true;
  bool needsVirtualOption = false;
  
  List<Map<String, dynamic>> availableProperties = [
    {
      "id": "1",
      "title": "Modern Downtown Condo",
      "address": "123 Main Street, Unit 4B",
      "price": 650000,
      "type": "Condominium",
      "image": "https://picsum.photos/400/250?random=1&keyword=condo",
      "agent": "Sarah Johnson",
      "status": "Available",
    },
    {
      "id": "2", 
      "title": "Family Suburban Home",
      "address": "456 Oak Avenue",
      "price": 850000,
      "type": "Single Family",
      "image": "https://picsum.photos/400/250?random=2&keyword=house",
      "agent": "Michael Chen",
      "status": "Available",
    },
    {
      "id": "3",
      "title": "Luxury Waterfront Villa",
      "address": "789 Harbor Drive",
      "price": 1250000,
      "type": "Villa",
      "image": "https://picsum.photos/400/250?random=3&keyword=villa",
      "agent": "Emma Rodriguez",
      "status": "Available",
    },
    {
      "id": "4",
      "title": "Historic Townhouse",
      "address": "321 Heritage Lane",
      "price": 720000,
      "type": "Townhouse",
      "image": "https://picsum.photos/400/250?random=4&keyword=townhouse",
      "agent": "David Thompson",
      "status": "Pending",
    },
  ];
  
  List<Map<String, dynamic>> timeSlots = [
    {"label": "9:00 AM - 10:00 AM", "value": "09:00"},
    {"label": "10:30 AM - 11:30 AM", "value": "10:30"},
    {"label": "12:00 PM - 1:00 PM", "value": "12:00"},
    {"label": "2:00 PM - 3:00 PM", "value": "14:00"},
    {"label": "3:30 PM - 4:30 PM", "value": "15:30"},
    {"label": "5:00 PM - 6:00 PM", "value": "17:00"},
  ];
  
  List<Map<String, dynamic>> visitTypes = [
    {"label": "Private Showing", "value": "private"},
    {"label": "Open House", "value": "open_house"},
    {"label": "Virtual Tour", "value": "virtual"},
    {"label": "Second Viewing", "value": "second_viewing"},
    {"label": "Final Inspection", "value": "final_inspection"},
  ];
  
  List<Map<String, dynamic>> groupSizes = [
    {"label": "1 Person", "value": "1"},
    {"label": "2 People", "value": "2"},
    {"label": "3-4 People", "value": "3-4"},
    {"label": "5+ People", "value": "5+"},
  ];

  List<Map<String, dynamic>> upcomingVisits = [
    {
      "id": "1",
      "property": "Modern Downtown Condo",
      "date": "2025-06-20",
      "time": "10:30 AM",
      "visitor": "John Smith",
      "status": "Confirmed",
      "type": "Private Showing",
    },
    {
      "id": "2",
      "property": "Family Suburban Home", 
      "date": "2025-06-21",
      "time": "2:00 PM",
      "visitor": "Lisa Chen",
      "status": "Pending",
      "type": "Second Viewing",
    },
    {
      "id": "3",
      "property": "Luxury Waterfront Villa",
      "date": "2025-06-22",
      "time": "11:00 AM", 
      "visitor": "Robert Wilson",
      "status": "Confirmed",
      "type": "Final Inspection",
    },
  ];

  void _scheduleVisit() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      ss("Visit scheduled successfully!");
      
      // Reset form
      setState(() {
        selectedProperty = "";
        selectedDate = DateTime.now().add(Duration(days: 1)).toIso8601String().split('T')[0];
        selectedTimeSlot = "";
        visitorName = "";
        visitorPhone = "";
        visitorEmail = "";
        visitType = "";
        groupSize = "1";
        specialRequests = "";
        agentNotes = "";
        isConfirmed = false;
        requiresPreApproval = false;
        hasTransportation = true;
        needsVirtualOption = false;
      });
    }
  }

  void _cancelVisit(String visitId) async {
    bool confirmed = await confirm("Are you sure you want to cancel this visit?");
    if (confirmed) {
      showLoading();
      await Future.delayed(Duration(seconds: 1));
      hideLoading();
      ss("Visit cancelled successfully");
    }
  }

  void _rescheduleVisit(String visitId) {
    // Implementation for rescheduling
    si("Reschedule functionality would open here");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schedule Visit"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Schedule New Visit Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.add_circle,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Schedule New Visit",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    // Property Selection
                    QDropdownField(
                      label: "Select Property",
                      items: availableProperties.map((property) => {
                        "label": "${property["title"]} - \$${((property["price"] as int).toDouble()).currency}",
                        "value": property["id"],
                      }).toList(),
                      value: selectedProperty,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        selectedProperty = value;
                        setState(() {});
                      },
                    ),
                    
                    // Visit Date & Time
                    Row(
                      children: [
                        Expanded(
                          child: QDatePicker(
                            label: "Visit Date",
                            value: DateTime.parse(selectedDate),
                            validator: Validator.required,
                            onChanged: (value) {
                              selectedDate = value.toIso8601String().split('T')[0];
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Time Slot",
                            items: timeSlots,
                            value: selectedTimeSlot,
                            validator: Validator.required,
                            onChanged: (value, label) {
                              selectedTimeSlot = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    // Visit Type & Group Size
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Visit Type",
                            items: visitTypes,
                            value: visitType,
                            validator: Validator.required,
                            onChanged: (value, label) {
                              visitType = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Group Size",
                            items: groupSizes,
                            value: groupSize,
                            onChanged: (value, label) {
                              groupSize = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    // Visitor Information
                    QTextField(
                      label: "Visitor Name",
                      value: visitorName,
                      validator: Validator.required,
                      onChanged: (value) {
                        visitorName = value;
                        setState(() {});
                      },
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Phone Number",
                            value: visitorPhone,
                            validator: Validator.required,
                            onChanged: (value) {
                              visitorPhone = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Email Address",
                            value: visitorEmail,
                            validator: Validator.email,
                            onChanged: (value) {
                              visitorEmail = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    // Visit Options
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: QSwitch(
                                  items: [
                                    {
                                      "label": "Requires Pre-approval",
                                      "value": true,
                                      "checked": requiresPreApproval,
                                    }
                                  ],
                                  value: [if (requiresPreApproval) {"label": "Requires Pre-approval", "value": true, "checked": true}],
                                  onChanged: (values, ids) {
                                    setState(() {
                                      requiresPreApproval = values.isNotEmpty;
                                    });
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
                                      "label": "Has Transportation",
                                      "value": true,
                                      "checked": hasTransportation,
                                    }
                                  ],
                                  value: [if (hasTransportation) {"label": "Has Transportation", "value": true, "checked": true}],
                                  onChanged: (values, ids) {
                                    setState(() {
                                      hasTransportation = values.isNotEmpty;
                                    });
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
                                      "label": "Needs Virtual Option",
                                      "value": true,
                                      "checked": needsVirtualOption,
                                    }
                                  ],
                                  value: [if (needsVirtualOption) {"label": "Needs Virtual Option", "value": true, "checked": true}],
                                  onChanged: (values, ids) {
                                    setState(() {
                                      needsVirtualOption = values.isNotEmpty;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    // Special Requests & Notes
                    QMemoField(
                      label: "Special Requests",
                      value: specialRequests,
                      hint: "Any specific requirements or questions for the visit",
                      onChanged: (value) {
                        specialRequests = value;
                        setState(() {});
                      },
                    ),
                    
                    QMemoField(
                      label: "Agent Notes",
                      value: agentNotes,
                      hint: "Internal notes for the showing agent",
                      onChanged: (value) {
                        agentNotes = value;
                        setState(() {});
                      },
                    ),
                    
                    // Schedule Button
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Schedule Visit",
                        onPressed: _scheduleVisit,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Upcoming Visits Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Upcoming Visits",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${upcomingVisits.length} scheduled",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    
                    // Visit List
                    ...upcomingVisits.map((visit) {
                      Color statusColor = visit["status"] == "Confirmed" ? successColor : warningColor;
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: statusColor,
                            ),
                          ),
                        ),
                        child: Column(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${visit["property"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: statusColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${visit["status"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${visit["visitor"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Icon(
                                  Icons.access_time,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${DateTime.parse(visit["date"]).dMMMy} at ${visit["time"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            
                            Row(
                              children: [
                                Icon(
                                  Icons.category,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${visit["type"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                
                                // Action Buttons
                                QButton(
                                  label: "Reschedule",
                                  size: bs.sm,
                                  onPressed: () => _rescheduleVisit(visit["id"]),
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  label: "Cancel",
                                  size: bs.sm,
                                  onPressed: () => _cancelVisit(visit["id"]),
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
              
              // Quick Actions Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quick Actions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Calendar",
                            icon: Icons.calendar_month,
                            onPressed: () {
                              si("Calendar view would open here");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Available Properties",
                            icon: Icons.home,
                            onPressed: () {
                              si("Property list would open here");
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Send Reminders",
                            icon: Icons.notifications_active,
                            onPressed: () {
                              si("Reminder system would activate");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Visit History",
                            icon: Icons.history,
                            onPressed: () {
                              si("Visit history would open here");
                            },
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
      ),
    );
  }
}
